Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45FEC636C9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC60600EF
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC60600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD9D6E440;
	Tue, 20 Jul 2021 15:44:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 892E06E43F
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYjOHeI3pMI2qMKCepn0LqXtz1EYQ7kjMPBbaDZzMlIIc0ShYXidCXFWyO/8c8ZFAHNQ0+27ctmNItP6ZBdjEjgE+OFU7oyjYd6/fnKuBrR3WGVqWZOqCbMScqeHoGj0uQXQjiKP84WpMMkLVTZva+KdXO1iQiBo1ri9aHyq8inI2kLOsGFmAMrshkjo+6Zr5KcCfPcIwQBLws3qvktucy5DwfTZP1xl3zZsPP+HAUbPLMShAcF0sbYEYnOjWNxk6jB7Ovj3r5D6Ia5uxXgo9uEn1qyJm9YGDrBQNee5Zk7yJ2oUhVzs+0G28Yb2PyWX6KiFQucW552llxHjt0jfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+joLGu0qtlxi6ZQkoHNGwWYMxo09d5tjM9xx5gewqdw=;
 b=StNzjkQmLWKyTLbO2tJEShK9bVnstR2nGWOVHJPcTFu/GLobe+To5/Aky4Xq+CiWcfcwnAVHtGwyZQRUthrVCO3UjyfRyLfA0FXL7zEoZgkmSPlZqOir1AfWoaLbXDDpeRg87RoJ/nU/bzP13tFMQ9vAD76ejWxnbP3GBZMCS47oWwcYO/I7g2MsxrSKQU0vK6LQQEHhTNzMcyNX0qV3tsUnKvp/Zezo0L1ennD5+JUaCoonLAZ1Ty7AREy/CTTOZqG67SlQpiH1dwJ8FEewNOl9uRTnx6zfZjxEqftjjm96rmZ+a+RXq15Oiq7qRufCyORPx/qTlcoAKlCF/jbuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+joLGu0qtlxi6ZQkoHNGwWYMxo09d5tjM9xx5gewqdw=;
 b=o9mrNB5klvwngR3AM/i8RAQsxy+frRILvgwSPM5MpyTwfTa/kMnsxYKwlR99U5V+vJiG9ok81MYS1sWoETXywrfslIEt5lxF0Ec4TZjygZ2xulWKYsLNAk/TJck9KCK1achEkeP7Uum2rUyHAI1/wS/9qi96AQ2OlxMbR9l5MVE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:23 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:23 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/29] drm/amdgpu: use direct loading by default for
 cyan_skillfish2
Date: Tue, 20 Jul 2021 11:43:41 -0400
Message-Id: <20210720154349.1599827-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93ca80d2-526c-413b-faa3-08d94b953ef6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5288BB7AFBB502D3381EA443F7E29@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAN3witEz7Os0MEvmiPRFbfpq1/acq3AWHNMtRE1/RYa5+y+iY4RzkiqA/8Zv2MkrzY8tQF7zqeQXFOVdqYOg1D1quq3z4T9Ag6Flt+T2VG+Q+VrNMWeJXBX3sUbbdWZIrKG8xnXvwyVJE+yi4VARI1a4HlSUS4MValmI7hD1G/97/wHzaN2npw0EzI0EXDok+ALBB4zpOXiD2M5TRXNPbJxP/RZbarP9HVMlymMjlqgqYxIwvXNpHGdL2y4Voecdrx9GuQ7Q3SI/9HwlUZUsZOrAWrKerZ7BLe4ZZsQA6a1XMmaTWBu2G1DvISmVPsRnPG/rAg0MGjUE+8ny5pUoUdGHv1LM5EnAcslGPGXthGwkOJNOScgsVRFR7rAbg+nfdQTpY1NQ451ipGXpTjfJluSW85fI00feEJcVRKndCr3cl3V1J6o8L4YYbHjhsCS5j9J0nmEMIiDTyuEM2s0a0owLvQAfRY3WkGAez6mFq/c196XV6P6/x935pdT/H80nLtBaXOP3qahO7KlzS96rBGbKX/8SQQNgBIb88hLA0oM6UpLHsnyMEe/qcJ0y6iOspcp2nTOPj6/PDWeU9Z+hGq1gj54CKNf1iP5obaDXQXdPJdKT50UDqW9ymne8ReXj/7RICn+DkDuBFdiY9IrWg8TKWGacEHx51kSOcZICnVjRDvrvq23Ns7idibYEKqtSh4z10M0zAfG9mpfjmSp3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(6666004)(66946007)(66476007)(54906003)(1076003)(86362001)(4744005)(2906002)(6486002)(38350700002)(38100700002)(8936002)(316002)(478600001)(36756003)(66556008)(6916009)(26005)(186003)(5660300002)(8676002)(4326008)(956004)(52116002)(7696005)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9/6X03np5mau3hTrPqpE1zA7yMCFX/K7bSPaleouWt/7FNe83wmUMHXNoNMv?=
 =?us-ascii?Q?UwT59RsHaWXcGq7rPy5yoGvGg4r3bm4qinHbyDys+QTQFQ8kMiwKFjadqLoA?=
 =?us-ascii?Q?kEr2gQdHC+Dhzbu38Nc5yYMCehHbY+3aAzwZe7WWf+gPm628kJdXWbKHcqN1?=
 =?us-ascii?Q?+6pwDYWOjr7VwvOnvDGud7uCueDu3LKba2J32QE+gMpZTHT3fmsKoYrrjX+Z?=
 =?us-ascii?Q?800OvhrZRoUAbWhEEOMZ86M/lP5AihUAST20nUE9Z0z0+mXXROYEChxS+j/M?=
 =?us-ascii?Q?orE++dSNzE6PB7uxKTaO2GYkahBLV26Ir6QNFMCI0OUZU9ob41KqJRJDlJi5?=
 =?us-ascii?Q?8FMEEsuNXY0XQV5njlwVew13J0VR8F3seumi4aMmo7xBDPcQh4AkDdLFwy4Y?=
 =?us-ascii?Q?V5xmPDWujPHDXPtxJIdHZHfe0AMslt3YL1qEKeGDNsrrUhoNfqrwA3tl/Fqh?=
 =?us-ascii?Q?R31Mfg1FL5/f5sg0xvYZbDLqnsoGeHBW21z/+BLwpc/iB3uBrabAq0yIm9OP?=
 =?us-ascii?Q?UERdjzOKL8uDcXbovpV0uxxBcsz9WUBP6De2NI3SiBbUpHbUta0uv+vPepIK?=
 =?us-ascii?Q?9EIvT5X55H3gIMoNOLM0wp/iyfn5C43W5A1IH68l00yXNqSmXRKcF0Jpm/cG?=
 =?us-ascii?Q?OFKXwE7FK8ZbaKXcRimoecUk0y/2GWyGatE6xgdpdHPtMtEZ3mUcBiX86O0/?=
 =?us-ascii?Q?S+Wf98SML7wIA2a3U0sNYm7IdmUdv4JdwcpINvjuFaMWiBMUjW8vlxwldB2J?=
 =?us-ascii?Q?U0UaRZ6vNkMYXVaaFhAKz/9eY1TPpb2JW+XZcp+t2dXz74jWCsYCTHatZOtQ?=
 =?us-ascii?Q?f+C9w5CM/kBESFplyP0K/RgGE4X9Ty0x3wmvzQMDUfCWN8MeAa488E1UkWIU?=
 =?us-ascii?Q?4n2WynsP1NLz9gbuYlOkKkW3HHH8sf28u8kpGopJISdpQX81ubap02F6Di1K?=
 =?us-ascii?Q?/iMVU55/EvbVaR7Rxf+J73tXMPCQRx/uKT2X3GtIhKPbhVYv4Jxd4YA0ltAf?=
 =?us-ascii?Q?hLupnaHHc76CDiiYNyvGZTYm/bDw+ZaLMrB5MSHBXLu+mC4Szk+NJEuPU8+n?=
 =?us-ascii?Q?zBic74dzJgrNDArUt6wWzSLWFzC35A91H7KKm4cR35kevqbStlk6IeILxHvp?=
 =?us-ascii?Q?6KdGydEONfjTWNA2oA+mRYQmdN/HEi2nbMq37tc4OvI+88+ycQktXz4IX+U3?=
 =?us-ascii?Q?ZLmnXeg2qZ6L/24bfkfS9hcXBDRe+K6a/5UIVRRw0vHTehdu9IH/5OLimwHL?=
 =?us-ascii?Q?hrYgNJVzctLuEjXYj8xJLEmft1iKvVmdkWlKIpmpW3hQBbNJpsouMNqeLx9G?=
 =?us-ascii?Q?hTBponQVty7lJtEarDt927DY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ca80d2-526c-413b-faa3-08d94b953ef6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:23.0260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RQzKUqJW/2MgQNZsllLsvHevWeBfrGz1U/qKbA8OHfGo07PD8kkh2vXJI5JUSj9MZxsEox7SkgWvzAAF/fefQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <lang.yu@amd.com>

Will switch to front door loading by default after this function is
stable.

v2: use APU flags (Alex)

Signed-off-by: Lang Yu <lang.yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index e683229b609b..445950d066e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -410,6 +410,9 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 		else
 			return AMDGPU_FW_LOAD_PSP;
 	case CHIP_CYAN_SKILLFISH:
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 &&
+		    load_type > 1)
+			return AMDGPU_FW_LOAD_PSP;
 		return AMDGPU_FW_LOAD_DIRECT;
 	default:
 		DRM_ERROR("Unknown firmware load type\n");
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
