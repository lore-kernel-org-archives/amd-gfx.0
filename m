Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3E5C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 02:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D302B64ECF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 02:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D302B64ECF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD076EC0D;
	Thu, 25 Feb 2021 02:39:23 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995C76EC0D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 02:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nahBj1jnuNvKSjjxOC6MHK0h2egyhaDDh5xd8Ypq8BzfECkyeFM6Xt9y/aNsnOkb3n06nB/bfC10OBeGMC5iV7Vq39kXU4ckQugkFF9eOhCU1m8FUAu9/sgTedI69njKofMyPxryhUI04yXwzDNos2EkMo8/x6dXCi//xivMur8fRRV4FEe4LBMEBX9dMWmBPrMnwb1zJ4ubIKLF0m8g+oROlQYnxwksuCvneRX3wWTQLjdn1YZKqBwQ+pVCsAg8xb8Ss7kssheiuORES4DVrgUkUqfChM5eOa0E29COF/UPFNVzKaQWFfpxJ5shOJWWbrfC8Le3prxF29n1acOYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEcI+0wGtVQWNxXwTkEqZxS5XVrxt0KYDK3UkyYvfeA=;
 b=DzGAAxK5FeSXlkKJPp6/zGit1wdIwfMCROWcv1sU6oNs5UATEUZ3gWfuFg0osEBIUSFnXloyRXt+kHmkfq31mlHYpkwn9zCJa83YytSR7rlgw9JQfgxlh4D5gnixuJnV8wlR5clIaLy4r77s15jVQ2yW1MviJPIeds1l/XL1kWqTBciHSpTC6kLRLXgPvJ4mFyMCRjwqUtfqx8xR67tWSwUUY3yFX0nvN5rcAqfUNpvCfMh7AvIDuiJzqCWdeeMBruO6tFSWjQVr2jc3gWevmvDVsZu9/GDrJDMZq0aFzAh6AgGxLbc44EDT+JfXIr6BOpeMLqP6e6VNggjMlvLtdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEcI+0wGtVQWNxXwTkEqZxS5XVrxt0KYDK3UkyYvfeA=;
 b=YownF1vg58vdIDKg7EQCpKvcC7LrpC8Ssc6nKuyrdQewVmcaEQC+k4Jc+3pWMMsCfrIm0yWBayETIWe1mIl1jSPiCpFW4az6wVFVf9qSjgS67ewLdsQ5oHuVJKCDltlC9XlAwuCLzzAq2pIJT8XFlOh08ISS6X+jbVISjvQ/80I=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2357.namprd12.prod.outlook.com (2603:10b6:4:b7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.33; Thu, 25 Feb 2021 02:39:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Thu, 25 Feb 2021
 02:39:16 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: make unsupported power profile messages
 debug
Thread-Topic: [PATCH] drm/amdgpu/pm: make unsupported power profile messages
 debug
Thread-Index: AQHXCtKRKDAuPitAQEaUFL3BJ0bl0qpoKP0A
Date: Thu, 25 Feb 2021 02:39:16 +0000
Message-ID: <DM6PR12MB2619396CE838F107C4F37DB0E49E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210224172858.2779680-1-alexander.deucher@amd.com>
In-Reply-To: <20210224172858.2779680-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-25T02:39:12Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=687356ba-71eb-449c-853a-9cac7aa12e8d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93da6dcd-c41e-4df2-fe5e-08d8d9368baf
x-ms-traffictypediagnostic: DM5PR12MB2357:
x-ms-exchange-minimumurldomainage: gitlab.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2357D111820B63EE51045CEBE49E9@DM5PR12MB2357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s0Jkj0a6UkkH6T3qa+sUumSX73CYWPLtGyFA+FoIq3VLzBzR0WyqpvpNVI5pDYlJbRZdWXY+teKPBc4MlCgLqKjbY8y/DGSVZ8NjfYY4DM6upRzh0Qn+snyLV3vKGGmEuAi8A7yZe11Ol5NhHO9cOpXHrA/UA0jlnohSEU2lj/Wx5E/dzAuKJ3zOLVmSFMSo4WdwrDOk3RUDAkTR1fsug9BdXsJzTOya/EcUvomy/AlwlQCsZzuHgMBQYac5+JxPSes7Y3/h/XAICy49U4KrUilFzQGQ7IgT9BWKGtMD4YbcoCMglhI3m/IGYygYnV3zgkSS0NyA1qSt2u4wrIcqymB3EqqlibAINrLgf/C6SDySp1ophhcgTPJJNReWII95f7Nd2Ks2q/z2zrEvqyxkmna7gI4EbTtGwyPiQN1Fd3nM3UBY5uGTmBzN+UPNCVxOfQnbRNZhZ1KDAFtedCAEk3wnJHHviMUO5VghUk6JvxSsyYjBk/ejaJfY3SFTTtAlEfWvYUS+g7MDEXFyUkGeiVPPEO6nARTEO96uLwbZE94=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(64756008)(66476007)(52536014)(2906002)(186003)(83380400001)(15650500001)(71200400001)(66946007)(66556008)(76116006)(66446008)(9686003)(4326008)(33656002)(6506007)(8676002)(53546011)(7696005)(110136005)(966005)(8936002)(26005)(498600001)(45080400002)(55016002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rWQfNz053tkOgDmrq8zP0Fs5VGZXsrOiICcCRzBI6SdvVqv34+hZKZvOGzLt?=
 =?us-ascii?Q?Q8lctATXyMPCCUlX3zz55LppiWWL7zySFrCbGXuH1WhEE7Tqgn0PBC4xj7fY?=
 =?us-ascii?Q?lBXeJ1S7gRa8Tt1aNWuYySuu8mKVb4w5Y2BJBPpwRHqbQp8ZFh0KhamiYLTL?=
 =?us-ascii?Q?LzvdIVkj5SUI190DpRodWCZjTWosimZg38gdi7Zy0XSya3K8kWP8nZ8AF6qi?=
 =?us-ascii?Q?Xzko9P/FS9/Rig4+uzxFxe6UQAaSRJ1pd8oZEi2lcEB5FKUYza40julLqNTm?=
 =?us-ascii?Q?SKSKkqejec/mOWfbCTW1uAffQvB/Ihmyy7x3plqTl2epHFDe+l/I4ZJJ8jBL?=
 =?us-ascii?Q?tYLGnNQlpe8khv9wblm0jWoVu740qkklNYxjQrUYUh2/Fkr8DbkobarX/T/v?=
 =?us-ascii?Q?oYmufp4P5wtG5lyUVylp8NN1VmuEeDJcYCycUp9KBloeB6gRTeSM7WrbUNFp?=
 =?us-ascii?Q?AVFjx2pMXcxPMiBJn0IsdrEVN/94nXKVOkjTGciAqZvTog7/smFanKg+TjZ5?=
 =?us-ascii?Q?dJje6uynfaBQZYMvUTclbCBql7sN2lt0AvTMRXb2/ll3Ig6y4ssU6qsmbFVE?=
 =?us-ascii?Q?4pnqLg6RnIaky4BoQPyKKwCRWg0FWi5YVKGgFRbmlp2hZdJ1nqsiRPjaUlzy?=
 =?us-ascii?Q?dJ7ijz2YJyxwfBroMFS++9C/X63vMqVBeEKBNhk3xUaB4xjkqttB0ZQb7QTG?=
 =?us-ascii?Q?v603GTZ0nk5cv8CJ0uan3oHLOvAgEBIkFNskt/9RmBsCILFmUXHtCld+byWO?=
 =?us-ascii?Q?xAndByOgm0kew1S0SszU2O6v1f3vv/QLO0kpie5kGIJAuTutpBVaZCIFCFXc?=
 =?us-ascii?Q?peUnOvGxvePeHIPwZy1O9kFRPN31ypNt5gDOcVsNs7EwXoYWuzTbY2WR+Cqa?=
 =?us-ascii?Q?4ujazeY1lvIQVGIss8wqITxVTJJW6LQaBNwM+x6uYLZ1HD2CLAvhoQJ9SN32?=
 =?us-ascii?Q?uH1jChPjoBlFXpcX7cx0MpbkHleIeztmhApF5TMTNDVl8f7yo6bvMaoBrmrO?=
 =?us-ascii?Q?sT0fRD6UKX/A+q6Rd8ihxpKqW9+kSJ8HhzDgUycTXJXIZ36z7jigZHWJGL2H?=
 =?us-ascii?Q?SZ/OmNpuqKidgBO4nFQno0TqTi3jh8QksYTWGT22CTvMYqJopj1n8O/hKuNj?=
 =?us-ascii?Q?Ab/a11N6y0D9ph+Vo5KpN13EmgU++AG0LWOdHDxhHJz9WD/u3YcYB5BFuHtr?=
 =?us-ascii?Q?GfPZBHBUTx1RbxgmE4RYrSyD7BCDB/OkQlcZhiF0ALXUpzLf51q+oeuOrGci?=
 =?us-ascii?Q?5YsSC0WzqQ+G+Oh+DLywP9AWKPYdRc7QIje7uVZymfLB9vqww8WNqc2q2gVD?=
 =?us-ascii?Q?vnJazGPiMsC7uA4l2qA0grDQ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93da6dcd-c41e-4df2-fe5e-08d8d9368baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 02:39:16.6724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IMeZ5gfGliIgj/ia4RiyUPQvZKFZJL92qzlvSvTfpDGogVMl0aXGtXkY9v01Qn9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, February 25, 2021 1:29 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: make unsupported power profile messages debug

Making them an error confuses users and the errors are harmless
as not all asics support all profiles.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1488&amp;data=04%7C01%7Cevan.quan%40amd.com%7C4e46d63ffe1d4cdbda6608d8d8e9b2e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637497845536303912%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=RsDNvjWLf4xZ4%2FjlIRaJFHpvSabN0CPC%2Fr7Zi8yEKL8%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 45564a776e9b..9f0d03ae3109 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1322,7 +1322,7 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
 						       profile_mode);
 	if (workload_type < 0) {
-		dev_err(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
+		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 7b7ae5532ddb..fd5539f8b53a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -810,7 +810,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 						       CMN2ASIC_MAPPING_WORKLOAD,
 						       profile_mode);
 	if (workload_type < 0) {
-		dev_err_once(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
+		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
 					profile_mode);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 9a8b1a1e148e..c9f766cbe227 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -826,7 +826,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 		 * TODO: If some case need switch to powersave/default power mode
 		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
 		 */
-		dev_err_once(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
+		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
 		return -EINVAL;
 	}
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C4e46d63ffe1d4cdbda6608d8d8e9b2e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637497845536303912%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ktKoLeR%2B93D9DHtE45plHS6jNbSoiE4QSwAufoKw3ws%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
