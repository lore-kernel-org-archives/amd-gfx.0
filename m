Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F416C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE56A6136B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE56A6136B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870DC6ECEF;
	Thu,  1 Apr 2021 16:46:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 599126ECF1
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+JJAVHbEBYN36wffaIQW0dXaHCZZSQVGQlaL4AJiJD7SppqbGLu0/KlrA3eomT60QFTkUTNIJBZTpxmT/d6+4DtKAZbNDUnPVgnY0RZasfkq2GlFO73JOqAuRPDNYIJTSXgmubR4N3tsLyyeI7jwGqY7Z/QiX3SVQUOyh+RLKDPaNyFEDyfNM65Qi2Y4iF9anhztaYfagZmIwkZZO79zTHsqB148aKj2uVf7lIhJ7iW1J06uqu0/3Kmj4+vGdqtOoFySwsEjdp5/nJ1MA8qpKDkeCd/jOKX8fQSNxQIwKKYWti4xkSanvZjbKIXbZbF1/cPQZT+U2wTr+4no4DLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrfwWXBlr+d1wlNzYN1xGlWKP/r+u1vBOBJ5KK6t+Y8=;
 b=AC35fgMWoHZJ9eNPjvUD7xuqJBpBDMjLtkKP3ZDcZWU75m72ce+3715A6B9PKPSznSvtp6bELpPEPrG23fD/fjbNTL3UNaGvjrxdwVfEct/hAr8PUsaCNGRg46rdWyNFcxIMlbF0LZToZ8kfL9AFsQYBovGQvjMPHRjOd/W/G5kfZfaXKleyXYUYwHb5fHtTx00o7yZ04u2J8CupZplxeQjnL59mPRYNZoU5piowbitbh6cR4m7pnlywGWLMqHPqfgL9P/tdTsWBRrbwz6SHz68OGDgavocVsrmC5dunQfFDxjhZ6StuJeiB/jJO+DSSllj7CRBerMeZI9Ou+D7L9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrfwWXBlr+d1wlNzYN1xGlWKP/r+u1vBOBJ5KK6t+Y8=;
 b=1lwDyLRgMBZ/c9zb9EwCr3bmz1EfPc0gFIKsxX1+8wmV9eTpnPvlK2IjqeC/kMVkKGTSlMRikV3bdApYENLhX3nf/XVGHA5P6xDu0W2V2cAFNO8o3hNdd96xbFmU3pNEl5kVviwiH3o+wF1BD3d3SovZTRaFq8Dgdt2nuHAEbHc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Thu, 1 Apr
 2021 16:46:13 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:13 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/21] drm/amd/display: 3.2.130
Date: Thu,  1 Apr 2021 12:45:27 -0400
Message-Id: <20210401164527.26603-22-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20bc38ca-d558-4696-e830-08d8f52da8ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37379DD0516DA3763EAE8507FB7B9@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZoQkQdeBagIlfxoZLBgOkHVbkkGvfBvMCL7zSbe8UNJxvOinfImvucq7NE10sl0NfyiDI6xrGhDASxP11iDXHLn2fTIAH3ynPxSYP4byUKiteLmrhYc+4JlHcSvzL240SMHqVXlVYX1eJiiLA/hrs4F8wlj7kB9oDjGael1p0ak2PiWvve3aAt2Gk6s11DSZm2J/UEu7R91Ne8qV3dnVF4VL59zT50RIBZentZsTRrsqlV99xfQ5O74tuWvg1OiLv59m8v5Y3DwTZRnTunQK4v/Sw0HvV+nzX1I1ozsCzKYg9AL+XCe7XrVz5BVcXl6LsLhtHS+jWVAZmzFpYFwExnUnpceTeDTaR2+/nmjIdAZXcQn+RXB5InyGF4/7sNzlaU1db0zy5wWUFEkIipF5H1X+bZ5VTh5B5vV6KJVHX7mU8OMv5eCo53q3ixfvxb8JIJzrEid1exABs/XjaDAc7yeWCWxKQZ4UJynoG1fR6bGqqrjbKzQWpY+hDzsdbD++cTPQhDPgLY/CSRLNbwxf2l/1Q3zuZn8Q8Tjsp0VFOuAHjHhCBPBjnGqXDBvSKhwMg3VYzdpOXkktL9NpFuHDINsLp31guBr4nVsBDmdFCtcbktPGDxqZbeMbIf4Cc02ZmGFB9JDKI7rGLUviFD+9rPDlkQRA268vp3puGywHKef0piwGsow7vG6jQ3hEGNI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(6512007)(2906002)(6486002)(316002)(26005)(52116002)(36756003)(66556008)(66476007)(66946007)(6666004)(6916009)(1076003)(5660300002)(4744005)(6506007)(44832011)(38100700001)(86362001)(956004)(2616005)(186003)(16526019)(478600001)(4326008)(69590400012)(8676002)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?s0biL5DNNvCuvE/E+oxWE66RhezinQRlFsNVEMGU4osbqoc1mYxRi+rCMC6D?=
 =?us-ascii?Q?Z+ZcgY0Yx8zH7TdkA1/uPmWUQFDMoDbXveHRIO3L3tFxgJLcvEqLPkV0e2Dx?=
 =?us-ascii?Q?1l05cS5WduhmS3urpmaFPNDkNwfM6WxTZ5ghAlYBfjJtI7sVj++m5kOgaakB?=
 =?us-ascii?Q?LzvKP30+HAMikv2n/zu+rgc0DucrGdTJ+2KwuHR0sMp0W+xiIAWIw8yDJJg6?=
 =?us-ascii?Q?2pDHahWlj9LxRMZ09wBY7+gpBYuvPwN/Dvq+v8rk7OSEy7LbZQF7fKC4Tjyw?=
 =?us-ascii?Q?nvhKhY9VF6NBHRJ/EXjXBybxgQ2qs7mmpZeBg+YphQoEAFM/Wct4mSrNV+o+?=
 =?us-ascii?Q?WLk//iVAqzyh1BtsODrCQbFNuWNNhdSKJPiPXRZiCZCUQ9runb5CR+bOqEew?=
 =?us-ascii?Q?Bk19abQbTX7E/MHpcEpkE5RoJ0OcyYout0bKZIR50oYciTg7VzGoxFlnth9E?=
 =?us-ascii?Q?uJ2czL9PWGd6gFWOM6DJtJZb7SqiVhcC96K2KY4bFhTOQ13rm5TqLh432yr7?=
 =?us-ascii?Q?0bD9lSuXh5nuoGPr5/2Bmkp1U+f3stXlIoXmC+zDgjFw1EArmJcxOwU8PdNQ?=
 =?us-ascii?Q?2gKVB6oo4XfJpAJsaCGPiuXck0WtVqSbYTPoF8DDArnu2np9Vs/28SieERJd?=
 =?us-ascii?Q?bYcCzO9jKtfRZ0DgW6r6Fki2O56kfh/Dc3t6r8ErWsRg5zzDdKMLGe+CFgaA?=
 =?us-ascii?Q?vqkPsatsVQfIONhtfSz2rNy9lmxsQDW0AUlYGoZAqIkQZvo7G4JJYfuu/dOW?=
 =?us-ascii?Q?9o0TiNbPprk39eUwSHkZ/xRwA9AkFsDgVTOaN4R/SIynbmgoktsV4dgueujr?=
 =?us-ascii?Q?IFQhn4h9lv+cCvdfFPl2yivIq7YlRgTjoxvMj1FAF0WfIC0E8m6pke78IV5y?=
 =?us-ascii?Q?IsDEDMQ6HzKmA755st+6YFitEa0i0HQ3vWwFCOz7CHmYNIVLAnoroutiFSdI?=
 =?us-ascii?Q?5wBbXUVv1vz//Gv7w2Q1VD8CmWe4JhQA7ZiS0kX138cYAEYbtVegz4Fls0K/?=
 =?us-ascii?Q?v5uPLSbuoRA8D6WNl4h97zRvc4tAwGxsLFxU50/kAt0SgJ+S9twesobA31Im?=
 =?us-ascii?Q?C8UTmqVd9W952Hvy/29NRm2yytCgxqzk7lRzPbqQrtTS1e0Hm+ldyzVJgS5e?=
 =?us-ascii?Q?Fc+oD2KWe/r8/rzkXq6QRMIWapWYaiorhU+FeqX5YXGR/GSW/Vvva6kGGRl1?=
 =?us-ascii?Q?DJawJwpGWTsHWTjLeTk1sMBFDALP4zbyKe0NbfcBq/+Ke0Ix0iwA1ZUXpjlZ?=
 =?us-ascii?Q?YGZN7MQXmrZZEtZDMjrS1/O10F1T/fyjGc8tJ84Lc1kjhAOzeEEM2tixk4wu?=
 =?us-ascii?Q?oy7aeYU4pC43mmCKytI/SmLV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bc38ca-d558-4696-e830-08d8f52da8ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:12.9587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doagAPWcSaf9KMsmnj3HLa+YrhLmsx0hL6118yg8poWFzoymnFtLn2JBjZQK8lSP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

DC version 3.2.130 brings improvements in multiple areas.
In summary, we highlight:

- Firmware release 0.0.59
- Fixes on display experiences for 4k TVs, register mask missing, etc.
- Enhancements on MST, code cleaning and debug messages.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index cf5abcb74601..8108b82bac60 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.129"
+#define DC_VER "3.2.130"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
