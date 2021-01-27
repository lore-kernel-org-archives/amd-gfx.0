Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A449C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B1F20709
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B1F20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C466E511;
	Wed, 27 Jan 2021 04:33:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F0246E511
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 04:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/o0OKa3yNIX8CJzT5CQMJMuxsn0uRpce36KA+mBo6/2XoOpydKY73YeuRjZoW74tTtz1JcNTPFTgJp9yCzKdSSm3f/bXAcf/6Px+0OvaWV3QcObE4Nbg7FsKQkGbW13sgxjiqzbMrzPqZa7ff9wjrT8H4Ck1fal+xctEyJq+nf1P/wRjgchJtXaGoXmzcJ/CCYcZnwCDSCQ6eml3I9Z7eLhvs2O2QltpsUwFYwHNHcriQJf4joY+M5wPlRpOll+N77dGeRWcxZBHjySdLIT8RWsa2PB6NLvqSki/6tW74zCPjcudKoedi4cLJZao1BsPSJVkaRd3WA6OkgGVf/ogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6meCgqztd6vW2UDuGlV7uowYZW8pFfH3LcV5jAdsoZ8=;
 b=GlE+2nTXvZd4phlNT069UNEfZDZEBfW7/5/EBP2jm3f/QivLSTSBvh/1qj4YIqm2ISFPEHnvijAxsKOwFpn9eVS5lmUVZYZRrpKxBqtj1I2Tf5aiNHZTPHPFhIn/DqdXot+RLgd8Ipa3KBcaTqsjaiOFaDgQZUMrRXNpOoXlQAtVJumfpQsUbSPuI9MLftpBwqvcBkYaV3B1dgG/oqjUMSt7t9aj62ctsiUo8qK8trVJU+JSqMd1DbbXLgvz7l8aJpCpp9+g/S/FhNKPQOQgg5gEQR5zLSa4/TJ8N8MhlRR1jH1E2DZ7rsyD2iA6pmgbrbq2pjxW/LTRuRu+91QYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6meCgqztd6vW2UDuGlV7uowYZW8pFfH3LcV5jAdsoZ8=;
 b=vsR3SqffMqy2dhWd1HqC5r1iNe+bTEybjEwaPC7oBkKCb6doufZ8cEkNIXna4AouGAny8mHAgwELB/z2T7gbg7Ue55AARjw9mhh9N8NCLTIQkRXClA7e1F/dKhpN9jDPw79W2wYkZqyObginMk9SrFjdtKED0lmwKxHIhkw2I/8=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1878.namprd12.prod.outlook.com (2603:10b6:903:123::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 04:33:25 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 04:33:25 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Topic: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Index: AQHW9A+BIhzDHaFOf02TgXGBIsF8U6o61ZoAgAALBbA=
Date: Wed, 27 Jan 2021 04:33:25 +0000
Message-ID: <CY4PR12MB1287945849A59414A6B38144F1BB9@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210126181702.48944-1-alexander.deucher@amd.com>
 <DM6PR12MB2619EE40237D99D8A666CEFAE4BB9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619EE40237D99D8A666CEFAE4BB9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-27T04:33:22Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f83e05b8-802e-4ca0-b111-93de88a0fc47;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 328ffad7-43d8-4cf9-61b1-08d8c27cafbd
x-ms-traffictypediagnostic: CY4PR12MB1878:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1878BA6CD634EFA0EF5FBCAEF1BB9@CY4PR12MB1878.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x9a/VNxYewxZfqClyBsvnpM0cTz7ZMYFdmLVFmwA1CaoSDjcMnyeZyi+M8ujhQ+E7qTCAtj+kPLjJbxI7kZfA3ovclRzEkEycxvmTlKhOU3h9degPf1wRXeVyOVyq3l1dZqu0fdc/IXiN9YkhFYSB3U0NaCjrJKEHp5zG/2DR/5/403PxP4jz8njRSs6gBcs/TivFxqHvPEiLqVP0fQQ5/N9y+KOjC4RpqVZW8Og5tPwYkr8/+Ar9xt1Zo/v28W+FO7spi82GHXeGy+1qi38wk/0w07rsgwj/DbUZjNqPdVAErqR+OfeDZ/ZLl8ru3i0x9fZptJoOwT51AQqWmqCeEbZ5xNCJLO80J8/9gUyU/fqDwLv3NFh4Zc01tx+GtaK2zSs6uSZmpS5HULTge/KWmpFccpDTtE/cU0GBu+sWTCpwZF19oLqk57P+dxQZmBc/GhAsTzUG8tllwY/UXDuY5rqb+6GMDZHCvsZQ9BOlbCoV/Q5hR3sVdGN04VNbqSU69bCSa0mt6Wb17IIGuI+8dbLG0adXzMb7E4/nSogKrlUjK0h8XamvazWIiPME7Nu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(53546011)(66476007)(6506007)(55016002)(186003)(8936002)(478600001)(33656002)(66446008)(316002)(2906002)(8676002)(71200400001)(45080400002)(966005)(9686003)(66946007)(4326008)(5660300002)(64756008)(66556008)(26005)(76116006)(52536014)(83380400001)(86362001)(110136005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?y3TW9sTnrcr5eTTXrdZhM0nuHptAk92/rmHfgrr8nKukPSsm1mOIZRi/IHAa?=
 =?us-ascii?Q?CLtV35gtNYceKh2iwEK2AVfSEVrBxW8xAYOnhaUV/T+hoVPgTXQPIksiKAgc?=
 =?us-ascii?Q?9mDQ10CFi7ah2U+y0KHfppEJlkdOXGW1NHg0CuzL7EnqzVkU+Dzve7kdWvEg?=
 =?us-ascii?Q?WkTjCR1MqREZb+nmdpjkF6PwMo7070JQZQQpV0chgeKGbUyUBRI/d0VU5Xtt?=
 =?us-ascii?Q?Q3Kqs9dMvqV+eF119D6EXThea3wjCffz6l2WQYYVqCC1L8iGQ1XOvEB9R8dD?=
 =?us-ascii?Q?CqFHdgFblS52Y53UdeMR1PwVvac0vlDwUYI7yIZsr6eXPWnFcM9Fui1q2roB?=
 =?us-ascii?Q?bQneBV5BzY+wO54eVR2eGg4evDOk68OEvbqcLy7LZWBUSTPlJALNdhF6/oVi?=
 =?us-ascii?Q?OAw3WAZfurGrk270FxuRpfx4138m4Pj9gh3c3CJTVq+oXuzr0+kLniMq0RJP?=
 =?us-ascii?Q?n/mHVRYNzbHKHecwfBpQUV/jpBskPZLvUQJh2upfQ0tpAPnrpXg7NKXG8Hq4?=
 =?us-ascii?Q?wgsRX1dJVTTlK89KCuHU68gxaNT+oPa2k+Oxx4M+NELNbWnq1O54VVVSC33d?=
 =?us-ascii?Q?LJkxrPTA2ZTcZrf8Q/itMN4COTDyziLZEJVpoNDZfElmiLA0UdRasPLuPpg9?=
 =?us-ascii?Q?2dysCPUIhnp5+9deWl9OAYyQZ9J0B0hfE3qvKODhBA/KGG8AHm+B8Gq/DfL2?=
 =?us-ascii?Q?0kko7Kg4X77EFNkLXCbomPO5icgTDHW9HccjLTzidiCSPh2hCHHPpYuI4ray?=
 =?us-ascii?Q?iTYkEk3piMx8u7iVwnVfiAx+iQBDlIwNVIGUx0ge5gfAxzoUpFlmBWZGo3T5?=
 =?us-ascii?Q?JP1DN3qHo3weqox8vUCzjBmorfTL0wusfKAK8ZQtwoocchVSBe72EoCpPG95?=
 =?us-ascii?Q?3YhEegY4oWmHDEvFOqJRaN9jheMhAij7dLFGf3KoUVscVsjbT+NSj/ioLob9?=
 =?us-ascii?Q?nm7irKJ0uxDbAW7a1IbnJMFAokfMK/LrRc8AmlrPll+pHzHCAfcrvr+v9Ptg?=
 =?us-ascii?Q?iV9m8zo7pZzo1FpHGc+E6dXmZs4T/xsTpvsDcv7fJufT3dDMEhFEWXetiwUM?=
 =?us-ascii?Q?bv+8CXU+?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328ffad7-43d8-4cf9-61b1-08d8c27cafbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 04:33:25.2312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPoVu5OjtdhoRlwwmS16ntItOZ1P/km0Uv7bwQoGZBZuBYswdmgCEY3MJu/b7RpdpOVoKxdqAvR6QjrbelA0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1878
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

In soc15_get_xclk, we have independent handling for CHIP_RAVEN case.

If (adev->asic_type == CHIP_RAVEN)
	return reference_clock / 4;

I am not sure if it's better to squash the patch into the asic specific function? Then we have one unified place to handle it.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Quan, Evan
Sent: Wednesday, January 27, 2021 11:46 AM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Actually after switching to retrieve fan speed from metrics table always, this API is not used any more.
Maybe we can just drop it. Either way the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, January 27, 2021 2:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

The xclk needs to be divided by 4.

Fixes: acab02c1af43d3 ("drm/amdgpu/pm/smu11: Fix fan set speed bug")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..36dac106ed4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1245,7 +1245,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,  if (!tach_period)  return -EINVAL;

-crystal_clock_freq = amdgpu_asic_get_xclk(adev);
+/*
+ * crystal_clock_freq div by 4 is required since the fan control
+ * module refers to 25MHz
+ */
+crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;

 tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;  do_div(tmp64, (tach_period * 8));
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473159431451098%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=e%2BzrZgRQDkOb4ElNJNiLWP%2FHBM0cIQl4GwKFuYfvsP8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473159431461091%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=lp9Gu3pJ7GdDbF1BJNlIQr4Z0TCY%2BTVDGtDWzZ2bR2Q%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
