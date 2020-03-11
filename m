Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F6FC10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 07:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A2D2146E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 07:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jDkVh/ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A2D2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D3E89B69;
	Wed, 11 Mar 2020 07:42:11 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750049.outbound.protection.outlook.com [40.107.75.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FEE89B69
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 07:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MulbZZ3cEYmOMNR+R+9IscBsN6PjAIsAvB/Jjjlj0qv76Z3hP71zT69NI7FZn7uGFRC6w8az3cM6PUFEgMAeM6/16HfGoBP3nBsHKJfVx8u/LwMRahjF2gmp0ETF40n4ZTILROodM+iXujSa98O9JDklHoLCN11XxZleZzVZsxWm+clr5Qu4a7uqUgo+upZBvRvYylRB0SN4o4y78dbbHdZAhBwGimBXn+GaCjc//TWtxRHcv6GuIktcOuY3lSGvQcE/RhV+YhPEGqkGY9XnSR1ZA9gEHBGc6CdUnpnU4euUii1STduK94ueOfq1SWSWewDztL9hdfnvtJIPRRfp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6+PzcToQSMTZprnps7ok71WvUC34HL6tTWCBNBU3BM=;
 b=nE6qDJXo1a07DO2cn7cFPPq/l13y4lR5huHo2LdRsEVYoRpZ65WzfzetXSdnZpbxLuO+RpRmllyUkjCTzhkMLKb0WtpF32GWgC6+ArkksxCgc40Ah6MkaVRMkMPrFtARTuOrJpYwLuiofYoLqHmrTE4ZwBQk2BEfI3zafogyuGdZNylrZDz2a2hwZMwHpFXkjgSKyi0oX+SQT5LQ7NSAjkCN5uvy02rh2J42wbc1ijGly0PVnBdDzTsPIzD2ipAV9zJwdi642QQcB8CVqzSwZISgeXB+GbiG8GY7oiriiO+Bdo7P7irDZ8YKAjCDvDGyGMzJBtCtgvEyd1+zJzMR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6+PzcToQSMTZprnps7ok71WvUC34HL6tTWCBNBU3BM=;
 b=jDkVh/adALMnSkWXaFvN/ut4oZlULXv4C8yrZvtfiZg+fMLqyyK6LnlGRvEvns8gUvWGI4DZtKQ8x7gFtOq/3khkbV7s7NAK0Gw/4+czAlB3GWG+jOucNTTKcbg0FgxxsSmwoNh+ZwwgtY5ufHIsn4+1OsZzIMOSoe49Mh4PhFU=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 by BYAPR12MB3605.namprd12.prod.outlook.com (2603:10b6:a03:ae::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Wed, 11 Mar
 2020 07:42:06 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 07:42:06 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use amdgpu_ras.h in amdgpu_debugfs.c
Thread-Topic: [PATCH] drm/amdgpu: use amdgpu_ras.h in amdgpu_debugfs.c
Thread-Index: AQHV92+Sjo/AhE4gd0GhCa4b/vC8S6hDAh+Q
Date: Wed, 11 Mar 2020 07:42:05 +0000
Message-ID: <BYAPR12MB2806E32E2772C2A3989E5CA2F1FC0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20200311063730.4156-1-Stanley.Yang@amd.com>
In-Reply-To: <20200311063730.4156-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-11T07:41:53Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=95a08912-c68c-4c27-82e3-00008be79d8f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-11T07:42:03Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: befe1a13-eedd-4528-a020-0000965dd643
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [101.224.57.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 738f16a4-efca-43d4-de72-08d7c58fb274
x-ms-traffictypediagnostic: BYAPR12MB3605:|BYAPR12MB3605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3605FAF747E74468BCC30FDBF1FC0@BYAPR12MB3605.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:364;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(55016002)(2906002)(9686003)(71200400001)(4326008)(86362001)(66946007)(52536014)(81156014)(498600001)(81166006)(8676002)(5660300002)(186003)(7696005)(8936002)(76116006)(26005)(66556008)(6506007)(110136005)(54906003)(53546011)(64756008)(66476007)(33656002)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3605;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZbSYC/n0qF9Xntnm/cu3eIruRThbxeKhHD5PKeK+ES65Dobjdnkf14v2wyLnI1m5BaaXG3+SIsMjrrewzopPVIu1b/tgvyM01i9Yakh8UM3YWtIn8AktGIOABjXXfkm6lkqAy6wDrCNQio6kAH/oeG/RikY1u0449TSMQUKij00vn3o9UPo+pd4slfaQCEQsEuHsgqqL8lR3ps4Ygvm4ZJDbCAacU62VR7oZCjMtdFkNO3g39UZFn4cH/1ogBdwotCp0YF/BP0kF+bg2Z90w7F8KYAR05ymBe3ubJa04iqy4eBp6a0cg78Rxb7NIe9VfaIHoOUWzy0ZipeXCXOnis0hrHfMDJxXm/Kv1cToJeDYTrUaIw3+TRSNU0cEGBqoWRi7otL1cGDaU6IafSX6Sa06mu/Oi/w24C2wPEAYCVsOzbOKrUSKw41bUXfHX8+MK
x-ms-exchange-antispam-messagedata: 8O+6vX/VmovUO4DFPBGJrBrG6rBJya39UIz57tWHSBfrv5MtPntvDrO3LUz2D9uxhexklCbBS9odVtUXfk0bRXw22XUW9IsLISkiMCYdw0IqUdpRxYn92sZEdpNFMzTGFxrkeqrdIiNIsLzHlP2VEg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738f16a4-efca-43d4-de72-08d7c58fb274
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 07:42:05.9694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rdCSgNE3jrFt4mkPmCZZlgehdp2Lc+zmTQjyxmhbvYBftb2DdHj5cJd25FPJk7XhBUE+gQO7krcunTOKnDH/qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3605
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
Cc: "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Clements, John" <John.Clements@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>


Regards,
Guchun

-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com> 
Sent: Wednesday, March 11, 2020 2:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: use amdgpu_ras.h in amdgpu_debugfs.c

include amdgpu_ras.h head file instead of use extern ras_debugfs_create_all function

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I2697250ba67d4deac4371fea05efb68a976f7e5a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1d513e4f9934..a9a278f87498 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -34,6 +34,7 @@
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_dm_debugfs.h"
+#include "amdgpu_ras.h"
 
 /**
  * amdgpu_debugfs_add_files - Add simple debugfs entries @@ -1315,7 +1316,6 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,  DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
-extern void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);  int amdgpu_debugfs_init(struct amdgpu_device *adev)  {
 	int r, i;
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
