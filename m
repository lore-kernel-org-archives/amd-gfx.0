Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA5CC388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 07:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F8D20795
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 07:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EgdiZB/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F8D20795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6348984F;
	Tue, 10 Nov 2020 07:50:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 865F28984F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 07:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8LXwPr0AHsKZsk8+gNG1BHH19lskdJR6t0fLTA+If8wZOA6k8kishbFsnVD5OJl9dOhrIHddkRj7BCLIQgUG7oG7nBtynuTc58/fiHQEvAhd+g4edS+JeTcSDDiSfWsC29IUa2uSePAKseysbV7FLk2i7eJJNgeiucCvvpfE681TsDYL2cZlnljwsSj1zKeYO4BfAsHbQdsi4FmVxkB5pD2K0lav2/P2uB3by2cDLoY4YHGxZGruaowK2DQJRRdRxTQVHIEaLzTIoemW4mJASQDQwQNvp2zptBnIN1wc1kTSM+DypvX0a0PBslRsFKX8D7cMegMeIOd+I9Bg2DokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxzoKaM4r6suO7Y++i4mydhKLRu9Q7pf9eVytEho6Ds=;
 b=AQ4Ko2SNKRlvlSsilTFM5f4SAw8c92O/Srtf3r2h3//qeDEcRIgxlQpkU9f/I788bwkZHUT2qkZvBPEIXQAItZJ7yGRybe+osESbzgEdSeD6/siEL3B8xq16PMHVWCzGh/gMaYcNGHqNvVT1kVnsZO/R5wlL0HN8Xc2BWfSG3MccvecQV223PkY49wmBJWf4nPDYMk1IBNXkHZ8gqrOk4Q1/eVORn3sh9wFJHsl8VyhXrAPC4hjy3UlC6KJEsNOabGU2ZmhR91uf1RBbG7Zr4UDXqKw5MR6H8BglF7QzM9IET+zj3ODxxAVTNZotH+sitYbrqvaJsoqyJNwJGC7jqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxzoKaM4r6suO7Y++i4mydhKLRu9Q7pf9eVytEho6Ds=;
 b=EgdiZB/8TrSRfFRsW6VaYGW7bgGsfjhlRDZNk7R3LBEa/B+anEUAMvOhhy2PmeePFbg6LfwQpaKHbRqosdKEahHZfWhJdDRFnuPa0xDqQSempIFz5gnU2HDSnkSk5scEnZtoEDOnEqBtcwWl2wdlKXxJipxRRemeNQVrMMeP1rA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR1201MB0172.namprd12.prod.outlook.com (2603:10b6:4:51::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Tue, 10 Nov 2020 07:50:17 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::8874:6c82:5323:923c]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::8874:6c82:5323:923c%6]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 07:50:11 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix memory leaks in S3 resume
Date: Tue, 10 Nov 2020 15:49:13 +0800
Message-Id: <20201110074912.54097-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HKAPR03CA0018.apcprd03.prod.outlook.com
 (2603:1096:203:c8::23) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-T495.amd.com (165.204.134.251) by
 HKAPR03CA0018.apcprd03.prod.outlook.com (2603:1096:203:c8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.21 via Frontend Transport; Tue, 10 Nov 2020 07:50:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74f6345d-7dc6-465e-2119-08d8854d4025
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0172:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01729AF2D2B40A84DD8A9813FFE90@DM5PR1201MB0172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpFcfH8L6lJ73EehLYnpTOhvhkPbEg9ySkRvm1bjRV2vLmA+lFagxKUCsqiqWTfeekLWSKSWIf4CaX00L0hZo+ejoC3+k2FBEJfXD/kKOoaFfG2SgiM35/WG10cqpNE8t8vYwtuufC+xUX9FyWPJNd79OmeBtXgQ4N4H2mfRXuQaSpOtAbdk4e60J5AjI9hQooXRqRtQulNGv4y7LzrRK10cd4UoQCsUUcMYfvS/w//5A8uEX3J29TSShu+A93Ce1/5vb9DK3xtE84ySERvb0rrKLQeJj8tykPm2opvmHLCYMt3IPAJH605mPlmoWg5PaHsmB3U30mM3X/95Q/E+Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(2906002)(478600001)(186003)(316002)(6666004)(8676002)(4326008)(7696005)(16526019)(8936002)(26005)(6486002)(83380400001)(5660300002)(86362001)(6916009)(66476007)(44832011)(2616005)(956004)(52116002)(1076003)(66556008)(66946007)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yJO+gkqk47mHKAMZAyteN1qj9Jw2C8WaNvzPhc2mLkGbBlZSPQT44MwPN0+gR7OpK5QWrbsH+EA7PukpcmizPNdDr/EnjcnQdlY7RbEM//k+qGGdTevsgbPqK/g51jCKX48yXBhHH5Es0WsoDwUk5RialknB6oDoQ71lE7kFQ2Y3MtNmmvqk3DbIKqV4wAK0Iuh/ogZ7MflcCw53+z3w4wgQY7HzOSB6i45hKsQJxTD4i1GR56HUDcAlY2gq2LZJBMrpUGv6CmbyirNUjIZs8awa1vm2wlCyo/rOOTd9J6J3MuYoeaJ/UoVSnjW8XacFcA+Fm76nhT7bN1VX6FwLPXc9KT3KImmlUT6IVgj+miruhRBwSdzbpyrAHGr2uzkzY0URccSGvVOtftPk/Vftpf2V07oO405MMwGzt8KAhkmABlYll9dUv2SvG/1mOJ666RPGMkoPs4CuKXBIhq39FsfNEspgOUy0Uyv55jumUDq1m6KPWiOxawTh6TnFPsz6WiKxJA4UcdUPtkkRlLP3mizrYaxpi4ndgoR3MEGahdCPw1wAY2n/vix3nSkJMhyNZAK8vSlh4lwhKPwlxJe/N+OYIHZz1vw/REjLu+dcXej/amx15nhzJIU6S25H8wEZf9o62ZGfz3X+VMuOJcqVtxJCkO/Og0VfQFCiKX0xa7mTqfIy7mmblYg3AAPZTcxJiBkjaZciozpotTXQq3jDcLGOWlovl2UzN6/pQBbt7tvY7e+PIoJKmBumCSUWKfKHtpuRpvmORarYXLZOVjUE91C6ObbqYdupN0fDOHuhigYZA4BJP31AdZzofZOTzIumtJhQstFOVGT/ZhEbmly13CEf3cTct5j3VNMtNafD1eQjzDyvmb//ZjwJBpnxi5ptGEQ1MrQvRx+WTCAhGNHhnw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f6345d-7dc6-465e-2119-08d8854d4025
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 07:50:11.1864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jmyz29SmRyUG5/C9fz4w+bQH5JRQLmUmLUK3010wgXFVQ9QpG8MsbiEEsn53U0b410G2JzID4Ta8KX1MRqwgLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0172
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
Cc: Stylon Wang <stylon.wang@amd.com>, Alexander.Deucher@amd.com,
 harry.wentland@amd.com, Nicholas.Kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

EDID parsing in S3 resume pushes new display modes
to probed_modes list but doesn't consolidate to actual
mode list. This creates a race condition when
amdgpu_dm_connector_ddc_get_modes() re-initializes the
list head without walking the list and results in  memory leak.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0b6adf23d316..715e0bd489f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2337,7 +2337,8 @@ void amdgpu_dm_update_connector_after_detect(
 
 			drm_connector_update_edid_property(connector,
 							   aconnector->edid);
-			drm_add_edid_modes(connector, aconnector->edid);
+			aconnector->num_modes = drm_add_edid_modes(connector, aconnector->edid);
+			drm_connector_list_update(connector);
 
 			if (aconnector->dc_link->aux_mode)
 				drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
