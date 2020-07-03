Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D91C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A392207DA
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="epQzCinc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A392207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EF296E1A3;
	Fri,  3 Jul 2020 08:58:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD056E1A3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA3FPKhF1MPpforf24Rnx+9cPKQ5ZkuLIp2m6je/wJRb+iG2QFYdz8IcQVs9tXnjymIgjl3NtoE8xfHIP5tIChRiom0PVptJY1BTSbbbvNZTGF5Xugeq0sixjlL1zkbjyE2tsE5PGth2qXEjszKxLiuNJT4avCYXJO7GaBl6HxWYRpMlG86gNU6ylOTh+Ks82d86nV1uE4G0Rs31GYZfrMboReG0cVqG592Dm+kz3HZyoT9zsZxZwGEqOonANXVv5bqyUW8Ztk5t/niuD99BsFmbO8IgVXhVS26ZfiZ6qUSGxLRhfTSo/wR7/pNzc/RrrSJRGoc6f5Ms3FXU3dS9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SeofFhHfxliXk4LfVtbTK3GsqXG/CIcEo62QPnwAno=;
 b=hnqGMbZ/yxa8Vn6dq51Vf3H5HQuWcN497uVu5Vf5QqtlBqw+ZKDp7afGDhsr6kO/fQntEBdTTDlkXIJQMa7RyeZ/IFUGJmZRjCQQvR9/uSQzzFMD/KqAzGzTEJFvh/Mka19TiRQ+PDS0MHJ/dhvWQ+Au1HysfGHD/54ZQIiMbao+hY/j4QhW5MAyK+80pAN0sWXM1ZThowd4WswShpvUj9ASsPDqbSVmdLfztHH+DTqKH1jOpBY2GKEW3VQWJCEgYwE5938Ah/WmB9MVsqQ1dwfmErIm/MNp5xcx3TjbjkWcTZu1qsj60cRfCCrZR+aCebKKf0oLm4CrRJXkVXLTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SeofFhHfxliXk4LfVtbTK3GsqXG/CIcEo62QPnwAno=;
 b=epQzCinctQU3Vzbb1Zm2eLk2fxTE6Jy8255VEsh3PbfjPCcBtV35HU3sLiSlKsvZePwonVEFX5so3mjUk+EknDtYygkC1sQEncS69zmUMYFg5KbTJmxGuyruN71zLucng/M/wBATMFdaxW7E4KdmJUxeVhpAdd6AzeF+rYCk4uw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Fri, 3 Jul 2020 08:58:44 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:58:44 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amd/powerplay: correct Sienna Cichlid temperature
 limit settings
Date: Fri,  3 Jul 2020 16:58:14 +0800
Message-Id: <20200703085818.7800-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703085818.7800-1-evan.quan@amd.com>
References: <20200703085818.7800-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.1 via Frontend Transport; Fri, 3 Jul 2020 08:58:42 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3de598de-d077-4559-8c28-08d81f2f4a0b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB435394270F6DA1A8FB77E9F7E46A0@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwDZxwHSlCnGK7snSHRnzoAA10dkvfNvLSbY15arPpuXWkd3SNKDIOs9NS9XY3zaUy09vii7GN0eAUY8fId6g686xTtn8XcxErwExSvFgvsExVrxvyhoA64WegbX0RJiHcQwinR22Cn2brLRaE5qdaRt00FlqKLczYn/9xjH7uX2vQNBx9njz7mbD8Fn4jvSpe1/yYibVQuh+fKzWix8IEuMbmJR9S83ujrSB4kdjLyI4UJVEIsbnW3rASQY2jc06VOc0e717ej5LG8K2YU62qdUw4gXXLmwiqxkySsshzkmHXClBtr4Xsgk77ZNDWgINpEfxxv4cjiL4pElpQWzog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(956004)(478600001)(86362001)(4326008)(6486002)(8676002)(2906002)(8936002)(5660300002)(36756003)(83380400001)(6666004)(2616005)(6916009)(186003)(316002)(44832011)(66476007)(52116002)(1076003)(26005)(66946007)(66556008)(16526019)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vgL+Tk+DQ+QlYKs8vld8/8lndAKanZvC++YobPR+StMX7aSK7DTsWWc8KK3BWXanpZ8YjbLkFw2WXiDIpOJXZaOT6qfO9dP64SGyYNl8YzyxTQUItNxAmHpHo+8bUlGF9yO/SjU4GlM+LAWd+n8g3/mIr7NZyra1Lf51nfOQZDwVE80U549au+/rsT/Kv8Cx6qt/bTKqBXTBaNpNs5CFWaBxORrWYSJ5HBHWEmlhuonx49o+esE5qRQfkIl+4NtUx6lVMnInL/c/cyYbTJyp2BmscGM3IA+6EAP5REXdvJ9S5/5ujJhrt5we/arNJ4pQV+PvJsftbb4VRCyr2U2gXXXTMMRmINKg81DjneeRbBx8AL6nAvK2of9jo3fMN/9vdOLdvx6eBHIlvfhHNK77ZlUmjW/wXapYYv5wt4sOYy3rcbG8rpoWPk9GIP9Y7YPKw5J/jtfjYEG0b1v49Fkdx1TRfLtU+9/G5jnY9Rla7EX/imq8IscNsn7Hg6qZwec1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de598de-d077-4559-8c28-08d81f2f4a0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:58:44.1058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rGan4+fq3pNaWnEwqPvESFj2rrIClHpxB41usfcCf6+DPtZvhvNahiDR+tDons9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These are needed for temp1/2/3 related hwmon interfaces.

Change-Id: I76ec427aaae67a0dd257e2b1d7908990eb79a5b2
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/powerplay/sienna_cichlid_ppt.c  | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 46be02e4b93c..afa8e46cd2ab 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1644,13 +1644,22 @@ static int sienna_cichlid_get_uclk_dpm_states(struct smu_context *smu, uint32_t
 static int sienna_cichlid_get_thermal_temperature_range(struct smu_context *smu,
 						struct smu_temperature_range *range)
 {
-	struct smu_table_context *table_context = &smu->smu_table;
-	struct smu_11_0_7_powerplay_table *powerplay_table = table_context->power_play_table;
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
 
-	if (!range || !powerplay_table)
+	if (!range)
 		return -EINVAL;
 
-	range->max = powerplay_table->software_shutdown_temp *
+	range->max = pptable->TemperatureLimit[TEMP_EDGE] *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->edge_emergency_max = (pptable->TemperatureLimit[TEMP_EDGE] + CTF_OFFSET_EDGE) *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->hotspot_crit_max = pptable->TemperatureLimit[TEMP_HOTSPOT] *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->hotspot_emergency_max = (pptable->TemperatureLimit[TEMP_HOTSPOT] + CTF_OFFSET_HOTSPOT) *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->mem_crit_max = pptable->TemperatureLimit[TEMP_MEM] *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->mem_emergency_max = (pptable->TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
 	return 0;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
