Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D171C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 15:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD38064F19
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 15:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD38064F19
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2651C6E202;
	Thu, 25 Feb 2021 15:45:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE2D6E202
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 15:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmMfWPBQg79ZULXGeL8RB/mHJxuFSF4ggsTSX3VDD7peirUPr3OScKtQvagD6pfgNvFmVWFiZU2LE0xz/EDZj12amA8K942xRnplavpDdWuOJp+WUP9/dTV5YbJun0s3pij00+0OMTGAYEzxdvB4xrggR+cPAiSZiD0echg5+BjnCvGXLM8Nt91BOfglOKgv8xKR8xZ77vDJiLAYft9U7cgXI8L2m1cv1FHvmkNmv1lWaUj/zc570YpRzAYOf0fCNitBx3ysqXQ0Cq/phgU8Scom5wv14Xa3kOhbuS2wwQx61YCQtHJ7h1zOagTZ9raHAjslu/KeIeMtVUinTsaEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o90UWh93SE2O7K7TOregRPoMmfSWfbHAocIdZ3ZUbEU=;
 b=W1qiYwVCwIdyYslUo3vtfGQYqRSdXbtL7vUhMU074WoxnLm+AvCHAHQW++O6YtZRGAr0yfsqT968w/+gQCRp4WP5+6qs49q5kUYQwI2IuA7L5SMldzFJO5QV1ixfqm3cv6iEoTrHo9WaO3BK/aQN/tQZoA8VNnQty3L3SaH5KvsG2SZUofr/+xvaxbd7gs9/rANQunDChnmuK0qJy1O3mDQvGrbnPz50+zysiUyNOHoA0Fa28Ezee3ybpzq55AQTqcM9wTsGucYxH0CWpBE8DkOCi6DXp3NMHsrbpE6JdLclrOU9hI7Oidf+62EBacZTm9Qp3PcOJpnfxoU9YuDung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o90UWh93SE2O7K7TOregRPoMmfSWfbHAocIdZ3ZUbEU=;
 b=tOBiQ1cUWAo7aoVix1dqH6kZowRVq8r0YDjah7IhQGasHvHXutg1lf0GZKfzDPmI5kAyubJ0tgqDkxVwqwAFTkuzkLpAZy0QS4BW4HmTqlUBJipsdoi1WTkFmZBwnWviXg97WDUdW79aCltwdenagqruxB99cOL2Hoiqe5wKrDE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB3128.namprd12.prod.outlook.com (2603:10b6:a03:dd::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 15:45:14 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::7c8b:b3e8:be0d:e84a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::7c8b:b3e8:be0d:e84a%7]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 15:45:14 +0000
From: Shirish S <shirish.s@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu/pm: read_sensor() report failure apporpriately
Date: Thu, 25 Feb 2021 21:14:54 +0530
Message-Id: <20210225154454.3644-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To BY5PR12MB4885.namprd12.prod.outlook.com
 (2603:10b6:a03:1de::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amd-WhiteHaven.amd.com (165.204.156.251) by
 MAXPR01CA0072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 15:45:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a721035-4db0-4c9e-dc17-08d8d9a45801
X-MS-TrafficTypeDiagnostic: BYAPR12MB3128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3128E4C5D0BFD8F7EA133119F29E9@BYAPR12MB3128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:178;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSxZc0pTzB/ZWD8rS7jDcWi0xSAoZE2nqaMKCmpe8TP1sEy0hP9X6tiGxQy0bs/OJvd7jd5u/5W12JphLqZx0iTLe2H3TcmhCK3aUAKtTyZKLMJ2f9M/QfNF76Jp0JyEYjLNKhrheRRzL5cV8kMJSj0pWsyaG8haLYeeRx0O75dbGsnNBHIcyT+aRmLQ8r1QDNK2irM3Nfgj7oASCHIfhsiQ/K3ub7g5Y1+eyrVVds4cjFe1vg+foyznymuP3bHCdCBN9ZnfVVBWv132QTB0RaMtSxK66kkjHglKynT81tQmqht+g7EhbfdHTscHe6xdHwJeI1H+bPPi167h7B10n4Bh5H8JZ8AY5p5YMvf9tpMx8Nxb4zLeB1V7EHBSU0U59nPcQAbqxF24PVoM+ouG1j9uWhWbwGJr3HLF/QPzYlSeYru2lmoBPHgZvOqqGkaz+SE9RByFGRsliwyG1onONNqaN9VzGaxZee2yP4v84ocnZpQCcDytzfW5zTopwPZsjEGb6mOIZPGz4jsi3aAdKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(956004)(2616005)(6666004)(1076003)(186003)(478600001)(26005)(16526019)(6486002)(5660300002)(8936002)(2906002)(66556008)(316002)(86362001)(66946007)(83380400001)(66476007)(36756003)(52116002)(8676002)(7696005)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?452UcY+OAALfb9p7j+747vOiIFcEEeIgQNdyWzgiphKgJ3LcT8c2x9s95J+a?=
 =?us-ascii?Q?yXHU76/WP2kWkwvmNvgVZATDbQ4my3hOFGECMIcw3BmESbzRf5qKlIEJpIZw?=
 =?us-ascii?Q?BmVsu03Ta6fGB8ZlNJ9ML8OSKXuzBG2UrlnlKFxs+QjU6Cid+wb2FpwMoJDj?=
 =?us-ascii?Q?2Gn+eQSFSUOxYdoNRPrKzIk7MZDx5tlP7D/0JRDRhfRKeICX0+PXQsftUYKm?=
 =?us-ascii?Q?2DP8kGFBgAKf58DetN9gLokQP55Ykh9Pm/xsGLeKr2cHmo+dEa4QzDnLlVBN?=
 =?us-ascii?Q?yvtjyVhOPikFSpBJxAcisOJfflp/Gi8kdr8t9h2G7vk+1LP1WpKuIfNJ4Se/?=
 =?us-ascii?Q?TNZJLTyJ+x2gRBv8bzLllfyAxrTFfaWC8poPZRmy99Ds05UNYQiP9v3K6AcA?=
 =?us-ascii?Q?lffci8Q3bdK6fEhMIhTH42SEXpPZC74oOvgNovM9vOf6p1J97pDrJYbqJeOf?=
 =?us-ascii?Q?UiWmhUlLpBu/+vSzD/cb+VvU4w7e+tWPKetO2lU5hptZGNwzTlgfWp1FVITD?=
 =?us-ascii?Q?nWQV/TdP4fnzWscZ/5ubcuyLrQ9rVtVE1SuF2KFaCxYXF9PtLw65kG8jAr5e?=
 =?us-ascii?Q?f4p09848PILhZyi0icBSVhV7S4Mq5vYS4qG/VIL2iesZC+Ocg+8OHBB3+KD2?=
 =?us-ascii?Q?6sG2OIDPttP39g1HQW9yshDJ0EhkXJveDmTrSvStMjpYxDQHRw/Rbi3Kfutt?=
 =?us-ascii?Q?JRfWP1IWpEmgYOEfs1z3og0DQ3qNcm4FXlO6Thf3B/oehi1iqhCQi0CNNUL1?=
 =?us-ascii?Q?ZUa3CYjBcvr/sJtEvF5d3EzAvtZUPQc85IKhescG/ELpiaWE+SHp1LlyjTqZ?=
 =?us-ascii?Q?n7GAxqhl0jZjr3gUr2aBEv8S/8s0+KrTfCsErxWg1M4cHx465kjVsfAwokME?=
 =?us-ascii?Q?6N6P8IaxbwXd++YpSmuFh012q2zd8ffi6Qoh6mq+FVj4aU6G/9wUuvDUsRsc?=
 =?us-ascii?Q?4JK/heAjnZONRfAPYnz8Gc4PhOoRapp5oIuEGXgaDPn5DxmV9v00IoBsFNji?=
 =?us-ascii?Q?1j3otf4HkD94SNiNXqxNIPGroX052Xi6clOHMlClgcgNe3KLdBeqaqYxpNmx?=
 =?us-ascii?Q?fKZ5EOuASqoISXkxazrL/gPyCb7Qpp3qty3ze1VZ7u2egBU0uJkIf5s31hnz?=
 =?us-ascii?Q?yEmxWhiDEjkGqfMzwq/pTRtO1ZGt4jaHn1RL+VfDm8LYzzdWmomiaycDRFFq?=
 =?us-ascii?Q?vgywAxHBkPeOjcYEWDxW5e22oM7DBr00DMyaAvp3W16YEQn0HUmMSbzSjyEM?=
 =?us-ascii?Q?yCwLcxPzQ5pMIZusQfeFrL0jaRXi0ZE2qlUK5TJUwLKLCglqNONoen0f/mXT?=
 =?us-ascii?Q?bucYENWYkF4Xy/Dn5+QHnpCD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a721035-4db0-4c9e-dc17-08d8d9a45801
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 15:45:14.9078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jULhs7ObvuLbvRVjn0K5WjvNv0TuKNaxCoSY/rPAoX1U3q/3T9uv5bvGLLyD0gECs3sVxqaRSGXMy10m9MLLAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3128
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
Cc: Shirish S <shirish.s@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

report -ENOTSUPP instead of -EINVAL, so that if userspace
fails to read sensor data can figure it out the failure correctly.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c             | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c             | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 2c90f715ee0a..c932b632ddd4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1285,7 +1285,7 @@ static int smu10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*size = 4;
 		break;
 	default:
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index c57dc9ae81f2..a58f92249c53 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3945,7 +3945,7 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*((uint32_t *)value) = (uint32_t)convert_to_vddc(val_vid);
 		return 0;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index ed9b89980184..2cef9c0c6d6f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1805,7 +1805,7 @@ static int smu8_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*((uint32_t *)value) = smu8_thermal_get_temperature(hwmgr);
 		return 0;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 29c99642d22d..5e875ad8d633 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3890,7 +3890,7 @@ static int vega10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 			*size = 8;
 		break;
 	default:
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index c0753029a8e2..a827f2bc7904 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -1429,7 +1429,7 @@ static int vega12_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 			*size = 8;
 		break;
 	default:
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 87811b005b85..e8eec2539c17 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -2240,7 +2240,7 @@ static int vega20_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 			*size = 8;
 		break;
 	default:
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
index 66daabebee35..bcae42cef374 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -3305,7 +3305,7 @@ static int kv_dpm_read_sensor(void *handle, int idx,
 		*size = 4;
 		return 0;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index 62291358fb1c..26a5321e621b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -8014,7 +8014,7 @@ static int si_dpm_read_sensor(void *handle, int idx,
 		*size = 4;
 		return 0;
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
