Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A791C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 11:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D968422208
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 11:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lRxxh77d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D968422208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9766E9AD;
	Wed, 16 Sep 2020 11:36:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF49F6E9AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 11:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBdrDir4+fw/rZrNzqbTUnWToe0fyRqGEZ4UBCu9DIt6CFNcwhXmPsZdsW11QVcpMAG2qpN1ZEEj8ct+ORiRDZh08b9Yl+5jTqaMNTrC2KZnE424BFs5g0zhW6ZxFqkYs/Xe/vOkY41oVFnkAkKsd9GPHJ/r1hvdTqbNe8mjYAfJULYbngmxPNOqQgkYOIK0IVzaFC4ONN5cntpjSp4iRMEFDQzEDHx555Ip5309LKGIHGpPDt+C1kg7V7TfdEDLFWylOKNkk9WlaFVAlEXGO3Zgnan4H3NVtIJAJPhZF9ksLl+CPMoRFEGMo8CL3P4e5NG8hMm/1CQbirptl4wdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFp1Z3AL2UmbNwh7Ydrg2ALcm+BsCggv6KbLhMq+bQM=;
 b=TszTkTViTJURqCptJYJ2lC10/exw0hzOJaB8y6CokyaePyzP3sLnA1O6+C6nC/hICKYLcjzloLFV4be4Mhjm5hAny8ohzSYdE8HW4UeVQOzZZqLZh7PcJ5mquBj+Zo7Do3+0AXL5RExBIH1HnhLMWAToy0nEBeymSwdbZmiGsH/8CZkG3OZNPiuYrOnEercSS+Nz67d39t3DeRJObWZeU0niDXOZHLSFIxEKedf6fG1QOKF974BVEO+eOzUXzV/teg4FML7xe+pXVxLrR0UpT16GKQdi0qTForoFSUkgXP1LJbBCTnWv/E9IrfM6fEj+B5sVD5O3b2kTBHdGET1KEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFp1Z3AL2UmbNwh7Ydrg2ALcm+BsCggv6KbLhMq+bQM=;
 b=lRxxh77dl71/O8Bq22cf8HK1czYbyWLd2kH2/IoPVDpvtnAE8Aa894ENAuKZdbimuIvPZI0grdpWpFYlBvDYbKsGD7F4neclZX1xfyIhOol1XI39K6TolGqG70Q3jdA0Evkcwy0Y+7YXkTGY2ItSqPIDrSziD/DFyC3NuJQOQ9g=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) by
 DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.19; Wed, 16 Sep 2020 11:36:35 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9413:d975:ac8e:39d]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9413:d975:ac8e:39d%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 11:36:35 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: declare ta firmware for navy_flounder
Thread-Topic: [PATCH] drm/amdgpu: declare ta firmware for navy_flounder
Thread-Index: AQHWjB1X0ei7mC9290KPoJZ7dGfzFKlrIv1w
Date: Wed, 16 Sep 2020 11:36:34 +0000
Message-ID: <DM5PR12MB1546B44E679A99554D69A52495210@DM5PR12MB1546.namprd12.prod.outlook.com>
References: <20200916113408.19088-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200916113408.19088-1-Jiansong.Chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a1bea2d3-9956-484f-8b58-836b7386df5a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-16T11:36:25Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd2afedc-4884-4d54-fe4f-08d85a34c453
x-ms-traffictypediagnostic: DM6PR12MB2810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28100983E3E5CC8305004D1B95210@DM6PR12MB2810.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +k0F3mfR6BdFBIAo5F/2NWwoE7AvmWcOtVCSzzhSos9Xt+aG2AEvTyhxT59VuhLrXx9swEvKUop4HCBZS5L8IEjpBQgWe4/ieUrbod27yPfAwzptgDdvCdTdfk6hLdt+PWSyHPqeOtTmJvKQkzTSh/bWN0ghZDnp5Zpx69sAVEEC44OiBdECFAaZboi8n66lSPlUxpmLKo8u1uW2+3eDs7PjivyKcPJ9aZyaP00iGV3yK1FHqTI6VupVSVnPMnJgJr8Qi266zdz0yfaP4pQYEN4XeuSbQHrg6I2GdpYQUCuPksqx47QfliYOjtY6JaE853EkDU8Y+8DRPHsAfXWPVhkAf5BOr16NzFpfXu30vnYcEie4r9pOMthMtfsV9RHy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1546.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(8936002)(2906002)(52536014)(9686003)(478600001)(55016002)(71200400001)(316002)(76116006)(26005)(186003)(8676002)(53546011)(86362001)(33656002)(5660300002)(6506007)(66446008)(66946007)(66476007)(66556008)(64756008)(110136005)(4326008)(83380400001)(54906003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: vFUJ6zizCSy1WcDR520nIJFAHDwjRHx+qamG/tIeg1QBV5aQPpwLugbrSnAzaLI3KOIYy6sCl+yz2Cjas+L2nd1fP65VE9CZD8E2mr1QRW0be7xuQeXPVACae7egngoW+PUpGYrmGCKHMu4X543EcMhn+yL67/LMeYYfOB/WP8GTCgkMMsKtzmlX5gQUvPb2MO/9HfByKTW29MQcs+cTW3jFlCcEQwuzXjzTbb0mUC1PVguUNOFFZwEl59ZDQFPsqmQYWenmb5PKTZT4QbpkjXY/8J0/XtUc5z8hcgxhBbZIuNc04s2+UGZPMjo3MvHfmP4s5e77AqsbfcTLWULSGmehuJ2tvO/x2DHCGvfnn8kE5qscbAu23E5AIOaJvf2OEbC/YUQct9L6M2806UdUm+0Lrm/tkYE/wbVd3pkfGfYQCI2FAj3cIv3v8se3A0l2PGWQpQ+7WOcBJ3KoUEGyMZsjFGxbHMFmGsDWE7mljF1bFJ1vrKEHrzU6BjXSrQ5pqfmgFOORPozKd5L/7isELwA0EZI0LZC4oFlzCMlCESDf72nq0AwSVFU6b3EyIJo8e/c5adZDdm72jPf7KxPSyxaCT2Nvp0w0zrnLhjF3cUlTH0gmyMR5TfJA8FXhXYqcIC6R5sbVmsUhPDkV6X+LWg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1546.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2afedc-4884-4d54-fe4f-08d85a34c453
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 11:36:35.0373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AArCzHa9/VQmXMnWTNWhfE63vtcneGp1Tb0mKgmD7y6UO+WddUcmJFKQ4UCVYEM/Ojo3W0s7YTZSJ/i+KvgeHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Tianci Yin <tianci.yin@amd.com>


-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com>
Sent: Wednesday, September 16, 2020 7:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: declare ta firmware for navy_flounder

The information provided via MODULE_FIRMWARE appears in the module information. External tools(eg. dracut) may use the list of fw files to include them as appropriate in an initramfs, thus missing declaration will lead to request firmware failure in boot time.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I0eb0231d0e4672ee00ebdbe0bd8e75245a8c1698
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index e16874f30d5d..6c5d9612abcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -58,7 +58,7 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_sos.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_ta.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_sos.bin");
-MODULE_FIRMWARE("amdgpu/navy_flounder_asd.bin");
+MODULE_FIRMWARE("amdgpu/navy_flounder_ta.bin");

 /* address block */
 #define smnMP1_FIRMWARE_FLAGS0x3010024
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
