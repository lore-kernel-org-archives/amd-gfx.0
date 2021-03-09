Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E32CC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2CE65242
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 15:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2CE65242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E806E4BB;
	Tue,  9 Mar 2021 15:59:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54E088DAE
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 15:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dywnu9rTExRyst1HGpATNuD47vnwjHLrjp/bCSqqhrkgGvohGt3Somotf4x0c9n9iJNLdkPzoD4Xq/TB2mG67Cg1b/5dZ4FNn4Rm4idK6+g1jMdQQsUKI/VQg6gF2WkGl7pWhHzeHs1P2wPgtdYWRTC5JfBSH0ec0eaGw1d1LOT79c/wu6cPC6Y0N9/4MDyukNOuKQ22JnQSjb1Vs8m5kyNOhePnGK5oSTU+ztcC1nkB/BXcH5DsvIGgTRxtGiPjmTJZmsBF6Lyl8/f4QkwYMaum7NLw46HrMopDhX0AGRi9SBTePkYcf4u8wpsrEpk7e9OktDOxNHDsDoBXq4wc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1U4+YBDUl9d7PM/edDnMqNY8Hy35UMNB/3yyrvB1tw=;
 b=S960yhK/pjnRAXm8NSAWuH7SI+nFqD4CVZwVCDG7ry16YJT6oIrze+hHXUEXZ2tZnspexVI/wTRefglg9Nd0fISflUDo9B5a9/8by4mEAGWlwa7x62cS4V4sisILL8u+De3wIDsW2D32VaCkgjcLM2+G/kuMgCEhiX/ntpBBMZ9kNUrLlT3qHnEM04JetfXIric477Y6ygW9AYY2DyZiV2nalZo6TvLLwdapqCWJ6+xZYBk0sWbeG5A6MT22DAG3JxtQ8yoXd28A22sHoICROjcv8GRporDIk6ATBfCPOkr/H3xa/McpO28unMfbfnV4/rSFot4ntvqJO0QZdbCTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1U4+YBDUl9d7PM/edDnMqNY8Hy35UMNB/3yyrvB1tw=;
 b=jgq3/jvaHqWgafcF/D4gtCHjA5lEisUEZhNWcgyolFPDldhs9xhLG7l1h730ytgAgiEeuBvH4HGnP7naJfnxBRxFEMMxyVQTyfBq/Q8EcRlW+ti4sCNXd8mdpGSBtCXJ+XFIrjeswJxmmgmN09OMwyfhLKJZTb8Gzqb2brV1oYA=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Tue, 9 Mar 2021 15:59:08 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 15:59:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu : Fix asic reset regression issue introduce by
 3f61aa92b88c
Thread-Topic: [PATCH] drm/amdgpu : Fix asic reset regression issue introduce
 by 3f61aa92b88c
Thread-Index: AQHXFPsbvRJHu7zUakO3+cFJfjjJ66p70CSQ
Date: Tue, 9 Mar 2021 15:59:08 +0000
Message-ID: <DM6PR12MB4075E785DDDCDDB88C304F7DFC929@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210309154414.25450-1-shaoyun.liu@amd.com>
In-Reply-To: <20210309154414.25450-1-shaoyun.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-09T15:59:06Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0f61479d-ba6c-4e7d-b5fe-c044b2f69b20;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b287c29-182a-4d6f-0ea3-08d8e31445f4
x-ms-traffictypediagnostic: DM6PR12MB4217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB42179D185C078BBEEB182EF3FC929@DM6PR12MB4217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +krl6uhkaBP4Bfk3nKe0z16FIksADEMm0PqAWFxhFq/CVA2ZafSdUB+MGTiAwwWfbODMajwGMhKUXMdJk8+wtJ1D0/BZ9JkVFj7jMSmevGvOnyDa0fcA/WwVKsBhnqvSV7QrdZFyTM4TB15Aornrap3wi12KqacTB4p5zERVeVB+nBSBFX4/ha7bxz3tGXpOTMEq9nMZlHDdXUKGeoNGiz67Rs6XsirrpsprCbyGLWuxINwftdT97ZziYTDBbk+klVT5iYr+zYlG5MF8RbFhE5ctw7NRCVG0eTmyxpGuBm+p2EDRLzg1wLTTVSGIjMRcmZQo3SE9x3IOYSrqWHI7XfDWT9v99imwApBeWdLOTZOtY4is2eYfLSfsOxGAQ1uxNYyHpEIe0I1XAQ2D1iCDijG8sklJfbunXhdIY2iAIZj9FM6qSPQQaJDRPyQp3M6/cuabVrcLYwspKuDesHqKut4rDv4kuJKZ277M8R9UHt/MO3+3gFXjcWCx2wIiVvJyUBOl9a36ndRDP7rkpuMywBrMHizIf0IQNrR9mDnOVgclO3MrY5/TRnfauc9loUky
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(33656002)(8676002)(4326008)(110136005)(8936002)(55016002)(316002)(966005)(66476007)(478600001)(7696005)(71200400001)(86362001)(45080400002)(83380400001)(66446008)(52536014)(26005)(64756008)(66946007)(53546011)(66556008)(6506007)(2906002)(5660300002)(9686003)(76116006)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mhCWa3gOQbjnZ2Y/Y/ETANRAf2sw+lLQKbuHbInn6+cT4DYubWvLJczwQGO2?=
 =?us-ascii?Q?YTLfKhRwUyIGY11suYUN7W8Lp4zjMRjahr4ouV9r+GRjJPUc8UhbqvKWbeex?=
 =?us-ascii?Q?SWy4POUqm9wh3ZLYjr2fhRWosBglv3OGw8mTYBFikamLBXYW2NLJ+OtcFOgd?=
 =?us-ascii?Q?+YmKCZHCotf54UJqIfNbG9cyPgwPQ03RPvaiTa/EstLv1VTNmCoxTPLOV329?=
 =?us-ascii?Q?9euuzFujxSwpDvRBgnjuMkEdMaPc0DSX/GWZScsL+AiO7P49ovnJnedQm0s6?=
 =?us-ascii?Q?GnVhjbVRhTRhhg7LbXENdJfepPm9rSLgUYOnUdZPPX7TE6TPL8vMr1D9YI/5?=
 =?us-ascii?Q?IE6599JzS9/Xknq7yrhgpa/Hk5JICpTvvYq+yxzXT3Jq9tDWEGZ2lWajxetg?=
 =?us-ascii?Q?flzDqbyZE5dyQTVRNymNtTA8Z3bJX5/kZn1t1vcnkb/6mnF7zfY8dW6RUTv3?=
 =?us-ascii?Q?tYnwpIzJ334sHOsGWtIP6flvdkhuFeSYxNUTkVCyAaBNVUGEkoBT+UJE5fmk?=
 =?us-ascii?Q?8g3DZ1e/+bVvdRrzAl934c3WO8UK9C9YONKOGWaBSejayaqkWTHMjKp8vVix?=
 =?us-ascii?Q?BIALKLI3fByRiKfoC3nthR/Oj4aIB4dtIXOH7ZrLKlT/a4zW5RL/cmAGQU5s?=
 =?us-ascii?Q?kjXRXCXnYnPF32iGf6TcM2Qb30jByfIuNAnoLUPcAbCO7rGTh1e5enk0SL/1?=
 =?us-ascii?Q?mlMKlEBYjEc4Ahu+cHJgx7mLuMtOK6uwH4ZZd4xNTvM51WrYLiYNOhcN7rOA?=
 =?us-ascii?Q?GiOXfJZ8VryUnMIN8FXSyVOA62/1ayzVQYfR2TqAxUsQsQRXnT80B+0jedaH?=
 =?us-ascii?Q?D9962jdKIAewz56Gn+3s7Fd8eoHqLZfGAGmLg3zIvkijjU6ydnw9wgqNTM+D?=
 =?us-ascii?Q?NdWY7VHy5i7e8pjrlkTerEiGeLvHcqPdF478Epr2NERdF+DEBVk5YUxEK+Nt?=
 =?us-ascii?Q?OywtI3wCfTGzAKWITaZMEwdxmp/SfkGzcM+oe9YELSfM4b0L0RbQoMpjtyDG?=
 =?us-ascii?Q?hdCe5vVrzPkX9qA7527PQ8xetsNFAIwRTqFm5Z1nkr/UY6lnZlsdWftW1nTs?=
 =?us-ascii?Q?iaJd6iUm6gIzphoang6tupPqpGvP7UPfAQWTWDfxSwxwYQHvruyrnSxWcfZO?=
 =?us-ascii?Q?/zVxQZ/fLOor4YWTuRi3Mdhzb6SjPn3b3luZcewv2oWaWho1ep8sKc5Ym8yF?=
 =?us-ascii?Q?60QAtGiy2FUVfZB4Oq1zvi2LEgzLJl39X78R6eoWaPpVywYkusw4ZSf/p0Yf?=
 =?us-ascii?Q?cUoKxlgZ8eZvB9L1HqVNWgrObh8n0MrTDq59PZpg4iAL2Is2yNmKCKVN8+sZ?=
 =?us-ascii?Q?4XtOivM/aMz2fJ1dVVxnGAqd?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b287c29-182a-4d6f-0ea3-08d8e31445f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 15:59:08.3984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xGZTO8uIDmSu3yUH43dR9nwtU1Ta+0yLWp7iDqg/E3CuJhQ1oJ7a3BYaMfqo8+LUMOPICxy3wClGt9mHakDbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Tuesday, March 9, 2021 23:44
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu : Fix asic reset regression issue introduce by 3f61aa92b88c

This recent change introduce SDMA interrupt info printing with irq->process function.
These functions do not require a set function to enable/disable the irq

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I595998b107f48865f47820ba2e7f758cc263dc64
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 9ab8d7db19f9..af026109421a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -570,7 +570,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
 		for (j = 0; j < AMDGPU_MAX_IRQ_SRC_ID; ++j) {
 			struct amdgpu_irq_src *src = adev->irq.client[i].sources[j];
 
-			if (!src)
+			if (!src || !src->funcs || !src->funcs->set)
 				continue;
 			for (k = 0; k < src->num_types; k++)
 				amdgpu_irq_update(adev, src, k);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C6e0858a294b54e80977a08d8e3123c8f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509014758483427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=xc0GL%2BXO%2BJXtpwwjX1usWLOn1FVcNG%2FKRbE9qtwsU0Q%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
