Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0EBC56202
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 09:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDDB20B1F
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 09:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xjbPL5HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDDB20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 659CC6E827;
	Thu, 26 Nov 2020 09:05:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB636E827
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 09:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGpJ1a66jwFgj/GdNmhGBGBZ7bzXGHW9RRTIQNXwgzJ22P4410+qX3GwFH0CvlCWbDs5Q4xK7na4SKrkMLqYE01yiV9NtKdcIrmlLzi2cBPQo91wYjWrbZ6dg+wrJbvGbB3DQXA68d47eYJYZFUeAI558jL8E5g2gF5mJ4xbQORjTkAGPN3m8goD3tEielaq35AEeMbHqV2GURFCrK/19O0qWL+8N+YPZSPrhF+Pt6WmN2Kbdt99CwmusiCvMzj6sg23zDnTHQSxsvIAPunqMjIrdEeTp1xQNBCO8tHLRwR9mJwZj043cPhTFdirr3jvnpC/SACN1x3SeVY6jmLObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKHjSawXLmxsrQW6bLQhjL7C1ab9lw5eiLA8K9c//FA=;
 b=DMLvjXanzJ6rXoj/4DAhvoC1hDtwl6fZPwav1gefD01eDZPWmLNDH8A15ilj/cXQTNRZTN/vdKT92BGiO5MDLjCXvogzIG+7YkIGCJbcmJbAu/sKwezq7XlsZeq5+26+8KDmVFVvSAlcgtVNQKkIovbQhG26nZnUMbl9w4XuUIT0dQog5QPfhwsHECrpDJUn/ubrvhGL61/TqLy6DBkAhLAo9AAOukOUB/nr+WeXKSTo3KyGQn3hDkWtkQGmMHtHaPlw/thhk/DWyrtETSRZEQb/9yqnexCdCYedw3APsX9kHjikWypt5JbJqG5geBrMBd6eB4IQAhcEu8P6O1Ysaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKHjSawXLmxsrQW6bLQhjL7C1ab9lw5eiLA8K9c//FA=;
 b=xjbPL5HX78k39oXCHVu/wtoVW5gPU4SA9DcplJLiJf6CUEwa4yke+5q0VWP4Jy5ebOeXFMIwhFKYp3TlVn9aXHypcN1ybOXYTlxM4zCihQzsXqb8eEAHpYUteAevtyldb/L2jROX3vAN/KghSkgl+fQoAw/T9ZRG/gITLIoMTKE=
Received: from BYAPR12MB3222.namprd12.prod.outlook.com (2603:10b6:a03:12c::23)
 by BY5PR12MB4951.namprd12.prod.outlook.com (2603:10b6:a03:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 09:05:03 +0000
Received: from BYAPR12MB3222.namprd12.prod.outlook.com
 ([fe80::7c6e:b8ff:6043:9dab]) by BYAPR12MB3222.namprd12.prod.outlook.com
 ([fe80::7c6e:b8ff:6043:9dab%6]) with mapi id 15.20.3611.020; Thu, 26 Nov 2020
 09:05:03 +0000
From: "Zhao, Jiange" <Jiange.Zhao@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip power profile switch in sriov
Thread-Topic: [PATCH] drm/amdgpu: skip power profile switch in sriov
Thread-Index: AQHWw8928yB8E0sFW0O4438ewVFuo6naHilA
Date: Thu, 26 Nov 2020 09:05:03 +0000
Message-ID: <BYAPR12MB3222878CCF698164689671C5E1F90@BYAPR12MB3222.namprd12.prod.outlook.com>
References: <20201126083756.3864267-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20201126083756.3864267-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-26T09:04:41Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1a3c8b0a-1afa-45d3-8478-0000d709a371;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-26T09:03:49Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a7ce3d42-96fc-4f9b-a8b2-0000762288be
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-26T09:04:59Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: fcfe6796-6fe4-4a34-a55a-0000141b9bef
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 139631f4-b5f9-42b2-d8ae-08d891ea5cb4
x-ms-traffictypediagnostic: BY5PR12MB4951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4951E62EBD3F7DC0B853F681E1F90@BY5PR12MB4951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zOSDYJ+y+W4ItTDbtcfvztLM6H2tHP8R0pgF0UpPFvMLwGB0BBeLLkqD0/gpdBpyCvuYUQMXyNDNReYCaXe+ThX9hMsPMD1u6Z0aXQcyzHQpXGnHalXJ+fX4jXwV07MRqDswq/xUTSLEgogZ2/MGW67xIajWTH0mJmXYPXT9JiF/8RMkbr1yIT8oZ0SuVIYB18NeQOQovJGlPaa1tR1cQelYKzjmWOVPdIsbEHF9pVz8KML3GqY+bnk3PncnJxjRGCIDBN1d9iIe1Y0SnNIJzQhqif+AD/jDhd5DAqzXiFG2PeUw4GwUtfgXJKoQ++lnFk0ZLbdRn1vLec7gRsB0Dw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3222.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(55016002)(76116006)(86362001)(66946007)(66476007)(186003)(4326008)(8676002)(33656002)(5660300002)(64756008)(9686003)(66556008)(26005)(2906002)(66446008)(7696005)(110136005)(316002)(71200400001)(4744005)(83380400001)(8936002)(52536014)(6506007)(53546011)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 033K3TVBkofOVdFeFQBd6vR6nUwIDNJr76W7diX37mUd0+Z/Fxd+B0drU/oFirZF82T8SiYyTNJfeBz4v384nzitSA1crHXwO7s0B0poqkpOQuNoGUMzu+Xsk65syHGnxFIOQMa/gnT0mS0lxaXA3Rrcj84nx+c/7w/FdBFcpD+jgyd4hFcJNpH/PBW5rj1x6Ipjl6YmySYuPrOOYu6YlC7ERAeVUplgukQqI/6osdqqM2kfSU+dk1GHrDY4jO5Jc2xHeBQ33pUgsBYSGko4XrDbsgqTFIm64jTPmQkFrPQasBrQqYKrqtFWZZgCOAEGrqtGH/0yd2oNgkDOr0ak7X/ZP8bQRelOSLL0uXjNlEDY/cjm+/H+9PnDskv4PoNiN/GPQpxCxP5Y76EmvR0MOyBw/ytkA2glvsjP+6cDVZZZKieZO8XVO5mu5DMgdnYQRNKHL4rtxlVT2f5eyyvyYnr+3BbcZMEoZcjOnLzDulLFEKtkTfNawtpXFWAg5unbj5zT1KjBSxIin0CBaxLF83NPrkKN7T7UZqdHtvk36BnHOi8lzsPNebaGXtI7rOvelqeHRusgUoN7JTuR0TnKf27x2jmc/mF2bWCrf3tTVPAICF5XfEMmg3V+NXlOBfIl3GqVlZVGfG7skqu9SJNFG+42uhWz75S+JWrU1r3qM1+A0QwEpMyNuogcpLtwauQ7h+LWIZ8EfkDnvWPlY1k/6STVBm+T3pkioopxnKs8jWGhRm/n4fgdfgi1NbNYUaCl0QRJtrGQj4NjlsXoXjkCwxkLeAJ7cZSBoCBrQc/pjnCg5Ho1Qz2hC5DRuqAvZNysVpLOcjpYrX3QkniemZOw4ZRo5i95HsO25JOJoJz036LGuHbJ9EWLhZDpswVbgNP5GrpskcUtcsK+ZIxbI4X3mA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139631f4-b5f9-42b2-d8ae-08d891ea5cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 09:05:03.5546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qai2DVoNgXP3euqrbSpnq06MRvzQtTMsFE91/jGXgmo+I7tyNvu4VuNhF++CN/Aw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4951
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Jiange Zhao <Jiange.Zhao@amd.com>

-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com> 
Sent: Thursday, November 26, 2020 4:38 PM
To: amd-gfx@lists.freedesktop.org; Zhao, Jiange <Jiange.Zhao@amd.com>
Cc: Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] drm/amdgpu: skip power profile switch in sriov

power profile switch in vcn need to send SetWorkLoad msg to smu, which is not supported in sriov.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 17a45baff638..8fb12afe3c96 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1168,6 +1168,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,  {
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (is_support_sw_smu(adev))
 		ret = smu_switch_power_profile(&adev->smu, type, en);
 	else if (adev->powerplay.pp_funcs &&
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
