Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA53C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 21:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B899E2078E
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E81xPPUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B899E2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4808C89A61;
	Tue, 15 Sep 2020 21:52:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6B389A61
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 21:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbnidH5fhsRf6iG8UIMn7Y7kzdVj7fKc+heGH+TPGLKGFLRt+B1FFIr0NArc0ESc9ws3qAhkizhDoxWHAh8IBmKpo1nmU8qrePShoatzS1CYtz/tsmnDN0BPD/HdZA9+vibS2DWpI54q8U1uloPXaBhdOXrNZXESc0x58PaVmc+lTUon8puUgQCsjjRmrNJm90UN9ClvfE6oLLMkDYUcTwDQlXLBi9PMxQhfZYjJYHQ6Li7P6pRyurjppaUe30dmihUue6fh7nVfOGdc7W90LbOIRdgg4eZSMtQCaJf4hpvmJaVx7AHPVj7d3XO4TKJ63Ue3Dud9BSHyD9QnNO0dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG5iq+PvUxbV71Pn84VC2YlShd2I7/NAg8p/pZkhOy0=;
 b=MyTc3z90HsKEwHpAfFdgnkQBz6NyDH+risW83TMm1GARgCJngPv0QrB4EUIsbje5ZzUUniH91f2TJ/Yk21mZvzYQlywDdvWYdI6MQoAsS3snTcgHiAUZhGzt29muF0QjYrfj8uR+qaorcjvWvOSamCxx8Sl+eoEFCnaYAKtQNRQSKbDXoQi/ZTmaeTDyVB/uyg/a7nPDpyp0cqCGmfh352V1mb9JPZP0Qz0izuUP0V4hOK7AGFMyuqiIDRAVnhXbhVfShAVexp/k8N9XIMrjLp8lAz28fDU83Io/C02e1Q6EXylAPDgDjpv6cM4OC2wy4xNaJttOjFpntesOeoRaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG5iq+PvUxbV71Pn84VC2YlShd2I7/NAg8p/pZkhOy0=;
 b=E81xPPUIQBujuqL87+tDLsqJkFL1bcj+agxeWeBhSWRdzbPTyknQ8sDC3kmfy5vOvvouPD/Qg3kfQoXKvqHp6v6sJxJsiI7yWFLsMPvTCTyvSYJlxQzhUwx+FiQzcrAnTekEwZicFW5czto8Kso8o9vcIGlpx8lTpNWT334sk3c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Tue, 15 Sep 2020 21:52:25 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d9be:3249:294f:1dd6]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d9be:3249:294f:1dd6%7]) with mapi id 15.20.3391.011; Tue, 15 Sep 2020
 21:52:25 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: prevent double kfree ttm->sg
Date: Tue, 15 Sep 2020 17:52:12 -0400
Message-Id: <20200915215212.2669-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: CH2PR18CA0002.namprd18.prod.outlook.com
 (2603:10b6:610:4f::12) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 CH2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:610:4f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Tue, 15 Sep 2020 21:52:24 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1cccf165-2340-4c65-6b27-08d859c1a1a6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3306241D873AD6284F945825E6200@DM6PR12MB3306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gL0MuuOUTpV2ZMFirnpDk/8Rwd1aSrzi9tAitfBYIvZEog/3TdWagrookuiXhka1By1FAQiJwOfrr3khPhOdg6v8NCjRzWNnDlxjyhNYWi7P7ybzUON1PuFJ6L5wEgO3EZrTn1PcWRGuVu+L5RFCJppy2mXlwAvCp/q8+oxryaGbZpa7dV+Fjsrk5r5eXXdkY9QeXIJcNJwg6uDn0aNe/LpZyth6Ca0LVztSPRkNL9IuOD/DhPTpxoH0zxrKDAFFS6Kh7OhohPwC9423Yw4luQNdsPoasNlB+icei9S5HKyyr+XSKpmCmL4s22VUivgRZr0ODxd6cGbwBVjsUO6aBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(186003)(316002)(26005)(6486002)(7696005)(52116002)(2906002)(16526019)(956004)(8936002)(2616005)(4326008)(36756003)(8676002)(45080400002)(6916009)(478600001)(86362001)(1076003)(5660300002)(6666004)(66556008)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1lgyoLYBtudMIbbJ8+4DBWsVJng4IDNkSF61hNfWDo2R/8+zyB1jolBUpmWen0H0kHk05C+YhtU8U9R8uz8tRJ7rz+qWcMLdFoepOodc5SdH8QZxgys/j1JjVaoFs2on4FCtE2nPRXSEsB+z37PwmjN/3qZ20xraVmWrqJ1OhZQlnzhUyCEhh4gw+ZNkamyD9JHGqLZmuIlCkdRU8IKOaxtxp7rpde/6kHzUvGbssk6XH8uOcQSEu730ldeEtH+r9f3ezNZxTbsdD2HhkPjvWW4dI1bOKL9gE/MF1L/9XqwRNcw+1DO3gvVgDRj4NhwRC5soeYj7kbDXP/KgYRvsDQFCR8Bs+tqWm4QgsUMESRyFftpYVswp+CNzfewTiPeawFLCxChL1VpTfC7fmjrzHdkE68LzVk4uioOfvKn5mlnvCSqkjWmfHsSPO7HbTGkkmNCd0WscqiDG2nymeVt+/+P6VncrwSNqX9k576nf/IC+KcYGpMBw6Mb5gUcdPy0Sgi4fk5NpaShfv6fYj/6Ja3tEfreGosozbd4Svc9noYgpH/T4+emHJJhNyFmax6QmwDfSj5S4gUBcUyvwVHW/+aG7qGRM7BvWS86USXHGfy7Y76XC74lu4jRKR2Tdjqmdiu4gjJjtslw9uV0XzW6JPA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cccf165-2340-4c65-6b27-08d859c1a1a6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 21:52:25.0682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjb7sr7ahBkDhdHdLFV6ROFntbb/9iQBhkSBgQg0rjmN4mRqas1JY4fJHyTqH3tZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set ttm->sg to NULL after kfree, to avoid memory corruption backtrace:

[  420.932812] kernel BUG at
/build/linux-do9eLF/linux-4.15.0/mm/slub.c:295!
[  420.934182] invalid opcode: 0000 [#1] SMP NOPTI
[  420.935445] Modules linked in: xt_conntrack ipt_MASQUERADE
[  420.951332] Hardware name: Dell Inc. PowerEdge R7525/0PYVT1, BIOS
1.5.4 07/09/2020
[  420.952887] RIP: 0010:__slab_free+0x180/0x2d0
[  420.954419] RSP: 0018:ffffbe426291fa60 EFLAGS: 00010246
[  420.955963] RAX: ffff9e29263e9c30 RBX: ffff9e29263e9c30 RCX:
000000018100004b
[  420.957512] RDX: ffff9e29263e9c30 RSI: fffff3d33e98fa40 RDI:
ffff9e297e407a80
[  420.959055] RBP: ffffbe426291fb00 R08: 0000000000000001 R09:
ffffffffc0d39ade
[  420.960587] R10: ffffbe426291fb20 R11: ffff9e49ffdd4000 R12:
ffff9e297e407a80
[  420.962105] R13: fffff3d33e98fa40 R14: ffff9e29263e9c30 R15:
ffff9e2954464fd8
[  420.963611] FS:  00007fa2ea097780(0000) GS:ffff9e297e840000(0000)
knlGS:0000000000000000
[  420.965144] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  420.966663] CR2: 00007f16bfffefb8 CR3: 0000001ff0c62000 CR4:
0000000000340ee0
[  420.968193] Call Trace:
[  420.969703]  ? __page_cache_release+0x3c/0x220
[  420.971294]  ? amdgpu_ttm_tt_unpopulate+0x5e/0x80 [amdgpu]
[  420.972789]  kfree+0x168/0x180
[  420.974353]  ? amdgpu_ttm_tt_set_user_pages+0x64/0xc0 [amdgpu]
[  420.975850]  ? kfree+0x168/0x180
[  420.977403]  amdgpu_ttm_tt_unpopulate+0x5e/0x80 [amdgpu]
[  420.978888]  ttm_tt_unpopulate.part.10+0x53/0x60 [amdttm]
[  420.980357]  ttm_tt_destroy.part.11+0x4f/0x60 [amdttm]
[  420.981814]  ttm_tt_destroy+0x13/0x20 [amdttm]
[  420.983273]  ttm_bo_cleanup_memtype_use+0x36/0x80 [amdttm]
[  420.984725]  ttm_bo_release+0x1c9/0x360 [amdttm]
[  420.986167]  amdttm_bo_put+0x24/0x30 [amdttm]
[  420.987663]  amdgpu_bo_unref+0x1e/0x30 [amdgpu]
[  420.989165]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x9ca/0xb10
[amdgpu]
[  420.990666]  kfd_ioctl_alloc_memory_of_gpu+0xef/0x2c0 [amdgpu]

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8b704451a18c..4b3ab9a25e91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1076,6 +1076,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 
 release_sg:
 	kfree(ttm->sg);
+	ttm->sg = NULL;
 	return r;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
