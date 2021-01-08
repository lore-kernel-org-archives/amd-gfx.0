Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3033EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E559A23A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E559A23A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7D726E8F0;
	Fri,  8 Jan 2021 21:50:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20ED36E8ED
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzru25QU/Ly4RdnxrnCiQR3oECoQTQpK0x8AJdc4XkaNNPxgMi05HyKUPh5SlwOFc0VG0hsuGU1FF8RpZftUI1d+oSl/R5Wb7IMiSbazfKbuKOywOE5mZ2UavhFdj5t285LwOxthHlmUDiu4fhLPELEHgydBSdRjGUVzYmItwmewIAmpktx4+y/d7pw6DsXPd9L/5TKdPYPuHiY+rbdLdqj7CWToxNRGjQRf9WIglKIISZ6kRqB6UwqcsgHvjAPGq6LNtiZ38nxPpn1jLPsnn/2Rg1p92iB7GYqCbTcxt1JVVFCogOnfcKqL/PZ+xg5Vt6OjwmBMGk/LfVXXgFGlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPiWwPj+sAc0TQWd2fKdpMcg2RG2MWUtdtXZnvKDfxQ=;
 b=GDmtD5ZhQQOQ/DJvf4TRWAGZ/tUIxwkGSKfuhSGVnci7/b5N3NhNc2tflyGw9S8Xk+0swNuZ5hBqEojF2eUWwuHifw7dPdu3HjjRq/sD4VhTIiBo6J+Qy7NRwynx9AqW7E4fH4k6pGLijZuyIwySkkq2oDOfzDy80tuXt7rPoLXJn1qQ5qPqwA+5e1RV/maVXcQU0D79nbcHv9usRP5r5GckAn9g52QxtC7XQV9ds5LRUrLFXWH2f3S/Twhuhw6xoiLryQ5sTyzskUBjMQQxrVj8CskawNc8sLov+PNvq280yru4CfnJrxOmmSNk23THGGhHvWPByZaXFSfo9lwswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPiWwPj+sAc0TQWd2fKdpMcg2RG2MWUtdtXZnvKDfxQ=;
 b=fApCGm6t3pdqHMnw7bt7sNS8rIzFNRRSXu7pV/JBZMQ1HAJVBYakurwg8dTD7b+CSn0GnrygbzERjLIC+XYvDuGJ9645SVG/XMcETTnEEv64zbrcUu0McQjx7wUNDu7h4D7RyXXtk48gvrjePANjsBHavULmMufPyTv9VYyf5dY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:44 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:44 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/21] drm/amd/display: doesn't reprogram AMD OUI
Date: Fri,  8 Jan 2021 16:49:56 -0500
Message-Id: <20210108215007.851249-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86f5f06b-b5c9-40f6-dc45-08d8b41f7321
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB188270B5C8E085966937F3A498AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pFLoLaR7Jkf01nrAYzPQyNBPnP1ai1mor5iQwVHMTPwD1uxYpyNG8Vf9RGfPlcREPkH7FpqdYRcRqG9pCMD5ZTRzYasyCwaBvyiDXK0kCVHhi90SBu6/al4y9cN6U/Rg+nfhuDBgj8dMDUHs7/LRFi71diTTY32nbEb4RIIKSV7oFnmn/aSXALJR2OV8qZ9ETBJEmFd1Kencu1oXvoDackdqiCwJF1R96BAs1teb1ADX9twe4DGdxvbgQflBwYWbikJX3Dz92XLCOUCA9IJ1IwPCaz00h8todU1YPAwDLjrLPfeg+Y4FoAehK1K8tfXlKsnADXfS0NOaxTOGxFiaIu1WMHtDQK1ThFyfCSfjSga4NlWzYJ/tixfna1hKIPlhSiPyTW5wmgGVnlsHfRk+CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(19627235002)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4ppiuh1ntbPWjuOAvUvQlTrrJf0bxFek5ZW6/HrtDhxh5pSswaD47CXy/aou?=
 =?us-ascii?Q?hMHUCn+f9Qq/HDGdRMd7tILH2LjfZfoOeQluPI7t6SpWW4B5uOg0Hn1x2iAG?=
 =?us-ascii?Q?u5yvosKJeqWHn8pTXSwxiTE448bXtv6z8pxZ47n7GALr8ZGLE+z1Cr5GMv2z?=
 =?us-ascii?Q?jTvsIUAIt/+8yBfkciAl4Q3+hIfuNWMRqCH7df/gAsPSG1Se7JDhhK/WLm09?=
 =?us-ascii?Q?Y38Kb07Uqka3OzdXVvGLA/QDd6a4XAvShdECywrDtmd/OlNsRWzwzi47h/I3?=
 =?us-ascii?Q?ylBSop7yi9i8HpEXZB9C3YQ81MC55TVBev35UJNgWw64P/3Sdgkd3WVuT4Qm?=
 =?us-ascii?Q?GfmkCqh85w06fd+yeMXy8ivdBmZeQ0hRxBQ6d5QhPFEQc89rhADo95hZF1lE?=
 =?us-ascii?Q?HkjJvYM6v9nEvxZDaESzPTH/wO75/ERrPyZH8KM3N9M6xIauH09BSg+hoxbm?=
 =?us-ascii?Q?eYIKDXquFm5r9LkZ+czdCUyvSp8SWKWRsF8VPizGVr9QzIkGIOhP3iwQK274?=
 =?us-ascii?Q?Fj0rHy1jrCYLoMYWLiWcYsmZZPpT9vQGJaENIWtm3yJ1OxHcBxeCyFULd2aV?=
 =?us-ascii?Q?CnxNAfSa0POjsmDPxcMssQ5AW/eDhdiVCcJzoIp8e89nnjR3XF1mMdhKnzxE?=
 =?us-ascii?Q?HfGghvvXMbWUgRXj2H6VGKY9t9u1R+U2Fw7F9cy6DcBlBR6K0ts177OtjNiS?=
 =?us-ascii?Q?0mvImyhrsBlZtAwe7t+2R+8I8zierbLdibxwJRKjNTDKojV2ehLtHECmjRKw?=
 =?us-ascii?Q?XzFcr8ekTkD6UCMVvkWAZV8l2jGLpgpG+pwQW7VcDmo41sO9bvmVQ2eCCQyc?=
 =?us-ascii?Q?wOL0AO0NHbvbzTTB/jxyCyuY98Aqzi3JMu7KzX7/qn5ulbqxZ+GuggBTSsC0?=
 =?us-ascii?Q?e9NFM9XSd07h+3HShumTTXZFqHEdstHn50MC9YspM5GvqMsqCwFKENBTEsot?=
 =?us-ascii?Q?6AXJNRYxkrzuGH9zyzUQGEiSqTFyZxaWOj/9Hy/qRkpVY9KH91RVhKrEqEJx?=
 =?us-ascii?Q?RJkkWjxTClQHzoMYLXUsKcerd6PcuPuOrNrye7+vSF7pR7dNCOdOk3EYGelV?=
 =?us-ascii?Q?ri8mb9cK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:43.9740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f5f06b-b5c9-40f6-dc45-08d8b41f7321
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEaGEb9HrBWJHohVZK02MQOj9HiAfJfsxllXcjqYwz2gt33iryBqe1J9RpaZnJzSFO+27yplaissCAZ+mmVxwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com,
 Yu-ting Shen <Yu-ting.Shen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yu-ting Shen <Yu-ting.Shen@amd.com>

[Why]
1. the corrected timing to write DPCD 300h AMD signature is before
link training.
2. and VBIOS will writes correctted AMD signature by after AGESA 1.0.0,
so driver doesn't need to write DPCD 300h again to switch config.
3. there are some OLED panel will clean backlight level to 0 once
receive DPCD 300h, so we will see flicker issue at that time.

[How]
read DPCD 300h signature before write it to avoid reprogram again, if
AMD signature was writed corrected by VBIOS, driver will not reprogram
it again.

Signed-off-by: Yu-ting Shen <Yu-ting.Shen@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 37 +++++++++++++------
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  3 ++
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 3cd84dcb266b..b2d859f32d54 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4407,24 +4407,39 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 {
 	if (!link->dc->vendor_signature.is_valid) {
 		enum dc_status result_write_min_hblank = DC_NOT_SUPPORTED;
-		struct dpcd_amd_signature amd_signature;
-		amd_signature.AMD_IEEE_TxSignature_byte1 = 0x0;
-		amd_signature.AMD_IEEE_TxSignature_byte2 = 0x0;
-		amd_signature.AMD_IEEE_TxSignature_byte3 = 0x1A;
-		amd_signature.device_id_byte1 =
+		struct dpcd_amd_signature amd_signature = {0};
+		struct dpcd_amd_device_id amd_device_id = {0};
+
+		amd_device_id.device_id_byte1 =
 				(uint8_t)(link->ctx->asic_id.chip_id);
-		amd_signature.device_id_byte2 =
+		amd_device_id.device_id_byte2 =
 				(uint8_t)(link->ctx->asic_id.chip_id >> 8);
-		memset(&amd_signature.zero, 0, 4);
-		amd_signature.dce_version =
+		amd_device_id.dce_version =
 				(uint8_t)(link->ctx->dce_version);
-		amd_signature.dal_version_byte1 = 0x0; // needed? where to get?
-		amd_signature.dal_version_byte2 = 0x0; // needed? where to get?
+		amd_device_id.dal_version_byte1 = 0x0; // needed? where to get?
+		amd_device_id.dal_version_byte2 = 0x0; // needed? where to get?
 
-		core_link_write_dpcd(link, DP_SOURCE_OUI,
+		core_link_read_dpcd(link, DP_SOURCE_OUI,
 				(uint8_t *)(&amd_signature),
 				sizeof(amd_signature));
 
+		if (!((amd_signature.AMD_IEEE_TxSignature_byte1 == 0x0) &&
+			(amd_signature.AMD_IEEE_TxSignature_byte2 == 0x0) &&
+			(amd_signature.AMD_IEEE_TxSignature_byte3 == 0x1A))) {
+
+			amd_signature.AMD_IEEE_TxSignature_byte1 = 0x0;
+			amd_signature.AMD_IEEE_TxSignature_byte2 = 0x0;
+			amd_signature.AMD_IEEE_TxSignature_byte3 = 0x1A;
+
+			core_link_write_dpcd(link, DP_SOURCE_OUI,
+				(uint8_t *)(&amd_signature),
+				sizeof(amd_signature));
+		}
+
+		core_link_write_dpcd(link, DP_SOURCE_OUI+0x03,
+				(uint8_t *)(&amd_device_id),
+				sizeof(amd_device_id));
+
 		if (link->ctx->dce_version >= DCN_VERSION_2_0 &&
 			link->dc->caps.min_horizontal_blanking_period != 0) {
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 80a2191a3115..cc6fb838420e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -451,6 +451,9 @@ struct dpcd_amd_signature {
 	uint8_t AMD_IEEE_TxSignature_byte1;
 	uint8_t AMD_IEEE_TxSignature_byte2;
 	uint8_t AMD_IEEE_TxSignature_byte3;
+};
+
+struct dpcd_amd_device_id {
 	uint8_t device_id_byte1;
 	uint8_t device_id_byte2;
 	uint8_t zero[4];
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
