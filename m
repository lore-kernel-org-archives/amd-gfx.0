Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E39BC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 07:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E762920758
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 07:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MKofmtPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E762920758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EFDB89FD1;
	Mon, 17 Aug 2020 07:36:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CA289FBC
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 07:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgX0TddATj6tGrD90uJkpCO8VtBj2X19QMpvm0K0i0PZU571OWZ7UIAkf1aJCouVoDFl41z9JwBa6cn5kIjT439Rg9A67BWT1Uak+NHoKb3ezYAGXK7TmN9fRRVQ/uRAWqOpnkee+KwCrLODpKPDlzhWRMhKFjNN6xTL+Qd/udH/uY5prbfcKT78p8eiFHeXwdmZRXe9fJvXm5nyldtbLjpSjC/jU8HjkLdImXglgvLCNZr0kB542NjdmX98EcXk3EubCGFrZVNvMedT0NUxk6yJ6Rh0A+KuE86yRD7oL5bMYl5h/zqAK8h/PIxyNsZbsIbC3JabiZLiw9VZY3o9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzVKmk99qU053tuhi4TFM2Bf4JAS90LFd226xkFpFX8=;
 b=X+nIu5rWDlpA06dfeisH+kqDAeUupVwYR0vS6GCwTyVYPWUTyA1lj5F6ibbhA/yD481TJLE3NS7gRnVoWhJJlf5VLdzLRqm2c9BnE2GcuZl4Kdvnu4Bm0bDHOINfcfSyFq8F63w/YnqkB+EYUHYMAn4PkOpkdCnLB74285iRHzyZS+j78qlXoVTZ3vA1fdfofH5mKP1CoevELeB456XMZmBxQIuwuONkD4Dx25wr7b0AGsTIQEK2o1n5zsHVf/HBl5GlTTAub2c+HqA1Mq57+JOWqmtle+CcXbwaLxC+XmPR7XUT2bhs42Ns39sJ0C8sWXiGrSLPdjTWpuQQ7bcChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzVKmk99qU053tuhi4TFM2Bf4JAS90LFd226xkFpFX8=;
 b=MKofmtPBEPUs0L8fg3CBRrYWviaqku0PvB8eQY2X/U81JJTpAyAO3AOoro0a8FOTPYBQ9D79ZAL9NroSyrL0BFKpCrrf9pBXLp/in/9K9Oe0ebavSBtoqrRmL+vdmQeGMTs8ZklVKrX1elibnVXhCo31kD7JiGe9sXVII737Eco=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3646.namprd12.prod.outlook.com (2603:10b6:208:c5::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Mon, 17 Aug
 2020 07:35:57 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93%4]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 07:35:57 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix amdgpu_bo_release_notify() comment error
Date: Mon, 17 Aug 2020 15:35:35 +0800
Message-Id: <20200817073535.699-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0196.apcprd02.prod.outlook.com
 (2603:1096:201:21::32) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR02CA0196.apcprd02.prod.outlook.com (2603:1096:201:21::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 07:35:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 204f16f8-2ddb-46da-f533-08d842802dfa
X-MS-TrafficTypeDiagnostic: MN2PR12MB3646:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3646776BA5D6B8CC3B9AE835A25F0@MN2PR12MB3646.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8bOkbzejvVa319Ea1Ld43flYtjcHPmff3PhFQhwG+3YVac7HqqffQjltpFcg6lXnpkqrcd0GsA2WgURMl7aO1tyAtXAV1t687wupv2i1dJDZwcnfaUoVyJjZEJH0o6uGEi25FnJFYKl5JfCBZmsM8aNOIJG2gJKeilqMQ4Bz55AQaCc/57duwW4WsJsfKMR3DKfyARvn0jieRz34Y3COnL2z6EgYgXsTiJFpxTJ/zsVfwSq3rspvSUL3O+b/c620MxOQ6TiES0ItpM1khoAZm+bsthsNHOLVkagsoOtnW7y5i6dTa7Yd8eHljEmxoqH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(16526019)(52116002)(1076003)(186003)(4744005)(7696005)(8676002)(316002)(83380400001)(36756003)(478600001)(6916009)(8936002)(5660300002)(4326008)(86362001)(6486002)(6666004)(956004)(26005)(2906002)(2616005)(66556008)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: F6xGEvrSZXHtUoKuqLRsmNwJHcn6wfQLH/NLMvhSwj+t82Km0/7vonvbkjjIfM4RfnH6uBfK2Ipr4a+YzLxlHk+RNWGYAI21SB9N4qQwvpMLbVcxrHPPOxll9J2fJGTVyqt4s2KbeigQjB0kNnBYRBGMlwe/KDVDK8dtRllz6kHERIRIBFYg/8pQHBa47tUdxWge8/FXfasAbhHrN1grQaPeNvNjnEo1GWqJMcfq58VS6zYAnpl6osfftczo/mpmTEmZfdjQaVdddokt7JGK0kp4+Z6NPSB4rWVwvIGePV45XMZCjFtnLMsAzGw51VpTcazmYFj6VukKYyW0VjtDpzMoX0fIMj8wMA4Y2lcttUYDdxX5ibEu2pHv1xnGwrfs1MkKWA3j0OHO8vJHMqIn8X6fhonhmLt2+cBZou89D+/Nn46xypfxfjUoCSRD/26CzYNgMkXeX9sasJpc3YISvkrl/8bjB5It/dbuTlBdkT+P7ii0FAw7ubUN3GzJvT3Ca8eqGwBfGZ9A42kLSD2IImp4DDPPAB0MwCIzMb5ZnruVjO2CgeeSAb9UrdvHabeY7ATapgydPpAm4D7M9pZIS9g/82O1EnxUQrixv9iGm4sVkWA2076n6I02uiEUo6Aqe/9OJfmHhgLrSn0mjM2r2w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204f16f8-2ddb-46da-f533-08d842802dfa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 07:35:57.1631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFi1l9IsCVwSNKavrts9YcEv1t0biia4I0vUb4YVRCKONvz/FZrTYX8MjMzFOMjQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3646
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
Cc: Felix.Kuehling@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix amdgpu_bo_release_notify() comment error.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 3d95b3edb635..4cb750ed6851 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1301,7 +1301,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 }
 
 /**
- * amdgpu_bo_move_notify - notification about a BO being released
+ * amdgpu_bo_release_notify - notification about a BO being released
  * @bo: pointer to a buffer object
  *
  * Wipes VRAM buffers whose contents should not be leaked before the
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
