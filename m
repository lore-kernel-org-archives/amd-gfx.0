Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9385BC433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 06:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AA42078D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 06:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0DHzSVXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AA42078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499376E0B9;
	Thu, 13 Aug 2020 06:45:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12FB6E0B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 06:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8NhdkMnn0yTZ+b5dBe3fx5mV9a+ZOZ7rp7IGheVK2yifJSiKLugWRhyXU9vlkh0W/zprTlkjxHMFp5lgQZIaCXeLDujtSygkr9hpzesLm/8Dcz50hebXONamJDhvdH2njuG2KfCr/vvitnUfX2ihQKLZ/zAZRmd7Jt6ZwjnVny5H4ZCGZCLdyfkQYYLgughHKMXnfoMFKC6agwMPHG23S6ZCrfhzIMV6QSjdn+bMApuNPoYDSjoYPjpeZ/IkHLZgK+0ck0c9mxeV02h7cTjgQq4g5zB3mFgSCq8JpYmpoWZuuTJFM++adO97wJOj8AzkSYTYy6t7tHGbUu2m1+8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7JNaYK0+skLn3IuwSXs6SHolFerFYVOngtaq5iOslE=;
 b=HABb2VnnFoGekEwWJAhukbCGsViCD3oDzqmGMvIBJ6Qh/d9pr2pdkzTptyJZJ60uY1ZKoEhhpE6gP07cbZ+jw/4V7FR1dMJitbkUXzbrk94UWmHkVBTvT3+t2i465k2JBRI0CUB5SScCLFtQtSmUed9CQe0KfI2JLHBDzBqop/PpEPh7u1u6Ncq8na8COP1GWmGH/RoKr/27n5zkSZ2HNs5BulhuXgcjYYSKroeUkv4JnFX9TFS+5028sp0EnTTgCQuQ3mDHLeRRd33nYJNiP3agL4Es0A5WOLCJhJsMcY6yENH6ie17wbKjq523lzX8HMCv/l6bwVV/fbSG/ILisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7JNaYK0+skLn3IuwSXs6SHolFerFYVOngtaq5iOslE=;
 b=0DHzSVXIFoCYd7BL8r5//0wxTHC933Z57ENlU3otaTryInujU2xHeSBZfb1WIoHTlfF8tcNhmBToc9GPrF0eHFRpg0TyJuw2f1DyV6mQQZnevK8wW1vmoWYIF0TncjeshQddtQDg1BvZfjCSIeXlMqyN/cuCVGKas0AD6C1YCKY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0182.namprd12.prod.outlook.com (2603:10b6:910:18::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Thu, 13 Aug
 2020 06:45:16 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3261.024; Thu, 13 Aug 2020
 06:45:16 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: fix NULL pointer access issue when unloading
 driver
Date: Thu, 13 Aug 2020 14:44:46 +0800
Message-Id: <20200813064446.23994-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0302CA0018.apcprd03.prod.outlook.com (2603:1096:202::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.13 via Frontend Transport; Thu, 13 Aug 2020 06:45:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce431108-d5f9-4ad5-6d99-08d83f546fe2
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01824627509BE647838E1DF3F1430@CY4PR1201MB0182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1Or9LASMOlgRTcb/QdesKVrSHPVPUB9SBXpwqcBdxqfxZsueWg1ta5JuDPrTLvRoOTNM/ZAIRdVrXwszd0rb8uYkuEVhEO9+egKYGVE50gutXXQXCoXzj0QES5agZAVUna3UooMbG/2BRHF3NhmNxWXbsipdb/SNuFfLuh2QFzBsqPQEnTsuMh1EuDBJ1CBZ4+FfUdOWt0Gl/7I0dj7ciHN/n2FMVdDxO8xvlLSaDo57vkKadSQcUmoRm5zxjstKbUXXEVrKqNRZFtci/7vGBFesyIk0IuenZ7lLwU+1tVEqKl7qyoouaviChyYUUrvc15TVEd5lz1HuoMV/svhLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(5660300002)(2906002)(36756003)(478600001)(44832011)(1076003)(52116002)(6666004)(7696005)(83380400001)(6486002)(8936002)(66946007)(2616005)(86362001)(4326008)(6636002)(66556008)(956004)(186003)(26005)(316002)(16526019)(8676002)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZmhaE2gajEloHwkT/YnOyPI3CS2Z4xJ6pa0475h0c8Crn0Az5ft8ymdkkeXgvSXVqBOsmLLjPnIXhLRofDYYlwgAcbBE/dFZ7KwixVKdMnQftszGiIsU08hvONe8SCGvqys5GAC11gWIJYdEh6m12rRdAT4zWwdDuPP53JeQTVdIponl1musn1gIukon8SbVVtxMJLzXx9m7NrfH3fK/rXdFzoinid7MHlHsmsPfOGQcmdCjO5BQsxyOAd1jPv/OBg0NeXhrlKHAwynC917drA2u+qER38NZAmXk3Bpfy9UqBYqwWZlopjzztXUTVasNL3WivY2wISh11fCjVa80aGb+FxlOVBaUX+Ac+9cOktBP5iy5TBAi8TaeDHZIzrGZ9k3ub0NqH2/nl9+I7XfKUeUu88lZ2DK6gVGFSAplwTPVMpr2sw4Jj7YpbMYVFs3aAnwEFZaV0nthuoDzcYEcY6TQxwhaDQWqNW0eKp9zbkchv3zLcw1IpgtnQ9ksSHr7JrVYUDfXkCFkCPV5qsuBwXEsYWlgjGo+BJHG6aBfkG0Ukv4PMTQR8Cvu+LS+j4XTIYylD9ht/YDGwrywAAcswmn+o5AQR3DwpI/OVRvbP9jNsGkZ0t/iXdHXsBtDhKthQ6kx4ISbzXGIzn4+qROQ+A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce431108-d5f9-4ad5-6d99-08d83f546fe2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 06:45:16.3366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wp/fwQFshuTbR91c+Wgt3nbGm463U6yBJM/EEi3IOMOF3ht/pRQLSTd5Tzb/ci7UpiHtAF1gqpPiGW/voD45nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0182
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When unloading driver by "modprobe -r amdgpu", one NULL pointer
dereference bug occurs in ras debugfs releasing. The cause is the
duplicated debugfs_remove, as drm debugfs_root dir has been cleaned
up already by drm_minor_unregister.

BUG: kernel NULL pointer dereference, address: 00000000000000a0
PGD 0 P4D 0
Oops: 0002 [#1] SMP PTI
CPU: 11 PID: 1526 Comm: modprobe Tainted: G           OE     5.6.0-guchchen #1
Hardware name: System manufacturer System Product Name/TUF Z370-PLUS GAMING II, BIOS 0411 09/21/2018
RIP: 0010:down_write+0x15/0x40
Code: eb de e8 7e 17 72 ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 53 48 89 fb e8 92
d8 ff ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 13 75 0f 65 48 8b 04 25 c0 8b 01 00 48 89 43 08 5b c3
RSP: 0018:ffffb1590386fcd0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000000a0 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff85b2fcc2 RDI: 00000000000000a0
RBP: ffffb1590386fd30 R08: ffffffff85b2fcc2 R09: 000000000002b3c0
R10: ffff97a330618c40 R11: 00000000000005f6 R12: ffff97a3481beb40
R13: 00000000000000a0 R14: ffff97a3481beb40 R15: 0000000000000000
FS:  00007fb11a717540(0000) GS:ffff97a376cc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000a0 CR3: 00000004066d6006 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 simple_recursive_removal+0x63/0x370
 ? debugfs_remove+0x60/0x60
 debugfs_remove+0x40/0x60
 amdgpu_ras_fini+0x82/0x230 [amdgpu]
 ? __kernfs_remove.part.17+0x101/0x1f0
 ? kernfs_name_hash+0x12/0x80
 amdgpu_device_fini+0x1c0/0x580 [amdgpu]
 amdgpu_driver_unload_kms+0x3e/0x70 [amdgpu]
 amdgpu_pci_remove+0x36/0x60 [amdgpu]
 pci_device_remove+0x3b/0xb0
 device_release_driver_internal+0xe5/0x1c0
 driver_detach+0x46/0x90
 bus_remove_driver+0x58/0xd0
 pci_unregister_driver+0x29/0x90
 amdgpu_exit+0x11/0x25 [amdgpu]
 __x64_sys_delete_module+0x13d/0x210
 do_syscall_64+0x5f/0x250
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6170d7d28495..35d5bf9e6f6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1276,7 +1276,6 @@ void amdgpu_ras_debugfs_remove(struct amdgpu_device *adev,
 	if (!obj || !obj->ent)
 		return;
 
-	debugfs_remove(obj->ent);
 	obj->ent = NULL;
 	put_obj(obj);
 }
@@ -1290,7 +1289,6 @@ static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
 		amdgpu_ras_debugfs_remove(adev, &obj->head);
 	}
 
-	debugfs_remove_recursive(con->dir);
 	con->dir = NULL;
 }
 /* debugfs end */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
