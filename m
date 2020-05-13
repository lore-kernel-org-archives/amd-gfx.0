Return-Path: <SRS0=jMTE=63=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228B0C2D0F6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 03:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDDB206A3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 03:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZK5yyqpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDDB206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B8589C18;
	Wed, 13 May 2020 03:38:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A7889C18
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 03:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E92RaBfL0MBx2M2g7JAmpfvUZez79CIoAtByQQ0Bg9qeZqj7yzp/LkPF3j6VWkJ/1dkMUGvRT8DeZzLOJVn4FD/ho77ufCUp1Bj/zjvTRRb8ZIdyrzartel9OH9EbPrcRRwWKyYCtNWEJUM4+J+4vBehNVx6UdDzEPJxxD7WAJiuXp6cqG7nVDfae7rCIO3n2Wb+RrbOdmUymIqksWn7M3wyYelyn1yjV5TLzyEVM3EkNum/b/jYCKP6hHqFjqSL5Q5PX1dfOlVBenh5kjk9wyJM+Qw8U7wg/sjbvFDFFwfry4yIJZu4kr9toWoVykKMj7gX2SEmYMuyiY98wNrJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CWMQws4WKX4Jn6bV2V9iKNzpit7IxDWjnDQfj/QSbc=;
 b=fHM5pjYaloBgC4MMCZu1qH80oi1E2oj8Xh269kEOSpHuE1+tDmU/SeDtSppCpahRzaK1IDDJc0f+ncucgdvH7ze4Md3YVGRgdYY7byPKbHj8+qfg/uZKZRoTJWpUuFIqcNklNV0T984jZqUxLbYj1uapciNllrbk7hT0KrUtGHNr2JAW+BtMzVJjqaVRbPCGkuZ4yGqTjPz9TKPd6WbYSCZmas/QZAzvbyQj9vHOIjNVHamuO12hbeIJzexQC7PaHdq8drh8jzkMGth0GzMtGfb3uxPExmuDpK6KyPFoVNgYFScQK2HKHCrnHafsOVvKn2vOpF0pnmjEmISgl0Uftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CWMQws4WKX4Jn6bV2V9iKNzpit7IxDWjnDQfj/QSbc=;
 b=ZK5yyqpxv+HFT0HX6hqezSeqN8cAs9YOwhkVqlkC289a+IQyencu9pURlRdIzfkG9oHPI9Vc1ybUQWrlrN45+f6sXbVsTBWWLiDAAUXWPcwBGc/nlqUnkNW8QQwZyZXMh8GQ6hnu/ChvvwmHHZArG4dlL8QIX4Ilw3itSr2moE4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:42::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Wed, 13 May 2020 03:38:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 03:38:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: ack the SMUToHost interrupt on receive V2
Date: Wed, 13 May 2020 11:37:45 +0800
Message-Id: <20200513033745.4020-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:202:16::13) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0129.apcprd02.prod.outlook.com (2603:1096:202:16::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Wed, 13 May 2020 03:38:03 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 948da44d-8922-49f2-4a6e-08d7f6ef0b23
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:|DM6PR12MB2682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2682CA7DCAF9D133040FBD6BE4BF0@DM6PR12MB2682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: md4r9xOsJmGRXZyzR7TQKKBrwFCgLZtwjXlK1Dt5wLmDRsTN5ZpQiwz+p+nxLm4iVJb16Usu1kAe06JTVSf31X2ImqsXuOLWarLu49y3YZI6hBQWTrYOVodJfd7Jc/Xl4tZ22bFSNmuybc6YtQpY2jVMt+XofoE/iMtB6Gg6tZnk4LOqFdy4XwfV0n0C2XDJ3EOr/a41SCpIrfvjgvXjjpRyWLj44n+sLAwTpIR1V4uMcmR3Js5ztgZIL9S07F8Lm8hKtK/cbUbdOS1mHOImp85MsENyiblNhkGiIxfUz+ONDH/iu9NIHQcrOzHVHmwRiH03diPH0znQ9dZD4jrO40tB7WFSG1Fy1Sj8A8sOV+GBqo3+/l/MxfX3bU321KBVeXyFNw/7h7kfYM2I+KaU+8tTfGt8uPMCPCbIsOjOLqg0OOWfYUzFvFznbI+y+vUc1TfSR4xdb7Wn2VRThmzaJoom1Faah7LrwajfnJBK08NNParDqaAVxF9ePanBR7Ndmxbb3QRUncaUyOc9GALcUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(6029001)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(33430700001)(1076003)(186003)(8936002)(4326008)(66556008)(6916009)(8676002)(86362001)(66946007)(33440700001)(956004)(6486002)(66476007)(52116002)(36756003)(2616005)(7696005)(16526019)(316002)(26005)(6666004)(478600001)(2906002)(44832011)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6DvLtMWWBRo/vb1iTPWc+uQA/mP5DHMbR8OG+ETX6I0Wqsh0JqlBqxQqZs8be656pkAnYxVnbnR9ySYmxLI0LmBuJR1QSFXPJEI6MH8NSc2ozfbP5qZPjnhFWuRaxnRJdd3aJj2UegBsj8bWujg6NDM50+2Qg3fXHuLlqjk2GdlZWROvH5NiTBQN8A33heLA8hOru/Rzqt2E5pa/aX0XDCUOk5clblYs+c6AMA175hRV+IOZ8WB4TWl6mdsPGdjuZWbUzgtXaw4nRfrrQrFBCGj4QNTcts91Gbxv2gn/6P4LN8kHMh5If41LIPpWYy7kIlnO7D1kRnOawuF8s1KVjKhqxFwACnCNcHYKOY34GqITSlEX3VnY4oiRokO9/M6jwqGZ9OnsTBfeMSQU4h+tXadPrCk4E/0o7IzAouM3lg5xuMFhYOUugAKgDoHhcTScv5s7gUotrAVcCvvc94h+8un0VPi+yhr5ZO5v77W96X8iu7PmGwJ+Vyde08sCGs8q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948da44d-8922-49f2-4a6e-08d7f6ef0b23
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 03:38:04.4701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QCV/Rvf7+o7uKwzwF+aGM+hIGsR3XG/cQqZ0DnkWJu8cN3BLrcNGWNPpgSQrZM9v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There will be no further interrupt without proper ack
for current one.

V2: fix typo to really set ACK bit only

Change-Id: Iad5adcaf7dd5c3a773b3d93ee0922a424dba8ac8
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 80d6c296a599..2df3019768c2 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1535,6 +1535,7 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 	 */
 	uint32_t ctxid = entry->src_data[0];
 	struct smu_context *smu = &adev->smu;
+	uint32_t data;
 
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
@@ -1576,6 +1577,11 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 		orderly_poweroff(true);
 	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
 		if (src_id == 0xfe) {
+			/* ACK SMUToHost interrupt */
+			data = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
+			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
+			WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data);
+
 			switch (ctxid) {
 			case 0x3:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
