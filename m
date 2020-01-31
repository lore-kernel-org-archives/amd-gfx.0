Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1423DC33CB7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA14B2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zcsJfbDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA14B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A1856FC38;
	Fri, 31 Jan 2020 22:17:14 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760049.outbound.protection.outlook.com [40.107.76.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BEC6FC36
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M78v2cb4ZqWUwkGBqYxF3sYVvmiAKBLDnJmQnrAR/Yv5b/bbssXcjlSHj6d81gflu+PTK2fXe6wolxVYQkODyyogWhiwoUfl8DMij4IHfJhBoQRQ7M4b5gfWyigjTgrGGJ6IGPpC4u/0GqBv0isfxAS+p069NAsKA0h9qkc3ZatQTqMgGVearqWWKmGmfmqi7dt4WVywVFYKhkPK81zqNGfW6irbv029m+tuS38L6H4PJaavXOPHDOjpTrMxUDCEhP5SI9nd2Ds32cj+nlXTtJ4hXfEJkRy/i8ZLUxvb42+aiYIss5UbAJHmXY0F8VRppEOz6z3S1N2M67G63l3qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzhrwBdp5bNruNGgsZcif6USEyp23IRJ6Y30yv4eZMg=;
 b=WrlrglucU/0aNlhDW3XrEJk2bPNWA45bW0bhcoxtH+d/kcJW2tqb5bjSmQAGoFgMAZoXO5Hs+sSKPiVooSdkCVUeH7MBLtxNX0ryYtRpek6JwbIY7nzOpMehkwPYIgDtzffmxvk8mYO9DR4BjP68yICta1MKO7l+lUp2AGa+LD7IlpYnNA0aOe+CYP4iA422L9XKC57THveuo23wH9DcuQ3aQf74OvnvwzwFItwzdeGFQgWHs9dRg7kfOaV3XocrTlh02lSub9N3Uu+/mwufzvujnw2LQhvt4DgO+V4x3ypk5B3mWKPKA0iBfA1R5FbDAl2kb2ctNCx2kay6hCUSkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzhrwBdp5bNruNGgsZcif6USEyp23IRJ6Y30yv4eZMg=;
 b=zcsJfbDISP2kPPasI9lK8JtN5JUjL4SgvthffbsqpzFSCKbYFP7bKdzvbF09GRM/WrId+e2cjCYBeDWFRU+El6pLa2gvmLGWWjKwluI58xBj1i7ISaVKIrZyxolyh/4Ewg0UDQ3Zxvzj/V4kVsvrC69bn8ryfyTbi1LECXZ4waw=
Received: from SN1PR12CA0098.namprd12.prod.outlook.com (2603:10b6:802:21::33)
 by BY5PR12MB3937.namprd12.prod.outlook.com (2603:10b6:a03:194::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19; Fri, 31 Jan
 2020 22:17:10 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by SN1PR12CA0098.outlook.office365.com
 (2603:10b6:802:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:09 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:09 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:04 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:04 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/33] drm/amd/display: Wait for clean shutdown in DMCUB reset
Date: Fri, 31 Jan 2020 17:16:20 -0500
Message-ID: <20200131221643.10035-11-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(428003)(189003)(199004)(478600001)(4326008)(26005)(6666004)(426003)(2616005)(81156014)(81166006)(8676002)(356004)(2906002)(316002)(8936002)(186003)(336012)(54906003)(6916009)(7696005)(36756003)(70586007)(70206006)(86362001)(5660300002)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3937; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c6efded-5f5c-4511-c5cb-08d7a69b5043
X-MS-TrafficTypeDiagnostic: BY5PR12MB3937:
X-Microsoft-Antispam-PRVS: <BY5PR12MB393790320823129F49CA6C50F9070@BY5PR12MB3937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yvBMenKwdjQDsf/tYPT2I4mwcfYjv07/sUhUifWeKLrlYnBoMQgmh6zY4QSXmhElWoodPtQlVhPoQG5jCScq17KRu4/k6HALVhsJ+z5looDyZRSsUsScV8VvKMZdM212vf/051yWrzIlTlyD1zBLYEdOrQGR0sj/VP/pxLUn88dlo1cEaMAVCeuXp713rzImozCleqXmXCVOSYGv2/TyP2nB06+hbEBMIMIj1lmBPqlnyDFRFLeukeqnue3/ToDOSQDAbBipmMcB6AsOAQQhFTxmtn3zYb1mZ2HeUAZVWU+6ECZTiYWW1M503v22ztWKsk4LNutp+5bCH7/IIbwjx/qDjWMw/B91rqAYlYMxCDBByE50O4AfURIs79a69lYmicPKVPE/dhvvB3mYnjyTxNsUt99/lma24B47jugSB47Oc5NJhEMMBIUZK1CRCYG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:09.1348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6efded-5f5c-4511-c5cb-08d7a69b5043
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3937
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The DMCUB may be currently executing commands when the reset is
triggered.

Before issuing a reset we should first wait for the DMCUB to finish
its work.

[How]
Send the GPINT command for halting the firmware before reset.

Get the ack for the command then wait for the scratch register to
become the correct value.

We want this to take under ~40us or so at most before we force reset
to cover PHY delay sequence max time.

Each register read will be at least ~1-3us so don't bother using udelay.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dmub/inc/dmub_gpint_cmd.h |  6 ++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 36 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
index 5398ed6b35d1..e13685917dab 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
@@ -65,4 +65,10 @@ enum dmub_gpint_command {
 	DMUB_GPINT__STOP_FW = 2,
 };
 
+/**
+ * Command responses.
+ */
+
+#define DMUB_GPINT__STOP_FW_RESPONSE 0xDEADDEAD
+
 #endif /* _DMUB_GPINT_CMD_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 7c1604c2221c..479f17bb3800 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -77,6 +77,42 @@ static inline void dmub_dcn20_translate_addr(const union dmub_addr *addr_in,
 
 void dmub_dcn20_reset(struct dmub_srv *dmub)
 {
+	union dmub_gpint_data_register cmd;
+	const uint32_t timeout = 30;
+	uint32_t in_reset, scratch, i;
+
+	REG_GET(DMCUB_CNTL, DMCUB_SOFT_RESET, &in_reset);
+
+	if (in_reset == 0) {
+		cmd.bits.status = 1;
+		cmd.bits.command_code = DMUB_GPINT__STOP_FW;
+		cmd.bits.param = 0;
+
+		dmub->hw_funcs.set_gpint(dmub, cmd);
+
+		/**
+		 * Timeout covers both the ACK and the wait
+		 * for remaining work to finish.
+		 *
+		 * This is mostly bound by the PHY disable sequence.
+		 * Each register check will be greater than 1us, so
+		 * don't bother using udelay.
+		 */
+
+		for (i = 0; i < timeout; ++i) {
+			if (dmub->hw_funcs.is_gpint_acked(dmub, cmd))
+				break;
+		}
+
+		for (i = 0; i < timeout; ++i) {
+			scratch = dmub->hw_funcs.get_gpint_response(dmub);
+			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
+				break;
+		}
+
+		/* Force reset in case we timed out, DMCUB is likely hung. */
+	}
+
 	REG_UPDATE(DMCUB_CNTL, DMCUB_SOFT_RESET, 1);
 	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
 	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
