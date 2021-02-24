Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA9DC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D4A60233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D4A60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035EB89D63;
	Wed, 24 Feb 2021 22:19:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D905C89E9B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNuviwDGeRdsdGIkVcMoUYrp2Qe8ewolPZuOjH/Gaeusx1ye0DvhBOcNQkvX1ciAmm9VB/p1zk4+JxD8C1+9W1+UMtTdjJr0lIE/VCZTHnySb9s7QLczGI1FH2+cu9D5gjBUwHNyhc+cbDNB2Xw7KhIie1nBmBM3Cu9VH2RPWj2xSuxSHQCAJz1geo/ZF27AGlsiu5OAV5TBQcljB73cIKannL00TSyRc6/dUpcW4yR6SuBKNWpJPDifu6z514OcZKStem96zOcr+NaIql2kr4GRXe45nUm9CYZN9SPhSfoBYR4bAvuvlMd2H/txu81NUaMrvveDNo30zbv2N681Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ75hBdnA0GIkkIdJyRoD2A1Wsxd7AapTthuAAyw6XY=;
 b=CD2ArKxQIVTdU3IsZVUdpA+02FkaofWTVV8x3khapbme0ju52OITfP2zoMSSRRItKLGe/Z+n6CCEWK+84KPv8vYQ2DY4RvS9qqRc/thAOjO9oeC+QKekf8kZYTDLF7bNqbH1TnuL2IQVgwa8YtmOFiZluOUI4ezuhsmTBSrLdAbmre7PtEql7S93xXa50q+fQ9HBjJJaF4cQ5RiA9118S7f0DWlowtX8/Bx1YkFqmnHRsAC5Zey0U3VEKKT9Dq/oJwwU1EHTxHcVMkp3Q8QiDH3u//0rZjwXuPKs7ZY+3BbndpVg8yw+mC6wtzJ5dg9yS2DI1ifaiOMhjXN4wNeB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ75hBdnA0GIkkIdJyRoD2A1Wsxd7AapTthuAAyw6XY=;
 b=dM1bcOlQFihszXQkGLmeRWshF1eDt6RYRfbwpeJ2ylPuaU+KWRKp359H4kDyfbY61x4FQubJpNR/FVJKDbWQ/wcRbDDPEVZc4e1sRdwKRHF+7fVLzeIhCWEq5wTSawd/vzwdnhmzKUAJDW8aseFsMru7VaYeCyTpDaPP/cw4RGc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 24 Feb
 2021 22:19:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 022/159] drm/amdgpu: add aldebaran sdma firmware support (v2)
Date: Wed, 24 Feb 2021 17:16:42 -0500
Message-Id: <20210224221859.3068810-15-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6adb1b37-f277-4dee-c69b-08d8d9124368
X-MS-TrafficTypeDiagnostic: MN2PR12MB4174:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4174B8A9F771D1314F3CD66BF79F9@MN2PR12MB4174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gue3x8qMvUDCGLgctkZlAcZh3os185lnfcqs6ek9MxXE/MXY3c/BD/6eNlFsh+hzj/2zA/L57xJJuFkVqvPHGm28aJJS/wW8yZSp5QcdWxcP4E4VzsjzlnL+gsECMjUpAq5AvhOBMYHTyZD5GtK6MCaXnCO2yg8ePcSljryxOOvlQrAuaxnpzpUNCYLP1U/Qf8MIfsmCtfq5mKMucA85cIaWdB3PQjkmleIhqwC4VfdPQbEKwxa1mP0dt61lBTlnyyCW3FwiWB1t0GJu0WpsGx8t4ACO+Ev42PdB2ARDn/lU0d5E0LqMIlhU4THHIJ+rO0FkKiD0/9fQqAbojAfbGbnT50EJihY00IW+YjnpjuqHEAU76g8QwWI/vNmQ7qJ+pabYnB4xgxXn7xf669D7oraMy1oKxMYRZa4hfyJv2KhTz4bfmbigr/o2ev2KnBdE+6RV5i6dM0pZn6D7AIdxcoQHw+Pb6R/zMmCPCExA69t+F8+lG7fOo9wawfKIsJMC5ObfNlotUaBU6PnZyPx6TJntsqbXsV/EwPKqKsPLhSrUEMXW3aGL4SY4hOwkfd0eUIPNpOvyhPQ9cW2fPHqOHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(8936002)(52116002)(4326008)(186003)(2616005)(83380400001)(1076003)(956004)(6506007)(26005)(6486002)(6512007)(54906003)(66556008)(316002)(2906002)(86362001)(66476007)(66946007)(6916009)(16526019)(6666004)(69590400012)(36756003)(5660300002)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kMrcdSWrGbGtRSlA11MbjGI2wPViccBjEZQNfXma89ATAmnijZUJ8nVCj2Mi?=
 =?us-ascii?Q?5tNQNvzYfOoHHP4gYxe7V4mYab7uyRMfjXyEBuVNlfTewxxBcgdoindW25Mp?=
 =?us-ascii?Q?oo4QvXK2dIgPagJZtyKwwn/mRJgxYfBzRElrxayFPU8Sf6C1llAUXSTfAd/V?=
 =?us-ascii?Q?vtaploDzpn1NW2bMWs7kxIeeGfz/tcK9tgoDrc2m5k2cMiQYwehh1wktCUUp?=
 =?us-ascii?Q?UdvOnECLGoIO9opBX4+LzNAMJFXR4fiOnpaVqhBNCcR9Bt1lgDvyvHF2Vkfe?=
 =?us-ascii?Q?raFSfkTSDuBsuE7j3bYxQ6cwEKzYCraYRpNxwEMxMIKyukQuIX9dKH+gMmI7?=
 =?us-ascii?Q?nqNvqWqzg8lg5JDDQT/5tqBpb8BHyMgq7YBjyNiVcw+S4HT+NeFukN7VOzlj?=
 =?us-ascii?Q?UbIvGyjaVDLjBHVB5SjEKzwlZT+dcRs+KXbrVEmSSbJ/9Z+MC/VidwBkY1wX?=
 =?us-ascii?Q?XNIuptRfBkCSUOiD0jikV8D6vgQ2eNUDFrUYt63DJk4f80TAglQ56wdjYraE?=
 =?us-ascii?Q?naQHQB/Fs7lo4ESB70rPMrXivY0Ko2Vq7rV604eb8m/FC6K3X9J1LYXltLAu?=
 =?us-ascii?Q?9MWQOjd76imYfoERcTrzOyPlSMnnpVTS443o/wJRc1Rb0pHnhPXHw1mO5qnz?=
 =?us-ascii?Q?Nhv45EvBWNrE7pCi9WqNd2ufgJA+YQPNTC95n41onq0MwAElmWbKEmlZgeRG?=
 =?us-ascii?Q?ommZlVycjclOW17bXqN4aB9ovnqVp8+YrkhcjCNTbHaTdwLKi3OhRsefoQKj?=
 =?us-ascii?Q?ZGspxLsGlYSfpwOcsF3wN030/s0kmQSLLt4UMByAZGgQowomCDnf+hhFveF0?=
 =?us-ascii?Q?BLAVT1dFuAWiuwVrnYlxNgVA4xFgsRld5+WsCJBXGH7EItDkQCgh2X1/TEGI?=
 =?us-ascii?Q?CIlJZfFG2ENEDJoq+UtPIvN0WNLrXKVv02Um2g6L6MIYxT4NEyYOwCOkXRAO?=
 =?us-ascii?Q?KTGDi4471dq24vArPwwSkfFt+VDK/Q/ZUDnCmpVD5EIGNsHc8nIx8hWcdGaJ?=
 =?us-ascii?Q?6ln5Imr+lys04LL9w2jucgR+fNpUrERGEoGJl1sXF5dbK6bLp4M1qQaNVjnT?=
 =?us-ascii?Q?Ve1u+f9VAuBEwK+PxHKg1VdE4tAcZBlgw/AdqlMd08kaeRUfwG98pAvDk9r9?=
 =?us-ascii?Q?5XFAwROUDqn+5fzt7/4vyuGnnxlfss7DOADk6gLtwISF3XgdJw8feTF8Vq3d?=
 =?us-ascii?Q?WCqIWahfTZSLd5dzAuO7DJ4SPx3SoDv9MtaNxsSrriESbGlCah6XURvWCSY2?=
 =?us-ascii?Q?Ua7+R88If4fgudtz1TGgg+kWNjOgXnHd2Yx1BOARMZcjxXdspsg3zbw10ONG?=
 =?us-ascii?Q?IUf4n8rr8Juxh4/yN5CKqNOD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adb1b37-f277-4dee-c69b-08d8d9124368
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:33.8644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjTYyzrlMkHJlLu3q/vGBsk0DkeFI7w/X5LPJtPc5Rvlu6aBYBDV7A86/rUFn8r3GYImKXJKh40bNSQYjfczfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174
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
 Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kevin Wang <kevin1.wang@amd.com>

add sdma firmware load support for soc model

v2: drop some emulator leftovers (Alex)

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 5b5081cdfa3a..bcb3ef8b3fdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -564,7 +564,8 @@ static void sdma_v4_0_destroy_inst_ctx(struct amdgpu_device *adev)
 
 		/* arcturus shares the same FW memory across
 		   all SDMA isntances */
-		if (adev->asic_type == CHIP_ARCTURUS)
+		if (adev->asic_type == CHIP_ARCTURUS ||
+		    adev->asic_type == CHIP_ALDEBARAN)
 			break;
 	}
 
@@ -639,8 +640,9 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 		goto out;
 
 	for (i = 1; i < adev->sdma.num_instances; i++) {
-		if (adev->asic_type == CHIP_ARCTURUS) {
-			/* Acturus will leverage the same FW memory
+		if (adev->asic_type == CHIP_ARCTURUS ||
+		    adev->asic_type == CHIP_ALDEBARAN) {
+			/* Acturus & Aldebaran will leverage the same FW memory
 			   for every SDMA instance */
 			memcpy((void *)&adev->sdma.instance[i],
 			       (void *)&adev->sdma.instance[0],
@@ -2479,6 +2481,10 @@ static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE1;
 		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE1;
 		break;
+	case 5:
+		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
+		break;
 	case 8:
 		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
 		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_LAST;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
