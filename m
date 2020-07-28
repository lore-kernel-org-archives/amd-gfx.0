Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE46C433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 08:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1602250E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 08:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WJOW5M/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1602250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D6D189906;
	Tue, 28 Jul 2020 08:00:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE5989906
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 08:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XV1KK0BMOu0XJKnTEhC/pdgXuQhyCaiy2J5gVjeRK0yOZfRIR84Q2oXrzghDz/jl7EvGAawKEGDAoFl0CFUYBtlXhoHr3CSzz5gBo7hb9qtT+jytJ9X1n1HFpgIjEqTXcni0QR9i6Qkl1rrfSkqUfySMRYyL1fC8ZXyICLj9NdL0YYMJSSD2FhweOv98hzvJSA9x2f4zEsFkzKYxGoLK9KKAMjh3U6TEOVp9i7yKs2TPElT3+k3ageX8j2JjekH3vGOCWNT5KKH+1xoxHexNac9z70QIiei113+KAa/aFKOrl3rUbD8oyBpSyJVRuZPnoCcpatqVA75cW+UHRJ8M5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxqShxQpnCehDLimx5ZEMjMB6ff3XJTDGJ36NWyWT8Q=;
 b=RH3+tPH/wUS8yYLCqhtkorRM0UAfDCn2/SYNiFllSTr8u+fji3NAKBLIiNdb0P0QhOzE//QzKwu5NsbcqzbPUPvwdfwv/Q14Hgiyds3myhEFVY2+1PnbqKp+RJ7PXszcZta9JxzSVwosy7pHPjMPvczvZLQZdzmVVHCoDuQP6BNCi2q17ON/Miw4DCe3uhBvu5k8JV/EZcsfuWhnYzDp1cD1AAHtuTL2YI+HPAAIt64nQZPpWPg81qlAUdcLMYx+cErfzoVpQQF4LM3E9fWLeZTyZf5oLziOnyO6rLaLAnIwespqIk5OHtXOYa79kNzeNFQNcz+acpCV2XXILghkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxqShxQpnCehDLimx5ZEMjMB6ff3XJTDGJ36NWyWT8Q=;
 b=WJOW5M/uEinVjs15cchN8+C2lH+1IOkZGLQwt7dNda/J4bz4US8lUzYGV0uBAZ97Rp5T0ZZN3T6UEyLS6bWZEsJVHZGXWY1KPK6JiQUaPnYqpTfDoGv7DEJbX+D/WroqFZhNMLKhHrtvhzYjxHSc7X1b2LtH1o5whDXcR7gukvc=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 08:00:56 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 08:00:56 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 09/12] drm/amdgpu: define one macro for RAS's
 sysfs/debugfs name
Thread-Topic: [PATCH 09/12] drm/amdgpu: define one macro for RAS's
 sysfs/debugfs name
Thread-Index: AQHWZLPA3XzS+nvRL02X1eqFiBwxpakcn3qAgAABQnA=
Date: Tue, 28 Jul 2020 08:00:56 +0000
Message-ID: <CY4PR12MB12870B57CA7A122BD0FA2B03F1730@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200728074934.12490-1-guchun.chen@amd.com>
 <20200728074934.12490-10-guchun.chen@amd.com>
 <3a8a1c02-8248-997e-f87a-a111e86dd0ff@amd.com>
In-Reply-To: <3a8a1c02-8248-997e-f87a-a111e86dd0ff@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-28T08:00:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8d543c3e-0b45-4d01-8be0-0000c3f89966;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-28T08:00:54Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: a5545a6c-a67d-4195-b3ee-000036685e97
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 266e81d8-a082-4259-a95d-08d832cc5ba1
x-ms-traffictypediagnostic: CY4PR1201MB0120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0120A57655B295175F58C05FF1730@CY4PR1201MB0120.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OPVDRO34L2qcCII6pnJGHnkJah43ElNMrggWFFxpYZnkMWCGSAx9/FzFXJ4YPnjRcswYhh3TmKr83AM0mHpNHejxvHGPxMJaLjKESr8U5Ee+rZ/a/kWTsH9lIoC4mcrYClOBrlVrJrUiix6nb/GljG3R9YZ/oUTinxmZ1tMwKXfRJkDA9w/djVevpJ120ioYk0+jkh8XFy1odfi4m/my/KuErvjSGqlU0Zlzd7OCPi0PubU5V7FjqQL//V1bhjkcnPkLJUsnRjt3Gests+bo1IZmMy1kk5w075jxgraYbOlzixQLf13CHugXIMJ0NCj+PaZ3GvIeCNAMrXmn2OwiF3ZEwEs370j69/1vCYc1p/C6D8m1D7eaPb9HNNLWFYAi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(53546011)(110136005)(86362001)(2906002)(83380400001)(316002)(7696005)(76116006)(71200400001)(6506007)(8936002)(33656002)(66446008)(64756008)(66556008)(66476007)(6636002)(52536014)(5660300002)(55016002)(8676002)(478600001)(26005)(9686003)(186003)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cielr0gJtNChBoxdPZE2YaY4VSxsBQ2S8A0UfGUkGzQ9nio39/Mc1tVeM0NcwJQi2TzK04pTiX8wOhc9rBwCHZ/BW78AdeYV3Ap8YoET2JlHb8DT1E7T9UPish1uxjJYfkWE7pi9a/mG8HHe7/bKZYkEDKRDGyoxEAWAmElQ92+t6dbINej+pz1scyhvtSVEbUf9ovrE4DQFaGJpgQkpq7bvK+Xsz75wAU9CFrFrWiUopKJ1XqMVz8p6HXqmFW1vulu5MJdT4pVasQfzuK/3qT7j8Zt+p5sQq3sMDua07+pB3CCnwyQA7JhRmHHrasB4VwIXHb9qGUgwzWJovo9escqoUMxhaqC+qMt5V8FrH/mX4URUXm30DFA3bYgeCnOFdhTCJS99UT1ajEyowu+vF+k3/NXO8u1xvtw4vgGlZL2foQ7xiFv4zHJzYOFzuW5Z2UP7aZdZKULzSx91nYaW2lTjqy4cIOF1zinWPs1wTSevnzVYCzVmrQ2eD3WD93nI
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266e81d8-a082-4259-a95d-08d832cc5ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 08:00:56.2394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /go/TnDbVU5nSSw6WI890qbOu2wxmj1nKfh8L/TqWkWWdT9N1sIAfBtBSHQt81LkOX9C2TWtGXMbj2a7+HdWcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks Christian. Your suggestion looks better, let me improve it.

Regards,
Guchun

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Tuesday, July 28, 2020 3:55 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: Re: [PATCH 09/12] drm/amdgpu: define one macro for RAS's sysfs/debugfs name

Am 28.07.20 um 09:49 schrieb Guchun Chen:
> Add one definition for the RAS module's FS name. It's used in both 
> debugfs and sysfs case.

Maybe better do this with a "static const char*".

Christian.

>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 2cc09aa67423..c1ed0074a52b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -34,6 +34,8 @@
>   #include "amdgpu_xgmi.h"
>   #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
>   
> +#define AMDGPU_RAS_FS_NAME "ras"
> +
>   const char *ras_error_string[] = {
>   	"none",
>   	"parity",
> @@ -1037,7 +1039,7 @@ static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev)
>   		NULL
>   	};
>   	struct attribute_group group = {
> -		.name = "ras",
> +		.name = AMDGPU_RAS_FS_NAME,
>   		.attrs = attrs,
>   #if defined(HAVE_ATTRIBUTE_GROUP_BIN_ATTRS)
>   		.bin_attrs = bin_attrs,
> @@ -1080,7 +1082,7 @@ static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device *adev)
>   		NULL
>   	};
>   	struct attribute_group group = {
> -		.name = "ras",
> +		.name = AMDGPU_RAS_FS_NAME,
>   		.attrs = attrs,
>   #if defined(HAVE_ATTRIBUTE_GROUP_BIN_ATTRS)
>   		.bin_attrs = bin_attrs,
> @@ -1117,7 +1119,7 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device 
> *adev,
>   
>   	if (sysfs_add_file_to_group(&adev->dev->kobj,
>   				&obj->sysfs_attr.attr,
> -				"ras")) {
> +				AMDGPU_RAS_FS_NAME)) {
>   		put_obj(obj);
>   		return -EINVAL;
>   	}
> @@ -1137,7 +1139,7 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device 
> *adev,
>   
>   	sysfs_remove_file_from_group(&adev->dev->kobj,
>   				&obj->sysfs_attr.attr,
> -				"ras");
> +				AMDGPU_RAS_FS_NAME);
>   	obj->attr_inuse = 0;
>   	put_obj(obj);
>   
> @@ -1183,7 +1185,8 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   	struct drm_minor *minor = adev->ddev->primary;
>   
> -	con->dir = debugfs_create_dir("ras", minor->debugfs_root);
> +	con->dir = debugfs_create_dir(AMDGPU_RAS_FS_NAME,
> +					minor->debugfs_root);
>   	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, con->dir,
>   				adev, &amdgpu_ras_debugfs_ctrl_ops);
>   	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, 
> con->dir,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
