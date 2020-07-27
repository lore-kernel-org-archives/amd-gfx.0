Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB73C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 04:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA8720775
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 04:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ApOjJcoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA8720775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F35026E12B;
	Mon, 27 Jul 2020 04:01:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A5516E12B
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 04:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKFoXGWKt+Me95ksmgHUaeSb0xenMW062X3p0IydtdT+g3JvusOgonB6MM+n8xtmnfb+krRdtaElgT1toszVAYwY64Pj9gji0cv3TQr25LnV4N+hagm8laZJD9FnEebm6RwFr+oh67uQhiR3Qvp1On/WlcvedBY2o1JCX+UCqx/vFgups2voXT9UiEZMfBc/tQZ/KNpZOC0ZZaufh17QrjzIdrCtlI9sZBrTkfJ21X/eho/2hrCOI21VVbDIKuFGH40JV7+JimNTLFlWXtGonl46esJyyJxtVS2ySTEAXxohJhKwQwztFWyKktO33sX2sfK2bEyoE8EeSFU6+7HNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JDilYF5bfzt3f2lMGsGvyRbw4U++eNYkXmFmb+BFoM=;
 b=m7e76aOKEDkzrEtaIdPaCO1+8rA6d0HfIjqw5azi+XWeKlYDba4WGBkmu87uApgh2O8BG3ZljSxkrN9Z1vso6rNwi6vF870rp0kbA8EYBpXRih3hOUgAogmZfw1GH4jp6E9/OUoYwAunWi4514OdmLuW5TK4068Pcq93xda/YtnrcMBKOqXDglMtJja7zorBZV68Qmb7h85r64WwJKbLCp/sAn6a/e0X8fw6T2WNSVzAfwR6osICYCUutlquTlF17S1DNFU2JZi7r/Tu2no9YMQ+0etxJ0FWdSVYxPqqKack19pekZ6cFRGL7HH8C+rtqOd/aD6SLPEbm360zTQ7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JDilYF5bfzt3f2lMGsGvyRbw4U++eNYkXmFmb+BFoM=;
 b=ApOjJcoJM0zLsrZc04ljfKB0j80LRRfiCjk1o/aUHsiTR+3O2HgQFa6r/G9DWGsSC9qVYSlgBoqNlor+8GSpJrOBsoNJzSlukFReQYGO57qx7M5QNfiiKnFRDwKydEaBPuGv47hG5DCh4CUy2naMufB5vHyG3ZSlT6zEE7prM4c=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2620.namprd12.prod.outlook.com (2603:10b6:5:42::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20; Mon, 27 Jul 2020 04:01:07 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3216.026; Mon, 27 Jul 2020
 04:01:07 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/swsmu: correct smu lock type on
 smu_read_sensor()
Thread-Topic: [PATCH 2/2] drm/amd/swsmu: correct smu lock type on
 smu_read_sensor()
Thread-Index: AQHWY8KprqinHcRyKEa+wW5rd24eJqkazQxA
Date: Mon, 27 Jul 2020 04:01:07 +0000
Message-ID: <DM6PR12MB261904CA92DCEA4DD037F055E4720@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200727030528.586004-1-kevin1.wang@amd.com>
 <20200727030528.586004-2-kevin1.wang@amd.com>
In-Reply-To: <20200727030528.586004-2-kevin1.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=05ca8634-e24c-4b5a-9315-a077599f74fb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-27T03:59:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28f4c53c-d72d-45e1-1546-08d831e1b0af
x-ms-traffictypediagnostic: DM6PR12MB2620:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2620D7C8DBC39C5BA8B42E20E4720@DM6PR12MB2620.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FAwjfjIDSkltMQf9E+jKHWt7rmtNgFz2V1rKzAwzT3lrz9EH84lEA8G8fEDz/qpaiYFmVtV0HZcqImkXs02uCJhB2IwJ01bDnGePwGfG9IrMT5BasfOUtq68rL/T/BqRF2c/WWbdHORVawgem20rfBq7ItagJOMOxkgunl4KTZ3/O0x/ALsJ65xVry1O9OPip0xXLz9AGwpKZ/fjvxuN7oiHR1L+6qFRUNSLG7eEHEfgJSn7KrjOsDc0sJ6MG1Nbc7KRg/jRogMiggw8edHkTw/XEy7wbRHALO2tdBYhn7yAYcj91wb1xH/tzxTeQ3+I29+yIHrQcCt6WUP9i0TSWPKispQifd0WSsfDewkPoJk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(54906003)(110136005)(9686003)(55016002)(8676002)(316002)(76116006)(33656002)(8936002)(5660300002)(64756008)(966005)(478600001)(83380400001)(4326008)(26005)(66446008)(71200400001)(45080400002)(6506007)(86362001)(66946007)(186003)(52536014)(66556008)(66476007)(7696005)(2906002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: jY7c4tZE5xHK4DE17SMSPQ0RWtW9sPYQU55Cz0hmoXiYiSEg2kHbx9hUAncYgNFxuBwp3VOP+dOg4ajhd1fD83XPogzTQaBYc2WJYSnQlEBLnbhVvhv97mN2/HkMVtk8Mp83O4jCH9obAUhwJCeAPd2CRsTbmtu1anygbJe6u7WxN9UdisBC/NSxZHPEbVzSlrESBiebxjDmhH7p6aqEs4IPluIIlvbpvR/ExDQJbTyGx8md5A+e5qPVBXHrCwnqUUYYrDKoBRNA+PgP49sJXqVXxHDEwEH0smt6WXGvb92y3/sLu2s4V4WbFR6THae3YsEjaDmrMAV8nus3cKM/EQVeYQNcMdEh6QfzfyWHYU8TPWef6kmj95eFojuV7ZOFqIWptUU5FoEKUj3Qmj4BNKPeqFCLo/u/KBJdDMfyrNbGwwm8XeGPD+fLWfQlOxySEYdssj9oxcbMvS858NqR2SMYszaa+Nwky+CO0oqYcC1h6QY/S5XqwbD8jeqYuzJ5
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f4c53c-d72d-45e1-1546-08d831e1b0af
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 04:01:07.3592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HryZUDWbcHPM/u2VOXg/WBRE9Jcl6x9wRExzvBkBEkhKdJ55LiuyCdkoDxQ1H++Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2620
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

It's OK to drop sensor_lock. But please keep smu->mutex in smu_read_sensor.
All top APIs from amdgpu_smu.c come with smu->mutex to avoid potential race issue.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Monday, July 27, 2020 11:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 2/2] drm/amd/swsmu: correct smu lock type on smu_read_sensor()

instead "mutex" with "sensor_lock" on smu_read_sensor().

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 4 ++--
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 2 --
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 2 --
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         | 2 --
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 2 --
 5 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 55463e7a11e2..69d7f7de9adf 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1946,7 +1946,7 @@ int smu_read_sensor(struct smu_context *smu,
 if (!data || !size)
 return -EINVAL;

-mutex_lock(&smu->mutex);
+mutex_lock(&smu->sensor_lock);

 if (smu->ppt_funcs->read_sensor)
 if (!smu->ppt_funcs->read_sensor(smu, sensor, data, size)) @@ -1988,7 +1988,7 @@ int smu_read_sensor(struct smu_context *smu,
 }

 unlock:
-mutex_unlock(&smu->mutex);
+mutex_unlock(&smu->sensor_lock);

 return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index f13979687b9e..5e56509a8f54 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1066,7 +1066,6 @@ static int arcturus_read_sensor(struct smu_context *smu,
 if (!data || !size)
 return -EINVAL;

-mutex_lock(&smu->sensor_lock);
 switch (sensor) {
 case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 *(uint32_t *)data = pptable->FanMaximumRpm; @@ -1109,7 +1108,6 @@ static int arcturus_read_sensor(struct smu_context *smu,
 ret = -EOPNOTSUPP;
 break;
 }
-mutex_unlock(&smu->sensor_lock);

 return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 6aaf483858a0..ece0f2a37704 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1710,7 +1710,6 @@ static int navi10_read_sensor(struct smu_context *smu,
 if(!data || !size)
 return -EINVAL;

-mutex_lock(&smu->sensor_lock);
 switch (sensor) {
 case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 *(uint32_t *)data = pptable->FanMaximumRpm; @@ -1749,7 +1748,6 @@ static int navi10_read_sensor(struct smu_context *smu,
 ret = -EOPNOTSUPP;
 break;
 }
-mutex_unlock(&smu->sensor_lock);

 return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 575ae4be98a2..3f4de2c30bfc 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -950,7 +950,6 @@ static int renoir_read_sensor(struct smu_context *smu,
 if (!data || !size)
 return -EINVAL;

-mutex_lock(&smu->sensor_lock);
 switch (sensor) {
 case AMDGPU_PP_SENSOR_GPU_LOAD:
 ret = renoir_get_current_activity_percent(smu, sensor, (uint32_t *)data); @@ -974,7 +973,6 @@ static int renoir_read_sensor(struct smu_context *smu,
 ret = -EOPNOTSUPP;
 break;
 }
-mutex_unlock(&smu->sensor_lock);

 return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index dcc5d25a7894..d4e52866e04f 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1521,7 +1521,6 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 if(!data || !size)
 return -EINVAL;

-mutex_lock(&smu->sensor_lock);
 switch (sensor) {
 case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 *(uint32_t *)data = pptable->FanMaximumRpm; @@ -1560,7 +1559,6 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 ret = -EOPNOTSUPP;
 break;
 }
-mutex_unlock(&smu->sensor_lock);

 return ret;
 }
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C59903ad7916e46d3996908d831d9c8fc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637314158764254291&amp;sdata=4oXm1j7KHefIx73tvURU627HeY8FNw0N5IjBRfzEmFQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
