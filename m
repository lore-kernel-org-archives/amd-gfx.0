Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AD2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 00:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22AAB10E1C0;
	Tue, 19 Apr 2022 00:58:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE7B10E1C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 00:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1XSvCT8aT6rvXpdye8V06Gc5Bbi5qwE5U6yt6k7sU3zpnjQ0XjiV3ZSW4m+tPFLgBwRe4k26SkdhRn3+CRnjxGECRxSjRbvySk+EE1dicU/WFNQRf8rPv9xx17J6XKfV7CBXXFmFiAnZBmB76JOT/rKHll6lEvhnlQ2pqSS1IujcSlCLj4Ws/oxhVNvce47xu5rg3vJmOm8WFBuj8Z88VQsiyFM+oZ+9fcSuZsQfTa4DmCfA8mZaaS+qWuAonQE5PHMvDX8pjncygG8mWwPEMlftrNM5uMga53Gg3p4P53DqXWgumq7mHAdYuG5k8SIirjTX+Lr5zXEMKZGNe1q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQaamNqpom96bRYDzZUSLYLM2fnAI0Mjkm941wzeVKs=;
 b=FRENQf+ooUYKDjL4U1bvdffXG4Re/Y3fo6Y+kk3U0omEn71pLcRzlWKID8UNImq7SrZjQrjWFdMPhmb5osBI+4CO3n8Hms0dtXw1ITsfd+WiQBfzIEi7g4UPLUaES3DMSc9dDkfh8TNuXKM/4vIHhdz5D+oIvKwxXCL1j6VyhhjPzqjImhyMYlhIdyed8x2Hfxv+R20OzCMTndGJJxtCXM+rJlli4abBXqgJIcrLqISu82XyyHv+cBP5AM+751DZunyebrUKCQU7NCz7NbFYkdpnLdyXyt+lXBWYSuAL+BvLoikTDj7c0lvUlQyVzWcjeylqEXllH1EqIZKSkcSKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQaamNqpom96bRYDzZUSLYLM2fnAI0Mjkm941wzeVKs=;
 b=l96ddKSA+7Q2cEFet4lJr7m7bB1vVbJ/1iQHDHMX53OjP9c9BB6duQbS+OKTW6IziXdj6AsWYukoAXZpp9POzjMASkySD63KcvVsJau8zKiE+QUTa1uJd95o1E/rgdkD1i+L+4OC37Dgj07pKwtajgNhOgmLWyeaH1RL7CD3FK8=
Received: from CY4PR12MB1496.namprd12.prod.outlook.com (2603:10b6:910:10::8)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 00:58:41 +0000
Received: from CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::b802:f477:9024:61a2]) by CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::b802:f477:9024:61a2%9]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 00:58:41 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke support
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke support
Thread-Index: AQHYUtHRcmK+eJf1TUO7t9dJebl2v6z1CRQAgAFgMaA=
Date: Tue, 19 Apr 2022 00:58:41 +0000
Message-ID: <CY4PR12MB1496E63A6D2A6AA11A8300C691F29@CY4PR12MB1496.namprd12.prod.outlook.com>
References: <20220418030927.11320-1-candice.li@amd.com>
 <20220418030927.11320-2-candice.li@amd.com>
 <CO6PR12MB5473BE8C2250B7607FA6F86682F39@CO6PR12MB5473.namprd12.prod.outlook.com>
In-Reply-To: <CO6PR12MB5473BE8C2250B7607FA6F86682F39@CO6PR12MB5473.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-19T00:50:32Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b1b842a1-b673-4504-9311-e71d84e170c4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-19T00:58:38Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 622d0b5b-db96-41d3-aa2d-b41fd6cb94ff
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb4defa8-b2e1-4017-87f9-08da219fbf08
x-ms-traffictypediagnostic: SA0PR12MB4429:EE_
x-microsoft-antispam-prvs: <SA0PR12MB442989266322CF2B5E21DB2E91F29@SA0PR12MB4429.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5zbKoqmvOz2git/S6TEKMSZnwA06DJOonshOgj/DOXsbLZuaOVm+NmxdX/WEbsCCyQOhVS/WNhnzGHM0Z2ylTNnWn5q5aMtUSy3dXv6yS4rvEidgKpIr3/m3AEf2xs09T4Kc16pe+f7FBGNldO++XBOF1xkTDFYozGaH6BLZLPAVxezwgK+QPU5llWILaZ3JNpHE9CC/d8abVgdmZwa1f1gKLjk7cSp4ARZ6wrcTvUwqjKFuMlJDx0B1ASapXfh18mgpHbgn+VOA4y95Jy1e2M8DENuzprUn6gQ7WYAckqoos+udFn+B+74+gPQv2OOW/K8p4qJN1TB8gaih7L+feZeyYX8O4DuCfent+mAbsoQz3zdv9kx03RiluDxe6vefSqZGAdtrv2YbS1Q6Pg7kgH5eH0LpiJgGzeShpVDs+rNnqFPv3/yCwVjmeMvYWlH+Pol6FqmlsbCRcSy2OK6M035q3FttPIOyU45sVbLeL5Bp4ddoSGUj8bsqfXh/0GbwUsE8ahW/Sdnpem8U6rCBD8v4VyO3OELEbI7zJEOQ2g3cOP+j9U0E82y1vOQOU78hauTEd3rN6rusabKLSHL18nnk1Cycibz/HmOtnyotmt8xgpXKA5Ew0LR4G8OoSMdUwSZ7ilGzMFf9LOYsIJBl7fehvIxRYg6YaNglQZSfyXbeVzWlna801rlNMlRkzmXKi3p0RjHDskupCx8UvyXSrf4UirK2pVY0UWS57OruAw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1496.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(86362001)(316002)(8676002)(53546011)(186003)(2906002)(38070700005)(83380400001)(55016003)(38100700002)(9686003)(6506007)(122000001)(7696005)(4326008)(71200400001)(33656002)(66476007)(66946007)(64756008)(26005)(8936002)(76116006)(5660300002)(52536014)(110136005)(30864003)(66556008)(66446008)(461764006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ljotqsZFbEgAzzvADw6cH7jtb21WYmsGe+8TyT6xuBDtHR7B/Zio6venymcF?=
 =?us-ascii?Q?xBuUmhKAz49P6v6HtrAMliX8sTZvZXKkSgzaNxmKXfv/TR2rtd98XPN/ZUyi?=
 =?us-ascii?Q?wyCaFWJ4H+mOIblFzDmnU+bG8NCcYlMb3uMAw8pG4xLXJlWPDlzgoQUtmsdD?=
 =?us-ascii?Q?4DD88bBNLQ7XzpBPmU1qR/MLYkyFqeNp0pOIn2baVuAc/BtYmsNO4ZX0d9a8?=
 =?us-ascii?Q?gapln6VTZsUhJ3QaLKstZaVn8leIR5+6vkEfV1oCgtz/OShBS/jqPoNnjJw5?=
 =?us-ascii?Q?89tJk8BTV3Fwybj1oh9Kjj1J7dBtx644UM9jWv581OZV6GtF6FuMU2B8ojMb?=
 =?us-ascii?Q?vEPUJ3tbrWRG/axsVIa/HL43OpNVGqNWs6tKUiH4B9PVRUgkGOhDKgMzSrxA?=
 =?us-ascii?Q?SKgQtfRHrgBKkVv9XBff/dOb9OVslLwgkk7cJm8xNw95O4oEnDFcnSebnniZ?=
 =?us-ascii?Q?+2V2e5985v3JG6mGWc1YKVLYgSmXwiBMyE55ciZ2XpgbVf/3Shnnpv9EnF9h?=
 =?us-ascii?Q?PrQPpfO6Z4beBmVIz0w4fMgFDi+1HWQ1BEfm80oSx//FT3jH+ZOKKajAMSBH?=
 =?us-ascii?Q?u5xbUIPA9MR51vK73eacWdzXsx5+s/edEK9bvPi4vfrJF470T/YdUAYqKZEG?=
 =?us-ascii?Q?gXJXlyTciGbvxyFFIqkcS9KWojVU9QhndBOmYbn7VnyXzv7YaNbOsjkoDqKF?=
 =?us-ascii?Q?SnjAieLel6W7PH4B3nkv7ro6XcAYcozBc9hqwwEE5K6mWt9zhk+fA4+Z4oe1?=
 =?us-ascii?Q?jYpnJukecyCQmK3hAbZMgL07aQ5PbDMweJR29tP6smGFe1/VEdsKlosqpMXP?=
 =?us-ascii?Q?eGt4oTJBIzBXzZb0vh7eGQBNfG5wN+GXsx8gkiZLccupSCO5dnY1Y5owkqA2?=
 =?us-ascii?Q?URWjk31pUyJPgoRkY6xmVDjA7jcmvbkycrTsHVnxx6L9elOMI5Gbf3jqLfbL?=
 =?us-ascii?Q?vgeUgEbJWfZ2P/jUnE3KtMjL0wrIObbJhA15JKqHTagST56IagxYOsdwiaFm?=
 =?us-ascii?Q?xm8BGPqtn9MI3shwl8q5UjMQQ5gwulED8UcP9MoLfH/OauRWwOhAqnORD79Y?=
 =?us-ascii?Q?IaIQ/CEyRkmhUBqvrpyT9oOB17mWQcyOUrPSwi7sp0kK4vwH1sviYDLaG10A?=
 =?us-ascii?Q?6YyXsRDUXKF44FnFjAWYK66+rLL+dxWZLPb94X2czISduceLGK0GYPvHm/L9?=
 =?us-ascii?Q?fwft+G5NOGxjyIgOPm7cszp1bmUY0pMSWlg/AoJM8dhmmSdHD7yGRH8zF5ng?=
 =?us-ascii?Q?+46G+8igXNT5GpXhi0NVa/v8nz61NcHmICB9yIK026c/lvR9ITJVYOiSNfsa?=
 =?us-ascii?Q?kFoIKS8hnLiwHzrPufAU2s7pcWM/7T5wZUMCbowcxsbsfSoEMwvYYVeX616I?=
 =?us-ascii?Q?LhCMSLEk1Gkt7V3XUUTjEg8wf382oDLkyzoKE8PM8HTDw5GhJGZ6qKKHZnUo?=
 =?us-ascii?Q?un8+pBRCPW7ygIy5yAngy6cIeYp4PUgeX3p0o3zZ/Ke3Ludq0BSVxQlgqGKx?=
 =?us-ascii?Q?ad3xWM1EyDOwmQYtehuOov/CRfjbXdww6CjujxSDrq60PVtBWRujI2UuE+q0?=
 =?us-ascii?Q?8wiErVPYeVgp8C8ExnQynkxdG/3K5/mpV2k8fdhjyMygX3f0R/axQO6j5AWP?=
 =?us-ascii?Q?uSrIxnuKRF0NT/SngXst4X2cm4+ZkrybMAO1xQum0efvwDQOG+r053ArkA9c?=
 =?us-ascii?Q?QEIULqo2u3wfiZfStzKZNf9fseju8Bv4hh1GF+6dM2thHg/n?=
Content-Type: multipart/alternative;
 boundary="_000_CY4PR12MB1496E63A6D2A6AA11A8300C691F29CY4PR12MB1496namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4defa8-b2e1-4017-87f9-08da219fbf08
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 00:58:41.2214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8bJjr9mSezGddZ5szA/L1gWq+2efAgx+bM3PJzkQqhpzeYcYmtL0KCHicREnMa+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
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
Cc: "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CY4PR12MB1496E63A6D2A6AA11A8300C691F29CY4PR12MB1496namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Thanks for the review, comments in line.



Thanks,
Candice

From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, April 18, 2022 11:50 AM
To: Li, Candice <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke supp=
ort



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Candice Li <candice.li@amd.com<mailto=
:candice.li@amd.com>>
Sent: Monday, April 18, 2022 11:09 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Li, Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Clements, =
John <John.Clements@amd.com<mailto:John.Clements@amd.com>>
Subject: [PATCH 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke support

Add debugfs support to load/unload/invoke TA in runtime.

Signed-off-by: John Clements <john.clements@amd.com<mailto:john.clements@am=
d.com>>
Signed-off-by: Candice Li <candice.li@amd.com<mailto:candice.li@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c  | 312 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h  |  30 ++
 4 files changed, 345 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 7d7af43a258f83..b525f9be9326f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -58,7 +58,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
         amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbi=
o.o \
         amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
         amdgpu_fw_attestation.o amdgpu_securedisplay.o \
-       amdgpu_eeprom.o amdgpu_mca.o
+       amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o

 amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 13e4d8f9b87449..eedb12f6b8a32d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -38,6 +38,7 @@
 #include "amdgpu_umr.h"

 #include "amdgpu_reset.h"
+#include "amdgpu_psp_ta.h"

 #if defined(CONFIG_DEBUG_FS)

@@ -1767,6 +1768,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
                 DRM_ERROR("registering register debugfs failed (%d).\n", r=
);

         amdgpu_debugfs_firmware_init(adev);
+       amdgpu_ta_if_debugfs_init(adev);

 #if defined(CONFIG_DRM_AMD_DC)
         if (amdgpu_device_has_dc_support(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
new file mode 100644
index 00000000000000..916bf3f6fce0d4
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -0,0 +1,312 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_psp_ta.h"
+
+static const char *TA_IF_FS_NAME =3D "ta_if";
+
+struct dentry *dir;
+struct dentry *ta_load_debugfs_dentry;
+struct dentry *ta_unload_debugfs_dentry;
+struct dentry *ta_invoke_debugfs_dentry;

[kevin]:

make above variable as static is better for this case, but it seems it is n=
ot used in this patch?
if so, you will get a "defined but not used" error, when turn on build opti=
on " -Werror=3Dunused-variable".

Please don't mind this prompt.

Best Regards,
Kevin

[Candice] Thanks for the review. These variables are used in my patch.
Will update ta_load/unload/invoke_debugfs_dentry to static in v2, but dentr=
y dir will be used by amdgpu_ta_if_debugfs_remove, so it should be not.

+
+static ssize_t ta_if_load_debugfs_read(struct file *fp, char *buf, size_t =
len, loff_t *off);
+static ssize_t ta_if_unload_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off);
+static ssize_t ta_if_invoke_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off);
+
+
+static uint32_t get_bin_version(const uint8_t *bin)
+{
+       const struct common_firmware_header *hdr =3D
+                            (const struct common_firmware_header *)bin;
+
+       return hdr->ucode_version;
+}
+
+static uint32_t get_shared_buf_size(uint32_t shared_buf_len)
+{
+       return (shared_buf_len % PAGE_SIZE) ?
+                            (shared_buf_len/PAGE_SIZE + 1) * PAGE_SIZE :
+                            shared_buf_len;
[kevin]:

  1.  the above code can be replaced with "ALIGN" macro..
  2.
  3.   #define ALIGN(x, a)>---->-------__ALIGN_KERNEL((x), (a)
[Candice] Thanks for the suggestion, I will replace it with PAGE_ALIGN macr=
o directly in v2.

  1.  do you forget to add some lock resource to protect/cover multi proces=
s case?
  2.  e.g: process#1 exec load_ta() and process#2 exec unload_ta()
[Candice] We already have psp->mutex there for psp cmd submission, do we st=
ill need another one?

and why not use write operation instead of read (load/unload/invoke) ? this=
 seems more reasonable.

[Candice] The debugfs write doesn't allow the kernel to copy data back to t=
he user, so with debugfs read, we can copy data from the user, then copy da=
ta back to the user.


Best Regards,
Kevin



+}
+
+static void prep_ta_mem_context(struct psp_context *psp,
+                                            struct ta_context *context,
+                                            uint8_t *shared_buf,
+                                            uint32_t shared_buf_len)
+{
+       context->mem_context.shared_mem_size =3D get_shared_buf_size(shared=
_buf_len);
+       psp_ta_init_shared_buf(psp, &context->mem_context);
+
+       memcpy((void *)context->mem_context.shared_buf, shared_buf, shared_=
buf_len);
+}
+
+static bool is_ta_type_valid(enum ta_type_id ta_type)
+{
+       bool ret =3D false;
+
+       switch (ta_type) {
+       case TA_TYPE_RAS:
+               ret =3D true;
+               break;
+       default:
+               break;
+       }
+
+       return ret;
+}
+
+static const struct file_operations ta_load_debugfs_fops =3D {
+       .read   =3D ta_if_load_debugfs_read,
+       .llseek =3D default_llseek,
+       .owner  =3D THIS_MODULE
+};
+
+static const struct file_operations ta_unload_debugfs_fops =3D {
+       .read   =3D ta_if_unload_debugfs_read,
+       .llseek =3D default_llseek,
+       .owner  =3D THIS_MODULE
+};
+
+static const struct file_operations ta_invoke_debugfs_fops =3D {
+       .read   =3D ta_if_invoke_debugfs_read,
+       .llseek =3D default_llseek,
+       .owner  =3D THIS_MODULE
+};
+
+
+/**
+ * DOC: AMDGPU TA debugfs interfaces
+ *
+ * Three debugfs interfaces can be opened by a program to
+ * load/invoke/unload TA,
+ *
+ * - /sys/kernel/debug/dri/<N>/ta_if/ta_load
+ * - /sys/kernel/debug/dri/<N>/ta_if/ta_invoke
+ * - /sys/kernel/debug/dri/<N>/ta_if/ta_unload
+ *
+ * How to use the interfaces in a program?
+ *
+ * A program needs to provide transmit buffer to the interfaces
+ * and will receive buffer from the interfaces below,
+ *
+ * - For TA load debugfs interface:
+ *   Transmit buffer:
+ *    - TA type (4bytes)
+ *    - TA bin length (4bytes)
+ *    - TA bin
+ *   Receive buffer:
+ *    - TA ID (4bytes)
+ *
+ * - For TA invoke debugfs interface:
+ *   Transmit buffer:
+ *    - TA ID (4bytes)
+ *    - TA CMD ID (4bytes)
+ *    - TA shard buf length (4bytes)
+ *    - TA shared buf
+ *   Receive buffer:
+ *    - TA shared buf
+ *
+ * - For TA unload debugfs interface:
+ *   Transmit buffer:
+ *    - TA ID (4bytes)
+ */
+
+static ssize_t ta_if_load_debugfs_read(struct file *fp, char *buf, size_t =
len, loff_t *off)
+{
+       uint32_t ta_type    =3D 0;
+       uint32_t ta_bin_len =3D 0;
+       uint8_t  *ta_bin    =3D NULL;
+       uint32_t copy_pos   =3D 0;
+       int      ret        =3D 0;
+
+       struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode=
(fp)->i_private;
+       struct psp_context   *psp    =3D &adev->psp;
+       struct ta_context    context =3D {0};
+
+       if ((fp =3D=3D NULL) || (buf =3D=3D NULL))
+               return -EINVAL;
+
+       ret =3D copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uin=
t32_t));
+       if (ret || (!is_ta_type_valid(ta_type)))
+               return -EINVAL;
+
+       copy_pos +=3D sizeof(uint32_t);
+
+       ret =3D copy_from_user((void *)&ta_bin_len, &buf[copy_pos], sizeof(=
uint32_t));
+       if (ret)
+               return -EINVAL;
+
+       copy_pos +=3D sizeof(uint32_t);
+
+       ta_bin =3D kzalloc(ta_bin_len, GFP_KERNEL);
+       if (!ta_bin)
+               ret =3D -ENOMEM;
+       ret =3D copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len);
+       if (ret)
+               goto err_free_bin;
+
+       ret =3D psp_ras_terminate(psp);
+       if (ret) {
+               dev_err(adev->dev, "Failed to unload embedded RAS TA\n");
+               goto err_free_bin;
+       }
+
+       context.ta_type             =3D ta_type;
+       context.ta_load_type        =3D GFX_CMD_ID_LOAD_TA;
+       context.bin_desc.fw_version =3D get_bin_version(ta_bin);
+       context.bin_desc.size_bytes =3D ta_bin_len;
+       context.bin_desc.start_addr =3D ta_bin;
+
+       ret =3D psp_ta_load(psp, &context);
+
+       if (ret || context.resp_status) {
+               dev_err(adev->dev, "TA load via debugfs failed (%d) status =
%d\n",
+                        ret, context.resp_status);
+               goto err_free_bin;
+       }
+
+       context.initialized =3D true;
+       ret =3D copy_to_user((char *)buf, (void *)&context.session_id, size=
of(uint32_t));
+
+err_free_bin:
+       kfree(ta_bin);
+
+       return ret;
+}
+
+static ssize_t ta_if_unload_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off)
+{
+       uint32_t ta_id  =3D 0;
+       int      ret    =3D 0;
+
+       struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode=
(fp)->i_private;
+       struct psp_context   *psp    =3D &adev->psp;
+       struct ta_context    context =3D {0};
+
+       if ((fp =3D=3D NULL) || (buf =3D=3D NULL))
+               return -1;
+
+       ret =3D copy_from_user((void *)&ta_id, buf, sizeof(uint32_t));
+       if (ret)
+               return -EINVAL;
+
+       context.session_id =3D ta_id;
+
+       ret =3D psp_ta_unload(psp, &context);
+       if (!ret)
+               context.initialized =3D false;
+
+       return ret;
+}
+
+static ssize_t ta_if_invoke_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off)
+{
+       uint32_t ta_id          =3D 0;
+       uint32_t cmd_id         =3D 0;
+       uint32_t shared_buf_len =3D 0;
+       uint8_t  *shared_buf    =3D NULL;
+       uint32_t copy_pos       =3D 0;
+       int      ret            =3D 0;
+
+       struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode=
(fp)->i_private;
+       struct psp_context   *psp    =3D &adev->psp;
+       struct ta_context    context =3D {0};
+
+       if ((fp =3D=3D NULL) || (buf =3D=3D NULL))
+               return -EINVAL;

[kevin]:
   "if ((fp =3D=3D NULL) ..."
   The linux kernel will automatically create struct file instance when you=
 open the file, even if you do not provide a callback function (in fops)

[kevin]:

      you should add some check here to avoid that the user buf is overflow=
.
      e.g: If the length of the user buf is less than that required, an err=
or should be returned directly

[Candice] Will remove the fp check in v2. Current check should be enough, c=
opy_from_user will not access the buf if there is no more length.

+
+       ret =3D copy_from_user((void *)&ta_id, &buf[copy_pos], sizeof(uint3=
2_t));
+       if (ret)
+               return -EINVAL;
+       copy_pos +=3D sizeof(uint32_t);
+
+       ret =3D copy_from_user((void *)&cmd_id, &buf[copy_pos], sizeof(uint=
32_t));
+       if (ret)
+               return -EINVAL;
+       copy_pos +=3D sizeof(uint32_t);
+
+       ret =3D copy_from_user((void *)&shared_buf_len, &buf[copy_pos], siz=
eof(uint32_t));
+       if (ret)
+               return -EINVAL;
+       copy_pos +=3D sizeof(uint32_t);
+
+       shared_buf =3D kzalloc(shared_buf_len, GFP_KERNEL);
+       if (!shared_buf)
+               ret =3D -ENOMEM;
+       ret =3D copy_from_user((void *)shared_buf, &buf[copy_pos], shared_b=
uf_len);
+       if (ret)
+               goto err_free_shared_buf;
+
+       context.session_id =3D ta_id;
+
+       prep_ta_mem_context(psp, &context, shared_buf, shared_buf_len);
+
+       ret =3D psp_ta_invoke_indirect(psp, cmd_id, &context);
+
+       if (ret || context.resp_status) {
+               dev_err(adev->dev, "TA invoke via debugfs failed (%d) statu=
s %d\n",
+                        ret, context.resp_status);
+               goto err_free_ta_shared_buf;
+       }
+
+       ret =3D copy_to_user((char *)buf, context.mem_context.shared_buf, s=
hared_buf_len);
+
+err_free_ta_shared_buf:
+       psp_ta_free_shared_buf(&context.mem_context);
+
+err_free_shared_buf:
+       kfree(shared_buf);
+
+       return ret;
+}
+
+static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *ad=
ev)
+{
+       struct drm_minor *minor =3D adev_to_drm(adev)->primary;
+
+       dir =3D debugfs_create_dir(TA_IF_FS_NAME, minor->debugfs_root);
+
+       ta_load_debugfs_dentry =3D debugfs_create_file("ta_load", 0400, dir=
, adev,
+                                                    &ta_load_debugfs_fops)=
;
+
+       ta_unload_debugfs_dentry =3D debugfs_create_file("ta_unload", 0400,=
 dir,
+                                                    adev, &ta_unload_debug=
fs_fops);
+
+       ta_invoke_debugfs_dentry =3D debugfs_create_file("ta_invoke", 0400,=
 dir,
+                                                    adev, &ta_invoke_debug=
fs_fops);
+       return dir;
+}
+
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+       dir =3D amdgpu_ta_if_debugfs_create(adev);
+#endif
+}
+
+void amdgpu_ta_if_debugfs_remove(void)
+{
+       debugfs_remove_recursive(dir);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.h
new file mode 100644
index 00000000000000..883f89d57616d0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_PSP_TA_H__
+#define __AMDGPU_PSP_TA_H__
+
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);
+void amdgpu_ta_if_debugfs_remove(void);
+
+#endif
--
2.17.1

--_000_CY4PR12MB1496E63A6D2A6AA11A8300C691F29CY4PR12MB1496namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.elementtoproof
	{mso-style-name:elementtoproof;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:635139098;
	mso-list-template-ids:763805384;}
@list l0:level1
	{mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1
	{mso-list-id:776681118;
	mso-list-template-ids:763805384;}
@list l2
	{mso-list-id:1150439283;
	mso-list-template-ids:763805384;}
@list l2:level1
	{mso-level-start-at:2;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3
	{mso-list-id:1299803927;
	mso-list-template-ids:763805384;}
@list l3:level1
	{mso-level-start-at:2;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks for the review, comments in line.<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#44546A">Thanks,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#44546A">Candice<o:p></o:p></sp=
an></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@am=
d.com&gt; <br>
<b>Sent:</b> Monday, April 18, 2022 11:50 AM<br>
<b>To:</b> Li, Candice &lt;Candice.Li@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
<b>Cc:</b> Clements, John &lt;John.Clements@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Add debugfs TA load/unload/invo=
ke support<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Candice Li &lt;<a href=3D"mailto:candice.li@amd.com">candice.li@amd.com</=
a>&gt;<br>
<b>Sent:</b> Monday, April 18, 2022 11:09 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd.com">Candice.Li=
@amd.com</a>&gt;; Clements, John &lt;<a href=3D"mailto:John.Clements@amd.co=
m">John.Clements@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke s=
upport</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">Add debugfs support to load/unload/invoke TA in runt=
ime.<br>
<br>
Signed-off-by: John Clements &lt;<a href=3D"mailto:john.clements@amd.com">j=
ohn.clements@amd.com</a>&gt;<br>
Signed-off-by: Candice Li &lt;<a href=3D"mailto:candice.li@amd.com">candice=
.li@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |&nbsp;&nbsp; 2 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c&nbsp; | 312 ++++++++++++++=
++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h&nbsp; |&nbsp; 30 ++<br>
&nbsp;4 files changed, 345 insertions(+), 1 deletion(-)<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile<br>
index 7d7af43a258f83..b525f9be9326f4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
@@ -58,7 +58,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_sdma.o amdgpu_di=
scovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc.o smu_v11_0_i2c=
.o amdgpu_fru_eeprom.o amdgpu_rap.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fw_attestation.o am=
dgpu_securedisplay.o \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_eeprom.o amdgpu_mca.o<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_eeprom.o amdgpu_mca.o amdgpu_p=
sp_ta.o<br>
&nbsp;<br>
&nbsp;amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index 13e4d8f9b87449..eedb12f6b8a32d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -38,6 +38,7 @@<br>
&nbsp;#include &quot;amdgpu_umr.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;amdgpu_reset.h&quot;<br>
+#include &quot;amdgpu_psp_ta.h&quot;<br>
&nbsp;<br>
&nbsp;#if defined(CONFIG_DEBUG_FS)<br>
&nbsp;<br>
@@ -1767,6 +1768,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;registering register debugfs failed (=
%d).\n&quot;, r);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_firmware_in=
it(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ta_if_debugfs_init(adev);<br>
&nbsp;<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_has_dc_s=
upport(adev))<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c<br>
new file mode 100644<br>
index 00000000000000..916bf3f6fce0d4<br>
--- /dev/null<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c<br>
@@ -0,0 +1,312 @@<br>
+/*<br>
+ * Copyright 2022 Advanced Micro Devices, Inc.<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
+ * OTHER DEALINGS IN THE SOFTWARE.<br>
+ *<br>
+ */<br>
+<br>
+#include &quot;amdgpu.h&quot;<br>
+#include &quot;amdgpu_psp_ta.h&quot;<br>
+<br>
+static const char *TA_IF_FS_NAME =3D &quot;ta_if&quot;;<br>
+<br>
+struct dentry *dir;<br>
+struct dentry *ta_load_debugfs_dentry;<br>
+struct dentry *ta_unload_debugfs_dentry;<br>
+struct dentry *ta_invoke_debugfs_dentry;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black">[kevin]:</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black">make above variable as static is better for this case, =
but it seems it is not used in this patch?&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black">if so, you will get a &quot;defined but not used&quot; =
error, when turn on build option &quot; -Werror=3Dunused-variable&quot;.</s=
pan><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal"><span class=3D"elementtoproof"><span style=3D"font-f=
amily:&quot;Segoe UI&quot;,sans-serif;color:black">Please don't mind this p=
rompt.</span>
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black">Best Regards,</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black">Kevin</span><span style=3D"font-family:&quot;Segoe UI&q=
uot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span class=3D"elementtoproof"><span style=3D"color:=
#0070C0">[Candice] Thanks for the review. These variables are used in my pa=
tch.
<o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#0070C0">Will update ta_load/un=
load/invoke_debugfs_dentry to static in v2, but dentry dir will be used by =
amdgpu_ta_if_debugfs_remove, so it should be not.<span class=3D"elementtopr=
oof"><o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><br>
+<br>
+static ssize_t ta_if_load_debugfs_read(struct file *fp, char *buf, size_t =
len, loff_t *off);<br>
+static ssize_t ta_if_unload_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off);<br>
+static ssize_t ta_if_invoke_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off);<br>
+<br>
+<br>
+static uint32_t get_bin_version(const uint8_t *bin)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmware_header *=
hdr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (const struct common_firmware_header *)bin;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hdr-&gt;ucode_version;<br>
+}<br>
+<br>
+static uint32_t get_shared_buf_size(uint32_t shared_buf_len)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (shared_buf_len % PAGE_SIZE) ?=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (shared_buf_len/PAGE_SIZE + 1) * PAGE_SIZE :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; shared_buf_len;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">[kevin]:<o:p></o:p></p>
</div>
<div>
<ol start=3D"1" type=3D"1">
<li class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-=
alt:auto;mso-list:l0 level1 lfo3">
the above code can be replaced with &quot;ALIGN&quot; macro..<o:p></o:p></l=
i><li class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-botto=
m-alt:auto;mso-list:l0 level1 lfo3">
<o:p>&nbsp;</o:p></li><li class=3D"MsoNormal" style=3D"mso-margin-top-alt:a=
uto;mso-margin-bottom-alt:auto;mso-list:l0 level1 lfo3">
&nbsp;#define ALIGN(x, a)&gt;----&gt;-------__ALIGN_KERNEL((x), (a)<o:p></o=
:p></li></ol>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"color:#0070C0">[Candice] Thanks for the suggestion,=
 I will replace it with PAGE_ALIGN macro directly in v2.<o:p></o:p></span><=
/p>
<ol start=3D"2" type=3D"1">
<li class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-=
alt:auto;mso-list:l3 level1 lfo6">
do you forget to add some lock resource to protect/cover multi process case=
?<o:p></o:p></li><li class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;m=
so-margin-bottom-alt:auto;mso-list:l3 level1 lfo6">
e.g: process#1 exec load_ta() and process#2 exec unload_ta()<o:p></o:p></li=
></ol>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#0070C0">[Candice] We already h=
ave psp-&gt;mutex there for psp cmd submission, do we still need another on=
e?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal">and why not use write operation instead of read (loa=
d/unload/invoke)
<span style=3D"color:black;background:white">?&nbsp;</span>this seems more =
reasonable.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#0070C0">[Candice] The debugfs =
write doesn't allow the kernel to copy data back to the user, so with debug=
fs read, we can copy data from the user, then copy data back to the user.</=
span><span style=3D"color:#548235"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Kevin<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">+}<br>
+<br>
+static void prep_ta_mem_context(struct psp_context *psp,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_context *context,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *shared_buf,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t shared_buf_len)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;mem_context.shared_mem_si=
ze =3D get_shared_buf_size(shared_buf_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_ta_init_shared_buf(psp, &amp;cont=
ext-&gt;mem_context);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy((void *)context-&gt;mem_contex=
t.shared_buf, shared_buf, shared_buf_len);<br>
+}<br>
+<br>
+static bool is_ta_type_valid(enum ta_type_id ta_type)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ta_type) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TA_TYPE_RAS:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static const struct file_operations ta_load_debugfs_fops =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read&nbsp;&nbsp; =3D ta_if_load_debu=
gfs_read,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner&nbsp; =3D THIS_MODULE<br>
+};<br>
+<br>
+static const struct file_operations ta_unload_debugfs_fops =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read&nbsp;&nbsp; =3D ta_if_unload_de=
bugfs_read,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner&nbsp; =3D THIS_MODULE<br>
+};<br>
+<br>
+static const struct file_operations ta_invoke_debugfs_fops =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read&nbsp;&nbsp; =3D ta_if_invoke_de=
bugfs_read,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner&nbsp; =3D THIS_MODULE<br>
+};<br>
+<br>
+<br>
+/**<br>
+ * DOC: AMDGPU TA debugfs interfaces<br>
+ *<br>
+ * Three debugfs interfaces can be opened by a program to<br>
+ * load/invoke/unload TA,<br>
+ *<br>
+ * - /sys/kernel/debug/dri/&lt;N&gt;/ta_if/ta_load<br>
+ * - /sys/kernel/debug/dri/&lt;N&gt;/ta_if/ta_invoke<br>
+ * - /sys/kernel/debug/dri/&lt;N&gt;/ta_if/ta_unload<br>
+ *<br>
+ * How to use the interfaces in a program?<br>
+ *<br>
+ * A program needs to provide transmit buffer to the interfaces<br>
+ * and will receive buffer from the interfaces below,<br>
+ *<br>
+ * - For TA load debugfs interface:<br>
+ *&nbsp;&nbsp; Transmit buffer:<br>
+ *&nbsp;&nbsp;&nbsp; - TA type (4bytes)<br>
+ *&nbsp;&nbsp;&nbsp; - TA bin length (4bytes)<br>
+ *&nbsp;&nbsp;&nbsp; - TA bin<br>
+ *&nbsp;&nbsp; Receive buffer:<br>
+ *&nbsp;&nbsp;&nbsp; - TA ID (4bytes)<br>
+ *<br>
+ * - For TA invoke debugfs interface:<br>
+ *&nbsp;&nbsp; Transmit buffer:<br>
+ *&nbsp;&nbsp;&nbsp; - TA ID (4bytes)<br>
+ *&nbsp;&nbsp;&nbsp; - TA CMD ID (4bytes)<br>
+ *&nbsp;&nbsp;&nbsp; - TA shard buf length (4bytes)<br>
+ *&nbsp;&nbsp;&nbsp; - TA shared buf<br>
+ *&nbsp;&nbsp; Receive buffer:<br>
+ *&nbsp;&nbsp;&nbsp; - TA shared buf<br>
+ *<br>
+ * - For TA unload debugfs interface:<br>
+ *&nbsp;&nbsp; Transmit buffer:<br>
+ *&nbsp;&nbsp;&nbsp; - TA ID (4bytes)<br>
+ */<br>
+<br>
+static ssize_t ta_if_load_debugfs_read(struct file *fp, char *buf, size_t =
len, loff_t *off)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_type&nbsp;&nbsp;&nbsp; =
=3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_bin_len =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; *ta_bin&nbsp;&nbsp;&nbs=
p; =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t copy_pos&nbsp;&nbsp; =3D 0;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev&nbsp;&nbsp=
; =3D (struct amdgpu_device *)file_inode(fp)-&gt;i_private;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_context&nbsp;&nbsp; *psp&n=
bsp;&nbsp;&nbsp; =3D &amp;adev-&gt;psp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_context&nbsp;&nbsp;&nbsp; c=
ontext =3D {0};<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((fp =3D=3D NULL) || (buf =3D=3D N=
ULL))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)&amp;t=
a_type, &amp;buf[copy_pos], sizeof(uint32_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || (!is_ta_type_valid(ta_type=
)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_pos +=3D sizeof(uint32_t);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)&amp;t=
a_bin_len, &amp;buf[copy_pos], sizeof(uint32_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_pos +=3D sizeof(uint32_t);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_bin =3D kzalloc(ta_bin_len, GFP_KE=
RNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ta_bin)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)ta_bin=
, &amp;buf[copy_pos], ta_bin_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto err_free_bin;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_ras_terminate(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to unload embedded RAS TA\n&q=
uot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto err_free_bin;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.ta_type&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D ta_type;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.ta_load_type&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D GFX_CMD_ID_LOAD_TA;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.bin_desc.fw_version =3D get_b=
in_version(ta_bin);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.bin_desc.size_bytes =3D ta_bi=
n_len;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.bin_desc.start_addr =3D ta_bi=
n;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_ta_load(psp, &amp;context=
);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || context.resp_status) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;TA load via debugfs failed (%d) stat=
us %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret, conte=
xt.resp_status);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto err_free_bin;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.initialized =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_to_user((char *)buf, (vo=
id *)&amp;context.session_id, sizeof(uint32_t));<br>
+<br>
+err_free_bin:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(ta_bin);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static ssize_t ta_if_unload_debugfs_read(struct file *fp, char *buf, size_=
t len, loff_t *off)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_id&nbsp; =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
&nbsp;&nbsp;&nbsp; =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev&nbsp;&nbsp=
; =3D (struct amdgpu_device *)file_inode(fp)-&gt;i_private;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_context&nbsp;&nbsp; *psp&n=
bsp;&nbsp;&nbsp; =3D &amp;adev-&gt;psp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_context&nbsp;&nbsp;&nbsp; c=
ontext =3D {0};<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((fp =3D=3D NULL) || (buf =3D=3D N=
ULL))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -1;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)&amp;t=
a_id, buf, sizeof(uint32_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.session_id =3D ta_id;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_ta_unload(psp, &amp;conte=
xt);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; context.initialized =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">+static ssize_t ta_if_invoke_debugfs_read(struct fil=
e *fp, char *buf, size_t len, loff_t *<span style=3D"color:black;background=
:white">off</span>)<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_id&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cmd_id&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t shared_buf_len =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; *shared_buf&nbsp;&nbsp;=
&nbsp; =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t copy_pos&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<b=
r>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev&nbsp;&nbsp=
; =3D (struct amdgpu_device *)file_inode(fp)-&gt;i_private;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_context&nbsp;&nbsp; *psp&n=
bsp;&nbsp;&nbsp; =3D &amp;adev-&gt;psp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_context&nbsp;&nbsp;&nbsp; c=
ontext =3D {0};<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((fp =3D=3D NULL) || (buf =3D=3D N=
ULL))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black">[kevin]:</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Segoe UI&quot;,sans-serif;color:black;background:white">&nbsp; =
&nbsp;&#8220;if ((fp =3D=3D NULL)&nbsp;...&quot;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Segoe UI&quot;,sans=
-serif;color:black">&nbsp; &nbsp;The linux kernel will automatically create=
 struct file instance when you open the file, even if you do not provide a =
callback function (in fops)</span><o:p></o:p></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal">[kevin]:<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp; &nbsp; &nbsp; you should add some check here =
to avoid that the user buf is overflow.<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><span class=3D"elementtoproof">&nbsp; &nbsp; &nbsp; =
e.g: If the length of the user buf is less than that required, an error sho=
uld be returned directly
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span class=3D"elementtoproof"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#0070C0">[Candice] Will remove =
the fp check in v2. Current check should be enough, copy_from_user will not=
 access the buf if there is no more length.<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)&amp;t=
a_id, &amp;buf[copy_pos], sizeof(uint32_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_pos +=3D sizeof(uint32_t);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)&amp;c=
md_id, &amp;buf[copy_pos], sizeof(uint32_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_pos +=3D sizeof(uint32_t);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)&amp;s=
hared_buf_len, &amp;buf[copy_pos], sizeof(uint32_t));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_pos +=3D sizeof(uint32_t);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shared_buf =3D kzalloc(shared_buf_len=
, GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!shared_buf)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_from_user((void *)shared=
_buf, &amp;buf[copy_pos], shared_buf_len);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto err_free_shared_buf;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context.session_id =3D ta_id;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prep_ta_mem_context(psp, &amp;context=
, shared_buf, shared_buf_len);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_ta_invoke_indirect(psp, c=
md_id, &amp;context);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || context.resp_status) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;TA invoke via debugfs failed (%d) st=
atus %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret, conte=
xt.resp_status);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto err_free_ta_shared_buf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D copy_to_user((char *)buf, con=
text.mem_context.shared_buf, shared_buf_len);<br>
+<br>
+err_free_ta_shared_buf:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_ta_free_shared_buf(&amp;context.m=
em_context);<br>
+<br>
+err_free_shared_buf:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(shared_buf);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *ad=
ev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_minor *minor =3D adev_to_d=
rm(adev)-&gt;primary;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dir =3D debugfs_create_dir(TA_IF_FS_N=
AME, minor-&gt;debugfs_root);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_load_debugfs_dentry =3D debugfs_cr=
eate_file(&quot;ta_load&quot;, 0400, dir, adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &amp;ta_load_debugfs_fops);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_unload_debugfs_dentry =3D debugfs_=
create_file(&quot;ta_unload&quot;, 0400, dir,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev, &amp;ta_unload_debugfs_fops);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_invoke_debugfs_dentry =3D debugfs_=
create_file(&quot;ta_invoke&quot;, 0400, dir,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev, &amp;ta_invoke_debugfs_fops);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dir;<br>
+}<br>
+<br>
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)<br>
+{<br>
+#if defined(CONFIG_DEBUG_FS)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dir =3D amdgpu_ta_if_debugfs_create(a=
dev);<br>
+#endif<br>
+}<br>
+<br>
+void amdgpu_ta_if_debugfs_remove(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_remove_recursive(dir);<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.h<br>
new file mode 100644<br>
index 00000000000000..883f89d57616d0<br>
--- /dev/null<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h<br>
@@ -0,0 +1,30 @@<br>
+/*<br>
+ * Copyright 2022 Advanced Micro Devices, Inc.<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
+ * OTHER DEALINGS IN THE SOFTWARE.<br>
+ *<br>
+ */<br>
+<br>
+#ifndef __AMDGPU_PSP_TA_H__<br>
+#define __AMDGPU_PSP_TA_H__<br>
+<br>
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);<br>
+void amdgpu_ta_if_debugfs_remove(void);<br>
+<br>
+#endif<br>
-- <br>
2.17.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1496E63A6D2A6AA11A8300C691F29CY4PR12MB1496namp_--
