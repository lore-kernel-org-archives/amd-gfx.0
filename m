Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CBDC33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C4420663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aNhmMxPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C4420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A9C06E283;
	Thu, 16 Jan 2020 20:14:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F276E283
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEJzVDKSXuGgOetiePlDS+OXD5jMbdmc+VVpUVSC0Ls5xgl4p/jH1NUrfRNpnOzJ1DIzCm5UXtgDmeZZhoSym+e3fSjrF/VdUmJaibOvXlnxrJoL9q+dpLT/6IkOPdDZqSXstQVoseFJSvU3MqAbp50xw5AwXWL3Unu3XKUT6slDTfkPjJ7Mct9DHIygEJx0QCcVFzzH7Xb3GN6g+7pORvrUPG0WXpq2yKsccAau9gQK7u3Q/MbU3GjiVECcZxgoTIOioJsCSVVtA4B4f8nV5dh7TK9A4p252pGE9EIX4dcneyagICq8HUBJni0/WKteCg7Dn+AkWGNZaxy3O60w+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQGu8EJEVgI4GEy0uFCkPxoVhJ4fY3tumFTxnsou86w=;
 b=YQAJG/MMw/LePAR5z3WKatD7nDy6lzralqt1lSlrUKn0cdyXPyF62Lde1r3avyqzzZ+6Sxu2ohchs4io/cjOgQ7/Wl+2C5L+KeNtwKVxTRB++90hy7CrZVxro//cRHbDHm2S8106y1qSg+LuCvPI1uJyB11IPAVHj+PHZPI3mKkycEtyO1JbmSbQIXWUi18jFRGKMYjX7RsdGRtgB6iMcX27RIQjHJX+VTjMVYFODSPTmsAdsiORJqPOic9m1sFxhAQu3duJt9HHy6aWFfRsjyU73GMI5wo8HmJ3o9Hk5/QDZGDXX6wE1EqbxMMdZZHWPlRXovVA2YklB5GoXgCsyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQGu8EJEVgI4GEy0uFCkPxoVhJ4fY3tumFTxnsou86w=;
 b=aNhmMxPmTRdepevcieYfO0n8iRlr70STqsDlZGqn/ZB6wg1J4e8oLa/8F6UUQW3HZBsYFv5SAXTfnEZ8U5w2QRCyn6uiziyIHl9/y1ITVjlogzNxt4tQ9HKPCk9L0KKRm8Hi1E3IHUY2MSU/ONJ4sbaM8q5ZnbkJ68sw4RTXTGE=
Received: from DM5PR12CA0007.namprd12.prod.outlook.com (2603:10b6:4:1::17) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 20:14:28 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::200) by DM5PR12CA0007.outlook.office365.com
 (2603:10b6:4:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:28 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:28 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:26 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:26 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/22] drm/amd/display: Fix DML dummyinteger types mismatch
Date: Thu, 16 Jan 2020 15:14:05 -0500
Message-ID: <20200116201418.2254-10-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(428003)(199004)(189003)(426003)(336012)(70206006)(70586007)(54906003)(5660300002)(81156014)(316002)(81166006)(478600001)(2906002)(1076003)(8676002)(86362001)(6916009)(2616005)(186003)(7696005)(36756003)(4326008)(8936002)(356004)(6666004)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2892; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1775649b-4cd5-42c0-61cb-08d79ac0b097
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28922A49095071E7B34E6874F9360@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vt0MEmGdsB9OkBn7RUC0K9+KO0kUx7dQvuj/x8wYvaguJjr9Vf7Tr9HD9i6siP00YaMWvAVi+DIQMLM8HaCe4zQHsAfAGZsLlYaCQQ79WZJkxJj4KOgxR2USXGen22aXqUxrizXiM0v6CX5cHtbTFdo/knEgXEHfeKITh4IvZaoknoBX5NA7eBr6QQH7+G+/Zlm5fr7XXJKHuJf+Qt7bPJpNkp+K82A2pMash1m1xH79GZpcPVeKho3sN39sge+wtOAL6FjOONtH5hRFUPNqbo3MHP4FMKL2SOdCv7a1/C5pymSnEVZRBuQqqebTwPm8QVEK8ptOA6y+J2rShC2MDkBU2ona/pq/dTStrZmm512gQAmgZJ24ijzlIu/b8F1N7wqbM6OY7CmX4BOGHyjB1GKMVJYf5YrwprrUfrHCI+vRns0gsqFVLzyBSKwPvi4h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:28.2283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1775649b-4cd5-42c0-61cb-08d79ac0b097
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com,
 "Jerry \(Fangzhi\) Zuo" <Jerry.Zuo@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>

[Why]
The types for dummyinteger1 and dummyinteger2 are unsigned
as part of the DML spec. They should not be long.

[How]
Make them unsigned int instead of long.

Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index e7a44df676ca..2875efd85467 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -763,8 +763,8 @@ struct vba_vars_st {
 	double SwathWidthC[DC__NUM_DPP__MAX];
 	unsigned int BytePerPixelY[DC__NUM_DPP__MAX];
 	unsigned int BytePerPixelC[DC__NUM_DPP__MAX];
-	long dummyinteger1;
-	long dummyinteger2;
+	unsigned int dummyinteger1;
+	unsigned int dummyinteger2;
 	double FinalDRAMClockChangeLatency;
 	double Tdmdl_vm[DC__NUM_DPP__MAX];
 	double Tdmdl[DC__NUM_DPP__MAX];
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
