Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62943C4743D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBCB610F8
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBCB610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C45986EE39;
	Fri, 11 Jun 2021 07:23:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B6B26E7D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6DW800hHmC1BHUGm/LpYoIVt48/IAXPDLvfoMt8EkvW/hnKjpQiu0X+5zGDpFmE8sz+nXVafE8oM3AHEVVFFdVlZefdqfXL6Pq+x5gCYDLljlMWmZwkfR6OIgXSZkQAu1AgWoO+RCwL/zaqXWZZqSBhRJRGiakkeufJ75E7jbzNCa5a8YPsR0T8NfiZxeo7FvBZmoB0P85yQ7CUycLhwplYrZpsGVrvN12mrUiQOOyue3mx+S5piVtE9HCOrmkaEdwwFu/ZcEg6CrbCUa3u/oUoyQAhEbndfE1LYF21ADD/lXuVgqJqGARX7UgSR/mcQFtW98Ix5vb0dPFdJhIbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZVLfuuR9u+oXSGvvzlM/3w5ldatwQBwHhwF8wzthIM=;
 b=N0xkyz+W9WgtN9sDBxSqtviNEs/ZhanpoOd7bekp+5xyGdtJiwvP3111PQwVOKn3f9jFWzoOxj2uHADqmi394CJufOvWKNGaG8/3n1CUMSdXxFtjAqiYE+ERof18g9IopDqUbmP68iHZJg/TQGntrCXu2jvRAFbifokQrAztDP//C37oDKvhUoaLTaP9hVoyPwA38ReQTHQNhSTSehmIif7usvu+C54ZGNykQNhj36k31XQaWgI4s4TO/jiJfRcrRG1fM28qfXToqmfTA4AjSrqJgzNc99quAd+0WVHDpAI8KWvg2RzPRGBf6OpzwtYgZMt/ed75kd4NcB+i9EqNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZVLfuuR9u+oXSGvvzlM/3w5ldatwQBwHhwF8wzthIM=;
 b=fX5UXeHBA5IRhhnClyG/kjkTH/WRNoikET5r5Kaet/Yq1GSZs8w7NKQ26NiYLgaOE3vTP8/ktOAJzMNxHksZ4mcbdF6x5xc67NAzv+usNbwbX4iGpDJDRGIfuqxL9Bqa7lzIiqhBKVe9jdQo3bOz41OnXRyMaDyaLoHUtpufaWo=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 07:23:33 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::e8d9:df11:13d:7d9b]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::e8d9:df11:13d:7d9b%7]) with mapi id 15.20.4219.022; Fri, 11 Jun 2021
 07:23:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable support error injection broadcast to
 all instances
Thread-Topic: [PATCH] drm/amdgpu: enable support error injection broadcast to
 all instances
Thread-Index: AQHXXpGrsD+bBiYXqUyvzArCNOhT8qsOaBww
Date: Fri, 11 Jun 2021 07:23:32 +0000
Message-ID: <BN9PR12MB53689DC1B38B9CCAFF9D8021FC349@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210611071557.12344-1-Dennis.Li@amd.com>
In-Reply-To: <20210611071557.12344-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-11T07:23:30Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5d414baf-835d-449a-8bd3-35629589ea40;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb20c6f7-d336-4995-4e93-08d92ca9d1dd
x-ms-traffictypediagnostic: BN9PR12MB5244:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5244DC2B8BEF34545E760BC7FC349@BN9PR12MB5244.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9kSs8v2UXqTXNMgjSZF/R3/89xcvUZPJgM7XtZqo9NoVyxzD4WYaJOnDfphfrWw5Cb/QW/EwJ0H+dSeTY09qp/ZTn9o1eA473+Ot9iuuHjtRtfxf+ve3Ha6k9vkO8iJ57AE8aJR9B463clKGxBnDKignii0Y8D66jCk9PQ4Kh0flV+VlPur+SJkoXYJcNpxytuxSUyfhcb7U5TxZ4I/vc+N+y/TDqrOpoby5OJW3+p+0exbwzYq2iP994DP3KHrwWMP9Ya811rBIsiLSRgVQvaOCd2fxG61xa2i4sfK4Wy4O5vG14uCCaua0R+0+TKm8XEpaZXONNfz8PoPH/pRx4VKaYLWbhVHpYd+BXvH6gJJgreRp4nudVb949dxXxttsUJylB7DBIb4gQeDHCfFAH/wwRwLqbOolXkH+XA6R4AcjiWOvGN1gUEAlRMP7LwK6kU5ZMLWlvAb6hV7MmsHaKZq5H4M1E1UrDGdf0BjSpWVHuMh+eeJdfpyBVW7o8ZfupZeBIB0PH+TfNCLucWbYt/R8KW15bUupkFOPnAHvTXKMG9pfe6drFuvL7n32DE/1F5jwpDJtZU3xz1jBC+qcrOWZ4vbS6FSgfQFVRWDyfqE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(66446008)(55016002)(9686003)(66556008)(64756008)(2906002)(186003)(66946007)(6506007)(4326008)(53546011)(5660300002)(38100700002)(66476007)(71200400001)(26005)(33656002)(7696005)(6636002)(8936002)(86362001)(83380400001)(316002)(478600001)(52536014)(122000001)(110136005)(76116006)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/avWj/HXnGrTj7Zgv20aBfBlw7RxYzK3UIrQUSFREsO0RDMFWoCyKLwfquY6?=
 =?us-ascii?Q?d1y8AlqnaPijXR9OW2eapDqNTHqOs0k61nuh3mmsVKPWWprP2t+n5hxKer3f?=
 =?us-ascii?Q?W4Y+nNaozNsFU6wIg4ot6mwl1x1sM2NgRYbL/URYuNWsO0l6Htg872rfVK0l?=
 =?us-ascii?Q?60IthoUZSQqDbv6GSED0g010pFikbCQ8bk25HtrXEc7+O0zbqwJso6Ux5UIT?=
 =?us-ascii?Q?B3moPJJ82TWBoR1t7fIgsIFteTr8i4iX+d6E7EQgYBs7XCH1Lnukmczyipb9?=
 =?us-ascii?Q?fS22hoLC+08/5iNJRdmGJwMOFBWXt3j/olhE285AjnXf6fMfoWLP1etRoRwr?=
 =?us-ascii?Q?xpjOh2MCZDCm9Opsqhx5AqV18lcJK6ayLr5GVqr+S6VgEPBhxU/gI6efo/dq?=
 =?us-ascii?Q?3wXa9sg7LR55VvR7ji8xt+WpIHkTvsBtGMQ5LiqiMxQjuz9VsX6h76vZvHGd?=
 =?us-ascii?Q?knSQlZAsM7M361PWyoKcIcXktx82LCmy53NX/Obwipl6HHggdxY9hxsUBLZr?=
 =?us-ascii?Q?pQOgUY52dNVPoSLnzNC1nTEdlA+DQ3fTIvyArH00hN+9TVSKOYjx/00Tli8p?=
 =?us-ascii?Q?MPdc8BzoCCyA2kJN9RWXP9XtjXwovCLAUeof/o73nSK0pPC6SfluQEtwHN7K?=
 =?us-ascii?Q?JUSB4/lrTjC1IEL0vHUloiBmhcr3cGt2wkqhcNcRXGanLtGCf4AruIbFmz15?=
 =?us-ascii?Q?ym4eIxG5qcq5Uy4+hpyB40O78xdtejl9TYkR0DeoPx6YmJ/Z0SYQ93Bh5z6k?=
 =?us-ascii?Q?oc2rQg0Umcoy2qoelJrlW4tgX+D1/z+efD638kcwBT5lm5PNiFM87HH781pa?=
 =?us-ascii?Q?8w+vUcKVrn6SqGfO8QrUk8QRHoNEXlrvBJ7GSIsZOGdQ7e2UHCTFSOohhODa?=
 =?us-ascii?Q?Tz0wWPdltLk7ovSkSGcBBgbG9I5c9ZrlbR02IqaRyTBbm9zsdLmKGUxT5PV1?=
 =?us-ascii?Q?ERe5SknIHeRc7ACoMx9/Ne/5eEDI1AbWKxd6zeOmn3CPVHK8kM+5fH2UNfGN?=
 =?us-ascii?Q?A4B0KZFD4+rmD3grMcjQaexBSTygETmGn7noeAZe3E/8h6AVTXOEIDeIDu/d?=
 =?us-ascii?Q?8Xz2BCLF9ONbw7luFUmoYsmns1CsPjTKQTpW3lcmP8wonTQen/25PXiW6U0Q?=
 =?us-ascii?Q?P3iKbANB6WDt8Suq93i7a3AiRAy4hGekGY+FqZl948vxPJ3U8W8CDGdop1a1?=
 =?us-ascii?Q?xD7og+qvpN2dZlFrOYEJ4X3vys7ejwkD3ogkTyFqJfnKE+9nsGCeSzeF7b1q?=
 =?us-ascii?Q?5P7GuN8K5mBwqepvI6JWF1ZVWR9vvrYMaO2zk2d9zYVVjfUHz2SDQnPlzdzN?=
 =?us-ascii?Q?msZ+QnfN8/ylRNzvMpeAfnt+?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb20c6f7-d336-4995-4e93-08d92ca9d1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 07:23:32.8476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+6YYsK0QJma2Fe/2PXVQrYM+/blo8wSqOHVADMeAdzD3Af+WuT3WM8mL1M4lmocQRYxvXkyfLhGNFJ4JUi8HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Friday, June 11, 2021 15:16
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: enable support error injection broadcast to all instances

when the address is -1, TA will do error injection for all instances of the specail sram.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 885a78301bbf..c828ce9525d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -402,8 +402,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 		ret = amdgpu_ras_feature_enable(adev, &data.head, 1);
 		break;
 	case 2:
-		if ((data.inject.address >= adev->gmc.mc_vram_size) ||
-		    (data.inject.address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
+		if ((data.inject.address != (uint64_t)-1) &&
+			((data.inject.address >= adev->gmc.mc_vram_size) ||
+		    (data.inject.address >= RAS_UMC_INJECT_ADDR_LIMIT))) {
 			dev_warn(adev->dev, "RAS WARN: input address "
 					"0x%llx is invalid.",
 					data.inject.address);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
