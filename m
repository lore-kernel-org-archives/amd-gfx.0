Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190C5C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 07:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37462082F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 07:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bx5YOHZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37462082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE056E08A;
	Fri, 14 Feb 2020 07:02:45 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700089.outbound.protection.outlook.com [40.107.70.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 452876E08A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 07:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjczx1hlHQHEjyKzAIDFMfyVxYPxnEdOo/P5pKbboqmUMhSgRlzWFjWPr14U00jvS1do4Cgdz1A0tjxKspua0RSZPUCuI/f2tvrNeYkwKeOsG/hBNx0oGzf/qKx7zTJZA+F4FMfogtKbs1wLxzd/A9M5HIHkcfOYK5HViU0C/JfzRAPm3ZpBRLV4A5voHHgU5LH6WTXh9cPj3/JPWgKrgO2by9LvtL50Cp1eTb2vdpUk3NddKeUmtvlr8Pm95E14hx+dMQNH+RbEpBFyqgw2ym2L2Vnv7toGZEEGdtX0ZjyohAqKity/EX6UUCvp5wnHHdZge6Mr/meiamc7ebhqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0YcCcyZVzHtgnaZKm65ChNEyYVqOozdWhIZrF4f9w8=;
 b=S7vFpJAthJqTVb9rfmmAGXt87H8sY9SDdB+cUI74y779o99pVYuPgVdosrkMBIf/Ehu3Er2szDJRRDOzoHq11ZbEYnLXXOMtwkYUxdqcfBe9djB/g67hv8r2WUY/OrOAJM5jjpLMo6rZcl4VfCYyfuP0Qh0BNo4kb3eYH4Jf/dFKC+DxUCF4+Zdddr+0oGbsMo+xh3P4cwmWBO9jUJXZzyBydFh/L68CQhO16iv4Ntzob190JMzo3Np/t1Jo1HxTnly42jeZN5G3wm9UmXrIfKpLHVgUvCsWqgqLP4SrlIbxKOL3WJfHBuUK6VPewQE4syRRRjYApVnbHOoHeQo4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0YcCcyZVzHtgnaZKm65ChNEyYVqOozdWhIZrF4f9w8=;
 b=bx5YOHZNOmShLJ62G2ThIJytcbGA+gD2HEWwPEo01gCJTSSVodPUVWIjjfkvh2lDV99yZ3g1S0S1BQ/K/dkyY1guTWUkEX6Tzxa6AZiTE/g/vt1Xv92vQt0RN3EllLeXQWAKiFusaVJQq9nhQelKrSkMiQT3xcgfDEQyZUPZm6k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3615.namprd12.prod.outlook.com (20.178.242.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 07:02:42 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::fc81:31af:b81a:1cc7]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::fc81:31af:b81a:1cc7%6]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 07:02:42 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: Ray.Huang@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add is_raven_kicker judgement for raven1
Date: Fri, 14 Feb 2020 15:02:22 +0800
Message-Id: <20200214070222.31089-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR04CA0057.apcprd04.prod.outlook.com
 (2603:1096:202:14::25) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
Received: from jenkins-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR04CA0057.apcprd04.prod.outlook.com (2603:1096:202:14::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Fri, 14 Feb 2020 07:02:41 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a539eaa-a36e-43fc-47ad-08d7b11be2d4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3615:|MN2PR12MB3615:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36158DD2EC82B02296919B01FD150@MN2PR12MB3615.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(8936002)(66946007)(26005)(66476007)(956004)(36756003)(6666004)(66556008)(7696005)(52116002)(86362001)(2616005)(2906002)(16526019)(186003)(316002)(8676002)(478600001)(6486002)(4326008)(81156014)(5660300002)(81166006)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3615;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQ8aDj9ucACBt4rtuXnUmrudoodiNKAnWNXOXYL49bHX3PRolpzP1nm7Vj4g64a6iLeGoNXbyCVLQ0AMFiL67MPd1uS7PFxAUFBHri+q3osE4VnMn+qIGiXFOodFdG0v/nfSGxl2nUImX7u5iwxcgEFcKxySCs7B2m6I17j2fSH8k6VP6WtGfF07HKi3EMeMESo0oI7cTrl/t7qLujjjpQk8BzVjP21b8SXsyjpyjJ6bCHbmL7SU89oyW/Ghxh4acyRaSJ8hV+pdReVzvfaOW2k52Aq/h5tGuacv5GdgcHMpBqMaET/qhtrKtyp4ByG+FHesKevhy8pTMEM+AOUwFDnfHh7lUrkk0PHhOZgUVlfBdWIi8IzKhuUO1xDNweGKmllXHo7fdPOIzqSWcJhMsSBXktxFSERQ1EHK46xp/+rnKbeCnUUEXqW6E7beil8G
X-MS-Exchange-AntiSpam-MessageData: pegg3F+gb4IZpjn0rL3nW9qHgA4yLw5JQQtYP2lXt/ygdg0Sivyi3hK8H/AOMSn2mqgAl40NIz7ZpJhGJyXhzED3x+Pz69k0KvXAq2crX11tNvhdVkuiv/+LoAVLCu7X9pQspPggaQCOPm40FkTMDw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a539eaa-a36e-43fc-47ad-08d7b11be2d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 07:02:42.6409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKnQWe2f6tXWuTyabHT9PGXnxkUJiTIlL0BR1HQx4RtWtIFjp/FUv5BG4AyGkV/89VyqDnu3h7cBs3ZX5kG6Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

The rlc version of raven_kicer_rlc is different from the legacy rlc
version of raven_rlc. So it needs to add a judgement function for
raven_kicer_rlc and avoid disable GFXOFF when loading raven_kicer_rlc.

Change-Id: I00d726cc39eae4ea788c1d5faeb8ce75ec0b884d
Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4d8b58e9d0ae..9b7ff783e9a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1193,6 +1193,14 @@ static bool gfx_v9_0_should_disable_gfxoff(struct pci_dev *pdev)
 	return false;
 }
 
+static bool is_raven_kicker(struct amdgpu_device *adev)
+{
+	if (adev->pm.fw_version >= 0x41e2b)
+		return true;
+	else
+		return false;
+}
+
 static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 {
 	if (gfx_v9_0_should_disable_gfxoff(adev->pdev))
@@ -1205,9 +1213,8 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 		break;
 	case CHIP_RAVEN:
 		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8) &&
-		    ((adev->gfx.rlc_fw_version != 106 &&
+		    ((!is_raven_kicker(adev) &&
 		      adev->gfx.rlc_fw_version < 531) ||
-		     (adev->gfx.rlc_fw_version == 53815) ||
 		     (adev->gfx.rlc_feature_version < 1) ||
 		     !adev->gfx.rlc.is_rlc_v2_1))
 			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
