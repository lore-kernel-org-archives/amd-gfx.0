Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB18DC4742C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 09:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8492145D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 09:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1sKjM2J0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8492145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C08616E45D;
	Fri, 13 Nov 2020 09:32:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946DD6E45D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 09:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oxt49ijNwF3XysccXhmPxtWYoVpZSl5yHtL+yvxaz3dVRhFJyhgDYSzNBIZB82Js2/5JQ/R3I8CjDp2TCE+/0dBWPljiOYc30bJa8x6hr6wjbUdcJCPTrgU8Ul8yEqgAoRTDeVht2EDBbMisb1POVCcY5bIGGUeKQRaQU/QLHyvGbWJmzbv/pf0XYE2MWX3i9rI0zwuIifcMKWyffik4SCnkl3uU7zAMKw8jzZgXMgYdnp7lUgEAUTr1NX833yVpsHjk0oyGN0CCcPzQTtmHAiNJztwu8PFLtkoxj0Pz9XKfp7F2NYE6I6M1WsULNi6LgN9dPKIlMLm1Jz9v2BcIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npIHksVqjp7nYYMhnvx3kEcaN8ago2BDwgjOsDbzzQM=;
 b=Nic62p76fwk6XoSM0qe5qSYst17csTrnujUv5Igbt//cIVXL/RO5+0iBvedBJxwcfFiIxPdGQUpRRvWmeZNrjWcod39Jsg9gzzILCAWogfraFdgjDf4AVdOrqEde64LbW8mmXzIZEkdQuEDZBW1y0pr3DMocO+PhxnqKhKUSCZ2E3xU7z8zkC3ikp0DS/RiBlckA4YTzb3NGq8vMBShurQiOaW5XyXKfAdY/tK6q6siXnmhf65iAx/+AjEoaOkVrLq8vu9YvThnCBlg+BjR/TbSRV3F6MfOay45KHVC7vdIQSoNhuoMSkhyena1ss0Mr/TEhMK6fpf+Y9xuhcIdInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npIHksVqjp7nYYMhnvx3kEcaN8ago2BDwgjOsDbzzQM=;
 b=1sKjM2J0j8cIbFAWFS2SGMaqoFdzFMUfocblyh1CsQIll1yk1JnuyyU83LLL2qEGGH/OY60780wwS/6if2loH9E0ks5m/slXPxTaymZHMSvIxaRHbvuKuiQYOSNpmk52bIIFQ1U2tpP5sN5J3T1OvQTlyXHw1pB+quhG6mQWtWc=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB0030.namprd12.prod.outlook.com (2603:10b6:301:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Fri, 13 Nov
 2020 09:32:26 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3541.025; Fri, 13 Nov
 2020 09:32:26 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: declare smuio callback function as static
Thread-Topic: [PATCH] drm/amdgpu: declare smuio callback function as static
Thread-Index: AQHWuZ9U5li163wzJU2/KpuVyYx4sanFzFYQ
Date: Fri, 13 Nov 2020 09:32:26 +0000
Message-ID: <MWHPR12MB18548D4AA8B8AC2A156BE2ECEFE60@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20201113092750.26602-1-Hawking.Zhang@amd.com>
In-Reply-To: <20201113092750.26602-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-13T09:32:18Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5f4218d5-b350-4bb4-bd56-0000f0eeee3f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-13T09:32:18Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 356e0b51-6b57-4d56-91da-00007aeb43b3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0b0558a-7a7f-4107-8f8a-08d887b7089a
x-ms-traffictypediagnostic: MWHPR1201MB0030:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB00301AF3775B7626303A14B6EFE60@MWHPR1201MB0030.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AGAoQlOQ8saQv+B3dEiFjqFzmb4tcqrhcjb533r5hhobEIA6vuOTRVwSPHiFQlub7HeNYjJyL1la4CkrApnbAHEgVAUBqUrMJofP69a42e303EsfrWSE95B0m1eZcyh1WbfaHwOYJXdVV2E+fOVZQ1uZTG4NWnxj2cfj/+n9euXN3bGT2wV5kzQDQkHABaLjK4zz+lwxjXmIOomOFtmAcANzSpuhIN5Ai+xmS+KfTSkBz1u+3R9bdQcFbdqcaGJbGwiZdGiVxEQlElZ+iDqlb4Gvf/+QJ+amBOAh5DyFU375ZrEDTe3YYZzgG9zxyfhj7arhOTwQ4Tvk8jasKsj5dwRJFVLfChAke4HXldt71II=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(966005)(55016002)(5660300002)(478600001)(26005)(110136005)(53546011)(45080400002)(71200400001)(9686003)(33656002)(66446008)(7696005)(66946007)(76116006)(8936002)(64756008)(83380400001)(316002)(52536014)(86362001)(66556008)(66476007)(6506007)(2906002)(186003)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TytGOrB81fhUNTdo5Lei+yfXn64Uv+opoA8oUlHK868AyfrlUOQqnugxC7j7C8azdA/QWWOA+38UELHLVRu+X8yzJxKee5h2lacozd5J3GSUCASf5nRN7HbfQrVz6wlS9N+8kM5c87uuL58rVxjkNqbPTWQnVX8fMnLQEY9yui6IrjiIuPk1ctqeGFFmDslvqTput+PyOjJAUGgBDxcAr0yxKaE+qR9enNKO+c5i8HztnUqU5nmvBzDTonIJfCqP1RTqjGDxAeyRqBqIhnceYSZU6ElDVuPAjT24dt/VclPwZEXZ3x4t2oQ78rqFhrULlQ08dHYWHz8iRiD7s0izARec/ApcAxuGhSNcjQX6Lv1qKOQTqsLNxE5xxGF4LCAKxsRWX+Xn0TR+9yq0jYkBpZRgCcaqL0PKMjNalgwY5MjHpzSRoJsN8hNg6nIR4l88dnmo4nkCwZxv6M6UdPhr799AM4CS/PuK+2TPILpsNYZnHGwsmWEm/xHfmZM30o3MXJvqsTvI1KSg3+cmkkMOQdsW0HnIP53/lWcLgoFOgOsEbORuUytDrkiUzcelHHfAcxlYdZb2NMkuPka/jIMCqe0YHtf5fyflwEm9RF9k3wpuY9oOo7WcEz/+IJ4v5d4scyu8ReHSeUAJIqKpP9Lb7MsGeX5+4+Su9VOV4VsUodeQw0/EPdJ0pzagNirtVagZ1jQJqOIql+RAFT9/VouLLZ4cjf6sjzfcZfRA+VmdvKswEUnkiIl8VfhNOExboaWupFDpMT/wu7BXn+KdKas8eE8K9bbacxF9/BjhuMXtxpLNjzkE4RASqQXWTwuVMYw4/1g/9rHVJtALj3r4T5GwTVfN6fvZlnPRhKkQwMa0QqBcKf//Ri5cdjJQ8qeIOWJrEMFRkD16wHZjadFpKrh4vQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b0558a-7a7f-4107-8f8a-08d887b7089a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 09:32:26.4677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRElk/ZdXkXlWfaaZzDehB/fHlLS+qLCoCnQTaq2CkM6FSxv98ZJglHdDNkMTlxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0030
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

This patch is Reviewed-by: Likun Gao <Likun.Gao@amd.com>

Regards,
Likun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking Zhang
Sent: Friday, November 13, 2020 5:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: declare smuio callback function as static

fix -Wmissing-protoypes warning

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c | 4 ++--  drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
index 137b410..e9c474c 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
@@ -35,7 +35,7 @@ static u32 smuio_v11_0_get_rom_data_offset(struct amdgpu_device *adev)
 	return SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA);  }
 
-void smuio_v11_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
+static void smuio_v11_0_update_rom_clock_gating(struct amdgpu_device 
+*adev, bool enable)
 {
 	u32 def, data;
 
@@ -56,7 +56,7 @@ void smuio_v11_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable
 		WREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0, data);  }
 
-void smuio_v11_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+static void smuio_v11_0_get_clock_gating_state(struct amdgpu_device 
+*adev, u32 *flags)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
index c9c3e30..8417890 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
@@ -35,7 +35,7 @@ static u32 smuio_v9_0_get_rom_data_offset(struct amdgpu_device *adev)
 	return SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA);  }
 
-void smuio_v9_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
+static void smuio_v9_0_update_rom_clock_gating(struct amdgpu_device 
+*adev, bool enable)
 {
 	u32 def, data;
 
@@ -56,7 +56,7 @@ void smuio_v9_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0, data);  }
 
-void smuio_v9_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+static void smuio_v9_0_get_clock_gating_state(struct amdgpu_device 
+*adev, u32 *flags)
 {
 	u32 data;
 
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CLikun.Gao%40amd.com%7Cd3cf6bdc033e4b3dbfce08d887b67262%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637408565018444231&amp;sdata=B7zgxF9FkM05cR8alsr0d7YraSU9nT9oBzTuoR%2BCA%2Fo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
