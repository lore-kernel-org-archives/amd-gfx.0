Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3EBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 09:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EBC10E1B8;
	Mon,  6 Jun 2022 09:23:43 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C4AD10E1DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 09:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXMjviVg7oAgVccLOQBgZTCuiYWAxnIwdsJ/sBMcjz4+3+iI4pREMkT6Mzl/hW3HNFzJruxU/lzYuBxZicVoGul2akpygwpaCJ709uvBp/5rrJAlT/xVZvdsW1Gn7J2l5w214wtSY4d66I10Gbt+Y3/WfkWpZrf9mcAmTjBylJ0vIxFcbj4a6Quvl8A25yGneJQKcuno9vMCFB+9+5ypUkl82YmJ8Ti4e/Tl+sjlj174CyJSxrFm5wj00874M9IeVWfmzUVlcDQU7Iio7bpFTsXc1F51xQWOjHABvFQPJg59GcTKM1+VLV5jncxuIXDMh2u7oS3KKG8UrB2sRvjPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVyqBUraoRRl1qYRz3Q2psUfLCxuNVzGAzKlXUQY5Ho=;
 b=GhSkWsAmEwKW+/wRRoEKdJE/8ebuznP6ViGC1YdHU3e5SBwSXvLN8yT+lKBRmrOvb0c5lBGKuGm9+cYgfEdpmWutGMNlnAJmNDudQFkt4a7f36WShptSQk+A456I4hu3ctmro+4wzmTmsbslEKAK2IZXfCNR4i63fWTeuWDy7QgRR5bT0X5gCVh1FzfZiucjHIHVLZiEzI9GASU87ddfuqBzQz2sGLG1fEoNhfQwM6kwueL8MM0u8wClXOBGoRocDShNOTXY5Yy/uMaVdyR3COz7ENJ3UIRxOVrldhxPwMzQLXvHG5bMvzZcy14S7cjsJ+PVwMd9TjhZiz0zxKg6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVyqBUraoRRl1qYRz3Q2psUfLCxuNVzGAzKlXUQY5Ho=;
 b=rLNz39//eDOm2aL27MgP5hNtyh+XqUqeq1vM9ZMA3wuMnuHk1zLLk9vr0KFFsho+qbh9Joggd8tzSt/xwHBkiavAJQfF84SYiL6b2nqf93ZknwEGErjBweNhobKGEzC+4VTln+Id/aubuGSEK11WGSHoWxUHQ9ZvTwH6FGssIhQ=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by BYAPR12MB2790.namprd12.prod.outlook.com (2603:10b6:a03:69::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Mon, 6 Jun
 2022 09:23:36 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::c78:3525:6eff:5e62]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::c78:3525:6eff:5e62%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:23:36 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v13.0.4
Thread-Topic: [PATCH] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v13.0.4
Thread-Index: AQHYcSonkiN8E77Kr0qz3+I+9larDq1CKlEg
Date: Mon, 6 Jun 2022 09:23:36 +0000
Message-ID: <BY5PR12MB387324D1F63D505D7FFE8161F6A29@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20220526175747.3044318-1-alexander.deucher@amd.com>
In-Reply-To: <20220526175747.3044318-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2d1c4259-b276-4112-accc-e5c6d642ab60;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-06T09:18:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 615b5713-01f7-4358-3df3-08da479e3c02
x-ms-traffictypediagnostic: BYAPR12MB2790:EE_
x-microsoft-antispam-prvs: <BYAPR12MB2790BD374BE98F94B66AC88AF6A29@BYAPR12MB2790.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yoDnjcb0Wj57VusPN/KGuBrn5OcOPtF2eRGQ7TXGXnMMmIWlxJDVxfOM+WTin4HkTeUeU06fMI4PZQLlZn34XAW/MHZfzD0TBhQ6QteR05B7YDYoRg5DIy5e3F70M7PnmklGFo8gZyezZjqc1T8MV++mYdJlhMOUdTqJy/Io5iVXElWGgYg9l7+45ZdG0MYqJFN1tbd67giGc5sS7KF3q91y7alSbKPBS7x4Y0AB4i9FDmvKq2bVzgNYcWoAIJihw8vYAMSQwPgE6wb6OYZdKvC6p+Z//2g8/p6/FSn8GW2CP+N6nf8sOMrQT3Fidj4OJxfbgwL8zoqcwKx2pY2CVUSScCiV8jmgzGIrVIdTr0za+T2i3wEhU3KV+nTchxXro72h9TrCd+mcv+bSWHNvhejgsmkQfE4ViWk0UzOTQ4/6L0nLEq+CbYeePsuMsSugDu4udEN0d5FzPVQq9+/KwYqlpf1PuZr+xa2WHhdw5dU4Pc3yZ8998qHhKFux8beGkAsWPcWirN4JGflyXuTnfvbkXa7iPczIQGh1iaY3Cgh6STTPn2ppRk8Yofdo6NJ8UVqUTTJ25I1gW4W0oHj4LDnqQ72hdbvBzBfQ0v6zg07cOxSJo91SBZTJvZyEZe5hNGJkFDU3f8xVWn5u5CAvLskhCSVpO23jqukxNUSB4+M+tCDkIzkX04mOvqmZh2QCmWxq7nJJTE8aUN+o6LNDqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(6506007)(86362001)(52536014)(33656002)(8936002)(38070700005)(122000001)(71200400001)(38100700002)(508600001)(4326008)(5660300002)(8676002)(66446008)(76116006)(66476007)(66946007)(66556008)(64756008)(2906002)(110136005)(55016003)(26005)(316002)(186003)(9686003)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ujf4m9jiR+8HfxlKsYiZEHrdwxbvAQyPjDVTiE17leDC3WV+wkZV6WbSrRO?=
 =?us-ascii?Q?6gS0GTKo0qTdrqPzV3CDZKOhePZ97b6oNN5LRVrPuft/p3SUPimHgGZ083hO?=
 =?us-ascii?Q?K91ox7UFV24/VHisX72gzbg9jJ6F8yn9Zk5cceb133N7Nh8tEiIyHmqtSldL?=
 =?us-ascii?Q?xtRmcw2eZvBs+dXfeuJL5Uq7Rmm54JVoAInsnLWp8Y7kr10cq+/nQNfG8qYm?=
 =?us-ascii?Q?Gx8ld9CCmifz/YcAk7ozx8oK09Oe36ayLSKsprixB2VuDP6P4tRi5BiJgtr4?=
 =?us-ascii?Q?pAsz0vSPBtn3qU3mHwt5xKsRx/6h1oOTqURSA1MTh2H+KwJShj7AyiBkXNHm?=
 =?us-ascii?Q?GpvhlXOnChKMYYpIbZz7wNt3FJkC2xYYVWDJ+VB04TfzIZhv8DgXWJWArcYC?=
 =?us-ascii?Q?/1XlPmOcWXlvXxcNy9kN2xA8MAHb9EExe/P2rpuZVYfkt4OByJ4+/Ko+Fb0O?=
 =?us-ascii?Q?/diW29jVvK8Ei9hxMVdHqFDTdAwcpoMh+QnHuYWQUpUIRzWVFwKOM6azZ98w?=
 =?us-ascii?Q?vAx7fdMASLGectC8PqwQEzWztO7+zur8HKfFpt+2q5FFVxGnFm/frn5+V6zH?=
 =?us-ascii?Q?8gmXLeWUycxOguowEGiyr2ihX2P2iN9lScAltAQFwPetbx2viPWV5AwK1CnV?=
 =?us-ascii?Q?R/PCSBFbYzZg/JnZIRWymYK35hG+phcr8iTGNhbLFutV7e4EHd32QYY2O5um?=
 =?us-ascii?Q?cXk+V9NEd5uuw1319vygHcIgqd/961ZbePXGg8lfAt1tqam2oGw5slXFkv/E?=
 =?us-ascii?Q?MD9IkQDyMPIjllouuLF7Is4DPJwko1sq4kxNXWCY4bMnYJMNV/ZP6uTSw/CF?=
 =?us-ascii?Q?xC8OF9KcqnYjflgOLSmBDWA7sN8jreaTj17UH8sqR98wFXD2jkzH4i++yUNg?=
 =?us-ascii?Q?4CKR+pPZU4g9HIfVeMzQFyPq7ZfSMD+0SjnDNwes8ZF/ChSrJae/ZR7O17OY?=
 =?us-ascii?Q?CY/R8I5SXNoJaq/hkLItZVJkIE78CtIWKTKI0OR9rabg6FoBlR+6Ke885vSa?=
 =?us-ascii?Q?556/hFs+FYlyL7GI8yWEl0C0Hft0wQgmci8HajJLMYH4Bw9HR33gRTkf2f02?=
 =?us-ascii?Q?VWcOBqunhz6VYxNhdRdh8u21LGXa6LlHp9L/GHk1WF4zHk+/vRjLLDqLvJXJ?=
 =?us-ascii?Q?x0++Z9mqudLi1JhqsS8TG8JO0l/uKYwX3oX/BNERBGK9Si277JZy21kuGNjR?=
 =?us-ascii?Q?AWiGFIookNTyYr5WNv+3arATTAWO9KMN9tUm0FXHT9ia6COPEcTKN9HlH0UZ?=
 =?us-ascii?Q?AR9FpTjhCrA1/DQBSj9Ee9txDHpmbAY9VIUb3K6Cl1fQVzZ/gAxBmM49/Yaw?=
 =?us-ascii?Q?C2SErKrJsWzqzH+xojr0iYP6bm1Lu/oblToyIi7vWKyhksIYA+T2MSYoFMpP?=
 =?us-ascii?Q?/T/QUnFgDhSMzSBknawT0tuOy0XiRnPR+5t2nC6Hd3Ur6STtRmEVHuPNodMu?=
 =?us-ascii?Q?JbQuHh3MXkmC8sL3G2KnvpjB1bXwkoSAr67OiKZMPgkFMM3Q79BMde2UH2mK?=
 =?us-ascii?Q?Vve4Z+vKANZYJRnYiqXrmj7EPE+ZSsismVM1Mh7x9ffzHsxPAqdkqfJTG3r7?=
 =?us-ascii?Q?2X8sXCeDvXlqzUxUT9720zei0QQ/iSS4LAlyJl/w/zBFPh3RORizAJhKDcwA?=
 =?us-ascii?Q?Rlc9/WjvlXFlpHhf6/9cxiZHxoizbpxEyxILCPBcRBJyDnuHJxBVchrMN0Eg?=
 =?us-ascii?Q?ElzlnGxR9XdULr/EjKJ0BC/xcMkprf29ryzMoqAmSwmASWSVulGZSiSQpqjL?=
 =?us-ascii?Q?yH74M0EezA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615b5713-01f7-4358-3df3-08da479e3c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 09:23:36.3062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtYDXDc362LlJ/AVmvHpPK5O5C93vYIxIMhdT0opub9auezp1oPlLb+1nnlMx3u08+o2hd73RdnIe6KFkPh+9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2790
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, May 27, 2022 1:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim <Tim.Huang@a=
md.com>
Subject: [PATCH] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v13.0.4

Set the default reset method to mode2 for SMU IP v13.0.4

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 9e18a2b22607..a400f5273343 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -310,6 +310,7 @@ static enum amd_reset_method  soc21_asic_reset_method(s=
truct amdgpu_device *adev)  {
        if (amdgpu_reset_method =3D=3D AMD_RESET_METHOD_MODE1 ||
+           amdgpu_reset_method =3D=3D AMD_RESET_METHOD_MODE2 ||
            amdgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO)
                return amdgpu_reset_method;

@@ -320,6 +321,8 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
        switch (adev->ip_versions[MP1_HWIP][0]) {
        case IP_VERSION(13, 0, 0):
                return AMD_RESET_METHOD_MODE1;
+       case IP_VERSION(13, 0, 4):
+               return AMD_RESET_METHOD_MODE2;
        default:
                if (amdgpu_dpm_is_baco_supported(adev))
                        return AMD_RESET_METHOD_BACO;
@@ -341,6 +344,10 @@ static int soc21_asic_reset(struct amdgpu_device *adev=
)
                dev_info(adev->dev, "BACO reset\n");
                ret =3D amdgpu_dpm_baco_reset(adev);
                break;
+       case AMD_RESET_METHOD_MODE2:
+               dev_info(adev->dev, "MODE2 reset\n");
+               ret =3D amdgpu_dpm_mode2_reset(adev);
+               break;
        default:
                dev_info(adev->dev, "MODE1 reset\n");
                ret =3D amdgpu_device_mode1_reset(adev);
--
2.35.3

