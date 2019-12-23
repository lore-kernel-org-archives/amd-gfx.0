Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A5C2D0D2
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 04:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212BD206CB
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 04:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2HFpZsxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212BD206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD796E152;
	Mon, 23 Dec 2019 04:58:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300DB6E152
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 04:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUv50y3i+f/rzgkTlHXd5nLtGR9qobJNotIJdwVY5ub9ye7j6z9kYF3kKRp/+l4CefkAs6mW5JSaLwLS/BqiLCzFhVRbtIlTwnq55//MvQKSnff98HnyJidvXOqemq7Xldut0BvGW/mmyif2IsgY59SXbVubfVjsP+0R9OAreN70C+jAOvOkWGrzmNsEKS1MRQhRqqMHRQzSHmB9I4KqYK900+c4movSC+QvTFevvl0Q9WCG+0XzK7XNuT4+aHFT8bAsGiGXPkT9HDiX16j6RjE9Nn8Oak/srWoYrWvMI0UrDsJDlbvmT/eE/OkVEoBwKKXYbdUYF3/Rz5/mpTneaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr6zogXP7v6cEbd+u4oNnba58/1puPBdKvMDPJ5stf8=;
 b=HOnK3yjf4PbzP2oc99aYSR34qhCsuOcN7R8ob95jK4xOFM5KTr3zyqw53nlWBFDQUGsAx/lq6QGLMg5nV04PplBPkZAoWtoOIbXu25AbV0bGoq0/sWrqGs9UI3l59BSS/Vl6yi0EGv6PEYJrAzDLvHKKGk0POUamny8UgUWJPvI5/BvZ+KqvsTfe7aBVLxVFo+OLWtjns+qaLPLTeFtzH/Ityi/w6c8ftS9bW7EX5Peezh1Ux70DO51yAvoRH0tEo+yqgim8/ywghqZKzzkmnbV9PJM9vrUS45Mros5CNU1x6np4WJui+Ajm/KnO1srO5CF0WcCQDYbbh+cWtIjwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr6zogXP7v6cEbd+u4oNnba58/1puPBdKvMDPJ5stf8=;
 b=2HFpZsxqehGxpBwSF3GpuR8v7XhgWZ5Lv1B+Mn2tXEv0laha114fdLS7zxbeRs/Zf1h+4k0l8sHBH47kRE8iUYkrhlcpB/j3fzEK4RUXAHqn1wDKjmArXQnS1BAzMPJAa7rlB8uFN4BMQUtPi0u6Lmw2l7lh6P4ZL/7NTPvnh9Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3336.namprd12.prod.outlook.com (20.178.53.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Mon, 23 Dec 2019 04:42:10 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 04:42:10 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: tao.zhou1@amd.com, Hawking.Zhang@amd.com, dennis.li@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add missed return value set for error case
Date: Mon, 23 Dec 2019 12:41:51 +0800
Message-Id: <20191223044151.14876-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK0PR03CA0119.apcprd03.prod.outlook.com (2603:1096:203:b0::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Mon, 23 Dec 2019 04:42:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81ad5707-abd1-4e31-8350-08d7876278bd
X-MS-TrafficTypeDiagnostic: BYAPR12MB3336:|BYAPR12MB3336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33360F15AE3CC55AE798F5ADF12E0@BYAPR12MB3336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0260457E99
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(86362001)(52116002)(316002)(26005)(36756003)(7696005)(5660300002)(6666004)(16526019)(8676002)(44832011)(2616005)(186003)(478600001)(2906002)(81156014)(66946007)(1076003)(81166006)(66476007)(4744005)(66556008)(956004)(6486002)(8936002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3336;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cp2IqviXRJxIWZJVjzsS2rzTuPdSOttK2WQB5ubcWmzC4wZpZ5olehrKoMX3m1J2d6NfUTxMgu3fpdYmlm/ycKjmiDK1GouSUoU6Hp+nJqJBv1XRm2GEpMXtWGE8Etn5k3mQz8DK3g2rZYmfBjMzWIrHs4eCJ8m1jPSqi3MeKS4LBUhOtg4rG65RokcN5rEQ3Hj+74YKFDhNhgcoYZrX5Z7rmkGNDQdGoEVxwDXB7IalewYByMeoYVs9K88Uskqu8g+EjDwhHh5dxmFj6lvDIEbMw9IiIYrPhjkquLGIkFN+GsvZ/NiB77HL4meGVZh2Mix2HuIEsAssL6ZuicYT137rMPgGltECAMeRmSCQ5tB257bquK2mxf7DeF48hk6h8/o6b7sM9wXq5/nbKohs0NGXUh9rIUQeRDQuqEDdwLRvxEz63G1I3jOx2UeykLX9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ad5707-abd1-4e31-8350-08d7876278bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 04:42:10.3482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITCTn467cgvQsXfqFuH1wL7RoBT1g5y5M4brV4jcg641vnUmfF1U9iID43RfKBBj05WJsE3as6ZTCvMUdtJbYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3336
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return value should be set when going to error handle tag
for error case, this can avoid potential invalid array
access by upper caller.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3f4ba408aee0..511b137d9d5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1313,6 +1313,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 	data = con->eh_data;
 	if (!data || data->count == 0) {
 		*bps = NULL;
+		ret = -EINVAL;
 		goto out;
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
