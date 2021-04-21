Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC109C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 06:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA686140A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 06:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA686140A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1AC96E167;
	Wed, 21 Apr 2021 06:54:24 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680077.outbound.protection.outlook.com [40.107.68.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86CF96E167
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 06:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guw7qpE8XWJT+2WFaxTxeLy5UbEX+UyvF7JcnCgDDAn5j1xsgLzHd3lAOMdXK8VGvVzhvd1a8isdFey2bLHUxhKPz5wiHt5Sg8Ul0Xb/b2Dl8TY7JVlItNNnl9ykBrnp2cj7ci2OxUSyTQTQScFXhI+LMnNMMW+34clWmNOkZM2PuCVbVnu7cmH4Dpp/lUf43fgReEWV+cHxuOstXqd2pqS/JP7oJWT9LhnIlmHZH20le/66nlKkkzqYdVB6AbcUe/U1PcTlIEPntTp6eB4lHH9/S15nFkeRdEXY2vK9C+H/yIZE8UoZ49SSeXSULXrg9r7Bt+ai5JPIoh7fFwkkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGAsuC0jcNLutJldq3+S+Wyl8ixGSGcFhti9umnkRso=;
 b=EW+Bj2LKmOlZhXR6+ZrF3PvCrrRJLm7Zex8KsP5gB7HiMU1Sl7lgnfjgkavU9sapR5bH6fR/WOf3ElWUasz7MX0nDV3tPJBU96ZGPxyMxQ1M0YOQpAb1F1zExAU8kX3N7iF6F2HrN/F2f286ReCJdLvDvYFn8Aa28AlyZ9QTuwL9m2Am3CK1YnAphKGiLllKZu9OJnVfppOctRSzjOnz5TDJyckqSclnGXvajzQvnHnApyoEKSL0w15vVClhuLsxIuZV7ZeXVUMX/V0bRjz8E3ItsukdguBfhXy5VQHMlSIpnpITVHeQrLThmRF2ToBTRnampDKqfMXmup4sZrAj+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGAsuC0jcNLutJldq3+S+Wyl8ixGSGcFhti9umnkRso=;
 b=VuYTZwEYqd7Jf/7mP2Jrk26OZybVVTFFun/KDYXCCQVF0KrtOfm/XG1+gMuz8qnS6o54v+Y4D9wzwOuV7nDFF1jCm2vzOaUyDnENDO18KHhqk7+QQWs5iQ6f78fki1Uq5sIGnsOPY6kMaxsm7JTH57HFL13/d8spczGvLRk0/jQ=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Wed, 21 Apr
 2021 06:54:22 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::555d:5042:518f:50d6]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::555d:5042:518f:50d6%5]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 06:54:22 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: optimize gfx ras features flag
 clean
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: optimize gfx ras features flag
 clean
Thread-Index: AQHXNQCZtgVP5xxjFEWI9ZUiOZSygKq+jEiA
Date: Wed, 21 Apr 2021 06:54:21 +0000
Message-ID: <DM6PR12MB4603A380C3698E47C5CBD46CFE479@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210419094421.24049-1-Stanley.Yang@amd.com>
In-Reply-To: <20210419094421.24049-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=63b5f376-e8f1-4cfb-abed-828d25df28e2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-21T06:54:15Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e28e825b-3de7-4c29-7849-08d904924b1b
x-ms-traffictypediagnostic: DM6PR12MB2892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2892E169B8261C6C7719EAEFFE479@DM6PR12MB2892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTxT1H3WEfd6GUmRfNe8W4HhQ5ZCpqbbHZlolXQ25nXcxrBtRw2sgFYS+5kAKON4WDpQDBnOW96rH+LHX6VumwphG/MH6DL/+rcRsUTU4PH0b3aqve+gH0Iq4CoIbKxsine3jx239RQEzskmP1fydfkUkMQsfW0IJWsjSCu+3fzlJ6kJgkO1iO/zp1AbkL+AyJU3FxnAhrCKFV+8XFVI6EmThQQ73a1P3QclAdxxvmUzi1RLiiMiDpyuPRK/+KVxfm3qsbz2dvTAd3/ddaKvmcHf+k+eIJrWH1LsRXGsIgdj1X7ysFlQWxDP60RlONMQHKkjnlS8AjX6HsBidZHw63cCACwo8efgWjc0fBEJi/M2ZCGE2S+bKfVqUX5RrlIm7lbhPX/3Lsij3JI07eWY/wk47pDExn2VlZ9ySJVEs36asLp2rmjL9C3dALX5I9j/f2f0lPEwgDtn2r4d8ppdW/hRhxV8KPDSzp70Lhq/Jit1slYb6W9nGERaIX1GRhXJ1X8nVsdbb0zHG6mXBPh5QWBZIi+1bTgp2Ec7yFZm7r+jDu/px6/OP0Ox0P7PQ76jNNUz00HC13JAMVfiqmOkxI4l9fa1KKn6328pEKsotPY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(64756008)(4326008)(83380400001)(26005)(66556008)(38100700002)(55016002)(53546011)(66446008)(71200400001)(8676002)(33656002)(66476007)(86362001)(9686003)(6506007)(52536014)(8936002)(5660300002)(54906003)(110136005)(2906002)(122000001)(478600001)(7696005)(76116006)(316002)(186003)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fO7sDNYQBUb3+n0NJSdD432OOW9l73JdXe1G1WbroVlAkmJ5K91igeF0kCi1?=
 =?us-ascii?Q?CvUwdz9iEHMCLfQSRFPHQewf+r4GI2qn5aQ/JUP43TvMon29iQrl7lG6WuLR?=
 =?us-ascii?Q?qrj6j5Mhz2J/pVCaAvUhE9CpQ8VkvIZgp08p530QdyURk2IsF/HFI7x23tRt?=
 =?us-ascii?Q?RkrcOtA5WofZaYdgIk8VLItcCMxANV1HIbKwV3+1AObuBn89o95SbwKza957?=
 =?us-ascii?Q?63qKcqZuApKJbFBi87C6WfanttF62VsCwH7hcuf//RMcGHGxAazb+MXn0Z3g?=
 =?us-ascii?Q?wZaHlb2pTa0yTvwKEVGIaIC0OWgjrLKj0ljOw3kapagKfeTdaiEb+j3oQz+t?=
 =?us-ascii?Q?o+TFyomtCi+7kpSrWsOfYHbSMUzxPOrTssjrP1xiGx8JzW3danOyelUAG2Vh?=
 =?us-ascii?Q?bjJXAONnRjXKG3rd6Bq3lZOhkFneeRgZwmBI1oT0B/9XXSkS/i3ekoIcIjNY?=
 =?us-ascii?Q?w7IfIV8L0vxuxQzVRbHo75YqHQjYsa/bfLZ6wmSPxPR0cIFXfqXeNlELuyV/?=
 =?us-ascii?Q?vJocLFPGF3Iaz3OXPBGQA2Hxg9hXGFvKH1XOMcFr/OCo6kzkItcdL8KYv32n?=
 =?us-ascii?Q?riRh9zSE0dff0Yu2M4CGTLOAWq1PZkAL0O3fGfIQcB+0opBudIsddkJu1lgX?=
 =?us-ascii?Q?lYgg5fC/8VRkFjfi7Tb7fgHQGzF6oa1LO937Saf8AiWSR1pHllE8gXf0QEPH?=
 =?us-ascii?Q?Sp/TQRgrz4ksd/1uqoh3NA7PuQ4es3N3fbRNKUJVWvKqyrYBSv6Vp+DyRtx+?=
 =?us-ascii?Q?NU9/yTiXj/T8nvINQrmN6Y/90Og+Mzc1H0NWHNmeYHcKHiZaMvW3nUTzGA9n?=
 =?us-ascii?Q?dk1qbjgOhBtOVQQCt5hOI93XwBh8aBuF71hftIp9wyg/qOfb9oIJQwe9Od1b?=
 =?us-ascii?Q?ajBJq4R+eHUCAPdl2GpO6dOiu9xkZHQx5zoCaoru1/Ky1YVzjpNQUpzdT8sn?=
 =?us-ascii?Q?TLpAdWWBnE+ALdmm8lpgb170DVUHs/daUAvib360GtzFJ8tWA6xZQof/ZHzo?=
 =?us-ascii?Q?8CSerfBweTJKzYxwK+CWi+ldbUhHAAmAuoUWyaKWQ2/2DgZyuvvQO1EP/x4f?=
 =?us-ascii?Q?+SWEY+oXn+itYiiPUcQpGd0yxHPy9acYkbyAcfM7qE77soL/vZ9ICDPXBiZw?=
 =?us-ascii?Q?qhNn7pp33KOMC6D3v1TQSfA8XBHVdS5wlJCyI3MF4lTYlsBmNGdgCy/FLwAt?=
 =?us-ascii?Q?kJxLFr3NAo7j+8sg7q/otgPL/jZv3CmkWU5DA04sEIBbNBM8EkNKSRhwJ/rL?=
 =?us-ascii?Q?YjQx+Ii763lu++iZ3Lcc5d5rsG+rG0aMtTvC9tLsVfaRmXInfR71gh4YrTpg?=
 =?us-ascii?Q?TGyzCW0RNKpAJ7OEpKyN+LlV?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28e825b-3de7-4c29-7849-08d904924b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 06:54:21.7985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hheRwOgkmx0CFaWOn6Lt7pJ5fUpb3YkGXhk0KokLqIeF91iBgH+iMEBPQ8p9L2Eb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>, "Clements,
 John" <John.Clements@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>
Sent: Monday, April 19, 2021 5:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: optimize gfx ras features flag clean

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ec3ebc33ee03..8fdf355d7de8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -657,11 +657,7 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 con->features |= BIT(head->block);
 } else {
 if (obj && amdgpu_ras_is_feature_enabled(adev, head)) {
-/* skip clean gfx ras context feature for VEGA20 Gaming.
- * will clean later
- */
-if (!(!adev->ras_features && con->features & BIT(AMDGPU_RAS_BLOCK__GFX)))
-con->features &= ~BIT(head->block);
+con->features &= ~BIT(head->block);
 put_obj(obj);
 }
 }
@@ -769,6 +765,10 @@ int amdgpu_ras_feature_enable_on_boot(struct amdgpu_device *adev,
 con->features |= BIT(head->block);

 ret = amdgpu_ras_feature_enable(adev, head, 0);
+
+/* clean gfx block ras features flag */
+if (adev->ras_features && head->block == AMDGPU_RAS_BLOCK__GFX)
+con->features &= ~BIT(head->block);
 }
 } else
 ret = amdgpu_ras_feature_enable(adev, head, enable);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
