Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70A7C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 02:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168A823E51
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 02:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168A823E51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BEAF6E822;
	Fri, 11 Dec 2020 02:20:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E8A6E822
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 02:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCb9SzvQBrpq14A8sOAXYe2EUGh8gmcN/9WkPFK62ZZj7wrFi6OdmHDzWordYeFKrbmAOhBsJZn4ETUwZHHtkzRwr0On44NcRARcLfpHI73YoSmyxZh7pwHiBbdH9oUqfqrP0taH6z/b4vikxYlTHyeRC9vsgGhznMs+jF3+8DUW9mORwa2kC6YCEUO3BzrcW2dS0zobnegJ2kDfNRgSb3oRaxSm+UhSgikDOKNtP4chD72DeW3cRVu7UkfDH1vSHcICNyFY1IErlhqBgIBUV1cjW0iZw2o/k40dy0NK0z0wvttc0wihNFyn2NAkjtz+XM+oYZXF/YpESqwQXjWSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptWChr3l1oMQaIBZtZRup5Ei2hXQ7B/ml2UhyO1Un3w=;
 b=BWeXK++DNFGOv/uY+XvHSzBHwxGi2TGt0+NHvTMpHzePX6dw5n/3mH2nJm4vE+xMvwnuNQ2S8+cJy5dAlvVh0erNNEoZYTL4hNRVBxPDACXrGKNzBeE0WEELDH8oCUDvFbNsRkW2JXrYH2a0vUss9+IXe6zW3wnKFuaJMfvlFAvFfbvHREl2MWTOHhCdmYmBtZwf2MFV2uEnLsSndfo9Nml9iGTjqHSOLPlOvanX6cpTgw1RLF0Pyndk+4O/5G5CfPZY116XcbfeDP1XlGUDf4JrbW1R8nuP7BW7y+ccSdo0ifcQ8usNC/tifJeMqCcAxyHoykCPLxXWkAUsCpVgRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptWChr3l1oMQaIBZtZRup5Ei2hXQ7B/ml2UhyO1Un3w=;
 b=X41uYGCfAyan3htDTrhZSBtKX1G2y21l4wMgUHQjvGsL1pigUzzqetzWdJJ5ACEYGGYV96sTjrfVu7oTbMaG407vxixn7qw7Lk4EyC+t26qBxqBzdggbYM18Hv80qvcYrOXxZGRpRyimX8+Th2uhgmqFFsos3Zwe8YK1y1GgeoA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0025.namprd12.prod.outlook.com (2603:10b6:4:53::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Fri, 11 Dec 2020 02:20:39 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Fri, 11 Dec 2020
 02:20:39 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/7] drm/amdgpu: print what method we are using for
 runtime pm
Thread-Topic: [PATCH 7/7] drm/amdgpu: print what method we are using for
 runtime pm
Thread-Index: AQHWzz3RG2HE0AVM80K06EIPEvztA6nxKc5w
Date: Fri, 11 Dec 2020 02:20:39 +0000
Message-ID: <DM6PR12MB2619DF7ABFE97224305D0CD6E4CA0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201210214518.704305-1-alexander.deucher@amd.com>
 <20201210214518.704305-7-alexander.deucher@amd.com>
In-Reply-To: <20201210214518.704305-7-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=415808a2-5724-456a-b65f-89b85a16ef93;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-11T02:20:09Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f19e67a-2741-4a3d-023e-08d89d7b5a27
x-ms-traffictypediagnostic: DM5PR1201MB0025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB002564141F5916CB823DB961E4CA0@DM5PR1201MB0025.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:356;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 07JdQpwU14KDimP6yHxbdmiMtDf21cj4L9RrSIRfLeeeRTfa/aGYw42wyHNuao8mNm6NxQD4lChZ0n2OjMIDFoqohY/CPUuadmwKcMMOfxH41CWhwugygNWBXSHJL9njxLE8G1ku1iPjaJ+vP5ESPWXs9xoRrBklzsDq5KtW+KQx5hEifxI56xSmw2lavo/0VWvj4W+Tr5/YzQhjgKuOII8OICxEfa3pnHpPqFcpzsB1aPDMNLqoCzuOqUvP9BvzqrBJZtYdCTGA5KDEm6lgCaJb5hJlND/Dy4DUwUTOAKz8BMY614dqe7sqzdAa33/a3JU0n9dutr5flCQuUrlEVumZy33Ius/R/CZGDjV+tKY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(55016002)(110136005)(66556008)(66446008)(66476007)(64756008)(33656002)(76116006)(66946007)(26005)(6506007)(53546011)(2906002)(7696005)(186003)(83380400001)(52536014)(4326008)(508600001)(8936002)(8676002)(86362001)(9686003)(71200400001)(45080400002)(966005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XnPc1gLmfJRaj+ZIIwygUj9EPt1Xx+Zm9DzRbTWl2HeC7EwwZZk/nFihfRVo?=
 =?us-ascii?Q?mobBk7vr+zQGeMLA770SNbC2fZz51RXuAET3ZD8V1zPFVLUPl+AYQdpCD05f?=
 =?us-ascii?Q?PPoaN6gvrL2kiVbdfwekZeySOl6ZhygoSdINJ7bm5tmyxALLRiyIaDBCotNN?=
 =?us-ascii?Q?flxZwA5SIeDdq5BiK/23x1R2FB3zk7medYKBG6Hav08GbhHsOJ2lEvVstwHn?=
 =?us-ascii?Q?uVUF/h/NjeWZRHlG2NpkScLvYl9aLbo1T47KqDu1kS58s9/YX8v7uLgjxPgO?=
 =?us-ascii?Q?aDYQQ7TpvUdomteh8ft/AvA0bT3LDkBi1Kt7JqJ3d8WP/5QJ2IYubw0q40vD?=
 =?us-ascii?Q?+oumcoIBuyouHTXEIm4TfUesHplxezPSpkJqQz8VFZ4QfLY55OBGlm5FRkbN?=
 =?us-ascii?Q?/MA6lOCbvO4J9SBu7Xu9Dg6gTtSdvFNIOLKd4ByH7eCBcZKS4bnygqqspo/h?=
 =?us-ascii?Q?o8CgwoNp4D/z5YLS4Jc2I1+DjmCNq0wiEl2ZfdrjLxjhZWLlXZ8vMQlaqV6u?=
 =?us-ascii?Q?rSUYEeaQE32xyhu690P848oiIEQfg/chuc8KOh0bFj3rx29RHJbxg1PUfqFe?=
 =?us-ascii?Q?q+hC1HqvVmE2CSK/jwD7CUziUgP5NTZUr0v8kn9J9rfn46fZpG3UWdGFPWdH?=
 =?us-ascii?Q?aEjD8XfpTh70kv4RWwzcss/ndH5BK6i+6Pmelkw3lNZtsTFFoH1q06OChGht?=
 =?us-ascii?Q?XDHLqGDzgGmWYuNGl0r18XQJbYDCeijSiHDjMYkGQfsF8A8G26OWXTmhiZ6F?=
 =?us-ascii?Q?IH+G1ZfJdE/bYbbjEoudCA9QxUo9m6s7oW244wr9b8yOzJQADpqwfca72eSF?=
 =?us-ascii?Q?OOk4uQlh3CvwO9Yg67ophpA7YBWVmFmvWOh9d8JvujyTa2r2uAec2QVBeYdY?=
 =?us-ascii?Q?yf1EBAOR0HaOY1qKl6/4RqYWw9Mk892AHbw6jYPMlI/D8ekC0ubJWN+d3XBo?=
 =?us-ascii?Q?KTxo11Xl4Gr37GS9xsEtP8Q/R6B5Wal8GmwiCAa5sfk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f19e67a-2741-4a3d-023e-08d89d7b5a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 02:20:39.1119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0Du4nPsQGPq9EgHI4wjGZNVO+HxmyCKAEbT/FH/tInu2eb0cWE0kncpKcpmqVNK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
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

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, December 11, 2020 5:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: print what method we are using for runtime pm

So we know when it's enabled and what method we are using.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index af049041ea3f..b16b32797624 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -163,9 +163,11 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 if (amdgpu_device_supports_atpx(dev) &&
     (amdgpu_runtime_pm != 0)) { /* enable runpm by default for atpx */
 adev->runpm = true;
+dev_info(adev->dev, "Using ATPX for runtime pm\n");
 } else if (amdgpu_device_supports_boco(dev) &&
    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
 adev->runpm = true;
+dev_info(adev->dev, "Using BOCO for runtime pm\n");
 } else if (amdgpu_device_supports_baco(dev) &&
    (amdgpu_runtime_pm != 0)) {
 switch (adev->asic_type) {
@@ -187,6 +189,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 adev->runpm = true;
 break;
 }
+if (adev->runpm)
+dev_info(adev->dev, "Using BACO for runtime pm\n");
 }

 /* Call ACPI methods: require modeset init
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cefb94cd5b4444ecee0d208d89d54f281%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637432335462088875%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=qXcWeg5ccsPXl6lZrL9YYaQF2GyvrzjyWuvDGBbX%2BMs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
