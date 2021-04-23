Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA74C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA1761437
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA1761437
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544FF6EB2D;
	Fri, 23 Apr 2021 02:40:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD5B96EB2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dI5QxJO4TbupttFGQRQRHIqz4ft/0W9dJxqokPnQHdaomPnn2LsYfzNmgQU5uX3LPUP+qeVx+eJucVZDMYYuFBgqpTRLIterubS4wWTffuG4dnPVqi0wr/eNNX/szwxlXft0+UVS7vsJMTLmi9rdIdBujn89e27b/n3RvNJMszoqB+wzxNcaeOql7TFSJ9jDDXnGzh2cvUe059s8/CxmSZomMZAapgT2vAfANEl8t1eiKP/eDqQC7oCey+/RiTkS4PmL4SiBY23Ssu1DtnPcuAD3eIv4bozGb+mVgow+tAOfGTPx9QBqccFIADXCJ9H5gNJ85gj3QTBRRY+NA8uJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NQVpdyPIgdq2NvHGjBACqqtNNoKgzwldMxOPWCB7DM=;
 b=LY5P7fgZTQWi8cJQY9zMuoTNDMiZPUfHtYy4X/ImZSAO191FdveXE7azwZPeLHzk6AcIBQKrVMdJsjekkVqSkIIHefYX++K5+ERRkVZiojDkt2zb1MxBaWI5CCpYTKf/QpedpIkguTGGURWaEIAtJ3BaoBTgg0uisQDH4Z/1emR54ztg53LetCrYEs3RAEkdpNLHUfUvQLcA90sAzeW4aAd6EaO3FnJkVAmQr+DUH0SmvvDdkM0NWNyqJ4FYeOG5is9OO9WBXjiyBZSWQWcRPEjo/LkR8fQlPkuAXu47oHjiax55MKkaIikh6xrvW6Pq9ZXiuv4xzMtGqSZZq72MLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NQVpdyPIgdq2NvHGjBACqqtNNoKgzwldMxOPWCB7DM=;
 b=UROwYcbNDUVZPWLWFKjO5Wx73Rd7zPpOYqk5VZS714v02fGi+28+fEINsS9hVD3fHkEyQioM1++TF6g2Skp//33mGm+10PiUa/fhmkn+2EswM+HuRz+/1HuuxjzavpQpKr2tqKoOy41yeXUU1ib77TyTYnmmdQoz8RQqxaPRTW4=
Received: from CO2PR04CA0194.namprd04.prod.outlook.com (2603:10b6:104:5::24)
 by CY4PR12MB1255.namprd12.prod.outlook.com (2603:10b6:903:36::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 23 Apr
 2021 02:40:48 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::be) by CO2PR04CA0194.outlook.office365.com
 (2603:10b6:104:5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:46 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:44 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: Add SE_DCN3_REG_LIST for control SDP
 num
Date: Fri, 23 Apr 2021 10:37:12 +0800
Message-ID: <20210423023714.22044-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3889e85-5618-4300-8d99-08d9060133ce
X-MS-TrafficTypeDiagnostic: CY4PR12MB1255:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1255CFAB297099AD8F86FB77FC459@CY4PR12MB1255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ye0cDBOyUNhLPwHg8c8ebaROH4BIVwU84V7YYDn7xeIbLxZGvt6qdNctgxbb5ak7JbLcyydrKk9BEnYD3w6Ek5mVGGPokrQPZVjm9PTFLzxUQS9DSO8PXuuwIvpBV5mHr2kiPMPlUOEG6u2BzKjvzpo2PXKgPCBCfMZKev5v1BAoOZre+NmZyn8IIknpEiZzz7SmnXVKe+i7GU8hgwnn5s8Np5Enb6Knb5cUZHm9gAEjpxCHE/1znKANjzuUiPymIitXXIpr0zk4tmEAt0mRM7qqym7IUP85Eim3/UBPdKxytOd1TQ4JwwUPFDI0p20d96qOcLp6p1jO4XuTcyBZZ3zfS3intxPGo3BAJfdz2F1WcvSMjJppuCV4FkRGmdK51NMsN+CWjQNMX3pm/jJnYOfLoaWW5rw4yF29cTSsWhimsK3Jlufe5kUFkPUB6lVTRfx7mc78hKF9mEai0Ql6nBuf79wfmRLQXtDYeuuRLzXuePH5YxwT0EZOkjonlHj3LmWEvu9iMfOJP22M46C15+rdo57mqx3JVgjmaFCc5slQ3IQpDBidwesT3omOxvch/1C6QDV4bHCV17+qDCutWScoLQlxh3O0MFZm06uT2XyE12Uc1Sy1paKR1FdkxP090GwL1cmahSbo3RQ8NNRWsk7HqR688rZE+z88JPbaCCRaPUvPNaJECu8sYQGmJv9P
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(316002)(8936002)(36756003)(82310400003)(186003)(7696005)(54906003)(336012)(83380400001)(82740400003)(5660300002)(8676002)(26005)(6916009)(426003)(4744005)(478600001)(36860700001)(356005)(2906002)(4326008)(6666004)(70586007)(2616005)(86362001)(1076003)(70206006)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:48.1975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3889e85-5618-4300-8d99-08d9060133ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1255
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 "Max.Tseng" <Max.Tseng@amd.com>, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Max.Tseng" <Max.Tseng@amd.com>

[Why] New platform. Need to add corresponding register control

Signed-off-by: Max.Tseng <Max.Tseng@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
index a8f49ecb84ba..9566b9037458 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.h
@@ -85,7 +85,9 @@
 	SRI(DP_MSE_RATE_UPDATE, DP, id), \
 	SRI(DP_PIXEL_FORMAT, DP, id), \
 	SRI(DP_SEC_CNTL, DP, id), \
+	SRI(DP_SEC_CNTL1, DP, id), \
 	SRI(DP_SEC_CNTL2, DP, id), \
+	SRI(DP_SEC_CNTL5, DP, id), \
 	SRI(DP_SEC_CNTL6, DP, id), \
 	SRI(DP_STEER_FIFO, DP, id), \
 	SRI(DP_VID_M, DP, id), \
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
