Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2FFC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 10:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9BC61029
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 10:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9BC61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD29A6EB93;
	Tue,  8 Jun 2021 10:06:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16EF26EB93
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 10:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE4KNtt4J1WFRUy3GANtCSAqo6oTNzWEAPU4jgpyWN/jlnA3VPe4wVnQg5H8H2FNyvcko7Non3wMUL7DvucHp4Qvc/AxqWwMFmsqm9znKswdPO9F+GjrUMcGcpp0wTAyl6tUQk2jtKvv3yyKjVLjc/aC6czrGGInl7ZpC7dGL7GeFq0OuLK2bVsu88SLc3evveXo8+/fhZIxMag19gEhlzTiW7TEkUzUoyJwtnG9HX9KQZspLMXVBvMbbPkYCV6HfFigdcx9dBHE9VB1ifPj4zGAcEBdI8JIBdVDZYZK70q9NufkVOA1LaYW/gwDHyE6AUzqONM/eyyiihC0mhIK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lHGzjwDK2Pw/EPF68i3rczDPuHBQy+82zus5s4CaTA=;
 b=ebv/KxIv4jTfmYj+9bvov8JTg7s9nBY71h9SZroOjNw2Ey/8sPZg6GC2rKaHedluYkBqjQ/kUq3SCLEN+byMlrnuYhxtWPXSUdlQArlN7rVk/tKCog8HtgSEVZ4ZmFVm0LBJmTL0P2rkKyaHZ5wdwhKVcrHclsA1uN6aNufFF9fduOCj+Tp5ReWmbM0VOOXiuxWeMErAaVo0e9hWZcTgSIWL22IVRUy5qdybzvBgcE3Dnd9uoXrPXp5C+y45GNkro4ff3pzEYwVY4LBIEtUu9d3XKtlwg81DxuAM+iM9FgtKB2frC2wD0M3/ex5jlPVgfQiNs457TmH3eIclIvibTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lHGzjwDK2Pw/EPF68i3rczDPuHBQy+82zus5s4CaTA=;
 b=3IxsI3DNMH7oXABVq5HKhttqfWXP4DvMR1UyAdyudQkWGtUlCaqLEpSwwrFl9hGJAFN94g2Rt3JtFwSyj0nDcKu6zArMjrb3D2+A3s+pIN75ToKwIN0NLxJ316tTPic9rfyTzOjNYnK+bg8nXRw+7sfLAU/qvov5ao8gi7U4+PE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 8 Jun
 2021 10:06:43 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.037; Tue, 8 Jun 2021
 10:06:43 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: fix shadow bo skip condition
Date: Tue,  8 Jun 2021 12:06:26 +0200
Message-Id: <20210608100626.7750-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.107.133]
X-ClientProxiedBy: PR3P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::27) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.107.133) by
 PR3P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 10:06:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24f34325-8b89-4fe8-78b0-08d92a651e06
X-MS-TrafficTypeDiagnostic: DM4PR12MB5104:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5104A2FFA4C058B733B2354E8B379@DM4PR12MB5104.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R32rAhWwbOgdc01UQTkdQJYqu9+AgeoDk6TaYK+0zDZjSPqN4PQoBszqaBIosJ5SDLMo1Tlibczj/+PuzxVCZjupJ0YzRbci85Yd5kdGqwtxch5/lex2ShtoPerjpYRogwGhQhRqTFOivEfgYe/UPWFsN5bJcxJYQ8bQxOYxdwIWdygU0VYm66h3bn+wpxX5Ckf/I/h3JMFNbrhmOCiTNWQgXPITI/UrWxtqV8dGFRgXDCGJPAh2142kQBjgrOh53+rzTARjCA2Z+XYAjP6P1S+me91cjwbYIxLpdXx/OEg2PY35b8/8NBdbC6uZhak4XGHWZiBekX3x4Wx/LTYqFtPiIjxjL6BqJmDYUStq1bjxIoi+rvCc3f458twQFRUvH7RbC8QR0+dxGp0aKgih+TrTBCp7DN7c9BTBsLbE4NgbZtfxvY5wh6UCVIi7qMyBPkBhhXyG6azNzgiH1LtkNe1s9zfnI09fWpsYfCQt6GmZ6IsQU6yvlXWDBjRHe2NJY9/jPZycVhagn5B5PJUoKLMhcdD5YyFTn8jx5PLqb5RlPfrjDtcBLZcgLJyBaBrEJfnH3jz3PDc/pazrnPUas6/1r8fd7SN0v7nYppwebb1KRLCiIMQMmmKHaWzKhi8vxg5bbqrHyBhW6zL0M3y6S5+tQm6L/zVP9amBXUm8p8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(478600001)(6666004)(6916009)(86362001)(52116002)(5660300002)(16526019)(83380400001)(186003)(44832011)(8936002)(38100700002)(38350700002)(66476007)(36756003)(66946007)(66556008)(956004)(6486002)(2616005)(6506007)(6512007)(8676002)(26005)(2906002)(4326008)(1076003)(316002)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HgWKMW4TcOcuPim7gnQuotWBC2eJkDTl5ryXq7w5XTi6PTlxZ4HgzMG8zvoS?=
 =?us-ascii?Q?FEMd8/kzmdzYj7AJKSCUllGqiaUSPGba3dpPoPl7d/6HFRwKOkDFvttwJaZq?=
 =?us-ascii?Q?iCTzwftjGXuAjghuzYItwmLnYPCIHN8+5A59WFdYhyLbusFyC2CsCavSaAVh?=
 =?us-ascii?Q?ecRWmF4LHm3H6H99Q4RhUwUaiEV07gmRsCtstja3K+v0zadD9qLCy9jSmt+R?=
 =?us-ascii?Q?YYwGIs7cgCuB/YJMwbpfnfMSpJNE6Bipy2225K31keoEIO+FffrmlmuGuJsY?=
 =?us-ascii?Q?9KGv077vxbsMAuKzDbBsBVSjmco0tYv8UjI7U48XXREA3XwITcdWciInsuQ4?=
 =?us-ascii?Q?doZObyFscVCAZ5WrnO5YZ3ijEKhkySLot49RHsOA8wSySjsOKmNl1vo8aky5?=
 =?us-ascii?Q?hkrOWy1bLpfG7eHe+tb1kakH69dtz+PyACBUYkb522LEJ3ZFJY1MedddLdXh?=
 =?us-ascii?Q?H6KoYmtiVS5/7AdItPDv/GpXxPf8c97CVgbbeHFIAvOHGUzaKktK9w9g9osR?=
 =?us-ascii?Q?k9+y9TeVynQPMEQeSOhUGhpXAts5i53hTJfVa4H2v9O2u7q7eUZSbT10JmsF?=
 =?us-ascii?Q?49q9EIx+i1W/6CdzTUaYRdgoEDK13SDj/etZ5tbXH9dx2hatVAHUfc09h3Kd?=
 =?us-ascii?Q?seY+8ZklSNQtbGY+hfD8/+6oK0q4tLbvL7IBL3ykMKj4FqihO+pcAScHxdfX?=
 =?us-ascii?Q?hiRaA02dI+farqdiPQiZ//qGCpqWATYL/6QUia93VnUmFdfJaklxInO9z09P?=
 =?us-ascii?Q?+BAkugu8WdFwNMuzlvuvVQ0mshfSRF71llEMByp8w2D4lkFHKvI3a1yg7VaU?=
 =?us-ascii?Q?m4UHABHX8LlxGxtpbkdLsTpsb2rS4EPbl+Zp2jklhsRXgalh978QiHnghEMa?=
 =?us-ascii?Q?+uKe9tohEWgjVzm/JGpu0MuLJmcowJabSCSAA9sNX9g4Tg5mIGdfPM+6Vi9D?=
 =?us-ascii?Q?fHS9TMttGAHItPdaCh5lSJD2H7M00WfDT/g36OrJNHGEvdjtl1p0aEzXHj9V?=
 =?us-ascii?Q?Ir/pZ3uuShhSx6xhBQ9qIYcDm/r5J23zbjd4EyPZWjsAgNsHeRHsWBnBLAW3?=
 =?us-ascii?Q?IdgjdMfHesAy59BRetxFr8+tR+RGBy/PhsmaFvq9mfJYLTowQF0Irk36b0K6?=
 =?us-ascii?Q?IBG41yPvzKIKweuPxI51E4PY9IlERf1z4WPB0Ta3CNwCe0pYgu2Wfa6biHo1?=
 =?us-ascii?Q?tTy3MOvI4a2zCqizYfYBEyJX8XC8BGjcAqyoAWG8XHFRN9bL6U8mMvZcIRfY?=
 =?us-ascii?Q?ZtNvf16IV4GaMljgPMzdeHegzjdF9cCQRWlR6PFeI++VcN347ORA4XzfgGZM?=
 =?us-ascii?Q?Xn5s/Pw6R4DJaIv/Tu68FpXZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f34325-8b89-4fe8-78b0-08d92a651e06
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 10:06:43.5680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MR6kYWMD9ODzAYOmcT/KcL8IVaoWagPbSG/BtolIY3jQYq7PzAzBElT/DAyQ15Z5BLumXJnsc/wzvC8kfwdEkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5104
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Create shadow BOs only for no-compute VM context and only for dGPU.
The existing if-condition would create shadow bo for compute context
on dGPU which not what we wanted.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 74c7d8b21c98..e2146caf6866 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -908,7 +908,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 		return r;
 
 	bo = &(*vmbo)->bo;
-	if (vm->is_compute_context && (adev->flags & AMD_IS_APU)) {
+	if (vm->is_compute_context || (adev->flags & AMD_IS_APU)) {
 		(*vmbo)->shadow = NULL;
 		return 0;
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
