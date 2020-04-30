Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023C6C83003
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 02:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE432083B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 02:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q93QbZAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE432083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 596856E111;
	Thu, 30 Apr 2020 02:42:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A106E111
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 02:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du+9IcQ+UrotG0oe/oCPnzYyLBtTHthJqAmSZBOQJKYcvptPBBO7ytjxAK4xByVNClaeCB3XBpzNGMi587fJNRdK7F73O/w4sZIHYfGpgGjkhDoCa16bEHA6g2sN08uPLArOviQqTCWBrsWCmNu+rMRZhp1LYF4iAF1bjBc8OE0WsG266MeFFgvVZSVrRqNUkUJG2sJ8i/30JfOBOUOtMxlLPy+S74Z0lZ/G1yN2MiEPxDOQiqXfDCRah1BMenmI8wAMd2N/h7UR63y1Dph0C/Rtlkqt4Yq1QpffIvtTT74G3duJTyLa0AbdnNrydh1QTt0vqhnw3T3XYHKoxpNjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXqsUZwI/RC2sBYxRRbU4EOohaJ5TNq42yGN3u2qN+Y=;
 b=IRU+Aoa29auME0eoT6YtMpete0LTffoQDSI/gKc/XO/OrGaXAH7XKVh9UELscW1cmhsX72B01XpQXFvkmLuYmlyPLmZqGkQ7XQdPRlpP5UKWypZulLcFsq1gWiN3n5MyfQ5ttoqNkR99CqlxW9UwozgZ4HTQOaTWnWAwHQrmqdYSvMXRjy4kfAxH2iYXZO4efLTqoZHRjVrMWvtnYtNjQNTzCE6n1+qPWOLI3Njf+OiJBysrd0obT+swEDH+JSthGn5o5bP9cxu4LM+PEmPpSG4eXCTaXlwZ8IuCf/iD/88sP2OCIdG6+SrSFCSV4L2o9BjHDODBvmuU87zRjqsm6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXqsUZwI/RC2sBYxRRbU4EOohaJ5TNq42yGN3u2qN+Y=;
 b=q93QbZAeL0ovX5NKyeZbfgQbhMaZIvCKaRChjGZhxkuDJfsBndQqYkk7+KrxqrvFtFieFl9EKf5gpeFNtIXnzIM573v1BO5mdh63d4qDmKM22VN4HlwbPlL8fQc8uYVsd+/h4/2o/+trKyA5fyq2JTvcyQ/sGPinJFv1zOm+mg4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19; Thu, 30 Apr 2020 02:42:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2937.023; Thu, 30 Apr 2020
 02:42:41 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add unique_id for Arcturus
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add unique_id for Arcturus
Thread-Index: AQHWHLO+5Wqs3dSRkEGKOKKY8fJjB6iQ989g
Date: Thu, 30 Apr 2020 02:42:40 +0000
Message-ID: <DM6PR12MB26198CA4F1E94DD9D8623E2CE4AA0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200427164735.27409-1-kent.russell@amd.com>
 <20200427164735.27409-2-kent.russell@amd.com>
In-Reply-To: <20200427164735.27409-2-kent.russell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f5570c62-8f92-4537-b09e-000085ee6d42;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-30T02:39:45Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39a48881-6368-4659-dd17-08d7ecb0271a
x-ms-traffictypediagnostic: DM6PR12MB4433:|DM6PR12MB4433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB443310255318DC2C9D23BC2EE4AA0@DM6PR12MB4433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJn9KUunarZgvZSBwdlUCIH8uFvOUTBbuLXPE79jD+lSx1rzw2p+ub0u+pG9ewPpZW3TJj2ZVFP0UBJIjzo//4ia00GGJodm96PYJEqog1vAYMQfJDwHAXVLsO1lei3VmJIHsIX92AZ4P8jI90Csi182xBEK0VHxq4LBBWHbaDiMVomYlRNMA2Ys4vGEecqZADhzKThKdLBasa12YxEdCLnjvvvwTsW/XjRnvUfU2NwNQepUgXNTcLFDoIUprZ312aUxuBd3Bj7AaRaiOvg93DgUIYb9ZM1E3rATESk9uFJBkGSVZiXRZTzT2zy1G2x1MIw3m7Q2SaAn8pfwnYMSlqTmt0F58LWtxrblyRIIPh1ofehErRw3fjs8a3wrC0T/tceqI54tVYUmYqa21hucaWtTyRMWL0i9LPRmDF27L3Yx5245a7BVWaUAmyPDx8EXyTPSm9UN1peGlhuPG+pxsX8DgKVFehKYYhZTsFYMSQg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(45080400002)(316002)(110136005)(478600001)(71200400001)(33656002)(64756008)(66946007)(8936002)(66476007)(66446008)(8676002)(76116006)(66556008)(53546011)(52536014)(966005)(2906002)(6506007)(4326008)(5660300002)(7696005)(55016002)(9686003)(186003)(86362001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JmMhJw8adphFc4XhJgWcBXhOj9xZHy3ZTdy/MGmQ+x8gX5fN675gWCVmHRrUFDBKrQ5IkVx+crS1fsxqHISMrdGyakwUlVbJv76teMYQg6st357SFgsbSLncA9CUURwzKM/jqw7fk8G4aBBla764QIldAF1ELy83S9ROnKW3ec5wFdcW5wZI6X636DGp7Eq/VOU/MKHQrdYJkoSKSgV8azjMLqrrjifItQrVtptcOTlr8XC9WgdsFH71trhinOFBWHE1MZdqOiY1JWiRo/wEYiAqGSL81zgF8YOP8NrkBzDXj+mD5MhH58lBHZkwAR6RkHrGJSjzU/yS2qRTfUX8aOd0MBplbW6sKDD/C/qFbbMdyBbNWErZ8S7BXJIXRqYfn3W6y/FGgcF5jo8CQeWkMUdUASf9g1b2udL+Sh6txJo2LHaCNpTHcJ5wNYzncHo8RT7Ar9N4o1Wbz1tLbaLjMHt0OT644a1bUMdOY7B3CJ+KBPvh8dT2VMiOK5lN7nQende+QwsaTQB88P314XJCFY/9vtZhMXri7ICn7+aW0QVTfCIqh00lupXiwQTtHE+PZbUmGoU2YOTi3slXh5WDXeiObpFgH1DTn5wJgqTPBBu8s0+PzD8dctqlm8QW1T2iJssIlwwqDNqn7t8byw/m9M+whjsnzLfT3oypry3oKUEsjxqvPV6OkhTu7fg/OM+Uo8CiW7f5a6HIYeNqqNknfdOJyz/W9a03wg4sbfVMHrJJOreTTOhFvkFO9GnZuRrVRYNVQvVu8ZMABUFtIMYGheWEyFaYqbAhW00AMSpPUxc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a48881-6368-4659-dd17-08d7ecb0271a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 02:42:41.0191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHE5ISU/hU1NV/1eF87As1hY8uNgtibs1IQ6h2BeyW3XG3h76UjNN6dPd+MWhPKd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

arcturus_tables_init() is performed on ip sw_init when the SMU hw may be not ready for message handling.
I would suggest to put this in some API of later SMU hw_init.

Regards,
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent Russell
Sent: Tuesday, April 28, 2020 12:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add unique_id for Arcturus

Add support for unique_id for Arcturus, since we only have the ppsmc
definitions for that added at the moment

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: I66f8e9ff41521d6c13ff673587d6061c1f3f4b7a
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index e98d92ec1eac..f55f9b371bf2 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -293,6 +293,7 @@ static int arcturus_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER
 static int arcturus_tables_init(struct smu_context *smu, struct smu_table *tables)
 {
 struct smu_table_context *smu_table = &smu->smu_table;
+uint32_t top32, bottom32;

 SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
        PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -315,6 +316,15 @@ static int arcturus_tables_init(struct smu_context *smu, struct smu_table *table
 return -ENOMEM;
 smu_table->metrics_time = 0;

+if (smu->adev->asic_type == CHIP_ARCTURUS) {
+/* Get the SN to turn into a Unique ID */
+smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32,
+ &top32);
+smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32,
+ &bottom32);
+
+smu->adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
+}
 return 0;
 }

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Ce1f630b561f3402e0abc08d7eacab98c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637236029365851744&amp;sdata=re07oSC474wvdHv7wWJCVYxj842eihH%2Fkr0Sz0YoE94%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
