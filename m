Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DFAC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 01:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E9D60295
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 01:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E9D60295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDB36E0FB;
	Tue,  2 Mar 2021 01:27:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E32B16E0FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 01:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNUOH3P50mXD5tDcSqzT/TIuBhk64Gew6wg7MYw4TO92Q9+UZHb+ZSl89WpSOAAlqdCSk4l4aX9b+Sr5fB6QpiExKtCT4yi618T9ES7hpZAdFc82xmIXpAfqmWEz/ZvA4g7mHoJ+tptqwUx8C7R9DKrDV3N40VNFNX3sMrZ0Ibr1xtOsVJJQ5OWk7MGID8o0mOnoHBlsm8NFZ/Sa6YC6W42NTjmhu3CBLegCpqZ02w0vkZcbf41rXncrulcUZZEnTxRXeLqBtmsOfLg1ed3iuJ04EfK9KqUoYv5ffY1eE9BNH2FHR/5dfl6FF0DKkZciEQysbF8+CvlH1kbCc6/vXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vAF0YR/e7ckH3G0pyamwiM55Pl/bDpj587zG+x2H2U=;
 b=UCn8qP7DvAsOSg4JMUFZFWiPW6hWy1jMskER5frGIvlFASiKVKPNzfEcpOyuEQLXCHwppPC7dXF+4xunbXq3I/n7WeORi9GGd2w+yNlYY9LHKZwgHWyeHvadjT0EKtLr8HZmCnta+limExxuxksq9W+E1j/FhtrhAEv/3dpyV6Y8m95dF9jjb2bM+i26347F/XZxs5FhISXj3O1D3P/zCUnwfeYjb5EIEQSX7m+GEm+7ruxFbYseu+hNzCTfnh2UYiRcZvDeum0u/qx6J/66eA2/HLojfQiE5BOfKv8ROXDjFIfqD3lqs4MWq+CdpR1iik6g3QoyOOUmbxs79yiUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vAF0YR/e7ckH3G0pyamwiM55Pl/bDpj587zG+x2H2U=;
 b=DdCa3wI6NEj+Gqv9W0wDkcbaPJhwkLF1QzCMQ9sXXp78ZH36cjakOKfoWKO+U3sJvwSZrMtbl6H4hqUIyN+xINQy01BMPjLFm1VAmCA/rUfLmxJTHs3ejaLj5BcdQf/NxgfcUPWKuctm3JOxb4fOBnBnwzLIP75RGnY9RIiPA9M=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Tue, 2 Mar 2021 01:27:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 01:27:50 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable BACO runpm by default on sienna ciclid
 and navy flounder
Thread-Topic: [PATCH] drm/amdgpu: enable BACO runpm by default on sienna
 ciclid and navy flounder
Thread-Index: AQHXDrO0DOMx8GV340WdoGGzuEe826pv6Nwg
Date: Tue, 2 Mar 2021 01:27:49 +0000
Message-ID: <DM6PR12MB2619F0C17D5B12615C4541AEE4999@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210301155756.1556369-1-alexander.deucher@amd.com>
In-Reply-To: <20210301155756.1556369-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-02T01:27:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=146cc9fd-da9b-474b-932e-2037130ffb2b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed43fc2b-c774-4140-1529-08d8dd1a64ad
x-ms-traffictypediagnostic: DM5PR12MB1451:
x-ms-exchange-minimumurldomainage: lists.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1451BF3114AEF61DDF1556DAE4999@DM5PR12MB1451.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IYJCrjmSzkUyxy02dLWNWy4b4b5dR0u5yLJz4dCx5n31RCddh+V4IdRTI6wtH137aGb0uHPrA8aScM8DA2p7eAlMBNVvwEpIbxkn0XKbNJRoqzdT/gR+dgGg18jLIoRpP0EP16MybL8aLzPiINQjjvjZZbTzNTiVK1Cywv1lW1X/+Byx/yOVzMFnj4RvVUaYGsrP0jyPkuizOVWEirBecoEM8NEQnyLb9NFpbUofylLF7TJrHi8OAIAJKGzopciW92TOU7R6X1hUWCgY5/ZqZLPRJgjPzWcckzcuLxzqmpvuSlUvqiDRub4FxfRKoJMLKRaY3/HedS6HGCNo4fG1N6Bb54lJUwq9GNi4fBMfu/1YzZQc1oJRBlDrp/HFiDjSS2StnDRgZIg4UB9u4IxV/++vCXgRBp1FVIwMo5ObkDWniKv2ahSqF97vjFvXWKcQuHEKRbBX+ZzeDc32UL16CX7DptJ3vuUVhgBQXQAMYVt18nOJ9cNQ/ceAfkjz+8J8f9xvdtMPg+x6hSxZ73Ch6DAUM7Up/2/AQuk0T/2NvoTe+yuiKAU/twBIO1I0sZdW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(2906002)(26005)(186003)(8936002)(8676002)(4326008)(33656002)(71200400001)(7696005)(83380400001)(86362001)(6506007)(9686003)(52536014)(5660300002)(110136005)(53546011)(66446008)(64756008)(66556008)(66476007)(55016002)(76116006)(66946007)(478600001)(966005)(45080400002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?o8Xfcy1xmAve7YNrCM0uZ0ogfP5A1QgjI/Vs+hL8pX3C/cy5BYk1ry4EnQat?=
 =?us-ascii?Q?Chil5oU1uA4s/LU14K79Qpy+VIVV+JgtRpr9AtpaiZHY1ftcdId+bllySEfs?=
 =?us-ascii?Q?Svr3872IEbyRCGNBMlpmmI7r0UKDSzSADWIleuyRkiv0DJSz1m80dhFG6Kkj?=
 =?us-ascii?Q?Aaet7kfggGN4O7u/w+P7rpP8LuxOR+8gcszCtUZaCNstp9XzGCCRLDKwDB0v?=
 =?us-ascii?Q?PKFU7ZrcInpT6jzuurYa7re+vcqN84EqjhG3cTKtthCPQEdIzd7UVfGx/ANE?=
 =?us-ascii?Q?IYAJi94B+I9Ysyu0uKQPB55ITbcw/LOIcIrCNtd7AA9MsHJ6r3t3OMm9byLH?=
 =?us-ascii?Q?sOcP0fDHR7JFf6SlWnJb6tjMHxGr7BY/T7DTYvR1YUvOPRvuqk3wOLJnVSBe?=
 =?us-ascii?Q?CPunxKuOfvXUgTzMID1sKWGFkppUlDieYoNuXg/7umvGd7QuI1F5J7QobB4X?=
 =?us-ascii?Q?Pn48b2NMO4sQLB9L4KuW65Nq73By7+gkShpShHDsdMF00SI3RKVoTIIgsJWf?=
 =?us-ascii?Q?/d3wq1I2wazinX4lfidbcQ7Aq0IKIgVoPNjl+RslvRqjkDWwnHITYc2jQUFY?=
 =?us-ascii?Q?uqbMS+sCfW15ZBizAOTSGfyKfMRCZPSTuoyq/+1lo8eD2ya0dV0deh9kggQw?=
 =?us-ascii?Q?XSN4fH91E8L0IfYZqo1pebqfsojxds39EWtO3L2cRfEwx5czEMCqrFjNfxNh?=
 =?us-ascii?Q?iJ2yFP9ShZMi5towz5dhbMI0DkIOrD/WfzH2FBSCXicWBnmhl+DhHzAOHDGl?=
 =?us-ascii?Q?hHdAjHUC/meKmvgJY0rMPFBVqzGPG5AWSzCrCJJKMnFp0k4BMi9nZ3ZlfyrZ?=
 =?us-ascii?Q?RiLjze0IE58MbLwmlkm9y0ES+EhTow6k+YNpsrLExFfiz7FfIZBQj3okbiAZ?=
 =?us-ascii?Q?fEHCuS8R0T1EL/wbHLjRpr1rR5+8/zZTN4tg1d34xDFx62D7e9CwNv00CtVB?=
 =?us-ascii?Q?EkpIDhDycCUk7ITShliF30V4fvVuDxhTtu1yZkJwXMu4wvWHPk582Lnsx+ZO?=
 =?us-ascii?Q?prKIlE+krTes3QWVVkXiiibOEuuW2wXaVqrm2eEjC1hzBzTIA2VT6jixYBlb?=
 =?us-ascii?Q?YHI7ODZrnyBexzvdAkI3Ib3/LcT3iMXUIlDOdUoqTKKEey1vtG+wrGLK0zLB?=
 =?us-ascii?Q?jMi8Njv5GcJYeR82tk9Le0eh5RIQdYk2AWup19XYoYQQwY7Cm2fRVWcJF3bN?=
 =?us-ascii?Q?vwu+iTxmQ6127jU5K4FDfWApjIU00GO4JaQ/AiTQozIMKJFEG3qYu2+T12Wz?=
 =?us-ascii?Q?1LLcb/7w24O8/618YLdZwR83VbeiSuAwCyktJujq3AjLzwYUCvUZbZualknJ?=
 =?us-ascii?Q?F8x4jMe2Go6JRoHgp69hZtU7?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed43fc2b-c774-4140-1529-08d8dd1a64ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 01:27:49.9109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ym6Fz+7kL4k5CDh54L+TUsTi2jmRU+0jaowMGMJfCqTzZ4YaW99/xm7oYhkTK0jT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
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
Sent: Monday, March 1, 2021 11:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable BACO runpm by default on sienna ciclid and navy flounder

It works fine and was only disabled because primary GPUs don't enter runpm if there is a console bound to the fbdev due to the kmap.  This will at least allow runpm on secondary cards.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index c03e8f52dae4..fbb863c1cfcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -172,8 +172,6 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		switch (adev->asic_type) {
 		case CHIP_VEGA20:
 		case CHIP_ARCTURUS:
-		case CHIP_SIENNA_CICHLID:
-		case CHIP_NAVY_FLOUNDER:
 			/* enable runpm if runpm=1 */
 			if (amdgpu_runtime_pm > 0)
 				adev->runpm = true;
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C4de9048c03f74fd660ee08d8dccad4e8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637502111017786641%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=iby5pNctn8X%2Fl%2BDD8yna%2FyX2yeIx%2B7LbmH57Xc7Ihls%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
