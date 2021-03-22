Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD06C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 07:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF0561927
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 07:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF0561927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA7906E3D0;
	Mon, 22 Mar 2021 07:23:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388466E3CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 07:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCzPWb+P5rrf6gkV3ACFdo9hysyjWxGyLzjZ7TUQG/8dJegjPxOTQt6x/Z1GHvgfQTPvuILQWDQendpeuqn0dnk88e2RrN62X5xq0NDl8rtFV/V9uF9APDl6lGHRiAEanEh+v/oRiGPP27S/dK9ZyTYgm0ZKINUJPf36lY934znBWSd9fD6vllXP+4dyadzkFGvjvQf1QBkZmCJcPrWNV6AcPgkoivDVQmU0kd6Jk1ZLgAOLD6OceXnhqKQHGA2YLNooLdf/cUYzUVklnTgmyRPyB0bIdqlnablTI1yrmf7DivjR0I/9tye5v+pF1FQU6uZVX9HqlJcN0zYO5XdZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAxjYJFk9gYIxwqhU+Vr8HkA07Td0/bsyu/aelwK1Vg=;
 b=n6zWUrKRSuvThnhuTcajPe046sAZ1TXMpHBPz5NDUJmAwkq4BvxFuUsqXH9XIN6n8NyKY64SG5toPXdJFeVksFKGR2x023Dx/CcXhzd0OB46JfAodHmfc+6/cmaW7KQ5+KM4H3MWF0SO5Wtd1yzDZBZg9ooWonkmZymmm+IDKI0aYbzDtVsqRSSGBR3ZfwMRxSVyQBo6GcIy3BHtqelbxYWLfBqfY3NazoJ4b2L6haSxi5lERaKsdTat5hZIsBUon0ne7CSFc71/WbX1X0AMMmvhurrSrrB5A9JAxZKXhzlIdKrHsrdJD/L0atQtdqcbT6gaseX7M7IBZzcksFNSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAxjYJFk9gYIxwqhU+Vr8HkA07Td0/bsyu/aelwK1Vg=;
 b=4muabCNC1ADzYp//f4zg8QD3mIeW///4HmbivygOEk40Pa/cn7kAQIIRceRgACYFMiY+ZAkx8SsxSUusSZWislGLsIKfd7v3ZEJiHe7Gw0H59fvYBsy9QLYIdNEdIS+yNK30wY+diqICH/5Ka8J1s/dg8ewV+kcF7/EAmqIDw90=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1510.namprd12.prod.outlook.com (2603:10b6:910:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Mon, 22 Mar
 2021 07:22:58 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 07:22:58 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, lijo.lazar@amd.com, jiansong.chen@amd.com,
 evan.quan@amd.com
Subject: [PATCH] drm/amd/pm: fix MP1 state setting failure in s3 test
Date: Mon, 22 Mar 2021 15:22:31 +0800
Message-Id: <20210322072231.23096-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0057.apcprd04.prod.outlook.com
 (2603:1096:202:14::25) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR04CA0057.apcprd04.prod.outlook.com (2603:1096:202:14::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 07:22:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 482dedcf-d001-4360-2f19-08d8ed035170
X-MS-TrafficTypeDiagnostic: CY4PR12MB1510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB151030C8D474127DC855A97BF1659@CY4PR12MB1510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LtBFZCqjriPCAOWP+CVLSl/lmuau4eqXqTvQi8nwifADG1tZPhJ6vmshziBLE+LTr88l3/yq6o/LIeyJFeUQ+0OmbuBdmgye/KetsNBt0NFdec5dshSih12IEGY9An42sx2Pv12nM313b2yteHVslHwwUm63S91bDK7qItIio18fps2ElpScPIzpTCBlIuTpYbi1fbOTvl6nqQhqdG0QxWFA38DXVR4AU2a1/R+b6l83XzXcOeLvXWFDc0C9O+Flnd/x3kPogMVk26ii+KeQhicGMekHAi9OnbjMQrBTENKPIC1JjmKRvjMOyY6T2ewyTbyDfy+9CgLx6Q17Vyew4SaionHKcKZClKhdAu7k0tZmzDHvcyoQ4U28txCpAQ+fguAl8Rz4ecWVECppvJcacmqzlRo85nRUqz2/YlBOWXMN0YmP5jyUrSOfTcTI2tCL3YgiVcGQMWQP6ezT8XhSfsPSMqDnOvYyp8SeqwrisZuGPYBA8wNPbNud+cpoSTuHO8GwBeSUIm3MkziFUnvtV4u9IM+YiMAzBKKvmXtnw4tobTsuxAmiao7yNc15BqTg0cS7gZX5HwjNCuNYALFTTkhLquZMKwgrraaeI/lvBlorp8xbY+TS36bNyMeB9ORZ1m9/kNrW58jMjZYM3rJJWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(8676002)(36756003)(8936002)(6636002)(86362001)(52116002)(44832011)(478600001)(6666004)(38100700001)(2906002)(5660300002)(1076003)(4326008)(7696005)(316002)(2616005)(6486002)(83380400001)(186003)(66476007)(956004)(16526019)(66946007)(26005)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cu0sCehZwXD3Ap4SUMfGVePmrX48/YvkS31furjuWz94lgNUobqYv/t+nrHx?=
 =?us-ascii?Q?niqTJibAne2FVYnguM6fV8Jg6tKjeXVi1kbr/cRIANcBKS3LH6bCMGS6N+41?=
 =?us-ascii?Q?bhvVMKGPk6yNm9TzPdvQukEpZoeRBL+tkIUUmu8DERtK6otTM/wA8hIr/TX+?=
 =?us-ascii?Q?hiknSTJrX1P286GIvNJhPtRud1G+HPGuCKhK8IAWD0VoykN/Spb3BunF/lMS?=
 =?us-ascii?Q?yxBDbjLeI8rZTvArFneZc4NN7mx8XJz7DW+SWJ/Jjy+307kFWtDbPGN+2MqT?=
 =?us-ascii?Q?EbxXeov7p7DlhDWCKO+CnwZ/q62HqB4dn+xvkqrlX4K4ZIJchoQBtTErSuS6?=
 =?us-ascii?Q?b6V4BAEEowb0AGsg8hjNPWOLIBTU0Fl/Q+Rkb+KUpegP03pQsiF7C+SIQrPE?=
 =?us-ascii?Q?mKu/KPUjSxG5OLWNlSbjI8l5j94OiKr7eYWNt0GqrG4zI0cIFFaZFOvRLzIl?=
 =?us-ascii?Q?0r62V7EXCd+LQeCl1TOlpUqTCjwEuGJLJMQgIObldJ50PKdtSy4qAxK42Jyj?=
 =?us-ascii?Q?g9Vmk+T6zfr2ILHruDsYlr+nlkD+7bwg6Mo6w7KBdeJ7YbAdkwWAkPIxgvu1?=
 =?us-ascii?Q?Ty0hiq3HMkxUwZkgl8dv3rmtPzgjVjfwVthWfsQ1rQMP+7rc+Y8uoGk42QDn?=
 =?us-ascii?Q?bIoYtPPvMB0v4o15eQBoDs6dWx9i1kKL8f+9mGbwV9UVODbi0Bm13l1ydzS1?=
 =?us-ascii?Q?vpaKyQ4V/sJ8iiOouEx4Sj7HJrNw/K56UH6SkqwgbEDbJ3oftfJSrLBk1FDm?=
 =?us-ascii?Q?MhripBVpH6BO0LVcJbAuQx7ZWDV8s5M126MAdL3NjK9mEu3KHN1TI2hEzOxr?=
 =?us-ascii?Q?C4FoQCGShsmQbTJXGgC+52oaAPHXQOMfQfsUdCdIuKGfTnSftWmnNxjlIeXI?=
 =?us-ascii?Q?wheFgsRBW23Ey6uGNpE3ncpWGQ4yBGpYTxiaVWcQbBB4gPfV9aeCw+6jwfiY?=
 =?us-ascii?Q?TsC2PGjERde6CxXq4ovWLrnP1zkPDNbAC8lFJ9q1d8B6lAkvq/q8ynM/7cMr?=
 =?us-ascii?Q?sXRdhtIROOVX3Twzi5a11nZW1tCm0x7lZ9NOMOXOIf8gW64OvjtKTVzuH/N2?=
 =?us-ascii?Q?RI015rSiKrLZ0X4nfLtAvPAn8YxXEFgwvpPqs1LLWp0jyHbst5qJBGSopLhj?=
 =?us-ascii?Q?Xe+lBanBPYYNVkWM8yjZY6ubmE9l4+xLf/y6HaDi4d/cPtO1gfSWSiepfMKJ?=
 =?us-ascii?Q?IGlVj7vV5eQWRqP/hwEkNRuOCoPlCqAtWUy3WsNGtSr1EDbCHuw3PTNqdTa5?=
 =?us-ascii?Q?qGdmnrjgpeLEtdvl1CCOVUH73HWgCFjqrtbHdc4NQ5332NAVJHWmzIYoS2dk?=
 =?us-ascii?Q?0J0pwz0XUN5rO2EcRIF1tmFi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482dedcf-d001-4360-2f19-08d8ed035170
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 07:22:58.2635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLQFb0yLf5nPDoSLJK5ohYQKdkZ5lLQFWp0wDuS8iY8h7AZf0PsIPrJzLBBkMLHBXNEjSq2rA+MB9ftwKbrSyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1510
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

Skip PP_MP1_STATE_NONE in MP1 state setting, otherwise, it will
break S3 sequence.

Fixes: c5f427745ecd ("drm/amd/pm: fix Navi1x runtime resume failure V2")

[   50.188269] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* SMC failed to set mp1 state 0, -22
[   50.969901] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[   50.970024] sd 0:0:0:0: [sda] Starting disk
[   50.979723] serial 00:02: activated
[   51.353644] ata4: SATA link down (SStatus 4 SControl 300)
[   51.353669] ata3: SATA link down (SStatus 4 SControl 300)
[   51.353747] ata6: SATA link down (SStatus 4 SControl 300)
[   51.357694] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   51.357711] ata5: SATA link down (SStatus 4 SControl 300)
[   51.357729] ata2: SATA link down (SStatus 4 SControl 300)
[   51.358005] ata1.00: supports DRM functions and may not be fully accessible
[   51.360491] ata1.00: supports DRM functions and may not be fully accessible
[   51.362573] ata1.00: configured for UDMA/133
[   51.362610] ahci 0000:00:17.0: port does not support device sleep
[   51.362946] ata1.00: Enabling discard_zeroes_data
[   52.566438] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
[   54.126316] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
[   54.126317] amdgpu 0000:03:00.0: amdgpu: Failed to SetDriverDramAddr!
[   54.126318] amdgpu 0000:03:00.0: amdgpu: Failed to setup smc hw!
[   54.126319] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <smu> failed -62
[   54.126398] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
[   54.126399] PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -62
[   54.126403] PM: Device 0000:03:00.0 failed to resume async: error -62

Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 0a6bb3311f0f..15e239582a97 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1027,6 +1027,9 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
+	if (mp1_state == PP_MP1_STATE_NONE)
+		return 0;
+
 	if (pp_funcs && pp_funcs->set_mp1_state) {
 		ret = pp_funcs->set_mp1_state(
 				adev->powerplay.pp_handle,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
