Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C44C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 01:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F7364FAB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 01:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F7364FAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B556E40C;
	Thu, 11 Mar 2021 01:44:20 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760080.outbound.protection.outlook.com [40.107.76.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3386E40C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 01:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gsowo6Q7tCmQfYqLH0iDaqBHGKVFZIsbw4HqyzbrgVdbtWZOXsmVZpIRsCv9yOm0SHSrN/Km3Yo2I7V4w4qtarTOWiuJe17X/gvVSOo4z6Q2mfqMOi8LKa1/8cDQDee9cFD13Oz6XixK9prkw24eWs5JzgnGbvcVub599h36NOO+r6IGsOr+DVqr6eZpG9FHoG8ENwuJRwaRpk7x6PEjzjE7cRoraGnlaTcwkF9co1JsEISEu21Hrslp5+Ai0NZyDOzkYisLaNRfu23SF9k7LWH/iujD67Cnyl9pyi6s9x4fS/KPhYYYAJMWdYLJr6gKKm6QsQkVe3jC5M07TP/ESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNLB1z9XGQIyrvKTR4NIV5Pdd5WW0XlNA1MvrQ4IQCA=;
 b=CkYXGjb9hHcx+MUe3TdGyMdonqANg2IegOU9aJKAxLus0h/RSACX+7P1hBrEV9sbb4WSo0e/okpYtJhAemuSFF18YDR2/BFH67TGcMs4kgTmndZ+NTDjWHDglhGvaBeep5DcjWGF2TgVRz2oPbAseTwvhoSTCknBFyTlA0F8XGZFP4Gc0ANwz07FejA0Oz2DijnOnuKTbpfE2Sf+qlIE9IDvB+yOVbVw6fExekDsYEojw71JC9cPh0jkX/4lkkQa7JMpUjSBMgJlDANZsU+MF1SJ496s8zHwkDFDC3XUN33ROiqggUVglYA/pWcbjWMpIC2auiF0480DfsUqdsw8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNLB1z9XGQIyrvKTR4NIV5Pdd5WW0XlNA1MvrQ4IQCA=;
 b=Z3cOw8jn5/V0B6FS+2KpKHg8dXdBu4dnsSB4dRyWFdK11Qv/Z0/9/RhWQPFunhrZzTRKKlAp+8IN0QIh3fKafS9d/VG34u4ooZVBsd5h7kkLWR/SYMAm+zGjVlqG05hKJyDbRYoGdpr+DlcMeOBihSI4hTtyGJnBMxVBHBvqMP0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Thu, 11 Mar 2021 01:44:17 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3912.029; Thu, 11 Mar 2021
 01:44:17 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/smu8: return an error rather than 50% if
 busy query fails
Thread-Topic: [PATCH 2/2] drm/amdgpu/smu8: return an error rather than 50% if
 busy query fails
Thread-Index: AQHXFdB8/AgYNtNvr0e0Xc2e2IVEdqp+A/mA
Date: Thu, 11 Mar 2021 01:44:17 +0000
Message-ID: <DM6PR12MB2619F64C4269DAF074E6CEE0E4909@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210310171137.1056593-1-alexander.deucher@amd.com>
 <20210310171137.1056593-2-alexander.deucher@amd.com>
In-Reply-To: <20210310171137.1056593-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-11T01:44:14Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=18e1f302-1c0b-4383-b7b9-b5c192c93d2d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65d5b561-11dd-472f-fe48-08d8e42f2f09
x-ms-traffictypediagnostic: DM6PR12MB4942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4942778967CCEFD948C1CC87E4909@DM6PR12MB4942.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:248;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bDBjcNDmfIBCp7dlMnPOwovZkf0ieXm54TAtRII1+qPoLMb6Dn+zrwz+Vx/6bCVqTapdIFcuO1dg8bMfOCk3sTiqfecL/RR9haMZ2aTGYvHB0xRJ3wE+hdZBrMq9CVMhQSGrzen/o3oxsj3TBnlEDkaPV63qw2HXcU7vR+pswdA8P3/AMOycKbPyBRjrf9pf2mjhEAudRqgZR1/J3vf3HEg4VrM+kQJjDobPc4qzd3g4dKS5M5CZSyDkfFE2PwM3iRmvuT7xnx0AvhpZFMkO2myzXaL7zHdfqD9tswZrRlZg7+5WTgNCl6j9xCtKmP8mMgWSg2yeyIxIcr7Zv+y+5l7/CVKfCJVcviyH3y1TNCRlyDmfQk2Mf6JUiLw0FKqVPPvuEDsdSwpsGDmVEvg84uqmMmeLrAuWG3U29jSEGfeO7gWA0RRJB04IbiQ87mkCL6AFLITgjhVdKjdiqJe5csSWbj1Yy2mkdVvzMyXGJ8qph9lw9bvo1aQoMQAbG35GZlOGBEbqX5EvM7e8fWm420OUD17ZTnnoyYPwuKZU3w2IqVpuRnpwSqONdd4Luc1M
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(83380400001)(110136005)(7696005)(186003)(33656002)(52536014)(316002)(2906002)(66556008)(55016002)(66446008)(64756008)(76116006)(66476007)(8676002)(66946007)(9686003)(5660300002)(6506007)(4326008)(966005)(478600001)(8936002)(45080400002)(53546011)(26005)(71200400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lcSEC0yzTHHVAriBeqAZvwnMh0pJ+NcXJdOhtbHO9khyApGsmhm+8uT/QUAd?=
 =?us-ascii?Q?9h8tprVSGikVB2W7QVsSmzUKE7TpgAFO4GdgErr0yXLvEnSTm6hu5ozpQ5cU?=
 =?us-ascii?Q?9EbM+dULWTIkxFZAVTYBl0csA+WyeyQjOOvG8rIDgUqvyA2M1xIMHcpESnps?=
 =?us-ascii?Q?22otEfw6Sxsrt4ayuyd0+LquolWoj29lT51lCVdxo9UoHSzzwlUHsq01I434?=
 =?us-ascii?Q?snu5IpEKznmomuiu1ZL1+qpNSWgDAdF40F4fcqXwLHcpP2AHF1NsPYy/fBEU?=
 =?us-ascii?Q?XytzJH7/eFVZcxjwww/Y9r8ykpZQq1KAVPgHM+8jXkjdqV7YySjf2jOgiVSF?=
 =?us-ascii?Q?JDIbJuxjzgvKWr8CnuYTOXOMLyJHizvnqO3/AxIs0pBSLMB5A7txgbliOmNV?=
 =?us-ascii?Q?c2BTHwbJE3zS6Tcj/hfdGhZJ16+/3YH0ziOa0SmPFxQHTFDVA5KN4Lnt18NW?=
 =?us-ascii?Q?aKTdEr56XP5WnpsPm0n8+XWk+cmc6iABUsq5+aUJl9CEOmyvs7iH6FvUa1ib?=
 =?us-ascii?Q?Y1xDMZ01gKLzHZQrVbDQzVGvmwpb2MMmsN5lGMS0rSuTgWz9u/SzNY6FLd3T?=
 =?us-ascii?Q?7tUNKwRwvo0/QJ5I+RzsQT/aBqtZwfFsVyn2erJZumG5qOxjHZWX4cn8VvRs?=
 =?us-ascii?Q?H41OfLXbRDqktnWvUXx0LxEmmHR5A2cR4UzMTOZTxyU/WjQzXggRd7o5WlqH?=
 =?us-ascii?Q?fK60C+XQ4cOMb4LoYLJ3blaCqV+stRlMBnOaBtcKVKQiBEhBNQDU5MJg1oFV?=
 =?us-ascii?Q?Fj84gXx3gFBfyH27hh8Ztm37NOEzdktu0BlgquFnudU2WObfffzu1PgsT3cO?=
 =?us-ascii?Q?zn9NvwVDEB7+fSuV0PZT3hYDY3m/UzYlSlURqCRblfedRH78/6uB55hpJ9XY?=
 =?us-ascii?Q?JP88QZJAOvzn/VGd8DFz6YA5mrWqZ9ecF0QKxByn+VVpTuBQ4qaC2m5DtHVB?=
 =?us-ascii?Q?JN2K/nOyOEP7aAgCYw8uOChxd1E8gy+J6IWkSI/ARLt+roi3Qgkd9VNv1LL2?=
 =?us-ascii?Q?qUxcO/ahXlLsLDgUd+nIqRJCQLvz+9MtX5hvtWsmvyd186gAFdd/203Zizey?=
 =?us-ascii?Q?qtLZPVtq8URajAXeAk7+fazGWbX8OBDVFeQ7+usWmSFhnyej7hmZe3gR8wul?=
 =?us-ascii?Q?gqCMooQbTT9YpxzbZHCQIsRGPKsRwVS9OAn7mapnl0VUzGqxodYg4aJBVpnH?=
 =?us-ascii?Q?ov5NrJPHiCG0vBB294mRHb7GBfxqAo/ctvA1YmbtC0YTqXEQfLgvt3Q0ZsI4?=
 =?us-ascii?Q?3ghx+jXYMu9Cz21fSf3zBO0Jrvcj6RlcQokmloynUOFD2iaK43eX0vtjw2/1?=
 =?us-ascii?Q?Q8apPeKbn3rvZc30A6+MyEBA?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d5b561-11dd-472f-fe48-08d8e42f2f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 01:44:17.5215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwzIApdTfLI5Hcwhq1GuVk0Dzx8zPHNIomeGG11hf8bAygk+eKrMBz9ciRCDz0YH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
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



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, March 11, 2021 1:12 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/smu8: return an error rather than 50% if busy query fails

For consistency with SMU10.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 2cef9c0c6d6f..e64c6ff75b44 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1791,7 +1791,7 @@ static int smu8_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		if (0 == result) {
 			activity_percent = activity_percent > 100 ? 100 : activity_percent;
 		} else {
-			activity_percent = 50;
+			return -EIO;
 		}
[Quan, Evan] nitpick: you can drop the { } around if/else. Anyway the series is reviewed-by: Evan Quan <evan.quan@amd.com>
 		*((uint32_t *)value) = activity_percent;
 		return 0;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C18cbbd8ebfff487b22f008d8e3e79de9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637509931222610662%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=pUtV%2B%2BCOkH%2FWKBCmjzwQYuIREazNbkHxInbh973i0Do%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
