Return-Path: <SRS0=WIfX=EV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F135C2D0E4
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Nov 2020 14:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E371422314
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Nov 2020 14:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OMVMfyWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E371422314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842FD6E9AB;
	Sun, 15 Nov 2020 14:45:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABCE96E9AB
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Nov 2020 14:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfZf5n/rSX+Ak1qcBTrzcM/eZFQgxfGMQGFBA0/QAkqH49AhEEQWGJQNCUoKV9+aeymHsPkBh504a1WoyTeVwF5q2zHLFKTgRO0orSyx+CNhBk9bOS8B7mDfoL7vrGFmGadcM/95aQnJg7bRrDEzQd9qvLPe95A7pqTGmdHtDuCjnHJXTDCq6xdocfAlSVqg7iBAMEoGC3/glBZtSkpydnXIaVOJnFzVhZ41Ok7b70T5CjH9o+2xSYl4UbtKuv2BlInl1UAHtyic393CTkpIHazTnt6fUn9D5P6Aq7KDWlp+7O8eDUZDmuaIHpLJFD3uAFf5RmaBv9jMp4oRRq2cgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K9AiGZ5fjoj91ZigNvR/mPQuvCgHjXFk8YBQ3/uySI=;
 b=h3sRsOTvGURNV0u87lTxQOG6N4p/vPGmc44biiNHsd0asRBe8AbbbA/gBGSb+MSqaHn2nel/Vf752rHwb+8JdT2cVXPWgiXBz5245lzp6s006lacvx254wBLJkZM+vTByaKplPDYNYPvUxrS+n9QgS3+TSa7FmUv7Y1nzPqaBqdFBB9mbcsFDML69O7zOunC4+uDayr1oouiEi4gL3xI/B/KH0uup46YwdxbaaVQSvoEyg2LCtvQK/7zQX/VHCigaT/rn5uAap2onXnit23TrEZ63S5Ov75e8HhAaIU+VlW64QySGgtH2MlakzM/QoToBnv+QWuKK6GYsSoJeuM41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K9AiGZ5fjoj91ZigNvR/mPQuvCgHjXFk8YBQ3/uySI=;
 b=OMVMfyWWOTIvH9XWiHH3Ys8Tmg1ZdgKFaJZ3JYn8bPNJB9+xGUkQ+EX8CfFUBeyGfAfu09cgEFGr+fSV/+fcPMFZTSy2R3z7jvG7k4Cb3jEEuUA/FtnR0nLFydRdTYSM79XkftA3d3fUHalLo5WAj6KkmaFfse3P+qigkdSAgUw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1383.namprd12.prod.outlook.com (2603:10b6:903:41::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Sun, 15 Nov
 2020 14:45:05 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::ecae:a003:1c8c:c99f]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::ecae:a003:1c8c:c99f%5]) with mapi id 15.20.3541.025; Sun, 15 Nov 2020
 14:45:05 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: enable the fine grain tuning function for
 vangogh
Date: Sun, 15 Nov 2020 22:44:35 +0800
Message-Id: <20201115144435.15993-2-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201115144435.15993-1-Xiaojian.Du@amd.com>
References: <20201115144435.15993-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR02CA0193.apcprd02.prod.outlook.com (2603:1096:201:21::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Sun, 15 Nov 2020 14:45:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5be062a-4361-44d8-2516-08d889750a25
X-MS-TrafficTypeDiagnostic: CY4PR12MB1383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1383201C32C6FCA8F593EBA2F1E40@CY4PR12MB1383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKorFcEkPxeIs2jteLZUpRYQevaxiRp9Hs8oeakst0NduwGUHQoARVi4VAOnWEVA33X13yOxD5GGseSCXR1GKE+RiZBPwAM/mIzyidn5iodQgKra9qv3PqPMHJ0PQRZRct+jLyXf7yfWtHX87J43RsNhJaUqov8slL4TMMc/k1gWy6mrBTrRJ2S7+jH0egdPp+VrEBbiCYXSc9QlqigggN6MMmAcw9Mq/A0wpUPBrJIuHC0+Kn0Fkuj5WUvGp04RuQdjOVfDsPS5lJ/axyr3Ihqj3O6EuVbxMKUFuPg8mAwy5geJfRCe/u1RBm/NpQiTvEP1g9M09eNzIC35HTNHwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(6916009)(6666004)(36756003)(66556008)(316002)(86362001)(66476007)(478600001)(66946007)(4326008)(6486002)(2616005)(1076003)(8936002)(8676002)(5660300002)(2906002)(4744005)(52116002)(7696005)(16526019)(26005)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GwzZENsQp3166IcOdGv8OKiIS9x2nzLDlPLmPbYHc3l1w3jwQGnOJn9qJc4EX2QhfnxOWTpCyrikL+bxNQpFp+dSvzZhJQM8UI5VZTi9DDCtMnabM14I7T7YO5NL50RFlS19L18NL1jIH+L6RuBBfinrn4shkHYX36z7Qyzlc5/ZmD0ZUXNh7B52n7akOAe7GiFQNTxlKDvUcpldnITlAOeog3MwbNm+hudidcQUVI0Mnb1nFNDi9P0jHXUgo8GsREgPj8jhWWmfCoS9V2A22lJ6SIojqmB2z8VsIB+VcaUMDMUd6+4CZdtQFyAQaXKi0yNrQYbLHKIKRg+w79uYIw65oYaFY0J9TKyWxk4uVN9v6jxYPnvakittrd32K968PGlScvzMXDOw+sAox1R3MYW2M01DnsT/leNJjRRlo3Zihhl6YikRAcGB4TXRYSQTFzJaS7TexgyAJxJopeBWaWXLDAl1BQ3ZbKBvRTT1BKoe1WnO23yTd3pLmifDcdZP/3S/ZsxBUQzris98Ys326fWvkoAMC1cPBHOyhTj6TtdwQ6hBk4TxFeA8MTWw2lDnNAPqlZ+L7T2osjVH+uzaGzfV+VBBtkpfx1iOgXy3MtqC0NCVc7MyBdRrgIQdNNTRgEQ+WSXd4NpG6xBMKVExsw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5be062a-4361-44d8-2516-08d889750a25
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2020 14:45:05.1488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioq2E1ZmupygH6VSa81Wan7dPLePmWhpf/TcEL3UfZX/aeOPHbLHAgRpOwyN7O9Kd4QI9jRGjIcDM/kiVRNSQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1383
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, kevin1.wang@amd.com, prike.liang@amd.com,
 xinmei.huang@amd.com, ray.huang@amd.com, changfeng.zhu@amd.com,
 Alexander.Deucher@amd.com, evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to enale the fine grain tuning function for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7b698c5ddad0..1904df5a3e20 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -405,6 +405,8 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		break;
 	case CHIP_VANGOGH:
 		vangogh_set_ppt_funcs(smu);
+		/* enable the OD by default to allow the fine grain tuning function */
+		smu->od_enabled = true;
 		break;
 	default:
 		return -EINVAL;
@@ -474,6 +476,8 @@ static int smu_late_init(void *handle)
 	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
+	smu_set_fine_grain_gfx_freq_parameters(smu);
+
 	if (adev->asic_type == CHIP_VANGOGH)
 		return 0;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
