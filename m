Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D90C433E9
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E5B2368A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E5B2368A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF22A6E7F5;
	Fri,  8 Jan 2021 08:55:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FB66E7F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 08:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvhUyorR7E+cgg1cTz6n+8UJipSdNoZ80+VCG0U0R0xcvq5mgQ+p6WQVxIulOay9QWMHLvRzfPDZrfHGj89xErgFddWcIfSkE52xUZF7bD4KwsyxbXs5jruhocC2LkoiUznH2jQfjvYnsJeAJfcuurf9/81ctKS8HLjXlfUICincQsfo5oqDJE4dm+89mPw1ypozoKq6rVW3MvxW3z1LmkvLUYZeIAjlVyl5EfmBd93Mj4ZrD9mDSxnDq2wh7lsZYorI18GNkclBcFFStqP65D3QPv/5Td5zk2EUWo08ebA+ZmFZhTdA7SwSKEIIJNHXUbQqqosaOhEa9exw0yYyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gKOkESsaWay6HG3E3brPJlrrS3Jqu1OgqK2FlsEll8=;
 b=iIL5qz5p+eohlhz8F+C61LB74viLtmCdoWvkoUYo2kVBFCg1qfVwuCsM9eSLnhshpJwkVkGi89D2Cj1pUO0Z5cRGgR7TrxtnqGFdctCKy/iKvnLSsT4GRi/Ah/dM19kCivHmF/9mtqeYpiq4YqzImLuCOGGHhdUKkBkt+tRVAlj/t9Zur7T3T4uSmAaoWhmJQGSTty9yUBXtTZ62pLgxoxbuxp2Gojz2WfMBWDyOXaabnZFSsJFdFD8t1FekYGtVt1ululAjBI3UscYsv5iJnrQgHqxt9dfJdlUToTZpmTqizbpevG9hYwe9MRtE0qqXYg6gQ9W5030tmjkcjr/AXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gKOkESsaWay6HG3E3brPJlrrS3Jqu1OgqK2FlsEll8=;
 b=atHnc3m1WiNUoycuVjYe0TT+X7hQT9tFdg3HU8HHALFV+bFDSi5nLMoyKOeqk599rskge6fajhAN+x4NZUpF/VThdl1nIzsIGDTMHb+v46SoRC9rsI9L5GSS+vMr0UQgGx/pinhSJOKzsKjRRxf65fDBvED4PIn5yp479pBLx9s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2458.namprd12.prod.outlook.com (2603:10b6:907:8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 08:55:38 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 08:55:38 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amd/pm: initial feature_enabled/feature_support
 bitmap for vangogh
Date: Fri,  8 Jan 2021 16:55:04 +0800
Message-Id: <20210108085507.1164588-5-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108085507.1164588-1-ray.huang@amd.com>
References: <20210108085507.1164588-1-ray.huang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 08:55:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01aacb22-672d-4ef6-3f5f-08d8b3b32b81
X-MS-TrafficTypeDiagnostic: MW2PR12MB2458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2458C4B6B6C19B0EA3FC22A1ECAE0@MW2PR12MB2458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:193;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCuoddeInzQ2GQyIO0rf6Td8qX11jxab6TeGD6sEcPJNnS1KZOsEgWDk9vlenNvSKbqw5RXa1xSwdyTmIX7SbD2kYkIh+QroeTktv2D+SBuPG5OPzHHh2YBV2l0e4A/ldFBAe8Qu6Fu1/1UKdDP43G8HK/fWMDknHV/PCJJoOHE1np6kLNgPdDlJza1rDlZEaMgAgXgaWNOnn9qRJev0PHFIeDay/mmt8JSfl60DvhMr8FGS1pMxPCuuhwE+smm0YFeJYirZyqaISGRpWzSoOg+ApGqw9Lg5ewoMzSsoE4VWOlrJ0az/LnTATDtUq2665OMyh8vSwpIw8tY6WR1Pgx+0bTz5t67koLA2VCc8/ZLhTLatcfwd5efn5U00LtL2ST1uzY8D38sCJukJRX9SB9b/cB1JVujfvLGODSe6jmmVwhCg0hHwN4T52ffUH4do
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(2616005)(956004)(83380400001)(36756003)(26005)(1076003)(7696005)(86362001)(4326008)(66946007)(6916009)(186003)(2906002)(8676002)(8936002)(52116002)(6666004)(6486002)(478600001)(316002)(66476007)(54906003)(66556008)(5660300002)(16526019)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c58W/G4XcAOsfcQ1ZBKoOFzmcjqgHreFq/YbOh0S8EzNMQXWd4bbmKF7jF6+?=
 =?us-ascii?Q?y7DeATih6Cs9ZrkvLLTzbVr5m1xZx9nL4txfPSBBLrib2198JUwBMdl0w/un?=
 =?us-ascii?Q?emHJdo1f+7W6DhAmG/MGBtkrwzZFnvvPoapdmKdBgAa2RH9BTQoCJWUzG0Ww?=
 =?us-ascii?Q?sQmX/Qyc/enOTS0HhkHO8eAW/8fMAnweW1zRKkUDyvonlrBANZ2CdT8ATxr3?=
 =?us-ascii?Q?icxe6LX5IbemMGY3OVWqL3tBlvpqzok4KFeBQbYc57+3zKimceDNB/EXEr5b?=
 =?us-ascii?Q?Rij2IL3c9PxIDII8hqEuoEZNN70tMh1uh69wUdc39GPdOC8c0VvEYUwvfIDR?=
 =?us-ascii?Q?mNIt0sqDQzDoVgeYjmY6h3jm6KDMJciqYN8h/oqlwwOUbEw2EEqB0MhLhhwY?=
 =?us-ascii?Q?Y+KMUeLMz9EZu0l1K0vt5e1jsOwhG+2n+/+8W8fD0M177tSso1ApBKeEZinU?=
 =?us-ascii?Q?5MmRamGbHzCWOggCgv/JUyvtDkaPlomSevIoFPGcTCcVSN5FuL7aI38TTz/z?=
 =?us-ascii?Q?iFqRR2U64KxH1yXqf6PPMJoarr2oyzOccpt8UuLXMtX+3gkIfaSHwAGbTyAN?=
 =?us-ascii?Q?8ViInya2+lCHqtReAiKAxa02xeiZYshUv/rLmYFNnLYO1MigsUozevto6j2i?=
 =?us-ascii?Q?/Lal0nP651LWQYlmtZ2V+2W8ZesiOviy8+abesw5es6D+cGmX2TbQD53z2Xp?=
 =?us-ascii?Q?qDh8kV+44VViUVdVnzGMVV4eEzw1i9Ua1Ux88GqrQkHBgtgai84DiUObgIcJ?=
 =?us-ascii?Q?/8CADJisOhi5g5eoRZueQaBRscZTp5ftVS9FoRkogIIcWFPRZaEWgXG183wv?=
 =?us-ascii?Q?jcZvlwjscMT9o3CfKxW9iZUgznsyem5XFk338oLcwjQF5R79ecX1erfTZ+1i?=
 =?us-ascii?Q?ZbZ5ZnCCG6lO+9Ik5Iipk85MjF/a9YgcDJ85fHgU4o6TSp+AHlDd8YhvkRFs?=
 =?us-ascii?Q?o0n7LmpkT5KIntMdkdf8LS0xMBcwBra4Pi+y+wvuaG058/eYuiXW/JWF0Y8/?=
 =?us-ascii?Q?YD/O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 08:55:38.1783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 01aacb22-672d-4ef6-3f5f-08d8b3b32b81
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I97kb+kNkW6MQ4u2TNPS+/Ok2st6wU64yD1fIllkiDEVBMft7/b62+/XNwhO/uL3dwxASdHKDZ9XijKs6O6pDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2458
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VanGogh supports feature mask checking which exposed by smu firmware. It
has to initial at first, otherwise, all SMU_FEATURE_xxx masks are
invalid.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 26 ++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3687cd1dc24f..233c6e4ddd01 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1373,12 +1373,30 @@ static int vangogh_get_dpm_clock_table(struct smu_context *smu, struct dpm_clock
 static int vangogh_system_features_control(struct smu_context *smu, bool en)
 {
 	struct amdgpu_device *adev = smu->adev;
+	struct smu_feature *feature = &smu->smu_feature;
+	uint32_t feature_mask[2];
+	int ret = 0;
 
 	if (adev->pm.fw_version >= 0x43f1700)
-		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
-						en ? RLC_STATUS_NORMAL : RLC_STATUS_OFF, NULL);
-	else
-		return 0;
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
+						      en ? RLC_STATUS_NORMAL : RLC_STATUS_OFF, NULL);
+
+	bitmap_zero(feature->enabled, feature->feature_num);
+	bitmap_zero(feature->supported, feature->feature_num);
+
+	if (!en)
+		return ret;
+
+	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+	if (ret)
+		return ret;
+
+	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
+		    feature->feature_num);
+	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
+		    feature->feature_num);
+
+	return 0;
 }
 
 static int vangogh_post_smu_init(struct smu_context *smu)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
