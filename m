Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D55C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 20:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0250F610E9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 20:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0250F610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E8B06E3CE;
	Mon, 17 May 2021 20:42:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA6F6E3CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 20:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acSos3hpJZspjsPfjtBKCuGaKRK4JWYtQ9DGMLMM7tKRDMYucs+0xFZB0Thgr3/JJJFsdppVXgThekPy8StelqqXd+v/Cx2FMqoZzqalqQxE3Zty33UJDEaVg7lpS3Ilcu2coFQw2y7VJeGLsz39PjemCqSmoYH6h+ggxRrO/Cyg+LO2PWkwrNG9n2GbNFwJt7i8IbmVELJOZ/26icHW6xPIc6at0uZiOBZHOzyCjsS7tlQJgHp7fSPuJZuxvtnvZvJXCe3RFQJPpY0DnfX/xiWKONe9LerkW2tyyNdK2rwf4RYZVvOE6LhCcDsXYGW9eiVCHolh/QJp9RGsPLZ+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC1bGpB31HQ/m/YDw8/NtXk3jYg59cw5ghU9JgWHSGM=;
 b=HDXqD0O9Vnt+Z6iAowIpjMhw35cgFjuo9z3/e3ona07FZcCDRWZoy76X/RABW9a/5imAGsarME/YvvfAGLGnhgycWw2o5WREaA5czywe/RbQkPTGeCqqvVP69wspFqX6Ect0qNn3CysRMUWe4HuwrWvSwgPsqXBcOPdumWUMivOaF37QqmgJ7HXr4a4yRmpk1Yk23PQIehX7aNaVnSvNhFKpSw71a3rlurRtzf59npdYP+wheojQy7XWmKxCQDLe4+T7StGmElvdwGWmgRz0rc9OLOTOdWTOOKvldax2FmJXTZIKAK5H16hyo7m3cKW3e+lD2KQ2TDxb6wKxJg6QVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC1bGpB31HQ/m/YDw8/NtXk3jYg59cw5ghU9JgWHSGM=;
 b=QS74lhf+xUgAM6CK1T3lnMc7VUk84L9xyunz1atQAdNcSvZ5xt1Hyxsi+v9obAwVciniGYwMGJYrBDk3gA8KoAhdfG1FNzk5AdYOpTUBgPmAylf9FN4RE1D0/ifJZLkrh0dYi6KhEY9soYLPqEb+/FVvGDr0TdSGqdPJjkRlUj0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 20:42:34 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 20:42:34 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add cancel_delayed_work_sync before power gate
Date: Mon, 17 May 2021 16:42:28 -0400
Message-Id: <1621284148-24512-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT2PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::20) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT2PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4087.54 via Frontend Transport; Mon, 17 May 2021 20:42:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a71ad7cc-c89d-427a-028d-08d919744c6c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33562AF412C0FD8C00EBADDBE42D9@DM6PR12MB3356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkCdp1slXpbZyWkXm75yIob6QSXHdz1xhtjC8gQHDDCMYpSxZc6Db6NT9S9XYXEISdJytq8LRL2vbZxe3jdIYrj4Jg9QEH0RF9fkyzuX6haKNQFlTvKVeEuVwgH9fQ4+hKkXHsFv6peFnD2gFbML5pGsW5LLsPP0iXBPcNDMAWURFzxmbCqdqa4N9uceDhhOze1rAMoH6y7yksDsiURVrjerZ2zHuHSz3Lz7Zgp4GWpUWTjH50lYKeBW3bVpppLlbKjq7eIhK1WZPK04JpziI8y+Exm6QMghLp3PTQTYdcHfAF1NKuzZOkirJWJCPgGmOhHN7t67jHUcUpnXSH4DBR7gTF4bll8TA4nDZ3ZjmAbOVx5aGAbKkGWwxBXZ5c9JRtG6FdNAtcjtN4eOLq4rv4VG+JPfT8DkoGmJT8oRm5aL6Og3YDGg3+6zFekDvTOUMiG5Ne7PLnt9CJDZNpaKhaBDFG9Q1DPNWOUxVlpTYp076rv35xZ8NCu7go+1gx81uUhluImHtCxqG5eDCeCxbQ9kiAXl3Stum4vk6tOS8T46lo9lLjdvSZ0zhuqc/7C4nVN21tFb+SIWZWpN8kkhnbArxvx5JEnSNkzJesbRLjaBa484nGWNTmlBIWCGuqJqC+3Nvi/OvJHTKxScRqhV1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(8676002)(186003)(4326008)(16526019)(86362001)(38100700002)(8936002)(2616005)(316002)(2906002)(6916009)(26005)(956004)(7696005)(6486002)(5660300002)(83380400001)(66476007)(66946007)(38350700002)(36756003)(478600001)(52116002)(66556008)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VyrLbVpiHZ1lkdEq00sJi/a3h9c4lNNalNxqHT2XnrOvaCo4nYZxNS/b3McF?=
 =?us-ascii?Q?76G+WwSvTaWI32TmtMWBk2A1wYQY7u7HtfmIjb8tIV7TOUPDcW4+HcDH6b7H?=
 =?us-ascii?Q?P5hmRPFgG6P7LWiZDuledQo1x1RRepCMz03iiY2fUiOy9+XahKUEQMk6PvZR?=
 =?us-ascii?Q?VbHz5m9l8oEb7FmrKz7Tbcv74bVYicxv6P54NAjhMlxPUV/PNzI2PpgVJNO0?=
 =?us-ascii?Q?q5z3WyCLWC6GHIsZ61RY5LKryN4hTKIPCQgyJYfN8S9JXEjg22Byq5yaSvZ8?=
 =?us-ascii?Q?1UGbPuumPRdPwJsEuGBDuhQ1jZdC4OC12s0wh83Rpl6HQVqTcnxfbHRzivzh?=
 =?us-ascii?Q?z8+9tSTtBDDXRYNhkKkKPdqkaFNEFfhhouiG2uhq2Z4tw1IRLkpQezEn9fZC?=
 =?us-ascii?Q?vwUYScjZaSfyshJdv1iNrDZbZOUgRvefcTXzZ1BS6vNHwEJE2PkkJqTXj+Mt?=
 =?us-ascii?Q?tY+IRdB5XddaiS2gMgN6y0pdkdi6zp0dBl69sM8KAPkPegxA8TeuGeYj8CVN?=
 =?us-ascii?Q?/nsxphF/GKqqkVFg6Xcy0SXLLQ7CpD+lupIW5zb5SSX2U6vYWZ23m++UApVe?=
 =?us-ascii?Q?qkVtZRsG5tkO2S3TxgYBeK0e1eSTDGNEGMwbiZsRlBGYyhat4GDjZ4Ybq7Lm?=
 =?us-ascii?Q?/raN+ih4kbDK9QtgGsAwLhYjg6z1DNPQ+0X0H4Js77+mbdlmkhv0kinUrIk/?=
 =?us-ascii?Q?FRo6Sk9Jnxu7jNK9i66J8H3OlM42QiBPig5oUvTDHOCKW0OoTFtTl7KmTDNW?=
 =?us-ascii?Q?3GVWzbYtpvmoHitiLt/UfFkcCAxFB1iKWLk90i7ZDzrOf0yo3OW8IC80ZAXI?=
 =?us-ascii?Q?PNPwVFnAKO0WPfNFIkwd7vpJw5HIuiiBQhSF4U7nuR1bfm06pJnObdxCbWl3?=
 =?us-ascii?Q?UrwFjrG9K83u1/5hGgj8lgQpJzd4gG3DyVlsApzsm6jGvObLZUFlZ3UUb63I?=
 =?us-ascii?Q?D6kaThceOdhaRU4nt/zpuH+hpToq25e+4+IS/bhTwuRlNMNKuqEIOhzzzS0d?=
 =?us-ascii?Q?ooZKUiCEfwhNh3rHrwcaRV5BWBe2P3ru+nt+leENTlKwXYqNoH4rCMBV/Q3V?=
 =?us-ascii?Q?Zob2doI10o+ZVLMgTI5AHu839PQZ/EsgvSoy//C7dptMPSObnX7F5QUqEdeC?=
 =?us-ascii?Q?/2q6vnT0bFDQOlx0fHPh7rzyZDaKuHHDpKcdiB5uLniE9RcD/Ot2Z6RLuFyb?=
 =?us-ascii?Q?YQt1W8pjnXiZLyAtlooVGVxIf0y6T8BXMGsTBRxOcHYjZdHwtAVM5FaXOfcJ?=
 =?us-ascii?Q?R+z6sqzhDU4OaLWfl8EE523kEFWmkGVXTQWTnPgN9auvYBhY+iQp0d31xnpt?=
 =?us-ascii?Q?8k9y1UhCLOM6PE6VekIJzDNX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71ad7cc-c89d-427a-028d-08d919744c6c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 20:42:34.0422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgkUABXXQuhA3n9/V5IDjpWOYlPXvl8JPoj6lu0Hcs7iyeZzkTvYLNQX7RV2YRgi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3356
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add cancel_delayed_work_sync before set power gating state
to avoid race condition issue when power gating.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 779e585..360dff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -388,6 +388,19 @@ static int vcn_v3_0_hw_fini(void *handle)
 			continue;
 
 		ring = &adev->vcn.inst[i].ring_dec;
+		ring->sched.ready = false;
+
+		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+			ring = &adev->vcn.inst[i].ring_enc[j];
+			ring->sched.ready = false;
+		}
+	}
+
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
@@ -396,12 +409,6 @@ static int vcn_v3_0_hw_fini(void *handle)
 				vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 			}
 		}
-		ring->sched.ready = false;
-
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			ring = &adev->vcn.inst[i].ring_enc[j];
-			ring->sched.ready = false;
-		}
 	}
 
 	return 0;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
