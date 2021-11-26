Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EF6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 12:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71CE46EA3D;
	Fri, 26 Nov 2021 12:57:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C456EA33
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 12:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBnyN9c41YWs3JJc7tSN6hD+se9/Sfnd7bO8Bz6Fi+BaH0GAvEQHoiUXS79Ca6GGnoBDblVjWWK9TJJMdfrFaXMSTsZ1lvM3cKgUNXTVnjAX3iOnWrh5UFzjZ2yBtzQ+AVv7817i8YzUWrNPbIIo/Sf+S6OrWY8IgXuzc/z0yFDjsbegQ5RexGWer089QN6YW/JY05soKKAzBlabVnr7lNna48pNenkoWXZQe8fsZ3vYBR6XgVc1+Pf90Dvrbd74y+L9ptuw4kIXrpy8sw/x5EFZPWUqCZk7tnmpfAkk3/NY9hVUJpkUKkOYvSFoTUJ7eqnQgL3XRf0+UR2RFXuIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E0C6HIP9jefzHcYXYAqZBoh24oPfOw5o6KYRd2/MVs=;
 b=cWhtmL/kzGY5kreVnYDxF9zRZgkgCBagjlK/aPTUBRIStI2IAvZiiMd51qp3Pu+qI45lON51lfGA5QlCr4SR574DESn5GiRnOee7C49GGnZDlH2dkloPTwwi22uOfOY4U5M6G0DzqJ/3NksDJvrv7yPLNezRDYP6nTY5Vvi/suiXLsSdz/YouCkkzt3qjJoWkdrIA5pEgkp6dqub8DdUhRvEkyAEUNc6TjuU9zhxoKr/+9xCSVDFz3FAIIMqLu/x7d7RFghd5H/laEhhREviyOtawceC28WUM4258Pkv2V97farijrb5macnetvnuHdwpuNw+czmbSQXVgYUEXT9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E0C6HIP9jefzHcYXYAqZBoh24oPfOw5o6KYRd2/MVs=;
 b=A07HJDZkYseXYHUfiZs64l5vf4BU8AmnuNdwHtdSB/H/kbU82Ry7fADuR94IU5erXJeutrG3RFyuQdN+PU4IMSxfwv6H3eW0GhAjsfnfFPdVyA1xwLVTinx1hAOgSjMJb4d1hjG/uyDPw0FRufZ4BNFu9GlzC/kt76uW0D8X1CE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5276.namprd12.prod.outlook.com (2603:10b6:408:101::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Fri, 26 Nov
 2021 12:57:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.026; Fri, 26 Nov 2021
 12:57:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: fix disable ras feature failed
 when unload drvier
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: fix disable ras feature failed
 when unload drvier
Thread-Index: AQHX4qrH3hCO15BNrUuq4KP4/BrMIKwVwNSg
Date: Fri, 26 Nov 2021 12:57:03 +0000
Message-ID: <BN9PR12MB52574BFE341A838E1FDB319CFC639@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211126094826.13732-1-Stanley.Yang@amd.com>
In-Reply-To: <20211126094826.13732-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-26T12:57:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fe7f4a64-fa8e-45eb-b3be-1ee62c5d2764;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9cd5fdc-a90b-43f9-9f27-08d9b0dc3ea8
x-ms-traffictypediagnostic: BN9PR12MB5276:
x-microsoft-antispam-prvs: <BN9PR12MB52763A42876E5F190A2D81A1FC639@BN9PR12MB5276.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESrRQ4AmCIUs5lH9BD6n7ymNJ7W3iSwO21UrgjS4NLOrThjvTPKC8mc8w1PrAlDQjVkQua9DBuIcr+Fn1XUAQmQKaRw+kGhI1+kmqg9t+tnT3gjjApoDiDVOCM7d7QuMb6GkfPxwXPVTi7qWiYyJ0nUuVhn3JHxRCaXvbRX4dEqGY/+pgfbZnaJ8VPbOXxaJczZXdbgHVbnkte3y2yg1DRID0wOb/XVfFbfsD3PA0KwT7N3O8FlEKMww+WZokTtcsHI4iA4wQg64a7P6rAiPPTYoaiBEsFXUrUOhM5D88yGuOYeCSJc8U3PwiT2o2fk8tDHeQ4Nm95m2pmrBebS4jLpbuBh4GooK5D3GDh/aVAYz1UfDg6b2F7U127xjNMdxONLE0IptEJY/tBoZE9w/F5CgEOcGIzlhVMuX2mLExdzTodhG2tOE9jkucc8T2iFjgU4sD6E9TEHj+HXjUKeHyQu/QQLx9kVv020Yr6SH8LSc04+iecF4Na9Ta6o6CmIsSWGZH3ORK+5JDsYkRhr1n45R9LU95o8sDm00nrf9h3e/bSelyjfbXm08L5qJagfu/Eu1N4c/Gl2//QtCqceYlQM3viNiFAo5pd5H1KYDO/o7KEb7bf8lHiS39M9ulDaFR4bvDOa0XjLm4S/l4Pkk8Eby4td5pSFC8PMEHtemADP0mfnNP3WmDw3keheDykA8JVT7mynB2pU/dFLSl5gh/kBGm/WUW66zU9TOQlud8fQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6636002)(508600001)(83380400001)(33656002)(86362001)(8936002)(6506007)(7696005)(186003)(921005)(53546011)(110136005)(26005)(2906002)(76116006)(66476007)(316002)(5660300002)(71200400001)(38100700002)(52536014)(8676002)(9686003)(55016003)(38070700005)(122000001)(4326008)(66946007)(64756008)(66446008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lEIjENPCU/X7spUxw5L8kih0OcAbV8l4KS2OMgBq9/4UP5iQal57ElgUPCR6?=
 =?us-ascii?Q?OaBC6/sWCEHzcQeTaJZaTovbv8ugvqaJK6WNu9OG+R8zdVCS2QaPsCGENPCk?=
 =?us-ascii?Q?CUWKhLIHb8xEYCNkw0jsnVGCFjPUhFukxO9tm26uwQ9SnVu+VtR98mxqQOd6?=
 =?us-ascii?Q?CeZiGH06oaPSq/9GOKxey2/66mq+8bOAz077/BiqPFdWP1Q//L/hFyyEookW?=
 =?us-ascii?Q?1krZBkE05h81P0W3l48rsDorKG4uSJGXGZE8+HOb5XYCLeTHi1Vgww3oftLD?=
 =?us-ascii?Q?KnVVz0AT1utnShlD61tLFYgldxhzdouwIcjrlBgRTRFmsFwZJf2UapJvqjpr?=
 =?us-ascii?Q?woQZGdNWETs36S2cVfcLnscdEhos7+Q4y1qhVK704tGLMgr60lIWs7zITV1F?=
 =?us-ascii?Q?pNLYeQKDxy7RHbMANqi3EVI7lv9QAmIGv5vLX5pzVh0TbG8M88SQUQDBKkCX?=
 =?us-ascii?Q?9RTVKJ7AmkC7XB1rnVu9ntk+kU7ePykwvZMR865WR+QE60iokU/hLhzxNw22?=
 =?us-ascii?Q?u6Kd1sbEYUam4ADP133doMJQK/UCjDEX5KTldbhyE0dJUQJq7XqhrXY0JLBC?=
 =?us-ascii?Q?BD6oNrq3cJkjZuWQUduFU6b/Dc56e+KpaRZaD8PcTG82sBi4ThTXCG8ClXVx?=
 =?us-ascii?Q?l30I+x0cfcRp5CBiiC4NstIzzcNHW/We3z3CIkksJ2Shp1oxtRWFp9GFVgwO?=
 =?us-ascii?Q?0RVIJfTsYWUCLgsIPfSBL5dFyu7DccifgBugwGk+c3PeHVXanFOzATmTHv+J?=
 =?us-ascii?Q?kZnOtJBilsSgTVcpYswXuvp1BQnHYWo52x+huQ5NI9kYOjkNrWoGS+jUg+NP?=
 =?us-ascii?Q?B6FzASLPuFFJG0IWvuSYtEsZgYmqnrYo9N7vTam1BUsh5MtsxGuy+HT6WoSW?=
 =?us-ascii?Q?ABArSJ2kCkW1+WCBkIs7j6FqyjwLxeURYgWfDQJu8HgrHKYwzCcBh1V1ikwp?=
 =?us-ascii?Q?2n/YgT9bz2J7BeLI5yZ8M+UcUi75S8DT2Do1e5JZGoPzy4+xv6BGZ/FdKjRW?=
 =?us-ascii?Q?S4JuV661B/i/UH++Rs4GvX1MGuScDoMNs7xcdMtF1OWHCs+6Caq/0dwBh2MO?=
 =?us-ascii?Q?Ky52DYOcThWq4EMEHvaykjhOQBKF38InJfTqCeBEUDJe1odlDi708dvJv/8S?=
 =?us-ascii?Q?bZQfSuQdJoVYNYXZ60BVFAQlzl9mOqaxW+jyRTjL7wjieusQI/APovr0ANdb?=
 =?us-ascii?Q?WiTx/Ju35adWBvvamB75WvuQGBGZzwzuWYd9yn8FrYqx4uL9XXUMqhs/Xjmo?=
 =?us-ascii?Q?w3tQk6e7rB5qrT2IClDyTr3hsf3njE+zFoDJo4UgEHVR9rufWrZclA/EGoFY?=
 =?us-ascii?Q?I79JBCmXIiGIEvXFxzKpJ1x3bBNn3F/ikk2XUAdDEGBQbom7vTeXxyhWZTSw?=
 =?us-ascii?Q?IG41lQqiDe1zffoHzYNLhqyuXirqJXwH7iHSbSxgi8GRnSf6KHdkwnwj7Co+?=
 =?us-ascii?Q?x0GkoOB5AsoEfYXZALslXGf2b2nv9y+El6Ow8My5TfxKCxXj/2XEvqGflY0U?=
 =?us-ascii?Q?asf2GV0Jy2yoBvydFW7BwMNQsGtzrd1TUP2hBqXAvvbjN0iMJLwiPM9BXL9T?=
 =?us-ascii?Q?ZSDC8uihj67jvMm0Bg9kQL21vISKW44/v8IQcWiTH7B1YE3+JDD7PE62vkjO?=
 =?us-ascii?Q?ZNN4NkYGTkSBzHcNvFO+3uo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cd5fdc-a90b-43f9-9f27-08d9b0dc3ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 12:57:03.6573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83ijB/0ZNn30V+v+g8SdqyN5gomy+I66JZ7GJPN45kgZVxbVgWzcMG2Vfjb1HUjn4/6UvU5CcglQm+SNDwm9+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5276
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Good catch. We still need to release ras object in the end. Any reason the =
sequence was removed?

@@ -2564,9 +2563,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
=20
 	WARN(con->features, "Feature mask is not cleared");
=20
-	if (con->features)
-		amdgpu_ras_disable_all_features(adev, 1);
-
	cancel_delayed_work_sync(&con->ras_counte_delay_work);

Regards,
Hawking

-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>=20
Sent: Friday, November 26, 2021 17:48
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,=
 Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: fix disable ras feature failed when=
 unload drvier

Function amdgpu_device_fini_hw is called before amdgpu_device_fini_sw, so r=
as ta will unload before send ras disable command, ras dsiable operation mu=
st before hw fini.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 4 ----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 73ec46140d68..d5e642e90010 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2838,8 +2838,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device=
 *adev)
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
 		amdgpu_virt_release_ras_err_handler_data(adev);
=20
-	amdgpu_ras_pre_fini(adev);
-
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_remove_device(adev);
=20
@@ -3959,6 +3957,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)
=20
 	amdgpu_fbdev_fini(adev);
=20
+	/* disable ras feature must before hw fini */
+	amdgpu_ras_pre_fini(adev);
+
 	amdgpu_device_ip_fini_early(adev);
=20
 	amdgpu_irq_fini_hw(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 39dfd4d59881..65102d2a0a98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2484,7 +2484,6 @@ void amdgpu_ras_late_fini(struct amdgpu_device *adev,
 	amdgpu_ras_sysfs_remove(adev, ras_block);
 	if (ih_info->cb)
 		amdgpu_ras_interrupt_remove_handler(adev, ih_info);
-	amdgpu_ras_feature_enable(adev, ras_block, 0);
 }
=20
 /* do some init work after IP late init as dependence.
@@ -2564,9 +2563,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
=20
 	WARN(con->features, "Feature mask is not cleared");
=20
-	if (con->features)
-		amdgpu_ras_disable_all_features(adev, 1);
-
 	cancel_delayed_work_sync(&con->ras_counte_delay_work);
=20
 	amdgpu_ras_set_context(adev, NULL);
--
2.17.1
