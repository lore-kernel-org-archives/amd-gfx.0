Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E47EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 14:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD592067B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 14:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CzNw2GGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD592067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A9686E8FF;
	Fri,  5 Jun 2020 14:04:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E25C96E8FF
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 14:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GglhQmNCGQL9LHbFVua4/56SVNZ149+2vV7PpnoD2Ig2belEyCdLR/w4gGt26h384Rzfz3ATKfUuw6zplNA/BoDZEA/i5+RZsoKjot546cE/9wqMysCnoXvkkEKGhc5pgSsyLXtKsCnoe9jqlySMB+bAtj2PdsQELajsd3ezVDc/s3QhJl5J9j/CthNVifkm9hY19SHJZVpSUpalsg8nb+37x9cpcW2EyO6la21bbNjIwlu+9cozOpiVbYbWuZV/g2ooskdVopvvxPobFv7+qNiw1aLcpZC6fXKnh/MdrgTX+eaWFkk7T+ymU4ebrKo86HW6SprZv5PLaEqYpxx+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVliTgTUhKrcSqg8VMzhtsVnr9AUUed3BGZLp4X9FvA=;
 b=KBQxdq3Xyn1QMl38Z49X1sG6zZsTq4GavyA1+fMJbVY1VogmpWa/3m5JlPAxZdc1lEEQd0xiFppOmYkGcmbtwAf/uzNfAUGRm0Qh8UeFK3qkV4NPut2/ijw0iPk97NyxkQlGai7IrQ7WmUzuaszyGUfKMzv7Hw2Vh0W6XYdPKeai+tQ1Q7WLrCCow4SbR4OMbQYTT4GoCMwgAuJ5iYipjpbZKk9NanpilRLbkLFPIAtds2qdM+OoNZf+7YHHjoYmmIMHEyL90Ob0w8PRkToDExB2neVd/uxxFpNrZPBJ5ovn3c8IpuVe12XS+ugJ9UR+3U2DiWVfO51J2ZM9QqhkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVliTgTUhKrcSqg8VMzhtsVnr9AUUed3BGZLp4X9FvA=;
 b=CzNw2GGF8NUi2oUGeN1wIGqzOYQf3GRkMxFgYSMwiDFyOJ3zFg82M9GYsAxLTBpXYl/OROnHBZ4DM7nxeMGyu9FYv6R3PTsB26ga8lfX9HZJ7P9rWwkNBnuuKUhHTeKvn1xcFEXhAO3wAc88N/j/lBVNd33Fqppi2UTsYWjtubk=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Fri, 5 Jun 2020 14:04:47 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 14:04:47 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic
Thread-Topic: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic
Thread-Index: AQHWOznaZ9JcTgW3Wk6nJGdozn5XzKjKDg3A
Date: Fri, 5 Jun 2020 14:04:47 +0000
Message-ID: <DM6PR12MB4075B8807E76FF2925063F35FC860@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200605130412.202089-1-likun.gao@amd.com>
In-Reply-To: <20200605130412.202089-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-05T14:04:41Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4b76a02e-c23a-4b0a-905c-00002e517422;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-05T14:04:45Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 28b063e9-c30e-4f46-9a85-00009dee2942
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32016a33-0a82-4766-d01b-08d8095967ea
x-ms-traffictypediagnostic: DM6PR12MB4281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB42815A2D5AD63CDCDC4B19FCFC860@DM6PR12MB4281.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7++WDNmwwJ2CnltHv8n1loRkOdhUVXwhWn3XPltv6dl+KCf6RytQz6Jcz+gSfgDaotd5liP92mB+70TLIs5l7+fVGiSxrj9jXjYEDb/NL1gDLofwp4lhpSJXNNlQpHZVIO8Ty7xzRoBRIIU7aSH/AyEv4rs0xIz4s+XALpCAUOWLThdE/vSoxGVCrJI+iiZwdOHAHCohkq4Ae2wzZsfrUYIRbjQ6G0+IDQNf/pEdoESLu3iuX6miZCtG9UvNQCXi08EjuMqv45u7IF3ejaLulOOBK+2JgHj4n6lO7tLX0g4WDaY8gdgK9uflP71NvJPF37uXFweYWyaU0juvXTfIVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(52536014)(7696005)(9686003)(53546011)(186003)(5660300002)(71200400001)(4326008)(55016002)(6506007)(26005)(64756008)(478600001)(66446008)(66946007)(316002)(8936002)(33656002)(86362001)(83380400001)(8676002)(66556008)(66476007)(2906002)(76116006)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: b/WnPeUYrYKqKU9kp1fTov0EumdLEJwAzf3r1fmCPw6pgu6pq2ubVP95mpdCp8Rovnmi5Mn2vhUKAeW4VQ0wIialzNTsF745yv2s6Kt8ZFIFhn1NHjKf616zqYSa5i+RhzLeY27QxbyNsy2OydMCdu04qmIytGUVyJmy80w/adUoKkebz9ghWtTW+Ihl8HhzBYFklbihYFydzkz52mpADboXUuHgqCnVY4KnDfdo+5ov7sXkPeNpyjrHgNn+wtcrFx3dZZkphSQy/MDdiR0z6L8awYqwJBeT6ROyTy+oSLoORao2aqGSqfnEWOB80JaEiN3tMy0IlnCQheFSSnjIDKKx37GfO9BCRBh/OG/BylfN/9OxMq2v/oUeCZ2PcmGuZAOwZikZoZa1MzlKmmLhgDO3YOPBfF9OFG0PjtL7hnxWEf4aOEWyLUQk4K8SZgSw2wvVCUooUgW9bvvC3mkQ8u2YidNoxCHIL1F7H18BpGzQ91J36dGkdr3ieDPQQePb
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32016a33-0a82-4766-d01b-08d8095967ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 14:04:47.1871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brWFACdCRhole6/IquFds3TFIiARKcbkbpSvDdZSKKelT2hW6H2y0SeEfDxs9BjpCtb4UZlMzJCccukPP5GSRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Does it mean there is legacy VBIOS that even doesn't have firmwareinfo table and introduce crash?

I think we expect the atomfirmware interface return 0 for ASICs prior to Sienna Cichlid

Regards,
Hawking

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Friday, June 5, 2020 21:04
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: skip fb size query for navi10 previous asic

From: Likun Gao <Likun.Gao@amd.com>

Skip for reserved fb size query for the ASIC older than navi10, as those asic do not need for TMR region reserve and may get an invalid value.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Idbc57805b8070f27ba6c3cf22f1892d6dab92f06
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index a9adccfda4c0..e2a64ae7bcaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -603,6 +603,9 @@ int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev)
 	u8 frev, crev;
 	int fw_reserved_fb_size;
 
+	if (adev->asic_type < CHIP_NAVI10)
+		return 0;
+
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 			firmwareinfo);
 
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
