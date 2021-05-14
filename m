Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B1AC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A269C61184
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A269C61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58EE46E217;
	Fri, 14 May 2021 04:50:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 665D46E215
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjWxAhXJ8SXOhodtM+6F7UCdYNOfV0G3lbEbJPe28bPh4c8QRIAcUHHRF45GFHB2yMLlkTTadmEYfzsBIE3hpYPeCGE4YCj97uvhU5rex1MneYqw93W/KxqIxMLP0JnU35Mq0VElB37nDCcpYMCg4tV6HMqOqL4jzgHraM5I23a5+DaRTdc/WiFQ1lqzHXuGVomGDZLs+3gQhI6tjCgCbh3B1nS/h24Cxv1D5bNei+DFqMxQRGkg+DiJ9Gu76D7A4stt59en2OAcJ797ied8FWHdHE8y8BFRtNP6yk18QDrtZK0SYVD46B+Rw5Ca7D8NHS5+7BBUmkP/SurWBOJJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l5k2r8fgzhBCCi05Pf4HrRPmQfl2hT+h5wywfqvdC4=;
 b=UDTKDEaPRNR3uUwpCqbC4fPxJZpOZw5DvVJ3ICo9yCAxQe8tjq0+8DfWFqF8cqGLZJ3uEXQsVXC2VF3isoaAa0EBPQF0IKAujbmO/tYl1TqdT8BuRT69OpR1ke99PdDcJnezpC4YO0Te3xg+sW5hCAtBabI/TEnmqqQv4Q3S5gc9aGACtdgp9e+5+6dyrG8C2thxGxVDFGbnMCdmMLtkg3V2t3K2Jh9rR3cxHqrtOrHIZB1dRfN7reVvP7eIBUWyoTxpw03irD31+y5iiRIxwU4deXOcv8l4zKXU6Bw8by307UHru+93RP/l/7v0qkJOOfU0Hap7JT9EnOoRRkqitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l5k2r8fgzhBCCi05Pf4HrRPmQfl2hT+h5wywfqvdC4=;
 b=1fcIQVB8uQp5Peyq/csuFJunPMuv+Ka3ocKi+D1WNfjIbH0ChsKO3FIAyD9GY4gxLGBNOSWA/I7Y+XCOOspLaglQi6TrbG9ctm1Mpib/n8m312p3idT/8F6V57N5tw5vLiGR/zbtlZaS2C38gXUexs2b+JH5QXbBslLp6uBDKiM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:50:56 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:50:56 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/20] drm/amd/display: Disconnect non-DP with no EDID
Date: Fri, 14 May 2021 12:49:51 +0800
Message-Id: <20210514045003.3069681-9-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:50:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ea2f3be-1849-40d7-3d48-08d91693dc0c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129A0693F2FAA77908B117CFF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OrR448Fn8qITAXtzwlgI2Toyo24nnDTUZi08nRVsNbnR97zQb/CT+Z9SrYFJlQ0fCrn+qwsj8M32Z99N2mFzpZs4J7KPDKp0iZvZOMOgKN2Luxy40JZX/VTV+CW0DFElaMfbY5vjQNfA4pfnXq/woZ/pnc0MFzvy3sWrt4CEk0+CW0P3lPaKhvcQ4VA8+mUCB8P1ozON27n3+829gwrE7Bmft5Dh4rUhaoLrlHU5e9He7OCU2YKOF8f73aZbJJMqRfZ/mNGljgmngm4+3S/jI4ObY0UVq7i3HTHULb/fvs43utEkrgtUDKipc3ytGUPRcJpvkxveBS+R9U8/eZHl4zeuoNOgJTSpm7BG2dnEPvXaK4RA3WNACypzqqJkK9VZzT21SxSQljOjn+4pPgGn4/d0h3mgT7dhN3QoEG1Lbb7AJB1FbWA2bb2KzR1SpR920dnUMPXi1bWYevBqOqRbc+wpLjgZ3smRbEKAMMiwPRF5zBd6Gwl4Vvoko5+nTo9KbPTcTbfJPB2LSA6VivhZJDZOKZcV8tixO/mz0Var1cy3vNIei1+je+2cercusDirXpsZGeGfR2bemG7hwiJYEJjrB0tbclhDqItnbrObZnNhDomIslSu5aEViehJo0xFbcV7kpPmYADmDEnQXhh0ORy1y+fhD1Vwaj5X1imLUwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8676002)(316002)(478600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?omWji1lFgA6WC127NBleKQZEeQY9plpG0egX9SFdYTyBffrqQ2BWwKbwJBqc?=
 =?us-ascii?Q?tFE4syMxeTaneCpknWZIeu2PwtT5q65PoPGPqTuueOtOw0NmRPkeQXdOH7hC?=
 =?us-ascii?Q?NpsbCsJMIVRw5pkNk93wl+rfQNRLx2rIy44Xs3TVReEC2vGvbpJJUmF6Ar55?=
 =?us-ascii?Q?7olR1CjpgIa/JIVhPu3rZpwy+Q/Ai1Piy5OxYFg1wxRaSV4JlL5uuuaeJeBA?=
 =?us-ascii?Q?tSOZ2yGyPsMuNJr7FAQLw72WiM1r/P1NtgdJY8o0B4tSVk8GcI/80lM7bMyy?=
 =?us-ascii?Q?Rp205ENoLMo49c7UzDUAM0kaN2+fs87uw3ovlAiHvfMMfjpkIy39Ug3+HzTl?=
 =?us-ascii?Q?dKjbhlAk5dVl6zv4WDOv2tkX2GIDfwmXMStrYGyALWduuvTwFOCUSw/cRxj3?=
 =?us-ascii?Q?DZvV1luZWAz0wdiJc9STa3ljDwoSyfHDuKOFNyt1bCvHz9nDujrUAZ+daU05?=
 =?us-ascii?Q?LGFkJopW6QUv78Ehq95P2ng+HjFI21CpovySS/KSmu/jRep8TTwEeRXXAib8?=
 =?us-ascii?Q?UEEPSQRp9BJG0Mxiq2NFeZ4htwUpRKVa/f4CTn/SqAxhh71haTs58ej3jT2b?=
 =?us-ascii?Q?VYMaEsuATXiiDXLnP6MSB3aVWfQF6Pju5/hlxyTZehekXmH6z45k76PM6pXJ?=
 =?us-ascii?Q?xb0iQ4kNEXbsfcsGQcJxXwmfykl9Ad5S+7QDKhJ9jXuew/95Pme40JhkK8X9?=
 =?us-ascii?Q?WRmlJ9p0SBWAY4j6abgJtkYYBMMjrbv7Bnxya3XfHAl6GxziZjEqVVfZ0GHH?=
 =?us-ascii?Q?jjQUR2YLJsm0qHa7sl5MhN8tDrqXzEl0WU4K1A/0I9QLBPRAo1WrC0jJRxBn?=
 =?us-ascii?Q?FI9H6njywgzTDccXM1ll6bAM+g3hUJzwi6gETxSk9GLm4n8y2ZqfNDRilV4Y?=
 =?us-ascii?Q?2Wb9KOxZZb72yyLDaHe6Q/o1drdByS+mnRdackJMualx10BfLZbFyC0waETo?=
 =?us-ascii?Q?Ncx/xy5Oz4NpKKCSI5wlCuc0RHoxVRmZlrbusRmnqoWJQh+7DLjtn/SHqfFr?=
 =?us-ascii?Q?hM5kQk2cnotvKOd/L9E50iQ4N5FMCcwVxbbeBw1G2sw9PuTv4qC6HkSVj+Qh?=
 =?us-ascii?Q?I1mFr/X9yHrLWK25LNvbf6wwngjFj56Kcm/7aWrnQFJzKw/cnTyad3FMMErY?=
 =?us-ascii?Q?Q4kKK6AD7btpTVdIe97UeihVmj+zfy9k0tvoX/yW2uinOaCx6j0aA/GJdjuy?=
 =?us-ascii?Q?YpIXRLrlMEMmM/+P5CnK1LA1QUqy060DHDU15rvzNZzVoa2LbqyFFlobvpaV?=
 =?us-ascii?Q?t/Z3mzAatkMec6uu5iUc8sdhmXWnPs5niPzAuiARW/37F6gAEJvXwz1OB96d?=
 =?us-ascii?Q?AQwpXtmE2/QdPJCx3qYpbo7t570B2ZPYyoKDic5RbDHgLQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea2f3be-1849-40d7-3d48-08d91693dc0c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:50:55.9738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44FxtRTLHr6vzwtMLLAHuMuU/vQoqBA2PPpMg9flz1dW9qqtVj0EbIxHcgYwzS3ckRLR4ZSQsxxqbleccPWgdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Cc: Stylon Wang <stylon.wang@amd.com>, Chris Park <Chris.Park@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
Active DP dongles return no EDID when dongle
is connected, but VGA display is taken out.
Current driver behavior does not remove the
active display when this happens, and this is
a gap between dongle DTP and dongle behavior.

[How]
For active DP dongles and non-DP scenario,
disconnect sink on detection when no EDID
is read due to timeout.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 81beff4e9434..c07b45c021d5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1099,6 +1099,24 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			    dc_is_dvi_signal(link->connector_signal)) {
 				if (prev_sink)
 					dc_sink_release(prev_sink);
+				link_disconnect_sink(link);
+
+				return false;
+			}
+			/*
+			 * Abort detection for DP connectors if we have
+			 * no EDID and connector is active converter
+			 * as there are no display downstream
+			 *
+			 */
+			if (dc_is_dp_sst_signal(link->connector_signal) &&
+				(link->dpcd_caps.dongle_type ==
+						DISPLAY_DONGLE_DP_VGA_CONVERTER ||
+				link->dpcd_caps.dongle_type ==
+						DISPLAY_DONGLE_DP_DVI_CONVERTER)) {
+				if (prev_sink)
+					dc_sink_release(prev_sink);
+				link_disconnect_sink(link);
 
 				return false;
 			}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
