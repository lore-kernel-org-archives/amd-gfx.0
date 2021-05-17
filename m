Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3412CC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 08:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E701161059
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 08:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E701161059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 727346E8F1;
	Mon, 17 May 2021 08:26:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC346E8F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 08:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH99GsPqYDzSwc9Ydk5qrV123MUpTm+AR+RkeypAqiCmbMTsjWqnKZ2fioOhiuxb5Kzdwrf3793ZvjTPFoQT5LJclCOkS3wmjVgDoHIJVXo/fqFqaCCu8LxCLMCLvoANTbSATypLJHMijFzJ3EdKvEw5Feiyv4GE476AAZ5wr4ATzdLGX+G2UN4/Uc55Cn2MmVP4ufacHwHYP9GW/4o//DV4mstKC3n+KlCqi4BGlgWLhrCrQ31UcQ1wsjvafitYogbcKecMa4ng6kXuQyQmfon8DiuIyZTrX9YsLqzrPpQzgW2E9wC5w361PQTE8j3gWjxPlgFu6JBkgqfBwFTHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QayU+bxxbQiwNbqyr6C3SKQLJyBzpV/FLYZ4g1QSRZ4=;
 b=NR4g3jdfwIP5zKa4g7OgvBD21QM8qkUmtFX+sFj4VIs6Fnr0PDwgM1LmnBd43J15M7vYWgTrqU44Br/XARkdjtgE7wzYTc/wOcmAaPdepef3eQhCwhTP7U1ZC9SsRuhZhaJAC57ZqTFX7jbySR1pI8/9ktdybj9M55Ov9KVEAmQptp3fRzroAYb//EUtz1Y56F0QIE1izcX2/6XOktWgKljIoyy1bpqO/kz6X020HUi/nustq5EVOpA4rzM/Sfvg4MFYiUPlJrdMnM7cmJ8mrDHgXAdnsSEjwaemgM/6tuK75RtWTuP96ldffKqRQvf9rZ1zG9RIUT1FWkfpOUYQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QayU+bxxbQiwNbqyr6C3SKQLJyBzpV/FLYZ4g1QSRZ4=;
 b=NJOi+oeZIse5ox/hM1snFgFfUM9WyRdnbjScFQ9EibXRYLhBOf/9EukkdxMJqucqb+y1i6gidG+GJRnOtmXFtadMoHNQQnszqDcRzDyRp+gvZvdYe2lwL7eb1OjbLxc8a0yKGWbUnHVc3/54eI5lVFeQTFItnBp500sOe2x3k/4=
Received: from MW2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:907:1::25)
 by DM4PR12MB5279.namprd12.prod.outlook.com (2603:10b6:5:39f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 08:26:37 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::22) by MW2PR16CA0048.outlook.office365.com
 (2603:10b6:907:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 08:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 08:26:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 03:26:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 03:26:32 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 03:26:31 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: fix refcount leak
Date: Mon, 17 May 2021 16:26:26 +0800
Message-ID: <20210517082626.1528678-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdc1c6d2-905b-4ca2-d8c7-08d9190d7cc4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5279:
X-Microsoft-Antispam-PRVS: <DM4PR12MB52793061F5CBE7BCF670D1B1B72D9@DM4PR12MB5279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7S1l+Pr/OT7jpTzEHvHQaoFsqGZyERoNtAWh2ZgzxqK6jE5axHeYoZQ/nUn46xhNtcUCuG1aw0w6Xl3XCcWj6LWRl/m/lNglRhoD3jOnMnTBKIWoz7eqq9wXp/ZajpSu0jHsugDgCgI3X0vRZ2SK0hxXT8ULsaEwEGbmZgI3zfjKUvLWz16f860LvV6XJilh3Z90BjmasaJxAh3wx0YuA/LjIV78Hy1qA07Drk+GDqYbkcK19iwdMJGkR4nKyA2gb2PysijLUi0CKDijzxdkE4VM1QMu6E7KAedAvsYLcqgLwqdU1ey2ARbD7SelXuOtlCS9XK2tzDS+izP1vcyjaHvT66SLzekSBDckOnYlFnjrne6dfF3YxeJmgQUs94zftnx8j43YmHbtq5GCRZQsKLLSi60CoRmZuajo3iJrY7LmMPBb4bvBk/KRcERlweUsiGj9mL12VdemtCC3fu5KmG8rUnbt6OXp3rWrumDK+ssYyLyXrLptcJ0ukTOEJ33b4JEucmG9SfjJvmdYytpTuzlrca2ibx5iGjojMePCQz5dIJ1kiIEpNJSr3lefPvOjjCarq+QwjKjxr9i/XqkXwVdVe/snltKkcfo0J/SdALwuU4mIJd6mHzzkt0Vn4sLvhxuOu0/e6s6JqR8k2qcVodfhJAkfdx4n1XvCyL9p6vbWhPfqbUWDOZKGPwoLIBC5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(81166007)(4326008)(47076005)(336012)(54906003)(316002)(356005)(186003)(6916009)(8936002)(82740400003)(86362001)(2616005)(8676002)(26005)(426003)(478600001)(7696005)(70206006)(6666004)(36860700001)(82310400003)(2906002)(5660300002)(1076003)(70586007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 08:26:36.6591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc1c6d2-905b-4ca2-d8c7-08d9190d7cc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
the gem object rfb->base.obj[0] is get according to num_planes
in amdgpufb_create, but is not put according to num_planes

[How]
put rfb->base.obj[0] in amdgpu_fbdev_destroy according to num_planes

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 4f10c4529840..09b048647523 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -288,10 +288,13 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 static int amdgpu_fbdev_destroy(struct drm_device *dev, struct amdgpu_fbdev *rfbdev)
 {
 	struct amdgpu_framebuffer *rfb = &rfbdev->rfb;
+	int i;
 
 	drm_fb_helper_unregister_fbi(&rfbdev->helper);
 
 	if (rfb->base.obj[0]) {
+		for (i = 0; i < rfb->base.format->num_planes; i++)
+			drm_gem_object_put(rfb->base.obj[0]);
 		amdgpufb_destroy_pinned_object(rfb->base.obj[0]);
 		rfb->base.obj[0] = NULL;
 		drm_framebuffer_unregister_private(&rfb->base);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
