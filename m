Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58736C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15718611AE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15718611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E880B6E843;
	Thu, 20 May 2021 03:58:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F25476E843
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 03:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2ifCZ5GTQN7Ocrv/UlZnIBRltwYn9KM44dh+hU/WcnOCXB661VEIU9vy+Q9PXyrGyn0tfrHK+l9kRQ57VvJ50XMcETFxMr9tAFs9xmNrduLqJLit0Z8bmDV5bhprRT5b4tZlLMwSM8VgQif85+2Yk7ym7dAUaylzd5PiNAD64cLyjv8Y7q16Ex5SJT/sYfawCd9C9C+hoMNB7RL9eQRprshWCwPRx7oKk6THQKjv6CyDh5utvi05k3LMMH+V3H8JBQePMI8tAitazMa2jeVzo+CWSVltowWIh9eZETyRhOS9DYsMXHCylGLeVz+GgO8ZZyjATD88+Z6VCqB7A3f9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqR/FJZAemnxgi7OESQ1Q08OH3+YfhV5QisDFgKRtds=;
 b=OUwU/zdfxqW7mpwvX8iif//ZK9DUQtJW1PfcQQ32rYNGdU1qyKe+QdEl6FwaP+VJkJ+mTCjJJ5BTIRNFF/mUUmMMNIflYiFwzV4eVRJbjUGPUHcJrUf0mQD9R3zaTre66XppPd0q7pv2gxjrpUL42wBlyN4MOtwiVsX1mjj7UvDLAd3iZsOCmUX2buk3Deq3z65pNqhgrIUxJ521ZLLi/HGKwkiSrPy8CGGHIbiMDy+a2Dm9DBD5l1aHtFxaL4LlQzIVhjhMp5SnwohfqK5CEX3Yy2oGN/rVz6x5XjmUAckaZ56mRqZV4yP7+DTAHyRcxsNzTgGNRCUIJRGnkjX3Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqR/FJZAemnxgi7OESQ1Q08OH3+YfhV5QisDFgKRtds=;
 b=vMmImsHrZPt5P0SK9Rlt85RQQq2HiW6Qrx4tWjSEtfa/Rite9dh0jvoU/ur0kQihDA6XDMZMksb59T+vBxyFsVBRBS9PqAM0ExqeDdH4MA1zJcrfnLSHaL1NQcTliEKMG7JFio6T2XQkGH5maifZoCHs27AJEuaXyRoJJaasCsc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM5PR12MB1612.namprd12.prod.outlook.com (2603:10b6:4:a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Thu, 20 May 2021 03:57:57 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0%4]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 03:57:57 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] amdgpu/pm: add kernel documentation for
 smu_get_power_limit
Date: Wed, 19 May 2021 23:57:22 -0400
Message-Id: <20210520035722.4877-6-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520035722.4877-1-darren.powell@amd.com>
References: <20210520035722.4877-1-darren.powell@amd.com>
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::20) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dapowell-ubuntu-200400-1.amd.com (165.204.54.211) by
 YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31 via Frontend
 Transport; Thu, 20 May 2021 03:57:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bbba355-eafb-4993-51d9-08d91b437411
X-MS-TrafficTypeDiagnostic: DM5PR12MB1612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB16125C88FD1606AE86FDCDD5F02A9@DM5PR12MB1612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRKV8JZEqDNm1/4G4JCyyhv8aNpsKTrjOkmJ1gTGSoTy9mCBBS72ImylxQmrJmY7xp0FugvQae2aHvnmO0w4O6E/TAuZQ9E/g5kECROoThwfmzpYe8h6B7pym68KYZpvr4rhwzB8WM6674mB4QO6GP35qRo0T6oISVY31i0Isiaa4Vf2j/bIcqlaiaqf0ybwTWIk+i4OBmPNchcxEyjuP2yVh/bxY23+cER1BTolzEeAtuqeyEDHClDjbw3QbgDeWNdQ3n5+DOGEG2IcpYODzR98NDXJ1RUz+vDoh5nf059l3ZaYcbdZntyOzB8bmyhsIeeoEI3Ew5VLqniX+N3cXvpSRFEOpWKII0+t7+RivHqcQMiNGCLjjpAsiARGmWv+vSaXZOxxkLGYYJGtc7ltb/GBvzpfaKfbTShMN5GAaOWpU7O4ZC5/4dL2I9xVNS5RRY5mp6RS/jCUchHxCl+Aq4lHlwQvBoHIFMVL1oHuyp5NtdmXc5JqrykciSTx08LBYuIbcXJeBrKgbeQ5RdrATyg9UdvozRnFf47fvRoDjmD/GxGQoCbeaJOGhZ1ifk8hyyaip0mNxu1Ev2Xia/v+/bu+iENJtiWXyGuo9sgFFJjGH3/HkW2y+Er+FCNuVvOwtIRm253KGj6QHu/gmfHEpjgnxnBiQQpaxufoghfurgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(66476007)(66556008)(2616005)(66946007)(16526019)(86362001)(186003)(4326008)(316002)(478600001)(956004)(52116002)(6916009)(7696005)(6666004)(26005)(2906002)(6486002)(44832011)(8676002)(36756003)(5660300002)(8936002)(38100700002)(38350700002)(83380400001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3nO4gNLz952JRvvqreUq2PvQ/kesrPB54FRQeZLCBXyik3WcL2ufkWKLha0H?=
 =?us-ascii?Q?ibjZ+WVBaNyKKtIJmQ/ZnruzeaX/ReEAOFaalhbSCNPu9Un0wjemOtozZqKX?=
 =?us-ascii?Q?H/QRFcQiuMVHJZ5HvGiavtaBkfVJmv74JvEZ8iYqp2m6UmqcYjkFw7n0JD9Y?=
 =?us-ascii?Q?2qYu4njbJ41m2RnoDrGeOxvl3gAmyle3Ed1M8deBdVjBgNmRKXVOL6e4DTuq?=
 =?us-ascii?Q?M/Adx7EZNa2yL61MwBMgUIoSOVfWyX/cQIoyu2GOXBlPP2HztI1SR7AiZPaI?=
 =?us-ascii?Q?Bz8kwLdJJTaNJmWGViBLY+VFFmeCzhnh80T+NHPbFzeS/4wW2Cv6Nsaeidey?=
 =?us-ascii?Q?Dmd4/rjRjhMcAea0XU2NDXQAnPTva0zJR9cROsKImgvbv2TDwhcfXn42gEHQ?=
 =?us-ascii?Q?EO+2CKZNcQ1HlWsNcb4japcF0c1W2/YT6hyB2s3Qa9SuHcTWKqN89LJnTsR4?=
 =?us-ascii?Q?IsmKdezZI5Vcr25+1y9WbRELDM1EXhRAVInZj10+Ox/8+gpcHD6+0ALCA86J?=
 =?us-ascii?Q?fsbtPAENwQzGAeFuUmkeLyE4qpOoHXR2BMbKG3plD+wEVCQAZmY8ZnrTnk5U?=
 =?us-ascii?Q?mMKc6D3KI5gXTdK0T5D/GKlF4wuUQ/Rvdp/M6Mn0hAwrHaZ79KICCm3phQM2?=
 =?us-ascii?Q?M6zEOnU7L47F9Q8J/1qMo2rhVkD4vkR8kWdwPymp6UK7KcTSdPvwzPGPACaE?=
 =?us-ascii?Q?y4zqgRFOuzwnlEXu0t8dc81/IAFPQTkOtpq2Qd+DfiMGgNck+HfZ2ItNUzUL?=
 =?us-ascii?Q?ddHxwOdPw6AtO/KBsxMUVW0kOgEFfOyV3RGJlTSiq1gPGwYQi+ZnqdQsrxqn?=
 =?us-ascii?Q?qMCPmT0uoD3tI91Gzirgg1DUZNxM1+WNZVAxaltpcE5VUaEdxuO81epWrG+k?=
 =?us-ascii?Q?tX4lyimicN3Bos86IdjiXJwaNxg0t2PiB8Mux6GbifaifhMC8nZto36NHpxN?=
 =?us-ascii?Q?3BL/Zhakzb5cIgVRvuXt3PFDl3XR3OYU9ln4gKKfw5izONehFIlGHKkIDX3L?=
 =?us-ascii?Q?Bwtybi0wfvNwDqlk9hlfO0ywLygWR7sNJn5CfjmGeKyLyDoPEIoM3glkWbnZ?=
 =?us-ascii?Q?RX8AH/dK3jb80zi00CKlQcZZPPcWBBqs71TbCsNTQYn1L2rkgS8LRT+ZyJLO?=
 =?us-ascii?Q?/z+u78Xjw3Fz3PrquzZQaDokoRuKkldATvmSgvIBFyWLjO9KRRyOepCzF+ya?=
 =?us-ascii?Q?GOTa4JJ1sh/hu3paIScixZMWDXyAGjmRhslhucPAYxWwoxvXx450B3/vLMBR?=
 =?us-ascii?Q?toCtFwl4PTHnD/5FYDXBswNrWq/sQoxZiyfdOUKMbT2n9aYzEHkuaI6wrQ4p?=
 =?us-ascii?Q?6YiLkqQTCveX7eOrN/3YJktQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbba355-eafb-4993-51d9-08d91b437411
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 03:57:57.5935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYI9bWj/JQLQcFU0AHhSsc5hZRRHijSxRzU92/SyJrSdeT7xhUMNIPO2aMwFOA8KOKp9ypCyJVqTEgVQH05iFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1612
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Test:
* Temporary insertion into Documentation/gpu/amdgpu.rst
------------START------------
Test Documentation
==================

smu_get_power_limit
-------------------
.. kernel-doc:: drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
   :identifiers: smu_get_power_limit

.. kernel-doc:: drivers/gpu/drm/amd/include/kgd_pp_interface.h
   :identifiers: pp_power_limit_level
-------------END-------------

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 21 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 +++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 606c89eb206f..e86eecdf6a76 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -192,6 +192,27 @@ enum pp_df_cstate {
 	DF_CSTATE_ALLOW,
 };
 
+/**
+ * enum pp_power_limit_level - Used to query the power limits
+ *
+ * APU power is managed to system-level requirements through the PPT
+ * (package power tracking) feature. PPT is intended to limit power to the
+ * requirements of the power source and could be dynamically updated to
+ * maximize APU performance within the system power budget.
+ *
+ * PP_PWR_LIMIT_* manages the configurable, thermally significant
+ * moving average of APU power (default ~5000 ms).
+ * PP_PWR_LIMIT_FAST_* manages the ~10 ms moving average of APU power,
+ * where supported.
+ *
+ * @PP_PWR_LIMIT_MIN: Minimum Power Limit
+ * @PP_PWR_LIMIT_CURRENT: Current Power Limit (Long Window)
+ * @PP_PWR_LIMIT_DEFAULT: Default Power Limit (Long Window)
+ * @PP_PWR_LIMIT_MAX: Maximum Power Limit (Long Window)
+ * @PP_PWR_LIMIT_FAST_CURRENT:  Current Power Limit (Short Window)
+ * @PP_PWR_LIMIT_FAST_DEFAULT: Default Power Limit (Short Window)
+ * @PP_PWR_LIMIT_FAST_MAX: Maximum Power Limit (Short Window)
+ */
 enum pp_power_limit_level
 {
 	PP_PWR_LIMIT_MIN = -1,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2815e932580b..57f416732265 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2166,6 +2166,16 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	return ret;
 }
 
+/**
+ * smu_get_power_limit - Request one of the SMU Power Limits
+ *
+ * @handle: pointer to smu context
+ * @limit: requested limit is written back to this variable
+ * @pwr_limit_level: &pp_power_limit_level which power limit to return
+ *
+ * Return:  0 on success, <0 on error
+ *
+ */
 int smu_get_power_limit(void *handle, uint32_t *limit,
 			enum pp_power_limit_level pwr_limit_level)
 {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
