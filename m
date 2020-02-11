Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA0FC352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106DB206D7
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y22o3b5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106DB206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5BBC6EA2E;
	Tue, 11 Feb 2020 11:23:05 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690056.outbound.protection.outlook.com [40.107.69.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D0B6EA2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 11:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUkc4L/zwo5+KH2mMJTQDWC8iVLD7f3TFT0loHZZh1/JD2ktgL0w4OT55pw8UHAqT6ysu+VuXEQeb2AlqicOzUg8sSvkkh2eGgTlbHaUYwWcrJCvtJPVSGqmFN0kgYigDRKdNe4BV5kcN45M6tgqPmrmkeEY0RBjWW/N6tf2emjcyoyprCCkB3xWEI5PkI1HApBViuyGYBZTR+fbF2gwfgm8oUuBIlze9U6OFT1axBTJJ/3NFlEfW+PvY4r6XpwsxObl0w6SdiCzJNekRv/vr+SrlsBmwgoMt+hA6QttMi8Ops5JhBkUf+EtKmvIlXUbFIUwS2/o9+T3tn/Ewe15og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xK+SxD6TVFJyRlQMZbGV5MXGs4z2unQWsq+gveO7h/w=;
 b=a81SHGU6dwA66lNdcAgSi/6Cwm4T068jqipHUmmYtX+YKlZsfpOhrhRO7Q+FogE8syqpl+ktJJiBKxkiZfXIRWzc6Jy4obohU2b8PBz/RB99+GHiEKMtd9hRaDJxhhP1tgScV8Yy9aebPwxVab+Vqx2FZcGM1+S/BWrfKiPxcdL83sP4FUZOB3mF0TM+7kwa3OOeHyhEYdVRqoYcAEhl4TkvUxDYAFI3N6fyQnKBHxQpvq4Njg3nWgUKOgNzSt2F/wvxRzYgw+rsc9kfFCePpGD/gUYiuS6HaAAaupRwP081EYSd8sG/gtURZ9HhLQRAsBaHbgxOVHoOBovUKKKoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xK+SxD6TVFJyRlQMZbGV5MXGs4z2unQWsq+gveO7h/w=;
 b=Y22o3b5Qj4N/z7XiEAYtnE23tlIGA8A8x1cB5HeMYEFG1PPlU62AfCfsjqFJb8LNsNT30cTyIhiENOrhJzhCR4KoqQryiunulER7pEr3aPxv1eG753uvaz7EIG3u63Dubr8CmV7YIZWo+NZJaLSOJs5M1N727YXY+Tio0Ee0OWA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4221.namprd12.prod.outlook.com (52.135.48.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 11:23:04 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 11:23:04 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH libdrm 2/4] amdgpu: use amdgpu_cs_submit_raw2 in
 amdgpu_cs_submit
Date: Tue, 11 Feb 2020 19:23:01 +0800
Message-Id: <1581420183-14223-3-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581420183-14223-1-git-send-email-ray.huang@amd.com>
References: <1581420183-14223-1-git-send-email-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:202:2::28) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR0401CA0018.apcprd04.prod.outlook.com (2603:1096:202:2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend
 Transport; Tue, 11 Feb 2020 11:23:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fd5ddeb-7f59-4ffd-5b5a-08d7aee4c297
X-MS-TrafficTypeDiagnostic: MN2PR12MB4221:|MN2PR12MB4221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42217AFB81A4ADC1DBB48449EC180@MN2PR12MB4221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(7696005)(52116002)(956004)(316002)(8676002)(5660300002)(4326008)(86362001)(2906002)(2616005)(54906003)(81156014)(478600001)(8936002)(6486002)(81166006)(66476007)(66556008)(6916009)(66946007)(36756003)(16526019)(186003)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4221;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZJW1g1ELZbznSxwbX8c69qZzs5sUwLGVjU079quPjoNCFrPcoDdyqUUZiMCrQt/Qn/S41ywLZLqHXFiT7T/yfLVtG6FrtDEV5i4O7qSxotsZS42Rf8SEv1P+mvi/z2x4yFGb2SFixA3i2ZPHKfKdcluxLYvf2unlSEPcs+UUujgqZtuJo0CKHBQ8c6Qy5jy+YmLR09gYlmjCd5eVV/93m2EU/SwFIu7c/iLv7SQEy6zrWXqKEI5MAJBn9tp5eDVVvdiGcurtLiPLBlJ5JmsMChJRBIPn1m2yrvtl9MloMw3wqb0DQCkB95qKWzUC4NPWhix6z016/XxaXdWUIw95JaMvFTVVPBAEZA2VKy0KC6TIfa8hTm7nEgKcX3rZzKxAm9mmi/7k4mBPv792fcALOvlw9xeikk9HEA6QMzmc7FJ6hBFqfs43KRI+gpqw0Uy
X-MS-Exchange-AntiSpam-MessageData: S/EiSOshsplz/XPFI8t4h8xu0kAd6gKpdXbQNzBKao7uIKvIfA4kqoARBAwU9c0T7+4Zxc3N+MFO/6O7AGx1/laF5yW7WNaHE/H6aIWO+wiU+cMjDsn/dsxBIVCXQDenVOfPebLD6w3NrJ3snkoSDg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd5ddeb-7f59-4ffd-5b5a-08d7aee4c297
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 11:23:04.0018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYCoqsQvw2wRc6wlxpwCcsGYgKJWlUOhV6ee5Rb3V/mGLjdRODKx7BNM6Is6siMzbEbsAtN1ULZZynoxCudlmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
 Huang Rui <ray.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So far, amdgpu_cs_submit_raw2 is mainly used for upper layer (Mesa), however,
amdgpu_cs_submit is used for current all unit tests. Our intention is that the
unit tests can actually verify the API which is really used.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 amdgpu/amdgpu_cs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
index aaa1f7b..864a76a 100644
--- a/amdgpu/amdgpu_cs.c
+++ b/amdgpu/amdgpu_cs.c
@@ -226,9 +226,11 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 	struct drm_amdgpu_cs_chunk_data *chunk_data;
 	struct drm_amdgpu_cs_chunk_dep *dependencies = NULL;
 	struct drm_amdgpu_cs_chunk_dep *sem_dependencies = NULL;
+	amdgpu_device_handle dev = context->dev;
 	struct list_head *sem_list;
 	amdgpu_semaphore_handle sem, tmp;
 	uint32_t i, size, sem_count = 0;
+	uint64_t seq_no;
 	bool user_fence;
 	int r = 0;
 
@@ -354,12 +356,12 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 		chunks[i].chunk_data = (uint64_t)(uintptr_t)sem_dependencies;
 	}
 
-	r = drmCommandWriteRead(context->dev->fd, DRM_AMDGPU_CS,
-				&cs, sizeof(cs));
+	r = amdgpu_cs_submit_raw2(dev, context, cs.in.bo_list_handle, cs.in.num_chunks,
+				  chunks, &seq_no);
 	if (r)
 		goto error_unlock;
 
-	ibs_request->seq_no = cs.out.handle;
+	ibs_request->seq_no = seq_no;
 	context->last_seq[ibs_request->ip_type][ibs_request->ip_instance][ibs_request->ring] = ibs_request->seq_no;
 error_unlock:
 	pthread_mutex_unlock(&context->sequence_mutex);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
