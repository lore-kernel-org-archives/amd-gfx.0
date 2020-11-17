Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51D4C6369E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 03:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234452469D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 03:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z8Zo4zOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234452469D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E49C6E0CC;
	Tue, 17 Nov 2020 03:41:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13636E0CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 03:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdvb9pKsd3JUOWB/gdxLUDee9C4D1ZmZR6/+hAi3I5IPjVkF4T+203sWa1QbQxr4JB1dRXoeGmQpldtKNxLPbBAB+IP/l07hvadnasI4EHqEpeQh8QzGiC1AZk92y34GOVZxFFeRf4WDI7w6hXYvR+4fup0wBIpa0pOnXOVTZF9Uu1ixkvfS97Zh3EMmCthMvlIBOpmMjjxY6FOZ3Ni+mPU7hjROrTiK9o+IFb5RXJGXrosZrsoMHRS/4fsWLLCcPcr9XQtPMYtJ96GOny6NTJDGVI4UEZ7NBGUg2JirlUidKEW22mtTIn5CS3v8LwUscED/IpCA/k+ex1vk/RUrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWgsgl3MFHcRqUR5mRrKHLSZ/EdkJ5Vs6uD8h4+MzBE=;
 b=CQA3hUO8gcayIjC/brQ1k7trprtEpP8d5lePmrypoOkWQ8mlM6QEh5rRrk0E6hWoUvxvtfaaNuzIsHcqi+md+3Am3h60jKNMn9FZtOx7ti7tFJD3J6kPoud7HqRwR3bPzSiK3xl5jQTsNTAUzgaCAnsexranmTol4k8Sgc5FzYkMbEctag4iIJ9LCOzFPi59bS+paUffs/blBHGQ7DIWaT2228LJXmoulFdcehKEPb3o7nuVc+VTWzGehRKSGlUIzoPVmu3j2RolAItMLjVB2VCjAAhGcrLt6Csyvn9zzcdjoVgnLupVMniN2g6TYR0nDFOmeHdhk6UQcLBp8vepLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWgsgl3MFHcRqUR5mRrKHLSZ/EdkJ5Vs6uD8h4+MzBE=;
 b=Z8Zo4zOASnbmtulYXUIRP24BpEVLBQ3MgD8eBiAkOZlYH8nfwnfFg146kOf2DOSztmXBbfIKmmzlcsZ/2AviNtWmtGZ7oiTtn9ovs+DvNEMA6l3E9TAJwj1wO1FD/w3yc+cEKBtkInYsFfNTZ9wo65cspapF1JjwGnLX46hRdVo=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB4695.namprd12.prod.outlook.com (2603:10b6:a03:a4::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 17 Nov
 2020 03:41:02 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a%6]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 03:41:01 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: retire dimgrey_cavefish hardcode for the use
 of soft PTable
Thread-Topic: [PATCH] drm/amd/pm: retire dimgrey_cavefish hardcode for the use
 of soft PTable
Thread-Index: AQHWvJI6g5yGonFjlUa6fbUFS4rl46nLrM4g
Date: Tue, 17 Nov 2020 03:41:01 +0000
Message-ID: <BY5PR12MB4885739D36E3A48D6B743805EAE20@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20201117033152.19568-1-tao.zhou1@amd.com>
In-Reply-To: <20201117033152.19568-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=91a5bfaf-646f-4ddc-bf39-fbabb1465198;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-17T03:37:29Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb5cf2ce-08db-4180-9a03-08d88aaa9acb
x-ms-traffictypediagnostic: BYAPR12MB4695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB46954A58DF077A9358107F6BEAE20@BYAPR12MB4695.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oK+vuQUy9yHfaczIKQz6eYZ3xvfZ4bqOMUJUHTL7MrkwQ/q6iRz4G9CcKUPUSGCX8ru413LOqvHCCVY5I1FXGK7oNstNZvSKaLR2kTCjpGWe378xQc3/kBQwbzxuppdesgMzRCG9VNY4WNP39RjaMdFQjj/6o4JAsi6/LyOIvBLq/tWPbJtPWWNXA72hjCDhW4LCF+xAfUMvgui7801CSabhKmAfCNOIzLlkz+QgcO2q8kIzecfUKjkmT/VbuW48Ikn7c57EqkR9bOusFHeAu0Kz54Z5w0+C8G5NWO3cstt8fjIGMY4y44NsBmof0H9FNUyl3QBwFzk8+1QPlV7A2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(76116006)(8676002)(9686003)(8936002)(52536014)(66446008)(66556008)(86362001)(64756008)(186003)(26005)(66946007)(478600001)(66476007)(6506007)(53546011)(7696005)(110136005)(71200400001)(83380400001)(33656002)(2906002)(316002)(55016002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: swgKbjrPP5544tPlllpMa1aHSOXf/PL2qQzznpylehSP3690O/R3xrAHBKgR6O4EGImG92CcD2+0ntGd3/iaDzZ1N207clNfc0iGTXeLs5VfRX0sDW1i0FS7MJRNoGKgdap62lnYcSoGMFfcJMdaO1JBRSLe1KL8Lx+yIBThuh0O96QFPpYGE0PPnDmNMui5D+mLa1WPsu7i6dir1ijHAaRQhp6p4knTANd3xCEtpqCY1S/8yKSV3jK/kSmqwfUHd1PgGG7kg2f/KEg0+mFI4ii/LGj8xByAGkhI2hRig1Pja06o18pm7pdPf+aDMJ4htJ0MiMqUTZRCRXfVC9RQcS58VYkyPiWkrcmx/op6GlIHyVA5t5QOwQV1Ol5wzPRb/StVarTDJEzk+iSHmpnb4Jar9Z5/gVi2UqB6ZWQBekeMRGyeUBnOP0SAvo6ozxuiuMrr2DirSiDy1W0BtjfRW3vfgmeaTsm8XkmtTQE9U+ToMhlmMKPEpdywAb6pGL9ej3k9NYMMWJz4i6GyjnMIb7ZV5qGU6oMucoof4688b54P9PgTmqymsr65NW7OPITN5+UamXMRXjiHLzB2olAOdRYgMR6XZKEjWgm1+l7NoU2xugFeHrzicuWU7D8bwERZrvme9N5O89hKu0Rl0glbSw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5cf2ce-08db-4180-9a03-08d88aaa9acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 03:41:01.7221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KoIk+LmrAK3R556O+E7ex9ECJTTxYoLIvwy7sDPBBTPbAk1+K0CcLoa4IRmW3OxdeUeRF1Qj3srytErzW8IzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4695
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

[AMD Official Use Only - Internal Distribution Only]

In the subject Ptable->pptable, except that,
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, November 17, 2020 11:32 AM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amd/pm: retire dimgrey_cavefish hardcode for the use of soft PTable

The PPTable provided by VBIOS can be used.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b23311096467..d5fa0d9dd7eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -339,8 +339,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
 version_major = le16_to_cpu(hdr->header.header_version_major);
 version_minor = le16_to_cpu(hdr->header.header_version_minor);
-if ((version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) ||
-    adev->asic_type == CHIP_DIMGREY_CAVEFISH) {
+if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
 dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
 switch (version_minor) {
 case 0:
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
