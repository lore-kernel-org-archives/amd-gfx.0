Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B60C63798
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123B822D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l3BO9guc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123B822D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B7F6E934;
	Fri, 20 Nov 2020 20:20:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5C36E91D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4Sf8UadInV8gkYMMrO5qFxpMpZm8YwiLHT5puLSDVEfZebVOrHMXu1Qkni9CfOQq0Jgz0UbwpE6i1PmQ3i400YFPyRwQPhInNKIW2AT3wUDZ17BbCerCsdTt3luwE5ul7rhnTDx9OCVvTZC1SwUGlrtrb5iMVO6AEOJ0JmH6nOIUYDlZ9PUm5OcekQFp2/Jgt8tuGwUpoAD+PLt3SgcTwmWxw9PnGzztcGwoefick5Nz1KwWAtX4TLyrwaQDhUQED5ST8POVegAZ3g0tgqBPnEkcqlbq3nWfEed7jIeKw2vvKkZSnxnF12ndERthSpEtLLSG5l5TuQYmGJnyiK/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy245w/AGYQvqjqG/VAajhkVr1B/JwSzmy8PilGh31k=;
 b=hHjaAwMZkve+d6OA7Ev3BX/+luFflZ2fhhRvdPeuQupvC3x8yI5j2UTu9UEK476AuX2LmJ/SaC8KtPTasXD3cHdgRBVWNaTPWOiZ/XDe1Z1/gLbM3XUq8hbmi+dBFWzuw/KEunHxJGZVGHj1IV0wvc4ZusGZYdTig8/AJWPUXNUy3DvwFuHUzh1n0JXzYkAV+YC5W7lKOQEnkz6jiza+misCGVHidPAeVF9ZK+QgDwHrlhB1c1+ek8CwkvmwENvW9wDKoRKb13AoXtMTeVjoOhMWaepirz0kzMFjofCkvgsSI2kiu0NFL7RKpRDrzTCVTKABf1mrxboNYl/KZeasnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy245w/AGYQvqjqG/VAajhkVr1B/JwSzmy8PilGh31k=;
 b=l3BO9gucIOJji7tOn0MaOlJcldvuSUkRwgvkW9+j6bFglv8rMgRGRgCL5mOLRiNeYuSzeKmkoJaTFIv+9yqn0o9YiIv/VfZShssdTc4DmoJzM1WfWn8jQ0jdOCWSUZeT74/RkAZo5ii22pi5nQCwaFh5ar7fg2RG/TKWctas4I4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Fri, 20 Nov
 2020 20:20:31 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:31 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/18] drm/amd/display: remove macro which is in header already
Date: Fri, 20 Nov 2020 15:19:53 -0500
Message-Id: <20201120201958.2455002-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57e67f84-22ab-4459-5692-08d88d91baab
X-MS-TrafficTypeDiagnostic: CH2PR12MB4261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4261E2C425B5CB014913F0B498FF0@CH2PR12MB4261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTZr13dqSLVy9Ub6hI2XW+bVtFvBFUQk016NEL4sl9G6O8YouENtaUAnKIiVcFQEFanV+qrUB8OFWJxL3XTHYl9yjwWrQcq9Lce4G1cn79gvnUYRxOLv3V14Xq2myYnDaePc3gFWlI9NqsHy8Rw4vF2DgHQrh0ljhWhjWXv5T1EowO/y+fMszQj0ikVvZZ16z0uhmwa0HjXolos7bx5Jw+kbtZqvEN28B7rNyo1u40iSgjV3zoaJhDy8j4wStgVVVxPRJDhJIHmjSIsAhhUrcSQ5Xv9mt9ieeAneEAxqWXzlqESREwp9fVkbN02eV2kqidr+ZAdcxzMO/QhWhHPksg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(5660300002)(83380400001)(1076003)(6512007)(66476007)(66556008)(186003)(6486002)(66946007)(4326008)(4744005)(2906002)(16526019)(86362001)(6916009)(316002)(8936002)(36756003)(6506007)(8676002)(52116002)(6666004)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cVTw4z8l5srYVhgfnDiVyH6uSqf89nAmRKeku5edpefrJVX3yBw/YnKcc/AbcFQbFRktu521qnLpX0Ckz00ScSgQQBxl8YZOsCZoE8x5+l5Af5mKqJWQOfpdn68g/3kDTVNC62ALhdnElFN4Nl5jcREA+njOG2EH/63NvBVuCaTXb9APSI90L/ClXzEBqqNnQy1cHmoKpgFM23e1gybFeHfwLvbe9kZuugSs3duWBhFHvSgIZIEe/x+Uh9ZGARr051UOvV+yk/spyUlXLh7OZwNSgZ8r86Zq5ilXZBtYo3e4QKYtIa60CGd1s+eQfBRgxCF7F6fyzqnRJAzuHfZ/MOcz/JNcaU4uzVRI3v40tWUh4RRN2qtYrRHC14Uj6w7JGRsVoJni2gh1UgOnOdGX+jxIs1hO9WrY0D+kYHff7VJ/rGucFHLSTA6ZcdQAqBk3uivGzvCYcuCoPsHA3tJ71chZy073z0P+wnME0PpDZGh1OUZHDvrCxeCv4VHKoPbAMaEMG/QgPoz/szsHMH9AgoKwXPOllUisIebWCitKyI86lulf+2N/ful0hoW0n35RQsBX6J9MXOQh6Dwp8Sk81Mt1rZcZ00oyYTKyS0B0FnbveBQcSzKqUJ1OudIkWWbw0XvggWPQre4lLGAix7GfIjDiisBLwmqxbfzRe2I074uie+DmNITxuOPGY4Lyb2tHxsyjS4X+P01v78tjVPViibliIU8rBnx8W5VuTPBYC2i73pnqQUOrvVsATbdvdHGDCYZhOM3rXjgRTJWFSXNYzSz23uf9X+aaKBlhX6sb97CIeENgbBeNUMhB7KVQdI678fxWGasdY4miAARZ4l8scDTdqr/9mCRC88N9OdVDkNHF0hqv1tpmshq79rYy1/FoRxnEG/FViiIXpoZjZcbSoMPTOhJy/gHsl6R2ZD8ZdfPgAE3KFUsNit7tRmtR2P79
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e67f84-22ab-4459-5692-08d88d91baab
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:31.6189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0SSa8SfapIBVQWXZAkeDgecXV6XYNd5faPo28IbAh/EPi6UpnGHFuyyJraw5lpQhY5vgD8RybX96iq6SF0mCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Remove temp macro since the enum is in header file already.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index bb6b546ec6d9..b2a712c7e469 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -65,11 +65,6 @@
 	GENERIC_OBJECT_ID_BRACKET_LAYOUT << OBJECT_ID_SHIFT)
 #endif /* GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID2 */
 
-
-//TODO: Remove this temp define after atomfirmware.h is updated.
-#define  ATOM_DISP_CONNECTOR_CAPS_RECORD_TYPE 23
-
-
 #define DC_LOGGER \
 	bp->base.ctx->logger
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
