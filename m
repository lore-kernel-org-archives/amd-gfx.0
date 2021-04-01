Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B42DC43461
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002CE61390
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002CE61390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 414416ECEE;
	Thu,  1 Apr 2021 16:46:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544B56ECEE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRpA+CaOZ0gXsmiOtoXsi5X+p388/WbYDDw+TCSF/nbd60FobXX1NyWQLK5/r187e6Oldssfdyh1K5S/Zqw80wn04bv6+YqU2VUu/c3xxuR+h87FJPLwgcmkpCqAUfPuLSukw+WXL6LMNUWQnZ42Ug8Y+Ma1lh/mBwX7pEs1Druao194c/FzfTXaJDyzbIY1fWTiTK02N4ghzn/KWe4Wy5aJ56qr2O59KJQxvOhJUOLAKq1fXxsiB0KVAsHN/r0B8nO9/Q8N9jWpG4iO/53yKloSaYFv2iUF+KkPKLpLZgEvw1YJR0X5hiz3nEO/oBGfSB4NGK6idLAQYKR4E+NePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbAMKxgnALRraiTcmwV3bLLmjQdVieAm2W/Ay1E6KRE=;
 b=THRK80JC2LPnIqRneyiJ6ymyuFtWThS3U4SAHBv276OXh07etMBG3nsllojIZ4mESxzvLga66BjbwABXxnlvwS5kblumiCwjZJkAYxGS8XtwwUDlm8IgIBZaqZNdQULsGxc34a2FKXq5OyC/5jCNYp4h1KA0AUk+8ow2ZTCDMdPkiO3UN4Q9gYg0fwIn3MPr8QdmcYkoI8xSg1V4HzgeKfp20/ldnMTMTqK7q0WQvxkakhYZIbFzT+qMT7CSVBDCMX1+WYIQTIux+4QQwA3hKrmlORFZAmPLN+s2O4zjyQc1lvSpY0K/dN9H9gHEq9nd77m9PnH55V07451wPV9ihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbAMKxgnALRraiTcmwV3bLLmjQdVieAm2W/Ay1E6KRE=;
 b=pN6CfGZlOPhg8/yV5+sz77YssKEt5cc9+S+4ODDpDoVUPaSc8mtvetiAY9FamNbO5N5PA9eZmtwCnitSeNBqljNmeIGHEyllqFvN4VMgamFKjy7P7lYzh0DgF/Z37RDmNKj3Ef3r1d9j3JkOmAchQK4Dem60JmG4tIMsCvyr/HE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 16:46:09 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:46:09 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/21] drm/amd/display: Determine synchronization edge based
 on master's vsync
Date: Thu,  1 Apr 2021 12:45:23 -0400
Message-Id: <20210401164527.26603-18-qingqing.zhuo@amd.com>
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
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:46:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23b49e94-dda9-4149-ab97-08d8f52da6b8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148C58383D673DEF7A8F6D5FB7B9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xh0sRcSg1LANV4UiNNd/OkxUq9jcueTw34VyyTR9Z4ZhKPqVSliQ/Rzl8GLOxLwu1UDtOMO4vjMpSfEoFl6EqeYLnKnSOl8SAKmDKXo7RbZYtCOihf68BTx8VfPfzF+tB1kACN+AfwNXAQmqJT2Tm5h5uasfnthzcrafjWo8hdg6RfSFtooriXtPEL/p3b7rrN+JY58Xr4kKGLfcBKCc45AuhiK8la740E4jNb95iURxePXcHetDZNt95JQI9Rjqwt2kv2meQIgsmgglwmIWxJgC5lh4nuzBCDwvpTm4JKIV525QhJ7JawMe8K646gz1MFDSunOFIesWXe/zN9oxXx6qRFi6gGSteGH0SjWM2nhLUa0JMB0j3HPN3eLFHJ9vTqv5/DVFVxv/foKclbFBCp9gkXl4t17Bj3IjmaS7DlIcMwDi/1EARSR+eUNoKmAdzL3bJy4GssiVSDMzWNjllEK2cwPSxcZM4y12l5L0ckxVCxpA4GK+iQOA1RawBah+1oIPAI61pAsLhKUT7+VnSrq+8ucz0dEbwQJA6+45acsUdy86El9bg9jiM8XXlGnaDZrAhAGjYcqoSNqEIgM+GEBqVGjjy6mhaGcDlgK/DZPwlIbPpaiXlhFDhIvbTfDIBaPjIBbEa94Oc/xSI+dGziM+MkRxv2qazX/83Me/lCl714mgi6qhsn+PlZU6tLhm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(36756003)(52116002)(4326008)(6506007)(478600001)(5660300002)(66476007)(66946007)(316002)(6666004)(1076003)(2906002)(69590400012)(66556008)(38100700001)(2616005)(956004)(6916009)(83380400001)(86362001)(8676002)(8936002)(44832011)(6486002)(186003)(26005)(6512007)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XRnqTwo695npYTKsH8xCj2dANrD6+wX63Kk//9yaZ6IFRK46vAXciYHSWVqf?=
 =?us-ascii?Q?D8ScrMZPrPnaR+VRo2TAblk/2kPY37ASSXc5O7UC52Ab9tw/28qbM3tx6rqZ?=
 =?us-ascii?Q?camc/V5fNhFV8RGUVdToO6PlQCKIrPSsSEeRZHS2abrXGzLA8zi4IdWKvpxt?=
 =?us-ascii?Q?AHJ8oL9lH2xKIywMGNDexWYqtbjCtrPAZxpb27asP24YVhwNPkqf0InJdAHc?=
 =?us-ascii?Q?HL0SiS67kHUlWmurnDhTm+0+MKAepgEaSlxzcLNmBGvi6kJ2LEsYfGjqCPyP?=
 =?us-ascii?Q?e9vkWrUQk5sx0npyeLR33GBtjmb/r/YssMaT+yuiB5Xcxn9Xn5x6oYuVVeha?=
 =?us-ascii?Q?5xuNim9VEY+6eKR3t5Tf4j5vCkzm3n3bHdJK+ei6NGjoelCEBBxfkd28f2Qk?=
 =?us-ascii?Q?a31eBiVYH9FLeOxJSXeiIGt5qOxshS+dUu5u7QRAW2To7hEHclpsJ2BlqbyG?=
 =?us-ascii?Q?ZPJzB+eDFtPXbNYUFbLH9Sn9zK43b9sfnUV5vbtmjZGNBZRYnMLEHXUoD91j?=
 =?us-ascii?Q?KVRsABycrqc79bKVckP5o7YgVBBiMcZ9nxaSoI+NQzSnrBb931Uil+ZR/vpZ?=
 =?us-ascii?Q?BfPkKgspkMaSP97CTaeukp9waRZSwHo+bazaFroziCY7/xP3cQYCtX5a0vnC?=
 =?us-ascii?Q?1TOywoFYuNXGFZfLRQwskcGdSKE+i69HwmcZN8mLhCX85yW3Bkywfpy5ofD8?=
 =?us-ascii?Q?b5rN+q91kWo+1+P5Y3YCOTYTotLb7P1VdBBkxvfKq0iEG5p/T/TdCFUy5dAe?=
 =?us-ascii?Q?uvrsd00eHnbRTQotKIUwndGkW9bKKRqurVOITZlv6HGIk1ccsUPS8ZRGtcyc?=
 =?us-ascii?Q?aSvldb1nZsFBWFCuf3/9Aee7QLKyww1WuOosf16fY+YQGmQQrg7Lg5Y7OMF6?=
 =?us-ascii?Q?QIX3VUGad7tiu8lug0Lpe4iPb0LMN7FUyGdyb6cyLK89C3AK8zg2gwHzPPlG?=
 =?us-ascii?Q?lRDl/Nsse0gczQh1+Gou05D3LxjDgeID83TwguUyb/8D4VL3dwjKEopKX14H?=
 =?us-ascii?Q?vHf1A20vtAECuQVpXlplqIwnaeedXU1/YMsZhuOgiDJEUDwCz05HJ7D3ScTN?=
 =?us-ascii?Q?CL2o4WWbQ4Qvlmp+2Gah9klkKnpDiDYP5Rz0CAEKhUkIg7s0kt8dV4yG2bKj?=
 =?us-ascii?Q?X9m+8qL9uHSpZdEZhnPUqTH0diVJxBsEa51NAy0avyUcVsG/EK7AJmebhrrJ?=
 =?us-ascii?Q?5xEsHQVwlmQ+ENW8C4ZztAvbY1i8r4xb7ptq3YHLKtkOKryLE7E2c6u6XOOC?=
 =?us-ascii?Q?WC5ti6p9ffcpqLyWRTBBaHec5/dR0dPsyoDm3jMEzKHdza8X7EbAg/4fLhv7?=
 =?us-ascii?Q?QkkIx+bAQNAxrDPuMQShHdm+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b49e94-dda9-4149-ab97-08d8f52da6b8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:46:09.4347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdvlxsxigWIasjZkWNSTFpPrqPnUrBhufAly3rYBphR5dphwi3bdtaWIDa/sjQUS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
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
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[Why&How]
The driver always wants to synchronize streams
to the first edge of master's vsync pulse.
In order to determine that we can read timing
flags that are used to program vsync.

Master stream's vsync polarity - Multi Display Stream Synchronization edge:

        Negative               -              Falling Edge

        Positive               -              Rising Edge

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Reviewed-by: Sun peng Li <Sunpeng.Li@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 92cee957b424..a57cbdb2c7a9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5394,9 +5394,14 @@ create_fake_sink(struct amdgpu_dm_connector *aconnector)
 static void set_multisync_trigger_params(
 		struct dc_stream_state *stream)
 {
+	struct dc_stream_state *master = NULL;
+
 	if (stream->triggered_crtc_reset.enabled) {
-		stream->triggered_crtc_reset.event = CRTC_EVENT_VSYNC_RISING;
-		stream->triggered_crtc_reset.delay = TRIGGER_DELAY_NEXT_LINE;
+		master = stream->triggered_crtc_reset.event_source;
+		stream->triggered_crtc_reset.event =
+			master->timing.flags.VSYNC_POSITIVE_POLARITY ?
+			CRTC_EVENT_VSYNC_RISING : CRTC_EVENT_VSYNC_FALLING;
+		stream->triggered_crtc_reset.delay = TRIGGER_DELAY_NEXT_PIXEL;
 	}
 }
 
@@ -5426,6 +5431,7 @@ static void set_master_stream(struct dc_stream_state *stream_set[],
 static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 {
 	int i = 0;
+	struct dc_stream_state *stream;
 
 	if (context->stream_count < 2)
 		return;
@@ -5437,9 +5443,18 @@ static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 		 * crtc_sync_master.multi_sync_enabled flag
 		 * For now it's set to false
 		 */
-		set_multisync_trigger_params(context->streams[i]);
 	}
+
 	set_master_stream(context->streams, context->stream_count);
+
+	for (i = 0; i < context->stream_count ; i++) {
+		stream = context->streams[i];
+
+		if (!stream)
+			continue;
+
+		set_multisync_trigger_params(stream);
+	}
 }
 
 static struct drm_display_mode *
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
