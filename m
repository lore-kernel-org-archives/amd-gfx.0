Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339C0C433E6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA36764F4E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA36764F4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A54606EA51;
	Thu,  4 Mar 2021 17:41:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6031F6EA50
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 17:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRUUXx+SJXwts3FBvETVcGghkQpKi0YVKXHc3Ba/Zn2OSiQ/xiPkrG7EZPEBM91HJPQHPjXSAjqyWRWPm4ioG+dRZmLXSNGFS0d88zvabOzuOMyXWmTUUhGpqIv8wkDDg1RxQ/f9fqlwCbP7cBD21Tzo7aqaSMnSUxobtvH/e36WCMZHL8XM7VLyBEflWBCCZU20GD734I2GZXIvxNqmn0vMUqu5fCL5DmB9544rG6amDKqAS6l/q5JvaNhAAuOXhlycsAsH/4hVgfF3+rF0EcadkW9lTHIO6KQsBKTGXK/QTxnHDqC30Q9Yd+3NS0ycHq04vhRIIa40t4zEHiKc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfmIKWEnVsT1q0DTZUxn/JST0QmC8sWEILRmkhVxrro=;
 b=ofrJQHdZ+BNyPzFBVKHKk5sMHAcCmECFfgKP498d76wMZu39vXSQOYo4cQIqb9vIOr6emquDUx+X9vuYo1IeJxdM39hCg/0y9DZe/aK7vKlfQNCLOm8laYEa5xaPGsjxszi83oGzCCvR+8BipC/4028kf0i1G7c9tsU8SFU0/fCJeZgTZ2zXw2h/Fde0fOiKwq6nhXaPF5hBgr3YqZUoNgOk6L65xDtgTQorI36WQeNmLIRbWbmsfH50GeNqsX6eTI8EkcuuaPGsK/Naq/3zN8Lp2TfJ9MCo7kcVtr2zUKHQr8Ti79NIraGD5gSfD/Z+DZFVsN7EQggXp0pnTlc5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfmIKWEnVsT1q0DTZUxn/JST0QmC8sWEILRmkhVxrro=;
 b=ypy+Xh90vFqzqIgJXNU4p0/9LLBQYf1ptFQFMwTXO8mwmwyLGhrpMnCjkfLC6PF/k8L2SGO5UJMybRDR6nrqPwB1DC2axiy6RRX0TkHEcyc20I1b9N+haMkQSl0sOMnNHDKoFGESciAtk4/dPRGu6tX1ElF2EWh7RsNUKK/PcLk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MW2PR12MB2490.namprd12.prod.outlook.com (2603:10b6:907:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 17:41:22 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::e0fc:4c91:e080:7b]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::e0fc:4c91:e080:7b%3]) with mapi id 15.20.3890.030; Thu, 4 Mar 2021
 17:41:22 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, tiwai@suse.de, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, nicholas.kazlauskas@amd.com
Subject: [PATCH 1/4] drm/amdgpu/display: simplify backlight setting
Date: Thu,  4 Mar 2021 12:41:00 -0500
Message-Id: <20210304174103.202272-2-alexander.deucher@amd.com>
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
 Transport; Thu, 4 Mar 2021 17:41:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 85f192fb-fa27-4cdd-f23c-08d8df34b9d8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24901BC5B0790F33FDEA7DE2F7979@MW2PR12MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5yyFAjpziZXstr7uqFR3mGHVSYUr9yNcmhSUtxrSsq/QeFlfRgT3eBBgkT12Y7RK9YaqeY9g/zzCQ57hY2x4CqcX3l6p+FnjT7SXS6NekvBG95sw7fTKD6gXuiYF5ctfp+T9LCWSlJ9myvKL35M+RVOU4TSc5n1FvxZCAjF7IMpCMkwKu4CXtP3Nk7j8h69u0NWF7TTWUMqWUE+gXcmDXSe87vfnMqYhkTJjeXnjaUEBF0GIpuPk5+7yf3z0eCycLDt7h1nEhIe9DBaVxolB6oliwgyCr3HF0vNwCyrBfVicmy3bwMg0PXMGAOfRsFrFQEPm6W6JQDvKq1MscdSHF7yTkumDCjEwV/1sqprXYMnh1wFPs+8O6nmXNK4ihMZa5jbaEE7tUf8w2rP9K/f5aNeikOmY15ZJEko6lRk9R7WM7vqdalKVqRcfQppteXt2TrQr273ztaFn23rOfySsn14/D9Hl774i3XCIO9xYwtK06ZTG/jzavhfyWkxEovKA3jfMQFMJOaato2ZbRFR8OgcAqJe2W6Sdu0QgS27aZlFg/K9sIrgX9IWAPXH3iveXFS1V3KADFdTAXxx358vEjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(69590400012)(186003)(26005)(316002)(4326008)(5660300002)(1076003)(66476007)(66556008)(6636002)(66946007)(52116002)(6506007)(8676002)(8936002)(83380400001)(478600001)(16526019)(6666004)(2616005)(956004)(6486002)(36756003)(6512007)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wJW+hWSzTF1yIUwFGIA3Wgg8vcxWmhLnQb9tcyPfVHq0PTjDUMdAS7G2SutF?=
 =?us-ascii?Q?AlX+/u/xQRse/qPoyVq9uEMTKyLQO2/iN0p8Ez9BwYGnu2frnRJDgTkPHzVe?=
 =?us-ascii?Q?zepQrukmGM7a7DE/ms5sPycSO/RUgkA6BvAY0H9KSrjNSAjVOJxaps3y41SA?=
 =?us-ascii?Q?n5/Jh2nbSAPDI8/6cKxWanCUg/7QcBhESpYFsj77q4RXgShoYwgjlI+GteEt?=
 =?us-ascii?Q?2eKhg3TWVB+duOFMmhHAIc5bhml2hZd+s8DOGdLhpH2ejs6fYYc8edvFTpX5?=
 =?us-ascii?Q?mJmTaaFzdnO2+ITAkxSbH/RHG7uG/Q5xwJIB3quuAtODp1+IlRqWLOV/fF2E?=
 =?us-ascii?Q?G2vO7LQX9Hzit/vQFE/xvTJpL8xhc6G/t3sihSXr+5qDA42RjxdF1asycJwP?=
 =?us-ascii?Q?PNhfO2Go/eVanF9bE3/7qdO3Y76DtTqIokpiPqyP9onNn9ehlkiHulF1PNRm?=
 =?us-ascii?Q?PCBvbPb0rLRHCb1liexdUXu9FH1rhq/E/pEmVFBJMgB3aQA4KcmodlbNxanA?=
 =?us-ascii?Q?GApSIXSy+vvExc2BhiWp/nUOYZWroAteImJ3I6q72TOrB9jUoH10HT1/IQo4?=
 =?us-ascii?Q?3mGA1TPsLKPglSCN4MaHnInqfxOKcBlxUUU0Iyzw3rdoGCBH37ODXyET4GGL?=
 =?us-ascii?Q?Te0FUanRWQ6V+s8OZapXZE9zulUlUhOw4Y0DKDIn0JS7jKV7UA3CZyxgVHgN?=
 =?us-ascii?Q?VDwr6uPbB1bLdNUMFc3ve/Bn+kOLkHr8ioF6mmgeJ9ax5FArFDh3lEVk7y+O?=
 =?us-ascii?Q?e9ykQ4z5+n3LZNF6RENsvOSU106rvWDsmnd3gw1xgR155aBODC+wnHM+K7Tz?=
 =?us-ascii?Q?IVv4uCYZ1MliH6yuagwMXaiZJjYZcDlpaBCd5AFK8xoHo/Uz2/0tmPi83iUO?=
 =?us-ascii?Q?nr883PYCEl4DAQgSDCDZ1Z9hutq4XMI27qIs0hjjncRV1aGerzjZ/vDzrUkE?=
 =?us-ascii?Q?WQ6r9Y/kOJvsYEeyzqnCWC1vQLTKOucXAIaHY72fCR895KMIvtCtvTQsS02N?=
 =?us-ascii?Q?XqebjmoQX4m/eqVQ6AwunhL8zeJRR28Y1O1EMcvzX6MRmkYZzJgcTUUnPL4O?=
 =?us-ascii?Q?H1NMe66CZrDWo+QCrhtfm4sd5BLDpyfdES4a6dw8zrQdZ1hoJPBSF2FmAfPh?=
 =?us-ascii?Q?nhvvJPqLgUlKrF9BGJSYGY8FZMhBGSWN+oTYwGYhW/cnzrVqzLwYuBrVhBRx?=
 =?us-ascii?Q?P9/LAc7JoYgGV0pe/YZKiKW4W7PUQJ2tg8nyeCLWqVgmbuMOr4cuHnsZtPVC?=
 =?us-ascii?Q?+q/AuxbYLz0O3d1yRNiat6yaUdGujZi6CIEEL8clfDmLy9DSEDUWnNF49p6L?=
 =?us-ascii?Q?TcaJ5s0VpWiWVwKCbMHFB8oh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f192fb-fa27-4cdd-f23c-08d8df34b9d8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 17:41:22.5048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzDVdqX6rv5x1u5Cvvc2dZ7m3dwnQhzGgNOA40Bjd6sreTQEKevBx49mRCvm9uRPeb0jTEQD4fzlQ9p12mtOGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2490
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

Avoid the extra wrapper function.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++---------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 278a11bde30f..175a4cd8b982 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3200,19 +3200,6 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
 #endif
 }
 
-static int set_backlight_via_aux(struct dc_link *link, uint32_t brightness)
-{
-	bool rc;
-
-	if (!link)
-		return 1;
-
-	rc = dc_link_set_backlight_level_nits(link, true, brightness,
-					      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
-
-	return rc ? 0 : 1;
-}
-
 static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 				unsigned *min, unsigned *max)
 {
@@ -3275,9 +3262,10 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 	brightness = convert_brightness_from_user(&caps, bd->props.brightness);
 	// Change brightness based on AUX property
 	if (caps.aux_support)
-		return set_backlight_via_aux(link, brightness);
-
-	rc = dc_link_set_backlight_level(dm->backlight_link, brightness, 0);
+		rc = dc_link_set_backlight_level_nits(link, true, brightness,
+						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
+	else
+		rc = dc_link_set_backlight_level(dm->backlight_link, brightness, 0);
 
 	return rc ? 0 : 1;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
