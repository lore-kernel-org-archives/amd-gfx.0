Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66BDC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941A864EE7
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941A864EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE036E4FB;
	Wed, 17 Mar 2021 08:42:02 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680072.outbound.protection.outlook.com [40.107.68.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD406E4FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTFW0B6BBPx0T/UH4eBp6FUtAnO6Sl5qNQy3s8u3NYpx2R34Y9yKQUS1JBCtrEXzLBo4BIpJKM8rDldDyyWx96OCBwgFd3rBm2cCLBPJYEwZYK+7ByTcIz+FCOC43DGaOnroUpojNiIkxDYosZaW4NaaE9NeBN1ukxBTX2U8EDeq96jNZiI92W0EjhiLCSy11PeCllV7tnKv22qM+tmLXlaRv3Ilxt64fUgt6IxNIIKjXz5XkZM2zD46hqlZ+NiDqN4ub9rsxwpx3Prlyj2MtBSuCtbsyEKwlPl1BBXxUcU0ayRK4DerIlccBh+vniSpX0z+07YzfG512kslwHMJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRki1T13qi95I09zRGifjNlGmQlkvoUh9epzELlCPIE=;
 b=IZODFJQw8Hobb6qltgfPyKfGn3IMArcrLLHm3pUauSid/V4/up6CvP/I8jJNEsfFBGqczIiwgWNVH2bmDOW2xEzvDsmnX6t2SIZcIqDE1Kx9S4ucxorNYAKJVsl9DOoZHpAPHBqPfQUqXwPp87PPr0xaXViAGZthzHcvxgGJ5eGN/lkzxkBTDyiI+oWIzcjke7R8jX6XTZctFuo5HTZAlItpG5eRukXyDl21jjaR8Gp1FiUGfr0OTNwLUDQ3A6i4sEsKGaifqEr0iOGsqrdNV3SD25DpDEe6kt3iMp3L6Z7CDf1ZZlVJHxPML3h5ZolnUpXgGjOgVfPx3rVfca9TNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRki1T13qi95I09zRGifjNlGmQlkvoUh9epzELlCPIE=;
 b=yhSwfR570XnQImGNYhb7MvfiTyxWCNl6S+TJ4+pXZqwnZM4S2idzcil5D0UTH9gj7tKfGamQy8E/sDapV8uLverBbY/UvPPVQLTBf51zwFgq9cSgkslGpNsGNv/HsmdGfcrea4mMVkbk2cyf7r9dT0E6Rg+wOpB2vbsL/1OUTzM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31; Wed, 17 Mar 2021 08:41:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 08:41:59 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: drop extraneous hw_status update
Thread-Topic: [PATCH] drm/amdgpu: drop extraneous hw_status update
Thread-Index: AQHXGosfZaGSJZo9B0mbfnT3TyqcCqqH3Z0A
Date: Wed, 17 Mar 2021 08:41:58 +0000
Message-ID: <DM6PR12MB26197BF3C8D7B545061DA825E46A9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210316173739.229594-1-alexander.deucher@amd.com>
In-Reply-To: <20210316173739.229594-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-17T08:41:55Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2c52aad0-c86a-4230-ab94-ff44e0ce6dd3;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63cebf40-b071-4a0f-ed68-08d8e9208746
x-ms-traffictypediagnostic: DM6PR12MB4353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB43535B17A3070786AA12B980E46A9@DM6PR12MB4353.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +dwth1G0wUaT03sT35i9eyp6Co0etYifr7FwOPl9+T/5NI0aQydNqZD1A392zDQOJ/4nm7aCeAogGXziAqSrQ3EbHvWg6zGFtz6UzuspAelW9ZxpbvbcHscyWBmDVjL4h3Bbd3LAc/HKkclCa6eqAWiMg0BmwqwBuVRarZzW8h76a7k6wluNndhIl8LgoWzoMi7taKv3/juO2dTjx0zj3jh81DZI1PtxkCmzTQw5p+N4GiG6dkw/pPFDgM8AAoyGF2yXhNj7dMoW23ZJ1p1V+YaU0ObXKWPzK/vKHbhKUVsaxi3x0dsLM79PuPX2MHHfa6SPPXrI9pLkKLVwHAB3vYgB6UM4/L9oaNQQdKVFcgFjj3KmIT/7qs2TNt8HxHfLjW+4sbTCgUhsJXV9L94ho+P5dpuQzRt2cU4o5+cDYPl0YBK/EeQTWUPu8pwN86sF07+sArypoNlTT0aZeY0/1kz7XAo5LozKOg3UijMaSsigl6CCf3hDs8ptJeNxubwmIswJaH6shUx+O3frY4KzyqdfDiz/KmR9cjehGfXufNBPbnlKyLpvvwVVdCWyXl37S8IcI5L3UQJAw4QX5Qm9ma71RReJzJEVlGLFwSpTCQU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(64756008)(66446008)(6506007)(9686003)(8676002)(478600001)(2906002)(53546011)(7696005)(66556008)(33656002)(55016002)(45080400002)(15650500001)(66476007)(110136005)(186003)(86362001)(26005)(4326008)(316002)(76116006)(52536014)(71200400001)(66946007)(83380400001)(8936002)(5660300002)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?d5gmjBasprI7hwwYYuwZrdwxiC3jNSeaZp8C5u76tNRvoX5SYmBZLl/1enIE?=
 =?us-ascii?Q?DMAdC+XtCwbJxrNP88S5DO3DjmgWRisugpMnvGNDwzmduqy4mcjBJavi812p?=
 =?us-ascii?Q?Di2uIHVRqzOLBLc24rnvZiLJqeximeVgbRscWQQicyWVSxWF5PG+0s1lT+Af?=
 =?us-ascii?Q?4xD6iISyhnp3QeVXtc9g7q37AdZoCrug/2HVDujwW6H7wjbhz4H4qNhaK8Eu?=
 =?us-ascii?Q?sLcLIhKmsL5dNRsULxZNNiEFuA0WM6XgVbjttOXIAoACEcDAIFstWBc5tuT3?=
 =?us-ascii?Q?25ozQhdjDK/G4GktOJkvBNvFhY3L4n90DkkZc0cQifhdLy15wp6Vqd/v1t6e?=
 =?us-ascii?Q?WiuwQIWOzd9/mFPbOwNKfI7P0N+KNVrbf6gjKksRQpsD3rlsK1dOXxNK7GAS?=
 =?us-ascii?Q?MCnNMLdwXgz/eyJKEBgg0Yz4253sBS6h7gzaBj3KoQ+h1aHe2eAFmTQUcbRN?=
 =?us-ascii?Q?hqstMAUXN8rf+741aBZvG4YC5e9SbKWPPgCaM04ZdxDscmh40A5CHcqfgqVd?=
 =?us-ascii?Q?Uc/QS2Xq1Omqhp2aW3InwxK90z71GfszkSrHK5mFrTBvwSLbE/9+DC0/S3Pc?=
 =?us-ascii?Q?x19Pk0Z0qLhtK4PHf1jNtnFWOMqBANGqOeS3RuoAV/qJDF8f+Kjtzi1lh4NS?=
 =?us-ascii?Q?WkSl+dkmAviB/RsJ/vLFzXU/CtdOcZtnj/0ra4wDaw+AqnI1p+SyQAg+x3rB?=
 =?us-ascii?Q?kQ8EthLLYr6BuEMNsILYutBzwDp36aC7Z8FVeYg4KVO1Ex2yYbbfJk5xpxTs?=
 =?us-ascii?Q?yWtE8JyqTEO/LHyI2ojo9KGO1jt8rBhS8gV+kksYU8TTc3OduZBfbE8+oZy+?=
 =?us-ascii?Q?54PB4DCwwnPJ9pfJdkv6+CalHgTHWAReARHURB+0guLoSxjKj2RUFUTMNce7?=
 =?us-ascii?Q?FEUuAmsJvrOSrmVhVJY2CpYlB5QBBkiFkppjXMzYQzWDk+oOPHh5M8TpIvvl?=
 =?us-ascii?Q?phzb8R6XToXU68k2rTzN7G7gGxjz0e8SSu2EhutaIKXVWUabuUymWQ4zYIil?=
 =?us-ascii?Q?qjJlQGWXHcTJ0utdhIL+iiBqP1ifytn6yEetKotFWg1rPG376oDSpe6ZAZ1A?=
 =?us-ascii?Q?/wEqLTKKS3XPiZ4UIYfCJUl+y815F9pIlFeh3wevYvu8E8MEtQ+UHRCMJZS6?=
 =?us-ascii?Q?MOWHuszKHVNX2T3WO02s4HC7at7Z+J0dxx49TMA5mqrJpqbGQ1sw7GWMx5Vv?=
 =?us-ascii?Q?VOo17TXV1IRjKZkSvNmdDPvYWRLp9kamRDC1zim8zzeG8WQdtMc/4hTvHzHB?=
 =?us-ascii?Q?H+E+p5r6GyGCRBTQzSb5djKyfjhqqIw7acl4ya64gxWj22f4OalSbOkUiHKR?=
 =?us-ascii?Q?0UjzngmeD0MkKJJVpngJXeH3?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cebf40-b071-4a0f-ed68-08d8e9208746
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 08:41:58.8963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdONOT8ephYRfnKzUc3of3RYd7CMxj26mpN75/IayPYMMzhpm1QOXMeuB07F+33b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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

[AMD Public Use]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, March 17, 2021 1:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: drop extraneous hw_status update

We set the same variable a few lines above.  Drop the duplicate setting.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bca4b5aa6407..7aa95eddd521 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2739,7 +2739,6 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 				}
 			}
 		}
-		adev->ip_blocks[i].status.hw = false;
 	}
 
 	return 0;
--
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C6f25f4ebe1e64011f07d08d8e8a23f87%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637515130869739502%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2BrRMUIeJocqIy7GSP4XsSxiOH1T1O0Tuk0gZLRD7ats%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
