Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2585BC43457
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 09:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D497222C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 09:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tmltW27u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D497222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B5B0897EE;
	Tue, 20 Oct 2020 09:30:21 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam04on061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4e::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213706EC19
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 09:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTfZ0G1a/ze7DCin+7kQ0C0jZ4LHnooBQjU0xiW12LH0x4IxWZv/whr3cX9bYc6y1dxA+5MevNDp6oHyv91gTtnIJk0VM2IfLvVeiLrvToxD6m842URyxmV6EqfADJzSkSnZFOsceHoobWxrynPlI5htdaXv/fTZS7UsQwH/5A5RQG1quTqTnLSNS5dHdrHmRahV+P5xExbYdBgCWhA8H4nhXW4tkp/qYfJmvzz1Vn5a/WweweL4NbgMRpY41tu8czLYob6VYWbaFRgXjPIQGGGxvqkRAsWmhoeLNhpZwmsUL+B/PDwdcSVDxpkAAvzhN5+h6a1W5lOJalRpFzhAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaZ+5ywFsP+KW2fO7sQ4NBLND7/anf6nQIDFdBQ2e5c=;
 b=LnOZvWLNWXFUDT0FxsiAoZLD5kLOEp+OWrzuYe9A6xWLOQVSbcO14hTUUXAyTMB+Nn3AqFUgXsekRDovPFk0HrUqUtriQ4HKqMMWR6DnfY2BSZ4aMuM0wQqFukNkhlQ12jMruqYnYsuHYsDdRoXE0a6/DLk+VLT47seKSuJzMhHLDntqknB+inyu7G+VkKXhsp4KuC0/rux6RTDa01k8igLamML8uUJzvEB4FktdXpruX6hU3SXBO6sJUcW7CNjzTlIZU1mzV8PLo6v6905/PjA2TvDbeiHaI2xOloTn1pszOaicMVDFGZrXhdvAPFtYpD+j+wXw9phEHEyb2esuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaZ+5ywFsP+KW2fO7sQ4NBLND7/anf6nQIDFdBQ2e5c=;
 b=tmltW27uwBE4gXTR3bYK27lN7YcrItcIWK7+ZyPK3Ok5rXBXUm917cJ7uzLsR1Ol3zj4AvfvJT6p79NHGJlCPD79pdZS0M+jQ5PB8e9Ot/NAFRK8rpWbTGdJHiuwHR0dHioEyg0UdUVKaAth36eHuRQ+Nipp62BzZrb2qAHwSK8=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Tue, 20 Oct 2020 09:29:30 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 09:29:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Thread-Topic: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Thread-Index: AQHWpr8SHs5t1chCykOD2IDNbDdqf6mgOUrA
Date: Tue, 20 Oct 2020 09:29:30 +0000
Message-ID: <DM6PR12MB407589176D37EC2CAD13FEC9FC1F0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201020085722.654734-1-likun.gao@amd.com>
In-Reply-To: <20201020085722.654734-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-20T09:29:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=24aa2f53-a80e-40bb-bee4-0000c656466e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-20T09:29:21Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4a554478-fe37-420c-ba21-0000162102a2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-20T09:29:28Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1257cbd5-051b-41b4-a322-0000ff6e5e9a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ecd015e-1ad4-4330-00ae-08d874daa5d7
x-ms-traffictypediagnostic: DM6PR12MB4435:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44355A00EF4C7EB9DAF59233FC1F0@DM6PR12MB4435.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tJ3uQ+k3mW5z0XSvUkQByCaMhqURZ8uDO5KaqwXeivdjp0jw2p6oWOb2IdHbyiHUYyND8Z1kwYkvM+GocyPvrTr4jYIExh3BxXDolCDHEj5bIhTBt3GP8a9w84wmaRuCl1XklTkHYhNvArmf7SeazH2MnmlS54Rm4UKv3GeSi+97uPOwRJWDfiQ1tkCSOCMzPDmtxxUgvSi2c+DTq0okmdHw/HA4G705CNkQ2TdNAOGKrPeS4bPY4fY5svFj6SVQTIueHUvCJVGd+YicIoR+NB0PQEx2IGr1e8KLKyEgDhkTkusCQx7eYNmVB3WV7HcJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(110136005)(316002)(478600001)(7696005)(186003)(86362001)(26005)(6506007)(53546011)(8676002)(8936002)(33656002)(55016002)(2906002)(15650500001)(4326008)(9686003)(83380400001)(5660300002)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(52536014)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: W6+d2aqbcwhXlCPB6MoY4xWSSvsMZg48R7iDcAizZJAntXSII9Wb6MXG09qGJzD0kUIj/QKe7dViDC9CLGOrvw3T4wnUe8UBvEvsNUsbrnnu29vKQQO8AYU02ZrISm6Gh9pegXtXpEJT8qgTJSHHXZpN/ChK2kIJUNU3W5AKBKoU8QgB1d1y8YG4TFKGUIi3BucSveoEcW1vkG/Ygm6G0FNEZeUXOYZG2YCwx+UYizJpTzIxGoC7YcZg1irvqBNFLjLAskWRT4Gls0R/7qql5kmdxbN+Myvxe+fkpjek2hdqAF8Trk2V2pVTCcnQpNtFNn6Cm4q4J5s4FHG3AP4Mb9WuHfidGrlAIG34W0vzRlB6KHz64h/2vU/tWXS0AJ8yHouAvoXFdzGQUWn44ug0niTgEp5hfssYHniaLTDvYvzaxeq+l/NGT0tda+r7G+NP/2bafq+rbAKUOU+kLFIW6cYZEWvoVtLcVAGM3gZi3fhl70CHIimsasPfXGwqVVQuVeAymJUyL+FpXrRcVtEkDImaavDZ99Ue3k+deES8Zi7HvRID56b8uToMiRexwVkBhMs7ED8OJL+Apvc0WdnXBxf/8jznKsHESnutcjb1u3QTYjNLgJ1mF3b0kOdtAUFc13j0jaPpQpRZ9MU6mTuB9w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecd015e-1ad4-4330-00ae-08d874daa5d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 09:29:30.5455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VmnzdFD4/I/G5d6REbUrIRz2dacYph7UDwXQswAQwrRm29a8KWFdSbq/fIwhSWpIRnEllCVNglMm3PV5mMI3Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Tuesday, October 20, 2020 16:57
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/pm: update driver if file for sienna cichlid

From: Likun Gao <Likun.Gao@amd.com>

Update driver if file for sienna cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ie386abcd0a00fd904155361c9aa8c0861473552a
---
 .../amd/pm/inc/smu11_driver_if_sienna_cichlid.h    | 14 ++++++++++++--
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index 1275246769d9..e418a46603c8 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if  // any structure is changed in this file -#define SMU11_DRIVER_IF_VERSION 0x39
+#define SMU11_DRIVER_IF_VERSION 0x3A
 
 #define PPTABLE_Sienna_Cichlid_SMU_VERSION 6
 
@@ -226,6 +226,8 @@ typedef enum {
 #define FW_DSTATE_MEM_PLL_PWRDN_BIT         9   
 #define FW_DSTATE_OPTIMIZE_MALL_REFRESH_BIT 10
 #define FW_DSTATE_MEM_PSI_BIT               11
+#define FW_DSTATE_HSR_NON_STROBE_BIT        12
+#define FW_DSTATE_MP0_ENTER_WFI_BIT         13
 
 #define FW_DSTATE_SOC_ULV_MASK                    (1 << FW_DSTATE_SOC_ULV_BIT          )
 #define FW_DSTATE_G6_HSR_MASK                     (1 << FW_DSTATE_G6_HSR_BIT           )
@@ -239,6 +241,8 @@ typedef enum {
 #define FW_DSTATE_MEM_PLL_PWRDN_MASK              (1 << FW_DSTATE_MEM_PLL_PWRDN_BIT    )
 #define FW_DSTATE_OPTIMIZE_MALL_REFRESH_MASK      (1 << FW_DSTATE_OPTIMIZE_MALL_REFRESH_BIT    )
 #define FW_DSTATE_MEM_PSI_MASK                    (1 << FW_DSTATE_MEM_PSI_BIT    )
+#define FW_DSTATE_HSR_NON_STROBE_MASK             (1 << FW_DSTATE_HSR_NON_STROBE_BIT    )
+#define FW_DSTATE_MP0_ENTER_WFI_MASK              (1 << FW_DSTATE_MP0_ENTER_WFI_BIT    )
 
 // GFX GPO Feature Contains PACE and DEM sub features
 #define GFX_GPO_PACE_BIT                   0
@@ -804,7 +808,11 @@ typedef struct {
   uint32_t         VcBtcVminA;                  // A_VMIN
   uint32_t         VcBtcVminB;                  // B_VMIN  
   
-  uint32_t         SkuReserved[9];
+  //GPIO Board feature
+  uint16_t         LedGpio;            //GeneriA GPIO flag used to control the radeon LEDs
+  uint16_t         GfxPowerStagesGpio; //Genlk_vsync GPIO flag used to control gfx power stages 
+  
+  uint32_t         SkuReserved[8];
 
 
   // MAJOR SECTION: BOARD PARAMETERS
@@ -1026,6 +1034,8 @@ typedef struct {
   uint16_t VcnActivityPercentage  ; //place holder, David N. to provide full sequence
   uint8_t  PcieRate               ;
   uint8_t  PcieWidth              ;
+  uint16_t AverageGfxclkFrequencyTarget;  uint16_t Padding16_2;
 
 } SmuMetrics_t;
 
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 75697b78c13f..820b9d34c997 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36  #define SMU11_DRIVER_IF_VERSION_NV12 0x36  #define SMU11_DRIVER_IF_VERSION_NV14 0x36 -#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x39
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3A
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x4
 
 /* MP Apertures */
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
