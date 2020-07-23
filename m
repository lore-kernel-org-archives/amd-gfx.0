Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3D7C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 00:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8FE32071A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 00:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vBkvDGiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FE32071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7072C6E0F8;
	Thu, 23 Jul 2020 00:31:48 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750073.outbound.protection.outlook.com [40.107.75.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B206E0F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 00:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIlABRSn5J5EXNALjCyixUerM5H6th9KC2UdfBvs7+Gk4djXljGiQO9rv9GlDVtZdfWKP8psq5Zvna4bF9CArt7/lV+RAfu79hJCsIW7VTMbcQOCzfiv1pbN0SzWHyZv7TdyoMQufK3PFAV6U+qIGJ3LUcFx5jFiPmRzQX/5u25QFKWoIHqihwx9DxlKqzMbb7yIrafE+7965uKSMIC0W0FjraSQZ22tKDE8/s38GYKeWwnZBYJXqxreDNbsy3JgYDj1UOvYuVAM/ZzqxdqDj360Q96Cnoz69oxvBtXI4euLZ3z++cwOsYPG8NQUf+T9WiCqOzox3mFOpHPxJKXrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IYCSDO0NGL5IODP3HkxgD8zeZjb2Ib6TeWwckgmHkY=;
 b=mNk7I5S9+3HqBZhnbj1YVGpc0Rm1g0wqOFRDKqEvIf9MH9IMHe4vK2dewYHrvZzdBsYAaztfMGZxjHtvHb3nWVvTsA9ld1tlyTED6W77LvEI5x1uwxOXljBUcfuulFDgX0pzSzTFx2qHcHy/8m8gU8rdpwu7JmIs+9ZGBBglGsINa+wg8TC2pgljHaMg+B3F2IgB2hg+Xwz1M1LV5vrWS8KplHsyZ1UHWAVFDts28WCK9cEWlALAs74SBAcuxV78sw4cgwLJa1M2P7yZzmyXVEqOGA7xpRxfGwdRV1NZ6avrx0SA00HcV7qFPPYDWOPKv7SNfY9uXLxfvAkK/ssT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IYCSDO0NGL5IODP3HkxgD8zeZjb2Ib6TeWwckgmHkY=;
 b=vBkvDGiME+2VTowuyFb7u/EuVQ+cCLX+Vsd3I+KEM0G2qm/qRRKe/k65EfzxW5RbNPQG0MR8UITJMz5WfiJZQq2x6ZLxXP6yIuP3MkhrknF1sR65m4F5LJ7aGEfe5KZgcTG2bG+jFnEPqJAR5B++q/XQK/rl2BdpnsZbh7ZK2Ik=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB3484.namprd12.prod.outlook.com (2603:10b6:5:3c::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.25; Thu, 23 Jul 2020 00:31:41 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a%7]) with mapi id 15.20.3195.027; Thu, 23 Jul 2020
 00:31:41 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, 
 Stanley" <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, 
 John" <John.Clements@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: add bad page count threshold in module
 parameter
Thread-Topic: [PATCH 1/5] drm/amdgpu: add bad page count threshold in module
 parameter
Thread-Index: AQHWX9ZA7Y1tnSIE0USL58EWwo/eKqkUUI3g
Date: Thu, 23 Jul 2020 00:31:41 +0000
Message-ID: <DM5PR12MB25332D58B47ABB52BFBD1A4DED760@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200722031415.4792-1-guchun.chen@amd.com>
 <20200722031415.4792-2-guchun.chen@amd.com>
In-Reply-To: <20200722031415.4792-2-guchun.chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-23T00:31:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=aff5611b-f1f6-431f-bba8-0744e112a389;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61f3d3e3-d6e3-4bb4-a464-08d82e9fc537
x-ms-traffictypediagnostic: DM6PR12MB3484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB348466DA1C282053972FCA05ED760@DM6PR12MB3484.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JaUjnWq86vngs3sDZ9+SfbEqQip721RuTODOlgyFffZrnb8fj1PIyiHah1+QYTaTRxIyrieox1MQB6bg6u4uiuW88W9SCjT0kzDLl4k2Ju157vsrBCl29QqRAII82fi9ThNz/uOfRGbiAkwJpbuAkb3cmSaEJDSysLF7Exi4AsGtYTslM9sjUqvoX3Wo+XPI0AlY/yPF6mDAflwvf8jO/PZal7GVGg9qj6/2kMi7bW5TNodQKQig9gTpOW8gO8OVLGxwzGeLD+Leo7mgXKt1D7Tr9NqHk6fTqTWzs2aYnQ9zdcbEwwXfMNphcEwSsgGV+x/PpKTHyXhJcnpNhmhDxMio4Drs4aaXBoer1b4X13wlpHxLwFE3gQd2ARx79hmJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(66556008)(64756008)(66446008)(66946007)(66476007)(76116006)(33656002)(316002)(52536014)(2906002)(71200400001)(26005)(6506007)(53546011)(86362001)(7696005)(186003)(8676002)(83380400001)(110136005)(478600001)(6636002)(8936002)(5660300002)(55016002)(9686003)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wo1G/lJfRlu22lPVpAQjmzieX1ZtMPlgE7ARNTtcBis75aWyo4VmsDZgLRptSATbuvYUg85XSM3Z7iA4HXV4CRWCrZfY1xTsoM1N3w0PxTU12wRYc4MB03K0UFPIWb7Lr2GvoB6pgjAltuDoi7E/4wZKKHiOxZsV/e7ICmFFMy2lO+PPvIuURuLHerSrlVYi2eTKuBrjXVRQRZbLDJ7aCNHUbgBJko1w9XB7nWeg+/VyAAOYFBrnRcwKq+BysUIh35fPX5ZVOTMNSGIE5kQ9XPxPdkU6F2oAri7j7dnmaPJp6ZCxgsLvuOon7Maesn2wgdsJmelKK1ddELTpXm7C5hdNk2L90z53TT3QJpjZbxWp+iczwMGWOEQ75GbnEXDLoqAGR7cKY7HMl2DG3M+QyKh+dXMVoYZYpxSqB1NSFgcyQV6dPqGGKvcLY8mWJf7FCu1uGyHkXb/I0nxacDmelR0moY687yftvQoFGjeLMbfygujQip/tF8V3HJDO5I+/
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f3d3e3-d6e3-4bb4-a464-08d82e9fc537
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 00:31:41.4432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AunQx0w88+jV1ZktMaxMk+YVCyrwnhISoYxr1BmVOaqnUNLHxzYGMG6hrC97z54p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3484
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

Hi, Guchun,
      It is better to let user be able to change amdgpu_bad_page_threshold with sysfs, so that users no need to reboot system when they want to change their strategy.  

Best Regards
Dennis Li
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Wednesday, July 22, 2020 11:14 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: add bad page count threshold in module parameter

bad_page_threshold could be specified to detect and retire bad GPU if faulty bad pages exceed it.

When it's -1, ras will use typical bad page failure value.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 06bfb8658dec..bb83ffb5e26a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -181,6 +181,7 @@ extern uint amdgpu_dm_abm_level;  extern struct amdgpu_mgpu_info mgpu_info;  extern int amdgpu_ras_enable;  extern uint amdgpu_ras_mask;
+extern int amdgpu_bad_page_threshold;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
 extern int amdgpu_discovery;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d28b95f721c4..f99671101746 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -161,6 +161,7 @@ struct amdgpu_mgpu_info mgpu_info = {  };  int amdgpu_ras_enable = -1;  uint amdgpu_ras_mask = 0xffffffff;
+int amdgpu_bad_page_threshold = -1;
 
 /**
  * DOC: vramlimit (int)
@@ -801,6 +802,16 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);  MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");  module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
+/**
+ * DOC: bad_page_threshold (int)
+ * Bad page threshold configuration is driven by RMA(Return Merchandise
+ * Authorization) policy, which is to specify the threshold value of 
+faulty
+ * pages detected by ECC, which may result in GPU's retirement if total
+ * faulty pages by ECC exceed threshold value.
+ */
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = 
+auto(default typical value))"); module_param_named(bad_page_threshold, 
+amdgpu_bad_page_threshold, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {  #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
