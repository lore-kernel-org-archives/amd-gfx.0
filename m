Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF5C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3036C61355
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3036C61355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38CA6EE0F;
	Thu, 27 May 2021 04:04:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532E56EE0F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 04:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccsc3bSJKYeRs5SpcGOn90ExlnOBiSq/dY0kbeKE45MUKeR+FKdGcgi7tu6ti6SbP3qUzT66XRG/UNLylT828ymNNC731mgWI5oospOmlQAaYcreg658PVUPXBhd30d7Q2uKiHH0o+sIAxNO/NUAEpbkTvwTmDr5UYpiW79JYm+PRRp2Et1mW/2CSUBT4e7SFCILq6lcREqXHy99zF/v3EE6mldiaHwE3Yx6XciGqrARR4YuDIVmWr7HZcT4P9EC3f7B4MUqamYtJav5Q7TSQGXV9iHNyRVtnCQkP3pCLHzozb3jUIoIrhF3yq88MnijKo0rgDvyP9/N6adgKRoJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFjuY7ZGMq479KImxNe/9OkrbQmUgJPYoSlRxIKkdbI=;
 b=GyWw1sOi2UHE/6HbJDnZz4XcUsxNGWwZr8mYTBGs8Tkxplx4P5UtbGvddNEGGmSwtFvcBlbGl2dTaXDI+TVG9X12KHrErnuJNo0a7Pq4k1MkVgQFEsKdh4R6SZwWyYD49ZreRcFtSTSteVfXJfuhhWlw0g9VHMjnEDL6N56owibQ/PEQUX7Fk/yHD0FMPNy4fb8OnpQPUO+fg+6MPtuX+FhZ6EHRYjjzwJjblZ8+R0da5pCip7m5/aIAR6/p9/tlt25hQfznxtIFm3W9ATsG9Iy0ep6S/LQlmbMvb3zoniOvR/zsABtHcyrISeQpshMXGtPV7UgWuKQbRMnuV7IHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFjuY7ZGMq479KImxNe/9OkrbQmUgJPYoSlRxIKkdbI=;
 b=hui1NyB9ptwjhIUsClNcQaTruvF2asx2l4+NLf/WNLmy/Al7GNb0ggXIHvh5gn5uQ1FyO4JSM0MzztVqfgVHAHVtJlc2sdBt82wj8Kh269kk6ND6kWXjXNsREECIjIxNEBf7AHrvz5QMj86sHOKuYcqmCoNSaPNZ2r3LmcmBHp4=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 04:04:48 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 04:04:48 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/swsmu/aldebaran: fix check in is_dpm_running
Thread-Topic: [PATCH] drm/amdgpu/swsmu/aldebaran: fix check in is_dpm_running
Thread-Index: AQHXUqtnPzaUHGROnEuJ+O9shdjn9ar2tUbA
Date: Thu, 27 May 2021 04:04:47 +0000
Message-ID: <CH0PR12MB5348AABE0FE71349C632CE4497239@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210527034952.247846-1-alexander.deucher@amd.com>
In-Reply-To: <20210527034952.247846-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-27T04:04:44Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4112e59f-43ff-49d9-8156-3dc286f7d17f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.222.144.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb9da00d-fcec-4e43-9f8e-08d920c491ba
x-ms-traffictypediagnostic: CH0PR12MB5073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB50738C8576307C5806DB4CEA97239@CH0PR12MB5073.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8yc573Vjn0uMq9cwLbAGYsNp9+wBHLODDeX5/aprRtBLIE1RPQi+PofpUHQquBBakZ1VKqUzmoyySZPAoLj5wV/E9o24J5/YKIrIq83cgFCebbMfSo9AG0iC2tHjaeE6JWumza1HKOz4uuA0Fzw4nhFKzkVmWKev3Zhj7wwyyH0Zv0wY2Cwv6EMbrq1yBl7hHB0vcAAXWPGsEH/itjjEBRhm39wUxf2nCAxjyUnINsbKnDXT+BNv4pB+dIHUweHZgQJbihVRBxACtGGUH4KuwiYcd2AH9/KVIJnkZdNL21WPoQDCxs6fC79RsCxDsS/+L7XJDUaIV9R3cu+SImhGdnY8/tEdNJJ82TSTs1DkqwByvn16tTnaELSV0Wj/imwnIAQJFjbwMfI0LQeFAomb1CvHJgWCK8ihR/sbML2FrCYOLr8mwJ2P+Jz3eBuV6/cJInB9V6wGaJBp0dVdWpYJqXSFbbNp6Sixo4gA7hikYpQvEvWrhnRpgVnlfkPJC1QeTMNAe823BuOJhDFgQrEE/Al44UkGCqe85uLOCfroze7JrsE1SD2f2UUKii86XP4gFFF9i5ueW7YHnBsRr742MKMEpznOjzOJqPZaUIT5Pp2STSrCBPJTqAJLXR0Vujf4ioWabFzlN26Ph6mmicOnyA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(54906003)(6506007)(7696005)(110136005)(122000001)(38100700002)(53546011)(83380400001)(86362001)(8936002)(966005)(478600001)(45080400002)(71200400001)(9686003)(8676002)(316002)(4326008)(55016002)(2906002)(186003)(26005)(66556008)(66476007)(5660300002)(33656002)(66946007)(64756008)(66446008)(76116006)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0UPsoGrnCs/9fVGOrM6STH6IKKovH7F6fb0yXeROnMPSoIGwKRXHkLa+sSRP?=
 =?us-ascii?Q?YnZ8OgvgpXnjmxlCCD+BH4TFWZ9q9UeUqlvgJeFZy9kHlX1ztGDbLPolH8Pm?=
 =?us-ascii?Q?1NgFC4fYkJokJ5rmszIKBNrV0Kfxsn7QPAKUh1jZMt0nFZ2fypgc1OG1o/Ma?=
 =?us-ascii?Q?/aw67Sry4UUWvM73xww0Ui5Ix4koY2t0d70mkCD1Fc04q0ir5+2MmxqxsK7S?=
 =?us-ascii?Q?zWe/alikC7W4Q7IDKL3oBkWjPmarioRmBLO00XGMSUEbMQ9P/ecT58B9WHye?=
 =?us-ascii?Q?qtzDbMPcmrdSaI0absr575ABQlYgnPalANLcO3hfPOJdnWyK8s6ExPxrrARC?=
 =?us-ascii?Q?tokeZh4sBI+4tcRAnIn0edC5ItGmDJRVt+KvxTDB1enc5GlLPh0gSICpO1q0?=
 =?us-ascii?Q?FUJI5aVcPO3ntqQadj+5WBf8ywi568aqBDlEfTfLlR/+6V5qu5dGtst5RE8J?=
 =?us-ascii?Q?+grAWbc00Rud+a0Z5p1rnnO9kLuK5JpZe9j7iQu4gOWG8289f4abKam0S3Dc?=
 =?us-ascii?Q?IGGbQaXaLe3kJAwD9N+hd+U8eApfbo+6EK+Rv5PFh5aUmceH0sis3lRQjk1S?=
 =?us-ascii?Q?TWQT6wHSkYNlFAxw/sHvKLzKvvT3fBzFxG2oqv/B0AzEEQwI6AJynHjnG2WE?=
 =?us-ascii?Q?mgww9Ihq/KXmhL56g8ckRsFn2hu/NWuBJaxifOoxzX2MLbobxoyekPa3H/W9?=
 =?us-ascii?Q?Qk5Ru2uZxxXjXupZNXHZJCbNvMJpkbaehM/FAxpD2NyXeuHS6/v+g7CACPd1?=
 =?us-ascii?Q?MA2bBhcqsEH1yHvtycSTSZkfVqyH270XKS7FuLwvcOROcsJmTwT10y7d9lQR?=
 =?us-ascii?Q?ZL4z4mSTMFWtoMcoiQJ7VHJTenGc8aLaQA+ZShuYcNgiGYxrhydVV0OO3vt+?=
 =?us-ascii?Q?LLkx4Yz2CNv9ltup+sP2+6RprhJ64rKSQPtmzFLXu4K/c4nWgXIZHakIgOGl?=
 =?us-ascii?Q?fsHPczlVw9EEi2HogaaRsEkbLf1QodZ1qHYjai48FNR9pM0j05sTwS7gqSR9?=
 =?us-ascii?Q?8Ot47iqUlXbA9I8yTQB0wFUS0RY6dDoa4iyi3XjWMkHqEz5luZyMgxEwAzfU?=
 =?us-ascii?Q?wHBZXvy2ngHM3D9Zp1Uj+DzFgueAC6AohSH8gH/8KisrvN9kCUW7nn0YYUhY?=
 =?us-ascii?Q?FunVdMci4NUITkkqSERkLiyqmoXeRaOpjaP5CzqwMfYYDoGPLNmjx2zazm5D?=
 =?us-ascii?Q?I6p8I/HOr57i+hFP+DZue6CdHP6Gp/UJUS+iZ7hvguD+vcToxJpNW+e3NQhb?=
 =?us-ascii?Q?GVLkdEW1zMGpCgE4/JYxkL7sC2FcGYFVtFh8ef+gm4q/pbuQGe8cNzJN5nPB?=
 =?us-ascii?Q?zZV4kMuE/+fZIYxm8hb+XJdN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9da00d-fcec-4e43-9f8e-08d920c491ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 04:04:47.8359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1srB0PI6QpI5ALO/WAch5RK786p68nuITJgSP65fUbeD1RpNC3NbGpt4BZL7c2nJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, May 27, 2021 9:20 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] drm/amdgpu/swsmu/aldebaran: fix check in is_dpm_running

If smu_cmn_get_enabled_mask() fails, return false to be consistent with other asics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index d6ce665baaf3..7a1abb3d6a7a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1368,10 +1368,13 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 
 static bool aldebaran_is_dpm_running(struct smu_context *smu)  {
-	int ret = 0;
+	int ret;
 	uint32_t feature_mask[2];
 	unsigned long feature_enabled;
+
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
+	if (ret)
+		return false;
 	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
 					  ((uint64_t)feature_mask[1] << 32));
 	return !!(feature_enabled & SMC_DPM_FEATURE);
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cdea650bc3bf94779810908d920c288b9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576842163298481%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=g7Bm4UNzXSINfEePLJ5QEwhJJEMF5CKB4Fecd1F5328%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
