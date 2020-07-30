Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA594C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 08:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF69621883
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 08:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l4rf5n1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF69621883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6B46E893;
	Thu, 30 Jul 2020 08:06:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CBC16E893
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 08:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbyhbBPURWq37sTr5u0etT8EblYd8kBCpS0aGaRXDyqzcSwaCcBSbVUS0ThdAaTVQ9LUutIH4NPrduWJSXsmS/67wdu0/qT0uCUM0ELSfnuL0AEPfcpoX7Ujdl57df2jdZlmD3gPG64U3ZMwlfOmxLNuEsahcEa1jdkATwF/1dKGUgHPWgfgmAu9hUWFm4GNvCCewXQLgMCGYLHReRzFEj/ZV+THklxBL/z2iaxklu+7l2pcvqDwzaEZn1L9cV8cJoVLgvyNLeiAWujxglYbamx+fQUeJGQs3S+1lGKIfsm/O8099xf/LX0hHgnyO+Us9w+y3EUuqvRLJQQYQVT9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5z0I5Ey3i1Yz5ljXW0gIrOBRCAY73tSeGE8limDpFM=;
 b=kkjAD4fLtv2eSwfY810SU4chQ+cZ+y0ZQ9X6dlIiEKv6yJsOPOn8IzECPyfCBiBp48H6rxFNwBNYhyTSmIeBO8PX8VYq2hjhsoH7D4PZA0woN9JDFpI9vXrnv0a5SzjtlZKeMv3OAoHTY7KBeFIaqy2bvYMMx36tlqeUWgG1gKRHcTat/Ic01sH//fAXZPq4CdvcTA27YAYIqDE4JkbeOYlzn7F/RCcl6bu3eNjd37/meC4TVTw7vVjldo2s4dcYcO4pfpKcYyB2LYmu226lQxmZJBMcVO4p9TwiM3CehTx9pedyhnz9zVNBQGmayZgNQppm99UtTZnscdMf2qUU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5z0I5Ey3i1Yz5ljXW0gIrOBRCAY73tSeGE8limDpFM=;
 b=l4rf5n1+quLAwO4/3N+ErYGwOgkFFBJORrNSFvhrH4TYKcT8KkUOne+WtxltTmkGT08G430uhXsmA/pb1R1ut44KMsabT3q6DRXGRbqhE5FO/27OGXofzaAUhN52J4zAF0ZcP5h1k+FluweM+r1uVgT0hRb0b+MMZ0kdB3RHbo4=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1288.namprd12.prod.outlook.com (2603:10b6:903:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 30 Jul
 2020 08:06:56 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3239.019; Thu, 30 Jul 2020
 08:06:56 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 00/12] BAD GPU retirement policy by total bad pages
Thread-Topic: [PATCH 00/12] BAD GPU retirement policy by total bad pages
Thread-Index: AQHWZVPpvByIwWr/50WSgjJ4cIa1A6kfxg9w
Date: Thu, 30 Jul 2020 08:06:56 +0000
Message-ID: <CY4PR12MB12878D8D31C5D72C94C190FAF1710@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200729025629.19355-1-guchun.chen@amd.com>
In-Reply-To: <20200729025629.19355-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-30T08:06:50Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c2563e4a-f01e-4d8a-941b-0000c113ae8f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-30T08:06:54Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 68a3bbaf-a018-4efa-90a1-0000e6167453
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21639fbf-1d73-4b8a-0a8f-08d8345f86f7
x-ms-traffictypediagnostic: CY4PR12MB1288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB128829B742A65B82FB551FC5F1710@CY4PR12MB1288.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iWy3Z/8A9/q8wNa4XgsNM7DNKZOS+KWYCsW9KtSqWLKll4RYPcO4v7iIrHiI8odErxO2anZTc78WlzJ3G2oQ5bgSUF+VyQKBA7VPEiHGgNwrUMflxf4rkLm92BNSSmecaqz8/nReQC1sXFxUEahVNxU7XSiUdClW7bOSx6A+IaZp50Esg6b1iiEOV+/NcQ7wVmgeUC/9ZwmgDKRwk1gqLxegBgTQAcpFrjxVVLNxrwDUB3fFVJMFNaCeStWpWWHRp97f+PHO0p2JYRVudotfhhAy0dGu8weGvPSUT2SpSPvdLgm2atjR3Yyeb10h2KuYfdwfnX25/P0jTTmspsylCG2FOZBvRzd2RQkmz9HUiYf4mHLKeihVtwzdQTOzJ6vL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(52536014)(71200400001)(53546011)(83380400001)(26005)(6506007)(86362001)(186003)(9686003)(8936002)(55016002)(316002)(110136005)(8676002)(7696005)(2906002)(478600001)(33656002)(6636002)(66556008)(76116006)(64756008)(66476007)(66446008)(5660300002)(66946007)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: DcPx2GBnxOzRSUtOuK6v7STLIj0ZgHR/cqL9N+gWYXLAzE9oq6uH4S1+sRBBQreb+R1/BMZosXxsInhfYryxML7Lfs2zcJCtLgA3oDbMORKmOTRnFWUnyx50CjxqhpjgL4tBxLL/q28e65KaX+0KeOF0uwZDgdsjL1N+r3GULfi2PVYNPCp42aXw1bR//H9AlRPpT+KutiGxw1SZlKXa5bREdCwpyNYR6Y+fxWaaJ0uoxc83w7FEDUBaHNRtk99psCJLIC3DYFPTtN6+BwuyRLlF/oHvw40GpJpOMQpQWJ3AnZB40GzAJ5v8A5us/ZHv10AhqUAFJVjHA/edE8mOmA87js1lHcxzc7FQQs0B12ZArV/XdkqJIgK7k8WbyFqUeUoeL+sI+q9xIU4L8dBmdrYEf5mSkl/8Mnclu7SqCdaARcwpgP4xD8U4lIH2vEIstpkkcJ8lR19jxm2/zPUozXJ0vooSf+olIjoc4h9o2+JYSpz/UF7l1R0fcPXAEk0H
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21639fbf-1d73-4b8a-0a8f-08d8345f86f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 08:06:56.2020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BMevikdnXH4OF8K6Y55Eqd/6O14vo0zXyfNGo59uIK6jP8fVQr3Xid1r1ymaHVBWWh9qiKhGpNx1daiJX/WvhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1288
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

[AMD Public Use]

Ping for the series.

Regards,
Guchun

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Wednesday, July 29, 2020 10:56 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 00/12] BAD GPU retirement policy by total bad pages

The series is to enable/disable bad page feature and apply different bad page reservation strategy by different bad page threshold configurations.

When the saved bad pages written to eeprom reach the threshold, one ras recovery will be issued immediately and the recovery will fail to tell user that the GPU is BAD and needs to be retired for further check or setting one valid bigger threshold value in next driver's probe to skip corresponding check.

During bootup, similar bad page threshold check is conducted as well when eeprom get initialized, and it will possibly break boot up for user's awareness.

When user sets bad_page_threshold=0 once probing driver, bad page retirement feature is completely disabled, and driver has no chance to process bad page information record and write it to eeprom.

Guchun Chen (12):
  drm/amdgpu: add bad page count threshold in module parameter
  drm/amdgpu: validate bad page threshold in ras
  drm/amdgpu: add bad gpu tag definition
  drm/amdgpu: break driver init process when it's bad GPU
  drm/amdgpu: skip bad page reservation once issuing from eeprom write
  drm/amdgpu: schedule ras recovery when reaching bad page threshold
  drm/amdgpu: break GPU recovery once it's in bad state
  drm/amdgpu: restore ras flags when user resets eeprom
  drm/amdgpu: add one definition for RAS's sysfs/debugfs name
  drm/amdgpu: decouple sysfs creating of bad page node
  drm/amdgpu: disable page reservation when amdgpu_bad_page_threshold =
    0
  drm/amdgpu: update eeprom once specifying one bigger threshold

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  32 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  11 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 186 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  19 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 121 +++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   5 +-
 8 files changed, 331 insertions(+), 53 deletions(-)

--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
