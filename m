Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD422C4CECD
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 20:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFCE206D9
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 20:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cu62Px6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFCE206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5353789F6F;
	Mon, 27 Apr 2020 20:06:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB5489F6F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 20:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yim3FTNN4Na5NQbQatYbGmBcNEF2MNo9snzN34B5NU7LQCbsZRaxrtdxWifBw3GO3M8szVRVyakjpnW1V2CU8kMxsAWASE9emd+Wm43KyUbv/RvRf4R1RtoQIhcW0eXFSZdSRxC8sM+xoLITxGbVD7elubOYXqurjpKm7r7KeZ7Zh/pRIfncH64qTBK7ZZCdtN3FTnP1nyg7hmIC/IjcnQrGLcu6g/3n4Iln2BhCroPh6PGYZl6teOI7yhRjpwIeUpRSfavmG1FWc5O14BqzvtYJ97/XwB0F3ggdcH5bxkkBTkqRzcGVRFeJXRYDTsWLqAzHgY8p1z2nutZcrmHnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPqUr3/e7JzhejO8phj2IMwQhb0aY3DC0RAt5x/WChM=;
 b=oAKXUJ8JwDIEaLgCVPHJY/8k3li2UcPXWn/qaaRRuPBP6ba5t8pAp6BqeCTQwymBaOQWagn+F1fw4woAzXFKrRnZXwqR+AYZX5HzmorLKENuJ33oa4PtDVe/9scHVWhcn8DroHUWKmqTAdoM/euvPwYhEGxmddm7wS5Ggpi9qwYJVA+dxCR/aCf20/02HBGLd+Vi29Em0TawdHJvdW5L8yNlphXOTcoN4tWnMYs+5XdZkHnMzaVAED8IAvTKKPbA+c+dInh3Dhtum/nWKBNZAe9FRVMJyVPu2MiyCjVVuIoGMLzhpxSMRP9QHyiO5zeYcGk2L6xEoFWsfzrxmOHymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPqUr3/e7JzhejO8phj2IMwQhb0aY3DC0RAt5x/WChM=;
 b=cu62Px6QZto+jUHUfVF5RExEwQZIMTGdnUYGfRmy2fqZfRMF8vNXJ+rKlYeO7UY2qxzOw2GXXkchx9lNEWk1ftKhPtRyOYKj23fFY6fXCqVVCkj9djEpjeKsA5qho+KbAgHSWpfjzQd92I13AUH92ErSqsnYrupZpnlGEoz31+A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1609.namprd12.prod.outlook.com (2603:10b6:4:10::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Mon, 27 Apr 2020 20:06:18 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135%5]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 20:06:18 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn2.5: wait for tiles off after unpause
Date: Mon, 27 Apr 2020 16:05:57 -0400
Message-Id: <1588017957-6910-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YT1PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::19) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 20:06:17 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a24bd933-24fc-4f74-d128-08d7eae67277
X-MS-TrafficTypeDiagnostic: DM5PR12MB1609:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1609A7617AF676F5E6FFB434E4AF0@DM5PR12MB1609.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(16526019)(36756003)(956004)(186003)(6486002)(8936002)(26005)(2616005)(6666004)(5660300002)(86362001)(2906002)(81156014)(8676002)(66556008)(6916009)(478600001)(316002)(66946007)(52116002)(66476007)(7696005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08YLZJKV5KMWCtQ72KvN9noSQ6EqfzMrZPof4AnW1ZOSoxwThxcnFouJBTTBdS2qwrtiWaErN/OigYQJYRAy2ftRclCoj+iIws8+g91wAsVTLtk5smOgLLP1IfEQ+LZtHQrriuzG/weVZ0QFa4VbXI4LW+YHl/XKm9FMF8h/QJxJsLAbopgeZFTbniF+gNW6VCkPtr0CFjKsMHUy1JKEIzCGO/N5lXBN+8fRhctVys21i6qVxpL1LGmVHysO4ED2I0ETiYe6nhJJthZqprw0xIl7WoUKcNAjGUB4YB8LnZJa/bs7S5YEaG8LiK+n/RKF+xqcwj1OT1zm2X9MmZQcSE4oiB/pnUVvyigfH6BXMmLjPaNBrVGayZ9hYDNJXofns0pvNJJDSmnRDbTTRLrRxU9eg0+7pMGivtKaeJRGWWpXZFJYsokQ8VQqzUYT7jGp
X-MS-Exchange-AntiSpam-MessageData: J2iKWz85slbR3FqQFHVSEHNdqlMh2p9evjeqzduXhxo9D/2ld0OmKe2OgXZMLCRerG40W0ETdNUbDdE4l2J42dSrew+SrkN9U3A33R6ghLtfGdRn9TlriRyp9yWokekRgsQn/MBpoI7NbnROX556r5K2ILMoj0TfgQhJgdwHXqMKrJcYXcmNR2texEN0fXRvt3rv66dOnZOF6mesckdvd2MOPbsKZPtq5GKAno7+l5afn+9ao19feM8RShy2p8f4PoWaSfTUC5H1PPiVXQghb9Tur9Tc/QCKn55fqN0F6z5J8zaMN5HYM+4Znr4zRuKeHxbVRVe0Uzaz3MdUzKhUvQKPwNOnGTa5/pT4qXAv6dpjzGPI2Em0diyl7QBTp+0rLuiw65kXG6ivq9P5uAr0bGMO++wzeUvAltKE7NarFbekpvGglvbwfsK/napsUyYqqROiLPDv6Xk2C+75WCwIrFxRmPDyPHpI0CniundRiAEVbg1R8aiQeSecg+ezh+pI6OelyQR/bv9xNGM7U3bOfuZhbmMzUKWx2ZLm/nocMuo7SlfIlZri7sw5BI4Fig8/O8KKKhhhuTHRa+gI24c/K2k7cSQEIu5x47GYAJmkoFPPp9sNUvAeUgGIznX0s1OduPnq8P99Tr9OxS9V7vuMT6Ujie88kVCVHR7fniuwQ9tOKt3XYJP2MUb+tA5DvJb33gKHCt2lkCCnl03a2gI0dJWA0RPr1J0h/YjbZiUaiXzJ8BHV/wLOwNslrF1yCIrwFaizYboSl+FaCJRlfoviHrsK57Ggg+a8vGAwrzeSHUo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24bd933-24fc-4f74-d128-08d7eae67277
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 20:06:18.3485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzKDC8+AksV712/Y0cAnSxmPn49ICGc9qjsdYlhQEqX/SivUdroP6JaTPgxshn5X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1609
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Wait for tiles off after unpause to fix transcode timeout issue.
It is a work around.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 0fa1c5c..38ca4a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1404,7 +1404,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 {
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
-	int ret_code;
+	int ret_code = 0;
 
 	/* pause/unpause if state is changed */
 	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
@@ -1414,7 +1414,6 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
 
 		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
-			ret_code = 0;
 			SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 0x1,
 				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
 
@@ -1469,9 +1468,10 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
 			}
 		} else {
-			/* unpause dpg, no need to wait */
 			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
 			WREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE, reg_data);
+			SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 0x1,
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
 		}
 		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
 	}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
