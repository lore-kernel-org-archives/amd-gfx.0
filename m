Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD5EC07E9B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 13:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8846661006
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 13:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8846661006
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4403D89E05;
	Mon, 19 Jul 2021 13:39:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4AB889E05
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 13:39:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gd/qNEV7Eu/kfi8MibJzPCat4xseoOdI7JO/LCNkHLM2bM8Py7LosDjaK91Yi1Z0Kc3Wsw8OEAeIXpS3zqi3zbskulmDigCvl9FU3SUj5Tg4Bs1+MPVeYdE8cWCGmXGlKqPPc+LGZXO/bJj2FQAvjEDnd098hM1EFC6WgVXUZjpZJ8aqpCBxY9djWobERVuGvp9uEtE28Qd7+XATpBh+stbIOzfqFcLbi0vxTB+gRW8ioCOX4cJ8+9NKhb32NfO3+NkGSicstLkWTdNXBGKYsxutqHxi1k6HM17wq/mVP3eaOsAESXjHEZJcEzOmBH4V65N5u6GRZ4CLFUGP6dZ58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux95q26lBDA4kD6QAT0tA8+p6XMAv/eLqIx86BA1x20=;
 b=l/Os7Ll1Z1dIZkOsvIWL525r/0+Cgoaq9Z+NFjcFFdUIiiPw7JuSkA2B3Xqkx3CC/dmNeTUULAhZTe3yA3QmRcxB1zGo4qtjQ3PKBj/OPpci2XnbS8kxeSjTe19JKPk5vweu9exlu0En3uLh6pMQAXDzu1pGSA0lVZwpQD9InPX/dhorOm9OSCbm+UCdlrXc4UMZwmP92F+F/stxTTwxDb+eoBa/MaIgdAbLf632f99ZDVBuSsuWuRqAibejwuCynsVENgoatHOVkQH8xEMVlkAhfuxBCreXA6o1BUZVsCTcBOiugDdGSGxFJ/m/AEsFfpTI4KrhKb9pHh+NJ9Rulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux95q26lBDA4kD6QAT0tA8+p6XMAv/eLqIx86BA1x20=;
 b=kpHZIKVHkptwMzzVPQZY6nsU0LjbxZsV8osr50VoYHce2yb9hHFar8Z/ZAc/LMGEKI6ozd0KGSoDTZMW6Qazg9+DpVCtA7P2oXGeV1JlRS5nAdcbN3fwXU7Sl9Qc1qettzO3Pm/k+UVUlMJDfBS9bf+RGwf75TrPc39ZPJ2NTjM=
Received: from DM3PR12CA0138.namprd12.prod.outlook.com (2603:10b6:0:51::34) by
 DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Mon, 19 Jul 2021 13:39:06 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::2f) by DM3PR12CA0138.outlook.office365.com
 (2603:10b6:0:51::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Mon, 19 Jul 2021 13:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 13:39:06 +0000
Received: from X570-RTG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 08:39:02 -0500
From: <veerabadhran.gopalakrishnan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu - Corrected the video codecs array name for yellow
 carp
Date: Mon, 19 Jul 2021 19:08:38 +0530
Message-ID: <20210719133838.100107-1-veerabadhran.gopalakrishnan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 522ea28b-624b-453d-2f50-08d94aba943f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5278:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5278111D350AE3EA37D9CCFDFAE19@DM4PR12MB5278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/hGheMbxRRIfuENU87m6a7d6ZNfDTIBR/0OoIP/WPQdmkTY9FZaW0YeliZ4n/tKcjje2n2aw1D0mwVEgERKSsF9d3gJWGDbHSOPmWyquA4tIjsSFjmzXS+X9kFcSGrVwO6UXqIUqqyEPSbzp21mYd94RO7ileBDUydimoA4i/fpB2k4QICN6kjUKRDesYCx4qwdnmhkIJs52CA9hB5DQGQZlNG0QrNMOL5EDS/fy5QMykLKqPqJisxra/3DvzPGj/PZq/JhLMGZbTECY9lIS6UMjeIw+l6ZN8Nqoxrhq82rm1L7D3LNje9qGuX2nrjW885aSSsDYuGZ53ekW9ePsUU1HMka/RzHecKBbm2RZm5GsIEVIrGwmKj1aTfiy7DkDqotVOM2ijLbcmIdpdHwoo5GqHDrhprLMN1DwCLUKXMEj5EMlbgokUY5rlszGckjP4ksF3EBQMZyCyyNuP/GE/IVtuaLWWCW/EFLS/YFKlg5//JsnS1rIopPAp9wfsFoOJekyesAyaEsGQmv4MUB6x2EIpP0EZhOaE+uHzbx7u9Rj3eI7YBrsJ1VxjcZio+S/Oh7yRCum5hnQXuW6M+zEg31a8lMpE7xZb1ZWeX/+pJu2zVrROzfUQotG9mId/3wHbtiOQS3uPNuHrdwGawpaJ+cOx30iQp6YI+x7Li776Fw4aco+ZM2Vpu3B6RFvaUM0tmSktV+ldTeTtdzoGf+XRiIDblGYeajnroIh52dPhU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(46966006)(316002)(81166007)(5660300002)(426003)(8936002)(8676002)(54906003)(36860700001)(478600001)(4744005)(336012)(6916009)(6666004)(2876002)(186003)(16526019)(82740400003)(26005)(7696005)(2906002)(70586007)(47076005)(83380400001)(4326008)(356005)(1076003)(82310400003)(86362001)(70206006)(36756003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 13:39:06.0067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 522ea28b-624b-453d-2f50-08d94aba943f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
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
Cc: Boyuan.Zhang@amd.com,
 Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 james.zhu@amd.com, leo.liu@amd.com, srinath.rao@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index cf73a6923..3027b44df 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -174,7 +174,7 @@ static const struct amdgpu_video_codec_info yc_video_codecs_decode_array[] = {
 
 static const struct amdgpu_video_codecs yc_video_codecs_decode = {
 	.codec_count = ARRAY_SIZE(bg_video_codecs_decode_array),
-	.codec_array = bg_video_codecs_decode_array,
+	.codec_array = yc_video_codecs_decode_array,
 };
 
 static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
