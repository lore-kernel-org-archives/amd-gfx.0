Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E9C10F26
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 05:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7505B20714
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 05:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oqkiiui0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7505B20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF6B89DFD;
	Mon, 23 Mar 2020 05:53:36 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750055.outbound.protection.outlook.com [40.107.75.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254E889DFD
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 05:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDE51EjOpnCtWsSpbOnMghe6tv5yVC2B+Pf8Kb4PW3l7+4uCTnILMA8SRxJHftf2on1E34oUtzZFnvlKxPWzA90e536BiDxs52MSKBRzetDQ9YEEqlCDjg17ZpJVAyf3ebNLt1FHSth9hxuGaDMNuOnsn/aH+nQMhuu62y3DQ+lWwsyDwubswj3BEXrqHW2tP5yf+jSxZsNy/cRIS9p1n02Em7cOfHZVZ3cffpmYL3ltM5neeVFezpnSRglTPVFLcf7u8p6rXmT50m/cghh590Ct61gSc9k4SBgATlq1SnBpqXWXlvajloVpM9gGyNaKrZMEJXwp9dtJeUiNhi7yBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsfJ6u7Slpn5QlEnmKNQ5r3tyRCWflA2w/ea3QaAkpg=;
 b=PiSZ25cw+8j2CDCBhDNp1OiJyXIIWaMVwGjCKULL2LvYi+Ld2DRQRZbKN2E4GvFhdP8DlhNUsbj0zA2xKxNDhro8mXZU71njsHLIkz3B9z3k4EPtYrRtb+9uGlz5SrWgH5k3sIQ2gqPvWQaoY0DBJUgVNECAXC6U8JZD2R2HTDdCS9viUEirhSfBjyVrxigENhmWhdgtGS0iwoNzbkBC51TNUAOT2oBV8M3Iy8QfwN+AUUr4V10t+3WJA1ubujscEraXMvYXIS3fn5CJGDsPZMIj1G+MttPQnc2fbeyccK/AdHk9iPTHTXdhSdhQ8fmhbjwKH8IjySGAlUpVdJSKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsfJ6u7Slpn5QlEnmKNQ5r3tyRCWflA2w/ea3QaAkpg=;
 b=oqkiiui0kGZGhNT5HHHY2k2kfJbjLYlFFp2wI28ZVnf8G4VJDBp2JhxeRATkg8UsldMCGSFKuIML/Ma3a0oEl02Sb/unowSvCe1ozYRm13QTSRDRomPoZ7+3NFuvD0ldVGlmOy9va74ry5jQ8XoCpEwrkO4EtXAz/pL9xP181Dw=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Mon, 23 Mar 2020 05:53:33 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 05:53:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix the coverage issue to clear ArcVPGRs
Thread-Topic: [PATCH] drm/amdgpu: fix the coverage issue to clear ArcVPGRs
Thread-Index: AQHWANF/gTO1PaK6nU+NljxLtXF2ZqhVrPaw
Date: Mon, 23 Mar 2020 05:53:33 +0000
Message-ID: <DM6PR12MB4075999E4AEA5A4B53427A42FCF00@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200323051108.19558-1-Dennis.Li@amd.com>
In-Reply-To: <20200323051108.19558-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-23T05:53:31Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9d3b24c6-fa44-4b3a-8647-0000ae1b0e73;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-23T05:53:31Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 1eac5fab-11b6-4852-a701-000069172910
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c3e4a83-6b9b-44e8-06b6-08d7ceee85aa
x-ms-traffictypediagnostic: DM6PR12MB3529:|DM6PR12MB3529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3529FC0BF0B7DE3862AB4DF3FCF00@DM6PR12MB3529.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(199004)(33656002)(186003)(478600001)(6636002)(26005)(86362001)(64756008)(66446008)(71200400001)(66476007)(66556008)(9686003)(66946007)(76116006)(52536014)(55016002)(81156014)(81166006)(6506007)(53546011)(316002)(8936002)(5660300002)(2906002)(110136005)(7696005)(4326008)(8676002)(156123004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3529;
 H:DM6PR12MB4075.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zko1jXeoMtMpNOqMK2pGnq+CL82eDZu5xRu4dpkhMi3HK4quBMZ0+qlWkkMhFPKohTZzL2qcs3WxMVFWsFcJO5+bZ6yQECoODuP2BGmqXnSxYNnq1wXQcvSKBNVJ+RB8jdD5wLSzGRv3RT5ULp3w/BjlDz6Cg9vzxW0gUsrdIgn247waUL93GVBxMlxeQaWRvl1DtBvJlgoYCVa5d90Yf506YEY8lcF7bSoYg1XJxIk3Rm29Mo3vAQ9+IbN2NfUDXqPercjnQ5j4KrGQ2uEenk7AxRNrnXserTnjsj7Xyy24Twf/7eUVN6UoY1l3YGYGr6idmNRZK1PxkhLYS3WS47ujCU39Hh/uNg5mxFOTWniDBClA67pMoPvKcFL2y5tPNzuErTXvUyLB1Y4z1ncVf4L7ItVibN6ZnAFrYISfw4TP71dWSOEJOAwQuD1bT4+pjaXNSpg74cQWL7Z9xpc3eqP5PEW/SOTi1QbO6H228YxVGojmqadYb+U7VhzASkSa
x-ms-exchange-antispam-messagedata: X50UHFPl4fROvcfa+XzP8jhexKKh3Q6eDZPluJ6hFmLrK/m1ZY82bIDZVfQKvbyH1uG+3ffNNAVYSdYDDnoC8n6fCdclTq/XlzxKjDUVK7iEL5IkTHMq2MxPdT3DM+GzWBgJ8WzxLf64+OXNXMO+sw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3e4a83-6b9b-44e8-06b6-08d7ceee85aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 05:53:33.5100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKjFtO9+ZXVXwz38gkiMVbgui4GOhko5/6HHbV4xbQXiS5pf38rUBdWDJCKwWWt6alTkjlDlXTcdVmIzQiG1RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3529
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Monday, March 23, 2020 13:11
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: fix the coverage issue to clear ArcVPGRs

Set ComputePGMRSRC1.VGPRS as 0x3f to clear all ArcVGPRs.

Change-Id: I296c3a162c0d5c7b84d4b48dc2002340a5c22e2a
Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
old mode 100644
new mode 100755
index 324838baa71c..44fb64460c1f
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4264,7 +4264,7 @@ static const struct soc15_reg_entry vgpr_init_regs_arcturus[] = {
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_NUM_THREAD_X), 0x40 },
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_NUM_THREAD_Y), 4 },
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_NUM_THREAD_Z), 1 },
-   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_PGM_RSRC1), 0x81 },
+   { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_PGM_RSRC1), 0xbf },
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_PGM_RSRC2), 0x400000 },  /* 64KB LDS */
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
    { SOC15_REG_ENTRY(GC, 0, mmCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
