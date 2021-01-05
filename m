Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13275C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 09:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E99F22525
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 09:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E99F22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8D5B89954;
	Tue,  5 Jan 2021 09:07:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A16C89954
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 09:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjYlVu3jHg+I4bvf663GOko50VEwnPx5mC369Av04Nxzrl20QTLs7YsY9A1MZCtWMa0NFugxh5fdgdqKLswOa6ACLdsmyz+7wc05FXnWUC3quCkjeaqszeLQHAAeVQyUaK0UJQPB1b7c0lEQYIVqi6CF+dr2X2A6BbzyLAS/Amp9k4YO/mxNDnR/CuG/SXundTI/Rp/1nEb07aF5tnr+pH2QAcArhu0K0drtVLoyIo9lXOnfIqcqlhyD/EitW4BFdl52ND+jjwAuvkWKQ/3AmRfJjiqSGwHT7EOXJFphALl/zEiOrOLHtxdC/5VcZPxg2/O4bFqZUfs9b9RaOIhz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7MnYuQVSDxM4F2hOYvb9Gimlix27V09r6tViPfcRj8=;
 b=UhiGEVHUD7s0vQCk87jM0ynVti3IauUYuD2kA3CcE0qaWEkjW82WoRwrFGVRlIQ401+/jKvn7wC83nwxiDCl0oa3DfQChNCPlEM7rPAQrGP+0tGdEz5KWzVFILcYIhdMEpK8Ep3TPK2+n9Cxmlu9IJprNSdnC7SoGDeahnZCncVhyTiVC+2fiXkE7+SiBeyDw+7sANSeBbvAoF8LsQ2VSgUn5KQx6xyOyTWR2zb30sHmvkcyer7LZxK0ojtIH5KVyBCGrpVktPMDhX7FEPBoXrGSSGKzXZOgzMd+rdZ5YxLT3bH16V62IJ71S4ZtdXM+rw811RW1VB1yjLkSgx7glQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7MnYuQVSDxM4F2hOYvb9Gimlix27V09r6tViPfcRj8=;
 b=1eBd6iz2wXcbeR4DGl9/TdinlNK33SWt9HrhzkVB9aKpa/uo0aZRSIRYvFDt8SE/XYyvvYHGj8JCppMjq4vi7XtLNqZrEngrZZvecRKVAds9RLMHx8BD452N460Aayw/HjrxyVfe6yKgSvrzvQv1JP21LbiMMWgcNfFliRzVr0I=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.21; Tue, 5 Jan 2021 09:07:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1%3]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 09:07:15 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
Thread-Topic: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
Thread-Index: AQHW4z4HPGaIoF5VfECmvtH23tY6w6oYvUUA
Date: Tue, 5 Jan 2021 09:07:15 +0000
Message-ID: <DM6PR12MB26197F38CAFE5F594633E7B7E4D10@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210105083717.468585-1-Emily.Deng@amd.com>
 <20210105083717.468585-2-Emily.Deng@amd.com>
In-Reply-To: <20210105083717.468585-2-Emily.Deng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3b0aa5a0-f583-4377-93ae-82c2435707a5;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-05T09:05:13Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf047532-9ef8-4a36-e9d4-08d8b1594c15
x-ms-traffictypediagnostic: DM5PR12MB1835:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1835319092D88DFF16EF6725E4D10@DM5PR12MB1835.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bI10JkF9ipt7SD8KLSx4vWowLbGLhBd4N5kWDjOJD+RDPbyerHZiZMfNHbZVoJKy0gBoyd8yfCWknKz4ZtVnC1j7eWM8hN2MI7pq9UBKT1uxALUdCDAIhCWA5FU6gCRvN+tj3wwJhJF/z6MnZO+mc+ckUGRjFu1FTx9fZ8d43pEuP7NSPIQOKmz2xV8ZTCsUaGsz0XIn+Gvk1+vy4cJMfqN/EDDIo7OYjiIXVr4CrdPeZCVj5sAJhWqkO+DaPguIEdrjjSYEf94/QtRjvG+iA2luyvRXQkFwzhLijgxAEfYXHhcd/ljjjRnQsHQd7/t3A0dYE+1wDBJfM46+Ekceqj2A4jL9keab8ha4FUKFrFf7uiNcKwV8O8TsQKMSeL24gn8rvubTtbAhsCvyOSQzd3FxYvQq6oD3v9GcLhyHWjE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(86362001)(7696005)(33656002)(9686003)(55016002)(8936002)(966005)(76116006)(66946007)(26005)(6506007)(66556008)(66446008)(66476007)(64756008)(4326008)(2906002)(5660300002)(45080400002)(71200400001)(110136005)(8676002)(186003)(316002)(478600001)(52536014)(83380400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bsPcjYU0BRZxbiUKxaydmAGMQYCeOQdzeBEJu0avoSkIKItpgeSIwv5M3+0C?=
 =?us-ascii?Q?bzChElxE2CxYXbfmvAWqJHKHxtcm8gupeKLgMHPBa18fQHO74IFcGqVkg4J8?=
 =?us-ascii?Q?U7geGmav5gO+4A8sAwGG51z++LOit5vu7hmoJ/A1+jrI1TCrXLSdIf7Q7pLe?=
 =?us-ascii?Q?Y3Oy95EiYHrAT42LE5H+5tPJFMLa4BgXAAUlQwm68MG1lrckXApGv5OcXPd7?=
 =?us-ascii?Q?0yG7CToPKs9ya23EIzzPFil+7w+WzQQJecvF9VTFTvkPkbP16XV+vfYrtmxm?=
 =?us-ascii?Q?9J6wl18v9Hqjpy7qtVBtGoUcao+WyDQZzL7kjFZ05ZsuwzvhGV/G107JD5s2?=
 =?us-ascii?Q?9xaJ3y+AUHLGNUMpe9oY6S+QqrJqXTVIPv+jIe3twyiMObgO369Nzq/OOH+D?=
 =?us-ascii?Q?34VnEmnkMjD3RFApj6iwYjvirWv2plMcFTm6o8yEFTmDrAmwR9l0EKdFC2wm?=
 =?us-ascii?Q?liYnVjM2HI0OBk4DmKOiqEwYmR9HziB5KFf0zXJLaeIgWmgrnYeOC/OFuAgK?=
 =?us-ascii?Q?NZT1IhogKpqjC8C7cOFfZbH2/zEHa61285fRReIbs5YFTCSsHDiIi0K7Wj5j?=
 =?us-ascii?Q?ArsI4L5iPkURAF5DnRc17chdgxi0NQYTjPOaZpCB63nXc8Q3dFOirYqKfFGt?=
 =?us-ascii?Q?PDT3gkIbBZd2JgYEF0Zen+g373tfFv2w3OEcT2SG6RKuhNG0cAElIj1iEej3?=
 =?us-ascii?Q?4gaka2f7jvXTxds05OUvs5WIk8WP5exnaiz90Nzh8E3OKRaAe8R9ipy/6wfU?=
 =?us-ascii?Q?op9bFQ45Vg2De638NN7CllfCUf6tNSfkSOL1rqlyTDY3iU0iqJI1Nr+4qdu8?=
 =?us-ascii?Q?meFDk2S1biZ1ztIDitcBwT5yujSsTlf/oVOksoa2aOENSFy6xZAhViIcRzLJ?=
 =?us-ascii?Q?XNY/Xs7nRQQ/DsFErmhz6gU5a0rGuRHgCpJkGGgRdU9sr5+3Ho3TPYw9jKvs?=
 =?us-ascii?Q?jGFeafF7zgwThZmkl/RBe6XFX79lePeYJMY+rTeq5bo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf047532-9ef8-4a36-e9d4-08d8b1594c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 09:07:15.8556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ynwCSAc5WbM0I6OMZrx9HEt3EyBwRTuFGKGI9H5iPwjfUtaXyNJEl83ik0KeHTs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1835
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

What's the issue with original implementation?
 And does other clock domains(e.g uclk) need this fix also?

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily.Deng
Sent: Tuesday, January 5, 2021 4:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 51e83123f72a..7ebf9588983f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1673,7 +1673,7 @@ static int navi10_read_sensor(struct smu_context *smu,
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_GFX_SCLK:
-ret = navi10_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
+ret = navi10_get_smu_metrics_data(smu, METRICS_AVERAGE_GFXCLK, (uint32_t *)data);
 *(uint32_t *)data *= 100;
 *size = 4;
 break;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C8f2af901fd044c0978a408d8b155289f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637454326608630462%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=mzE040qzS6j1%2Fy85pZgUE1q3Pl6LLYOIe6Z7S3zsxJw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
