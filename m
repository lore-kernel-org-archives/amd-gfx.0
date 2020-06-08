Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF4BC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2812E20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FxLe6jzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2812E20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87DD26E45E;
	Mon,  8 Jun 2020 04:51:01 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770045.outbound.protection.outlook.com [40.107.77.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA366E45E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz90JYC8CUephjZNbX1/o0E9k/SSmxPZyhNHpdkP9Rrj5iAuv4MKaBZrNiYcMYfDW5qinXVAenVfWDCviyK/FIcdr7IlkOJKcCj3OoZWx9GNhfiOOK3ozCnMhOJwOahdtM2bD0Ff3/wIiE0qHkUxr76+PR9fsiyuQCuFCvH3wfZxptEcFh7S4m1FnfgvRMpyTfL+m0dcSX3mboB+ULoWhpWNrxYT0Pq807CoS7gs1shheyydJOE3tl/RhfwWlbadOK0THFU6pdYPj7eZyI+9eUwXSkLlzphbeu6X06WRrptxRc+ZCCkLpWAgkgZ4panaDWkQHa4Wiry0tBTCPh6cgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nn7YVY3E6hGASBObX6dq02v6Z8ZfUhg+H9a2qjHCjs=;
 b=IAp8WcAjmN8WZ01KgwSRRb4y9xq35WeXiw9fsL2ReSRreL+vCuhf2JohgTmnBDHoTUeCmAek1rP6vrXb23jFJ8Dh/Ijmrf5QiGTUramzLdVkInOFrxeSKFADf18UDfkaaO8wXYe7OQLMnOujSkLkBUWkw/2nfQk8pWcgzx1amihfebogIAm5kUsZhr0CfMyb+Q9VtIk6cNGpNlK1h4eBfPyAw4JuiOGP5Ku4sN7TK36QTd3+WHYYwDFaJ7DfqzQKSXOPqCLnsNsR4r0krZe79QQgooHaJFrWe9QMSBBPmx1Ese2O45AFUwverDktreegvaNlCAxHM+8kH1GX0xphsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nn7YVY3E6hGASBObX6dq02v6Z8ZfUhg+H9a2qjHCjs=;
 b=FxLe6jzb6A4BDZtuMVM3zyvFmkRKH+Hyjnu6lW6Ap007ALtbKWLTwyAs7K2esCiVnw5KRbHmbh1Msscq09n3JMdLZifLcrw/sozcu+CdZuG4CKpT1d42Tt2DlDaoesmqO/zRcRAr1HaRndzcaqJtmj0FIaWJitvLLkIOmXGUKF4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3610.namprd12.prod.outlook.com (2603:10b6:5:3a::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.22; Mon, 8 Jun 2020 04:50:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 04:50:57 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liang, Prike" <Prike.Liang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/soc15: fix using ip discovery tables on renoir
 (v2)
Thread-Topic: [PATCH] drm/amdgpu/soc15: fix using ip discovery tables on
 renoir (v2)
Thread-Index: AQHWO0+wkkh+P5+q702nyzlZwerfS6jOKhpw
Date: Mon, 8 Jun 2020 04:50:57 +0000
Message-ID: <DM6PR12MB26190DC73DC5525D12FB1206E4850@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200605154029.118736-1-alexander.deucher@amd.com>
In-Reply-To: <20200605154029.118736-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=eac7fd82-9f2a-4493-8fc8-0000306ad39b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-08T04:50:43Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0d53e9d1-4634-43c5-804e-08d80b678882
x-ms-traffictypediagnostic: DM6PR12MB3610:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3610A43C439CD21A5696C924E4850@DM6PR12MB3610.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xU7lgj48sWex9oxaSE7GD3/7RG4kJLSMWZkYCw6u+YP9qS+pI1vi73hPfPBojElvwvEQNs4Svk9FKdVoTeS8bleC7z9jICH2ucOz/K7pZUVEVOjES8McPDc8Nz3qAf6koXtzcuKiCqOF6wYwTmQ44aL9O5y1boG6BrItBR18ry2ryGenkq9CafMWK2i8Fqm1tliwx1ESaLXqxkb+aIfL5XmUZ2xEHrkxkL80ESh0aVAA2waS3ArkKKRPmD9CkO92xpWr1Ral7508JCUIkq9ljNxQkP8docAc/g/xv7hgH3zEfiV8xAnZuojxqs9LfoUWdXjkSTDhS5/VKpk2mjaVeJR8haZP5pLEGU1sZFTicw4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(9686003)(7696005)(86362001)(26005)(4326008)(8676002)(53546011)(478600001)(45080400002)(186003)(316002)(76116006)(83380400001)(966005)(6636002)(66946007)(5660300002)(8936002)(66446008)(64756008)(33656002)(66556008)(110136005)(2906002)(52536014)(71200400001)(55016002)(66476007)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ARwh0ph9OrjDNQoOkCYdEjRV8oyWHR56YArTKPFdomAnxrmwIGqnzdn/wlrgvmgDr1oPemmAv5kVoJzFabsSQWb9OKFD/5ikazgtc1GTTWDf6qCHHKT458itNASd+/sQlCqqzwggEZn4MUV20O/1hCh2toNhmBawZPd/CzFQPFpPbc1qhTsyhHPJbPrqzbrF0qiGoxEaH2lJTlx5hEGzjNDSVEHwvrtZi2furxze7MQO3cReQoQ9tv3HUc2Rz1iHhyzfcXnN5kZN55EDJb1wvcbL3C081T+JqUh1n1RJaHcz9FO1GfpDcakTWDkyr6Ot9/0GazUWhJaXnZg5ATIuL5fII/X5q1crULMBlZX+n47vYFhWGVbeNRuHfJgpkwk8tmkz7tXTLTcwRUvOTIvO99TkW9o18YuWZYkT5xETyaNcISLDedUhNTmdfj/whiN2/esZoHFrJqegs/Zsjpqvq3WDWpmK0YJSJ+t3RRBSB+yaaEAogi8zyniIeBQIVrGW
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d53e9d1-4634-43c5-804e-08d80b678882
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 04:50:57.2366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpO7ZYm9/BkYoLLXgj/kXWVWT0kjWAMA9i/BGqv9C5+15tFPos6GmwgdzYaZPW0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3610
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, June 5, 2020 11:40 PM
To: amd-gfx@lists.freedesktop.org; Liang, Prike <Prike.Liang@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/soc15: fix using ip discovery tables on renoir (v2)

The PWR block moved into SMUIO, so the ip discovery table
doesn't have an entry for PWR, but the register has the
same absolute offset, so just patch up the offsets after
updating the offsets from the IP discovery table.

v2: PWR became SMUIO block 1.  fix the mapping.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 623745b2d8b3..dd17a8422111 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -686,6 +686,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 DRM_WARN("failed to init reg base from ip discovery table, "
  "fallback to legacy init method\n");
 vega10_reg_base_init(adev);
+} else {
+/* PWR block was merged into SMUIO on renoir and became SMUIO block 1 */
+adev->reg_offset[PWR_HWIP][0] = adev->reg_offset[SMUIO_HWIP][1];
 }
 }
 break;
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C3f359d67aa2d42c7f53d08d80966d087%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637269684501531639&amp;sdata=K5%2BV%2Bo5cBNSAVgDk8NHQ%2F46YiRVB5rbbk6wy%2BSL9RM4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
