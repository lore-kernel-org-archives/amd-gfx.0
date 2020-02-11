Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E262C352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457EE206D7
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y3R/bcFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457EE206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B03B56EA2C;
	Tue, 11 Feb 2020 11:23:01 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690086.outbound.protection.outlook.com [40.107.69.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A776EA2C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 11:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeYkWPEjCeIhnn1y+f0lEL2EfjQJyXTNLI83wGYeeZJrfHEh/7LgPDdaW977NijWzuxGOIQaJ5ktFrxFdMrXHiwjg8EUBcPbRzvFOXcqGhD5ZeHLLtHCChWjTRs+HRbIqysSb5GMC/RcXM5Ho5zU81jz55qPNcg0okZQeq6N9IH8By+P0cxCt1l2ui6eetnbgoehAkvm3WsKVkpe//HRJRNgOpZNkmPIkMJv2nfTZ+1AxFLZskt9p0D6kW7kWTiLBIbdzHWdRan5WtOXfqF0nx0VD3Vj9xCHFKYJi2HDnZgaKhDyE+DtwhD4svv+0/EIs7RGKGLDgKYZwEmmdkUe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VaWe5uLWrtDBuzjDencHgcEZLDbyZAR35cz8nd+96g=;
 b=cJaj3wG6p/nWIbZKKs5a10+TxPJqrdUXuyw5HJdXSiXUgJmx9cmyVw6VAKBZ1wzw+xlxn0MraeeIq++pmr07Mg+ybHrKnE3mSMfKrnGsqL/rIlhD/IUoVrwIsreBVKDzeF35dxmNPFhd36k/sbop9Rj0tDwXsAPNwqcLuxQrirMHKVwc/k/qtl7gaPJh+D3I0yJqqQ+ROVUiiuAmdBQWTBtkHDk63oVUDsHD8NPSdQzGeDInm2kpc5QloAyJol+8xWFgHyhwYiGqhrRRyC4ztPGwpjwzymYEuLzuqK6/TblJtc1+6H0mPn6ZcMAAQNJrFVm18WgrX2E63zi5BasNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VaWe5uLWrtDBuzjDencHgcEZLDbyZAR35cz8nd+96g=;
 b=y3R/bcFzPcig7H/vabLsmiG+7wuzppkViVYPIBbxAWknGAHykY8BmsOxHpq5JblKvYIpaHLl3QBzudqOEcvQlsDuW63SIvIHRi062Ja80ukoUJUaYxEEyNLD8tfbxVkeDunLi/xdLEzk9qS2zb5FBx9S0pfqu4Oo43P3Xog0s/4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4221.namprd12.prod.outlook.com (52.135.48.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 11:23:00 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 11:23:00 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH libdrm 1/4] amdgpu: use alloca for dependencies and
 sem_dependencies
Date: Tue, 11 Feb 2020 19:23:00 +0800
Message-Id: <1581420183-14223-2-git-send-email-ray.huang@amd.com>
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
 Transport; Tue, 11 Feb 2020 11:22:57 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db1d0734-ef4b-4647-07e2-08d7aee4c074
X-MS-TrafficTypeDiagnostic: MN2PR12MB4221:|MN2PR12MB4221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4221CF137351176E2483A2DAEC180@MN2PR12MB4221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(7696005)(52116002)(956004)(316002)(8676002)(5660300002)(4326008)(86362001)(2906002)(2616005)(54906003)(81156014)(478600001)(8936002)(6486002)(6666004)(81166006)(66476007)(66556008)(6916009)(66946007)(36756003)(16526019)(186003)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4221;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgbGS/hG2h51LDtnWyE5KX6G0CrU6KCkczs1a1joYtwVHwxtahhi12uZZiU5s3kui2pMSwH+oRMW/4MfkJSn6sz0JGXS8uotvOh3jLueZNVFbYfBdjbT3PuVIvHrjWLCU9wt6vBQGkSlc3jLi8g8QyCMeRBJgtnm/axbLtYNbBWynig9DNP5iC7JB3ocOXc3CdlwroCrp/r0j94UhbaGMY/vJ0QAe7lhqcPNihBdXzcH2G/sQHQKc6ObxKF6AKu4QvB3qVUOMwkn2tNZYkwwMBHwCfiF8HAOTOjYalLc21rHcs5xKJ5D8Cthoa4eW/+CzPW9x9LomElND6g4mxqbMFS2Sd7JjgNCDjLsxEgrmBDy/JLbocm2flBJ+90ogLbq1vTWSd5pfQCoJX7G3mOrXYCkMcbzkPnVxP+IHOC3oIbiS3rdGkiwCnegWyAE8O8K
X-MS-Exchange-AntiSpam-MessageData: CBNZUaMg9R2LlFbgW0CQU0Xe0YrIfTdMC7PRID1y3SvySiUB3ym2wFAbgt00fKYOEVqXjFNRU3JvrZiNpkAwaZ3tj/4t1hDECm+tkykVPcV0Am1oT5LkxuhlVkRa7qYgAChy7FMjLO9Z+j8xP/07ZA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1d0734-ef4b-4647-07e2-08d7aee4c074
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 11:23:00.3998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaWLGVG6x2rIBaxwtzZZZjAuRlZZg6s41GfeJuqbLFpulq6Lj5u/yHCpVvVnxSX9uwM8pI8YdUXbYG7YruX57w==
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

Use alloca instead of malloc, then we don't need free them at the end of this
function.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 amdgpu/amdgpu_cs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
index 1bd974f..aaa1f7b 100644
--- a/amdgpu/amdgpu_cs.c
+++ b/amdgpu/amdgpu_cs.c
@@ -295,7 +295,7 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 	}
 
 	if (ibs_request->number_of_dependencies) {
-		dependencies = malloc(sizeof(struct drm_amdgpu_cs_chunk_dep) *
+		dependencies = alloca(sizeof(struct drm_amdgpu_cs_chunk_dep) *
 			ibs_request->number_of_dependencies);
 		if (!dependencies) {
 			r = -ENOMEM;
@@ -326,7 +326,7 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 	LIST_FOR_EACH_ENTRY(sem, sem_list, list)
 		sem_count++;
 	if (sem_count) {
-		sem_dependencies = malloc(sizeof(struct drm_amdgpu_cs_chunk_dep) * sem_count);
+		sem_dependencies = alloca(sizeof(struct drm_amdgpu_cs_chunk_dep) * sem_count);
 		if (!sem_dependencies) {
 			r = -ENOMEM;
 			goto error_unlock;
@@ -363,8 +363,6 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 	context->last_seq[ibs_request->ip_type][ibs_request->ip_instance][ibs_request->ring] = ibs_request->seq_no;
 error_unlock:
 	pthread_mutex_unlock(&context->sequence_mutex);
-	free(dependencies);
-	free(sem_dependencies);
 	return r;
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
