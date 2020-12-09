Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82CAC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 04:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F1D2389E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 04:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F1D2389E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106EE6E0EA;
	Wed,  9 Dec 2020 04:19:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D8D06E0EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 04:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWM6kYwbLu7gCdukM9XvT51fnOABatdotXR/gn3zfnmZBtHWmFu2EmvF05I6tOBunc0cx1aTJ7tGc2dytU0TZ63hOMNx1oF3jGJbOVcXhPWhucvlwnxy4xEDsGoF673Z6+dnFvssWtKkgEl4sn6Q9SUH3GsWe1nQxwq5Je0CECOlZKB9qzF4fIeC4NAH4lQMhiGbZ/LgTuSLGE04Q22h3JYCeFSp6APwf+L5oLb8kcf0GuC6IJwk+WUKIUq8HmpSZBP6BayVihnKVohaL8WZhBzNV/KTNtxhR7zOjSA4NTXLtDCX5itP9I8oAE/leXK7UrFTHbVDEiv2+dS5JQDwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRESgfVO5V8MXTp5tB0ccugsktWjV5rIe3+xwwNgFi0=;
 b=fOx2aClKhKU32Df2Rmba8V5y+rX9iQgbegfDqrLkxMGFv22wF+oXTYr66k3hBqDwRX/iSN4Y1CzBoq+PgC3YTJ6zczjVEzsQYyBM/o76ncuZef+APd1fWwtaKTQ4q12EXtUbDmNYeVItQEHLorZDqNExdgXKAiCUewdwB72Kx6c7TVEJdmUZCCrCBEDpR0n4t9ReTB8H8KJIDqnBP6ediY9yNxl8WfZHpmHCz7740l9yNOAlTXfY14Swpeu3yYKb612vqdZdnfq72H9IYLu94BIDBJm/Ez3nstTJ8mBVL5K1e/URhGvLf2dxNzbcXJSZ757Te1FOk3Kf02dWTA/5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRESgfVO5V8MXTp5tB0ccugsktWjV5rIe3+xwwNgFi0=;
 b=gkd238PcyLMFHwG26M0CSL9EQ3zXmqybtyFr5g9Wh5Dq2dJPC1Va1am3WPJFGKdirSzxI1flD0JhbundFdTEn6/6bY5ek+iNPfBk8ZSmc9hIjwf29aOY3z8z4OhkYOttYltcb9E7O+mgAe/PrTMF9ROa3tgOxvuYz4eu3mfCeO0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 9 Dec 2020 04:19:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 04:19:05 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: new macro for determining 2ND_USB20PORT
 support
Date: Wed,  9 Dec 2020 12:18:34 +0800
Message-Id: <20201209041836.143264-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201209041836.143264-1-evan.quan@amd.com>
References: <20201209041836.143264-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:203:c9::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR03CA0024.apcprd03.prod.outlook.com (2603:1096:203:c9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Wed, 9 Dec 2020 04:19:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1346ad7c-8455-43d6-a2a2-08d89bf990c7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25055EF6C1E04383F816AA17E4CC0@DM5PR1201MB2505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxdQudwdkpJHAwDVw0Dc6c0MCJ7u00Bp9Jnw//0xjS3+SGOe5gwHpHLxv7g7zEXSyQXEbRuiM/vemIjvnrmzMuJAoSrIQsSD6HxNZhLp1REn9tjwvobtTn7dVe/8vjEIOdZWjEYjv0fC1/hFxByRmFHVIUMPkRGLFUsbO5hMvuNBKKqHT46a0aJbdP51eKw0wt3KPDa8qZd68mEzHJVwOWDysy3DVM3dwQcYdNognx4Uq3MwJhZQc1L0zCnf3JuOriH/vfHon+UxmYwEgyvTy5yqAAfL4SGl5Moq7ilrfDBkk1KRn//ubf8KwoSS8Uv78jaeA9vdR9DK4FYyR5d514IUX+h9T6PL1Z+YFCAKl0pNCXt/5aMHDyfjqZBjCUwk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(8936002)(7696005)(66556008)(66946007)(66476007)(52116002)(508600001)(186003)(16526019)(44832011)(6916009)(8676002)(6666004)(1076003)(36756003)(26005)(86362001)(2906002)(34490700003)(4744005)(4326008)(6486002)(5660300002)(956004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/xgP2ejQIJk2XQuU3BOSU3rrMTjgQb0adICdkO9X9/0uUlFWP2c4rUL7kPXW?=
 =?us-ascii?Q?Gi8PvvkqttPm78WqDKDV61Vp0qZthw0OAK5YLCzVseCh1cPp/LiVZshJ1UVX?=
 =?us-ascii?Q?SU7bPhneUm7BrqzzXMBjtPS9ke6jDRQiVW8AyV2xc+9CVZoZ7WOuse0qb4w8?=
 =?us-ascii?Q?KZ4Oc4K4E1DqdDEKfQXgqGhmOfXzMAcMpNbrzY961UDznnRxwAPgQF4ogfwU?=
 =?us-ascii?Q?l/lAn1GwYIXNkYkRu9JnDI+pm8dpdr/RDQqLXzlGULON6/y5Rk9g1vwcMssC?=
 =?us-ascii?Q?ierIxOc2mQi+B8I1fjMp7b6f8AvveApS4McEjaUdSZvpqvLvcDq2Ce1JOUHd?=
 =?us-ascii?Q?QYNMRQcmgihVRuaJkbwtyUVumZdISCpCSL835mRnqB4lHVyvUuo8aTliN9hI?=
 =?us-ascii?Q?TRygKEMpRaJZtzT/HYDIVUloeA8dWAfc5d+vk0VQ0PYUoq+33X1DMEfo0lgk?=
 =?us-ascii?Q?S6iHDu1/o5Q1tBZsPxVB+p9qqDzNCh3W569D5yEUBIg8z8ukS+xO6aDEdn+J?=
 =?us-ascii?Q?Zr2DvfNzIB3bpeNeVDDLTQIxiQM4Qk3irPvR5exfWj0SHoqRE3hwwcwXxcLb?=
 =?us-ascii?Q?VTUgwq3o8e3kYMhfUZ+n+uL1H6TFWrAieCVtuoDWWPbKJHW1uZmUEKDrJE3i?=
 =?us-ascii?Q?OhhCQGy5IKxPX7/IxtoMD8lZ9At8FYCYsUTrKhc7aI/rQIrm2ZDY3vHZ0sgQ?=
 =?us-ascii?Q?FADvdGkysmDUq0F3/IoTEpBIhuIJLtdRWTAd1yII1NUhSe6HzQ0NQHWQuH3b?=
 =?us-ascii?Q?ktmAHtqJR5WJDmMFK9pQUPevFcO+GI4JiA/qsubzzWUeEO7XUd/P/0yFm6wq?=
 =?us-ascii?Q?Cd5ODWpCsEJIAZrof5v/pbpGxvDQmHVMcCgJ8CSk59z650Xh3+9XR7GOI8g5?=
 =?us-ascii?Q?bvQLCSShdO+5GYgU7NXTxxbxkP2LHdApH3sjCanuEYf2/DgMUdpZb/EEL8nl?=
 =?us-ascii?Q?eb6eEsIDwjtaFxCT0nYiD5oc4tQof+cGq78/FKm10Zjyuc46KixVQM99UFeX?=
 =?us-ascii?Q?MVsC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 04:19:05.0100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 1346ad7c-8455-43d6-a2a2-08d89bf990c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5dd0QV6Z4fRBYPPLhYcEqWiaIzwpU4CGSavytNknrGrkHHTugy4NJ1m+XIo5qdL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used for determining 2ND_USB20PORT support from firmware_capability.

Change-Id: I3ff37f0a0dab311566bdd0aba189f2b7fa89ec2c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index c38635992101..3cb8d4c5c1a3 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -499,6 +499,7 @@ enum atombios_firmware_capability
 	ATOM_FIRMWARE_CAP_HWEMU_UMC_CFG = 0x00000100,
 	ATOM_FIRMWARE_CAP_SRAM_ECC      = 0x00000200,
 	ATOM_FIRMWARE_CAP_ENABLE_2STAGE_BIST_TRAINING  = 0x00000400,
+	ATOM_FIRMWARE_CAP_ENABLE_2ND_USB20PORT = 0x0008000,
 };
 
 enum atom_cooling_solution_id{
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
