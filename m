Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E52FC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2707164F4C
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2707164F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8EE06EA55;
	Thu,  4 Mar 2021 17:41:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED106EA56
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 17:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCDh0OYsrr4lzCpdAJ04bIQjMFBGyjFqR4yC8bpKuCrilAnm2bkcjn1yoggRCMoeIptouesXH+p7R+mIoCerOLcSu9bVUGeRwee3bacIu74Z6z/LR7Wp26SR4qe9iYwJKAx9YvDSySZhuMjDM3YCgTw4p8+yMDmRqLA2M2itsTHMz+quS5Svuq4X6QEVN0dopRVXrmQ3jBWS2Iq+082U2q39H/eIs10txLaTKKmIkyGQfKGU+PFrEBrWmO2ecOb9K937iFmx3hx9zdZCTJbzNa8i9MAggM9YRfIzUsHfGtxGAfRAGuULWST6Ac0Eol5QQCpKX9nUko30rL4iPYG3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Cp7+AS+cMPjVGsgsmok3+NDG99xX4i/8c4V0VZXad0=;
 b=W1OSkpzjksf/UGJHOskiP4v9DHfBIjLcr4FAuM05DWmEfsRMnI3nQT4VFMjRHH19o5j50GwZHQMdks/yxNGtv6bjRef9nQxfl5WUehqqei/LAYsN3bOLAmimHiDbGrcTw57IyiYtMhS358DEQZj+sBrTAnXRJAeOkywG0Xt5rlkBu/T15l5rgIwTamcJsInZPWInJalRvVb2cx9HMYWfdzy+0XBnU/LLmjabU1gMx8n03T2+uMlbByu007OdnEjWaXNnHMa39y6vydYACRvAMqxMOujRFCpBWjRCV4zE8WCkjPpSWq1J7+hUWx+YtEkO3yOwRx0oJljxbDPQPBzx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Cp7+AS+cMPjVGsgsmok3+NDG99xX4i/8c4V0VZXad0=;
 b=car1mdrlAYd4OEei5vwJHOqulqLmSjXun6GVHvTDP/hI5bUEBRP6/kGXDxJUYuoYqxjYRzYKb8+4cuONf2PdW55deO9vGza6aZRN8EBAz7mlwfhjOuTCovJPO2uSG9CBsLImerDAz0j4fECWvx5dVA6GPAdSa+4YQR0Hf46B9DA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MWHPR12MB1341.namprd12.prod.outlook.com (2603:10b6:300:11::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 17:41:27 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::e0fc:4c91:e080:7b]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::e0fc:4c91:e080:7b%3]) with mapi id 15.20.3890.030; Thu, 4 Mar 2021
 17:41:27 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, tiwai@suse.de, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, nicholas.kazlauskas@amd.com
Subject: [PATCH 4/4] drm/amd/display: Add a backlight module option
Date: Thu,  4 Mar 2021 12:41:03 -0500
Message-Id: <20210304174103.202272-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174103.202272-1-alexander.deucher@amd.com>
References: <20210304174103.202272-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:208:236::18) To MW3PR12MB4491.namprd12.prod.outlook.com
 (2603:10b6:303:5c::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:208:236::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Thu, 4 Mar 2021 17:41:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ccd8944f-6dab-423b-a9d0-08d8df34bc9d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1341FE55CB0FB718446CE5A0F7979@MWHPR12MB1341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaUJyrcQ4mv0EOK+ODViMtPQTVLqW0FGltx2n4sdSNkhNzUwC1M4FQG5tz0+ZNaV1ODUOghDor9sIg3pBQU/muQyLc5pafS9hP5G59kEOE1pkld+hXGgD/3PYc4zL/6+Rh7aLdKKPsn3ZPjeSMAPLU0nRfLteyAImvHcNClObTqdkXBYopA1sYNt663Kq3ULXGSeJKnecOpDSKd/zMEuxXVa/pS5MPTb/9bxJxy1kKybwQOUoSQUFzAM++BAkYktE/1C9GrUOUxd6X9cpAc+pNO/wV5gNYU1M3fi4gldCIvjpKBAOjBABqzJ/5XberVNf51N28Cl89n7dK0bklmrXpM3fZ2ec0aPsqwzFV9iAeCpLb0xHoxj7amsepjuMZ/olyLOzdMT50cZtD9kxyEQsBXDXd/3wRlVFV513oJdbNvyhBcW60WB3kVsTcuk2I2Nm6sOi5MhnK3gMZzM6eb6dBVzHYxfs7KAVzMSX6+clqzzizUWHXYuu9bzC1Nz78Zjt40Yr1OWL9AJ2Y0XRKc42gMhy6MR9CTEcgq7iRaFvoSh1KHgSTZHSGu8yIrvbFNdFVfx4Fk+jOXyICLDcTaQRYk+uW5oJRJ/1dOGzc3Z1vYUmVUIIvhwobuLWkzogs9yDfuE4dULNOnPp3vfdpLNOdZq5iTGDJjmiU7fn84YV5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(966005)(66556008)(66946007)(52116002)(478600001)(6506007)(66476007)(316002)(1076003)(2906002)(956004)(2616005)(6486002)(8936002)(6666004)(8676002)(4326008)(26005)(6512007)(16526019)(186003)(83380400001)(6636002)(69590400012)(5660300002)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kKP5DbPB9ShqGm1Y0OFBl6pNn1DOO84A8kb6gBc+RB0GYf5FMrMYF5yib3Wa?=
 =?us-ascii?Q?Qmxapro03N1xH31ZlidpBmQxlwucA5i1e3txdCaz1ig7oRQ4l89sSzoxOrEu?=
 =?us-ascii?Q?EoAu4hpFmgDOn4usWVyVHiO7miXokkybY/Oz/9N7piGlnQIKdhLO6uY5I1SP?=
 =?us-ascii?Q?ZkLCuC+9NcCAZBBUXAdaq/1ZzY1dcGLqhiEzquQDYNnF0/go9GMroKppIR6a?=
 =?us-ascii?Q?C5i+fv/y5EwgrNdKIpmHvguQRsVHE/NPOsXifvMJFV6TK4yjrNHgrEf8Lhug?=
 =?us-ascii?Q?4hJ0f1Y7Sn16Z3tja9xv9Kz+4nuzELugu5a18MmHlqSD5K3W4FhOZZUBqBIM?=
 =?us-ascii?Q?w6yUS1NBfZaXf4mqC7xWwC6R3EcLYbcsR7a7oqIChJdHr4ed0DV8iSyjo4C5?=
 =?us-ascii?Q?t58kstN5MtRsEUdvtlpFhRgY1nVugxSSCTFh3JtkubhP6O9DjP4DBMBFtl4R?=
 =?us-ascii?Q?Jxak+4EMIkF/Rg4FR2AiRkMccQTMfqPi8Ur/48UvRMG7vFUP54wuriW+rBRC?=
 =?us-ascii?Q?hB9kDKDnDRcBh76F0FG+wX72PvCgfrUxvRIaFsp5YD4JWoq+yBrr2vrbSHqO?=
 =?us-ascii?Q?Rc9ZQ3motJyH0HOFDSC/mCdvwsdh/UUHMSDSGu4XGQhiG+OYE9BPVDoExAhO?=
 =?us-ascii?Q?WA/ndoijGYEVMCZJhth0SmhABd6UTd4l5yydI0cAQnFy9NRWK1TI4YTfrm7O?=
 =?us-ascii?Q?nyAE+kCAFDp3zdE+aIYCe4k8ax1TnlhSspLR7WjFPtBcrhwcxh5RKkQrAhM9?=
 =?us-ascii?Q?8ozNCUHvY/400yY4B0RX75cSb82d47cGjcvPiKfuCH6z6iTGj+J+iCDkqWxK?=
 =?us-ascii?Q?AWik7ok6cmtzp5iHpZlFcUwlgu++KKShet4j8XcXzV6vx3yX6+Y1b16G7H5M?=
 =?us-ascii?Q?NNOUROx8OjIBVBJEqAbfdI32CTvRfsW/SmJWse9qE0Ix71q4rHiAD+FYfWPD?=
 =?us-ascii?Q?dfchShDXQq9nO+za63Z+pLxk9eLvpaWpPhY+HVF1sSBheOImuC25itZHFVAE?=
 =?us-ascii?Q?vGCCy3Xr9jlkS/do6RYopjPNQ9iQGAjUZ94Z2u0uHifTXS0dS5o9f80mXelt?=
 =?us-ascii?Q?cFPOwxkkMyU7uyn6LamAeY9xijTJeavl0dBB6KmqjBZ+rQXNkFqqOIb/3YpT?=
 =?us-ascii?Q?8zxkQhzeM4RSvy7CyD54gqR68Cm6yKXpxD8J08x2HUEZcqoreRFaunE3yYrR?=
 =?us-ascii?Q?f+KWzeRlKyAoGvGN5x6X4WDt2aw6mpd7LqG/H0Q7OdVaKHOgWT6R9dQAOwrP?=
 =?us-ascii?Q?HK1sJjFOEjtrLkLqCNlCGTxG+9i0ufPKDPvbjhP5xcDuLP48UO3e7M0qbyZc?=
 =?us-ascii?Q?CWEQ69I23XC3Lo+XJvIzL2ed?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd8944f-6dab-423b-a9d0-08d8df34bc9d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 17:41:27.3207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwtqktk92EruwteVu249Inl14dDdLOtq4Ywz8dH2usBZwcnf87BizkiibdyimD4OJgZY3yDqU99DKyzkHt7P7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1341
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Takashi Iwai <tiwai@suse.de>

There seem devices that don't work with the aux channel backlight
control.  For allowing such users to test with the other backlight
control method, provide a new module option, aux_backlight, to specify
enabling or disabling the aux backport support explicitly.  As
default, the aux support is detected by the hardware capability.

v2: make the backlight option generic in case we add future
backlight types (Alex)

BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1180749
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1438
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 4 ++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9c0e1d43b470..2673457fba58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -181,6 +181,7 @@ extern uint amdgpu_dc_feature_mask;
 extern uint amdgpu_freesync_vid_mode;
 extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dm_abm_level;
+extern int amdgpu_backlight;
 extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3a6f52a4b2ec..b3832eb16eb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -784,6 +784,10 @@ uint amdgpu_dm_abm_level;
 MODULE_PARM_DESC(abmlevel, "ABM level (0 = off (default), 1-4 = backlight reduction level) ");
 module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
 
+int amdgpu_backlight = -1;
+MODULE_PARM_DESC(backlight, "Backlight control (0 = pwm, 1 = aux, -1 auto (default))");
+module_param_named(backlight, amdgpu_backlight, bint, 0444);
+
 /**
  * DOC: tmz (int)
  * Trusted Memory Zone (TMZ) is a method to protect data being written
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fb1ad1426cd1..e91af2efb2ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2282,6 +2282,11 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	    caps->ext_caps->bits.hdr_aux_backlight_control == 1)
 		caps->aux_support = true;
 
+	if (amdgpu_backlight == 0)
+		caps->aux_support = false;
+	else if (amdgpu_backlight == 1)
+		caps->aux_support = true;
+
 	/* From the specification (CTA-861-G), for calculating the maximum
 	 * luminance we need to use:
 	 *	Luminance = 50*2**(CV/32)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
