Return-Path: <SRS0=P3OX=CR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C475C43461
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 15:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22DA248D3
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 15:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ry7K0S19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22DA248D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D8C6E851;
	Tue,  8 Sep 2020 15:52:46 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700085.outbound.protection.outlook.com [40.107.70.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6A86E851
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2020 15:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEx82p+hdLTGpridYWEzgZSPREamKdflIKZv7TAwiXzpf9EGtkJswkCD6lKi1eC+r2Zdu4kMMqQksLa+sfe1T/794B+9JTj1Vpvqy0YwKPIDdi6G4BP4VBHL4wTpowb4qGKkxWqIsqydPLvT05ZtkjWk7shGQAB51IV2iZ9HmAnySmCZ9IivJ2VpFWnB8vOJpqbjODg+tgNPiMFzbFAyXiu2CiDYCVVAs2OIzO9C3Umguu1zG9whLRB0lOvGh+pz53FhZqIDhYXM14yTOLt7Q0jPSCl+X9AZJ3JdqhlK7KUNB8UtwBKG3LVsy2Cm4XL5FsPJTItJmjlvR67zs0h4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVZsHjflovIXu74B5rhVnSL+M+jonE/iH6ndi4MJwJg=;
 b=OcGRfKHXgLBvoqRXYMKJuXg6eISDqhi1pIP02EJ62wmjnYQm2no4xAma41x0dYu40h6016aXSCS3SodwtrfCia/UdM0tSR8oksOHkkXbgVvRCujIndu48C1ZeDTtKZjTYNbkun32kbTTq6+Ik5ijh0QB+kavAkiPyR6bgmS2+SZAZARxpm12CTZ8wVag25boS4ZV3DFMCV96l1I370TmiFP/DLBrJrNo3sQDdpxac1+dVh/lUkd/j9o4WXJa31NN+mvThTKOKd+BeTlxHGEZVkxO89drHhHCfUuKtMZnaDGrrTsYB/ej+qMa64KXKvqHx4IEAobzBSgmhswrc6aMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVZsHjflovIXu74B5rhVnSL+M+jonE/iH6ndi4MJwJg=;
 b=ry7K0S19CWd3VvNakAS9KqsLDWjVxveAJYA79aCCw3BlBOlNWHj3e2smkV4anszdfHZomaOmZuIexSigocJ7zrl060xEuXiIMk0qvfnFXWlGkI6yiQnnK7YY+E3xYzAL92B/0YgjrxO7KUkCfsWHdtXX1+Frp2yJh6zpDBxtSEI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3911.namprd12.prod.outlook.com (2603:10b6:610:2f::12)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 15:52:44 +0000
Received: from CH2PR12MB3911.namprd12.prod.outlook.com
 ([fe80::a063:d3e8:e727:1226]) by CH2PR12MB3911.namprd12.prod.outlook.com
 ([fe80::a063:d3e8:e727:1226%2]) with mapi id 15.20.3370.016; Tue, 8 Sep 2020
 15:52:43 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: fix a typo
Date: Tue,  8 Sep 2020 17:57:02 +0200
Message-Id: <20200908155702.17314-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: BN8PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:408:d4::11) To CH2PR12MB3911.namprd12.prod.outlook.com
 (2603:10b6:610:2f::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN8PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:d4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Tue, 8 Sep 2020 15:52:42 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a39b3ea-cd53-46c1-d9f1-08d8540f3916
X-MS-TrafficTypeDiagnostic: CH2PR12MB4037:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB403713EF8E2438370A0A0DF68B290@CH2PR12MB4037.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWxxbtCh/lK8hg/IRZITsRRt1vFOQWINZ01HfmdomerPeG4AuvIaj2Bh4XgTiQpc8kltKPPyL+L12xp7XsTsfhhAa47mjfn5OYVxFqHJ5DrvuDjFHBdaO+p0sJG402mwk2ebYXVh5T3EBKCDVyDaw4VxYsNuuO5EKxr/5XHkkafP8SoONzBBa/hjcICbVxhtfU1AhSSv42gEn4jpcIFf9VihwoV6/XY/zpjZE8kaK4tJsHws6/ithuFGVwTZ9SNGQTlgfn/Xtpdc4fdkEUUucYE7ELjsbIg8xwfPckKDmEYJUq/ceH9wRYfjoVeud82YBcHvBG+qb+gpXTqHSXh7tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3911.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(6666004)(956004)(1076003)(2616005)(52116002)(83380400001)(478600001)(4744005)(86362001)(44832011)(5660300002)(26005)(2906002)(7696005)(6916009)(186003)(16526019)(8676002)(6486002)(8936002)(66556008)(66476007)(316002)(36756003)(4326008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SZN3pOvZ9eAcxE3oq65oDRthYgNmqek8AwqRKmYaNtciovkgsJ23RvEyLV476EXA0o9+6+zYwS48rMWbENp2LZUQQIxGkGUDjRudXVOjsWVgTIedjmFqYHspQ9e86AChKMGAMvCsESVMXiLJ2vnR809YIwSPKC+jTpNs2kxyi9RUnwcIm/PEu91vAt4a9y/j2+Xr8KRb+TlhhKd4MVgDHpjnbE6x3DxGJXi5I2bwxT5stypnTup0NOY8BA3a6il9R9mbD1GecZbw1K6/P9OfJimYHG9HZ1J6AkcW1I8m2YBiNkrOlBklASwk+uwC+Ex3J3lVKgOZnlstid7944i2tCXDCazGzoXZq2Dnj4GsmJ9GRIc2lvS98hpoWnbz8PLpldJ39MXF7m5b/nPohW0w5a2M7NmBmbZP9HSrzj3n2pyCdvaq/gs2gh1xqyK4ol2GevFNx805r5RS5O/68Lo2FbE2AoUDG+/gzmrhVxh3/OAkGMV0NNdabmOBQVWUX3o1o+1I/A2kWk2K0oC52rXoBk4J7/81CDDn0f4UgIWzh1MkMGNek/4H5pD8js7J30SWLTmLVxO3itOzGxu+8x+csWC35h/IAkQUEmbT8DHPbTXv2ujlAwg/CGRo88Nc8wXf/GfHBw+a4XpZgP6KDCmYAg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a39b3ea-cd53-46c1-d9f1-08d8540f3916
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3911.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 15:52:43.6953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fW4T7C/ndcVz9YK4T8k0gtGjNptamXze2uzuKTUmXECxMFguuMwi352mJmvFl2xGU2Prpgp0PzLfwUiNeJTqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 9a0154630e958a2f (drm/amdgpu: Bring back support for non-upstream FreeSync)

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b826f2d6efe1..d3dadf10b13d 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1096,7 +1096,7 @@ struct drm_amdgpu_info_vce_clock_table {
 
 struct drm_amdgpu_freesync {
 	__u32 op;			/* AMDGPU_FREESYNC_FULLSCREEN_ENTER or */
-				        /* AMDGPU_FREESYNC_FULLSCREEN_ENTER */
+					/* AMDGPU_FREESYNC_FULLSCREEN_EXIT */
 	__u32 spare[7];
 };
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
