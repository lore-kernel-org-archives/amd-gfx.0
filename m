Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05311C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 02:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A56A10E724;
	Thu, 25 Apr 2024 02:32:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3E7V7Kia";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB7410EBB2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 02:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMeSRGdsO5l/rPHlLJF/ffRiT5lXZ1H/aP6zseOBm8ipXpjZuSyn8/3wUflup6KdS6efQHhuVGAlG98MAIwSfwry20mLpXj+xzoo0MuZZlWSpkk2eHRFJmjjZLT4kxCxryTwAZQnYhebHVyUGgM7C5m6tW7Jyq/PJ46IMf7msoXzFu73EYX/vuoUGVmkzXvaiIQAi7PuyLpNrBQ1xBRzDzIqydOizUnEtCVW0JtnaFABFi1C+x7Ldmv5rGqR2ygfZH10YkA2qJkfylaABcO2ktoplm2JBkqWA5OxCLYvH0KaI+dl4UEkYICBh1vD/PzdyHIO99RZWq2eNqe6c//wtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9uXoK5UJPWzL5daKyJBabE0jqoWFb1frHNl/PdHi5M=;
 b=Kj6pAD9tojj6EdTMfPDdXa5nOZs/RrPWDdZpQZVNhZsou0JfShjIY48aTg+jKNoa9laX5pO0HXIy2kNR+fYboEaVqNaEToVsoNFCY6eNQhkJ5mKb7brlz4YFxmA5DYkUAKITVj+68t+UMnE0IUKgaYMIt327YRVrmFNeVJxvg3G4m2kyq6Yx05scjuPPOnKbDJ6FZWFf5dyKQgY2LNiAsRFV02S/TeArEoPrPQirPIphxnq3jcKNKh4k/heGVdGDI3WXPl2rv+/JN44yp5jhqyAblB5Qygrh+KV3mIfTGCncyTZJ2uHk4tAO57q7DN7vdLjI5GSSzlVq8cYfYV6xRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9uXoK5UJPWzL5daKyJBabE0jqoWFb1frHNl/PdHi5M=;
 b=3E7V7Kia5oO3a4V2G3jzIA8J24vntYibTryx7y58MYlw4SXlbJNazWungbCylCumWTmig+vlKHpPb69fOke9bqpbnSBIcZ+MpuCQo2BPFIcNTmXrmVcIa2dg4ewVhDX/0jAnQGO2itcOOzTQXrwgThQRnnrkxdH4SOfPP8ZiF4c=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 02:32:39 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%2]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 02:32:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 04/15] drm/amdgpu: add poison creation handler
Thread-Topic: [PATCH 04/15] drm/amdgpu: add poison creation handler
Thread-Index: AQHakTy8mnXZ4GUGv0WtXrjQla80wLF4TcvA
Date: Thu, 25 Apr 2024 02:32:39 +0000
Message-ID: <BN9PR12MB5257DA7DEFE1AE7A17C9140EFC172@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-4-YiPeng.Chai@amd.com>
In-Reply-To: <20240418025836.170106-4-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3ef226f6-0f84-4afb-9c9e-bff40311e5be;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T02:27:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB8333:EE_
x-ms-office365-filtering-correlation-id: 652009df-8f52-432f-1bcc-08dc64cffa33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?+qbwe3B24YplbPqTlGln3vyi8lwPlXjiEF60iNACvfgiK4VgjMNfrpY7V8uH?=
 =?us-ascii?Q?7AegnwKK31NNybT7fRVaDtoWs2PpYePPjkFasFF+rK6SgT/TmkgZ+v3n5oDn?=
 =?us-ascii?Q?OHibyT0r4gETJPd+nd/OUtCuuLZtwQDOd/t3l44xaMM8V5wIaGd4dRlthOE6?=
 =?us-ascii?Q?OPfVQCIb4pX4Z0uJpB32fYPBy42KrpseT5wWhLBjGRj4Qpnw9NsX9Z2kBFp1?=
 =?us-ascii?Q?yYKW65sO7FKBf/jvPttEQx1wDuCfRVBLnfhaSn9WwcevAkweVw0X3bSw6S1k?=
 =?us-ascii?Q?v74A3Qd7j0EF9i4NeiPAlsLykvd8WP7d3rmB1rY6/gQ53gulfgAzPq5+9uAE?=
 =?us-ascii?Q?zTWQDbIKkHESQ9jxeIzsVKksJ1MUh0o2g+aBJtj+cq0I8z/HwoLXW+2a5MJB?=
 =?us-ascii?Q?d94JFWURqQBPZTft7VNtY78EAbPtK8JLrSPR3bjWgva8oDGSsM0vXNdTGnLM?=
 =?us-ascii?Q?a3wmQQghZFQ0InJcc8+fdIbkurT0106K+/MbGCZzjg4FjnUBTkpahvpkaLf1?=
 =?us-ascii?Q?C07T0QgUvN/QDNJLlWbZmjyND4IYihVucBmxI8xdIQolI82dfvuvXqt75sqT?=
 =?us-ascii?Q?c9SO+7nFcqd49uC8weaurtyzvrLX7YCJPzT/FEAk3N73e/GFQLNuyw+s3ojF?=
 =?us-ascii?Q?HqTNAr5Y643NdASfzkqABfxHL5YV4kykqvLWlVaxVDUSBhv7QbiHqI6MEjqX?=
 =?us-ascii?Q?S8iOk09ocAn97np1PmDlHrEVlJXS/kH0UffhI1Hq2QS5AHyAPFBRiCRcomln?=
 =?us-ascii?Q?QwVkohA71eNNvc+5d+EVXZG/qKenG+tK16Br1eh4VdbxkogXpUZZjlXul9EG?=
 =?us-ascii?Q?a53nmpKpZLQlORBv4uZegejaOU3jyMOZENI3bZRmgXVDgQKKgtedtENWiOFO?=
 =?us-ascii?Q?u+jIcJj0c/jmObWl47kMXT/HhkOuErfss7URKIbcGZAXTPoBvkLoqa+oWOMp?=
 =?us-ascii?Q?Wf24aCacEdiEBnODum2tc31BtneMbbgMuSp8WM5kjKyHzCNcBGGkXVznTPQu?=
 =?us-ascii?Q?KoNRJvhDSkTLTiqfK55Y/7NB62IJWjmoH/cCGlTO2OILLBOsX1VNbicEi0hK?=
 =?us-ascii?Q?AkIwYVTSUVsURliB8+o31wj6lJbWlPXKLeuJLR1puTikVaXQkUDQkJItvjWU?=
 =?us-ascii?Q?YAdi0/ct7QCckrEB+FqT2PYqE973EzAhMNZYWV4qcVX6hZbvm/cZ0istpi/m?=
 =?us-ascii?Q?97RoUku9oCJBgGHQomIZ2CXCpm064KnRcqOG1rw7Gksex17bNHkFs0Ukjfx3?=
 =?us-ascii?Q?d6R7M85Xjnuo/35Bwbo24pslYQEtqrWbGIc9BOtiAHgPXjV5HjBF9R1sv1pD?=
 =?us-ascii?Q?HU1aDGmgH3rKn/a+85hEqNREFZQ0O7jEeWvdS85f9yq6rg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Elt8BSI1grQmUvayo3c4IJZhwiutexEewtwjVr5voNZXAhLyOVtqPfv0ZHi?=
 =?us-ascii?Q?qUHRwcOQr7cbSAcL1lc6BAddx/EshYGY6U2KL1h0Rz5JEx+o+CaTxEl8ht1b?=
 =?us-ascii?Q?42HpPAqhZ4338P/KJ/pPqXGSLCxeHs9syOIRvbUZaxl/JCu7hDzjdX5ZOEIt?=
 =?us-ascii?Q?1w5dPVpW6JJxPJr5RUrrBtBAwjQTrx/PMXNZj8IfsiC5gCJmDI3V3lVLuq5X?=
 =?us-ascii?Q?g8AW2n0mEJp81hL8qy0yI9+W5VPADOdgtFk9EG7j+l4nAvhzOpSViIb+LTRt?=
 =?us-ascii?Q?I/GvNmO3VRFSUvXNhqXh/JcdW3YMMF6IoKIcL3NX8BlubPf2UK1gRFmncG5+?=
 =?us-ascii?Q?VFUE63JSaf61yeNNwJZGtGq0TGFOpTnhz4QPX2dJHGT75DT6ULuqWLa8OmpW?=
 =?us-ascii?Q?nGPoyH1EM/Ut1ptnfDAWY+4H8RhDj7V4Tn0SPMQi9+DFsfthAMT9obj+kW4c?=
 =?us-ascii?Q?XGL+70mwRPOdIuEw2hef9WlQClfpxlIY74LzBKVwp0AZ6ldZo6g7AYiZRv+G?=
 =?us-ascii?Q?ceSoaKO7lyotlvssfOU7ofuyjybmRmnk/oszo4CbQTZMVTf4DeIUfrie9lhh?=
 =?us-ascii?Q?kBwc6VSXxP+odX5UfXq6DS05v9qsT3Ft+dwWjkkVj0TWOA/U+ygpSdI01cZP?=
 =?us-ascii?Q?2NSmdYh2LndrQV/w2LZVgdFAwOjiKEwoVmAFwNDUbv/gaYCl5RfYR/xkKMMW?=
 =?us-ascii?Q?2fNz4FIn0rHefhypm4Yyv6dquPUViK/66moptqWqNFJru/1pgx4/3D4lu64b?=
 =?us-ascii?Q?rJ/Oy4MNsBORmaJ1zOoyCDVgnoTk/BwHrasIR0AEwHWWYuVOroE25zjBeyTo?=
 =?us-ascii?Q?XqBbFmuTuoGcJ9GyEC+FNy+i1E/Ze2YcMGnn49bxUTUrauDvspW8XKrjsh54?=
 =?us-ascii?Q?1MB7hCJSmgJGT1ExoqR6c/Bo88hn8ozckPgdncgbAQ6Ha+oFr+e469q14yAu?=
 =?us-ascii?Q?35ro2bs44lZZsp6GQoKRbXJ7YGmKS/8fhsyb2xtVlNkDfL5ouWf4xJFw7Elm?=
 =?us-ascii?Q?OQ44suMAO6h3JFusJ/DlHBiUh5jbtNOjWDcMK3l+8Azz7Zcm4MVSxx358SbW?=
 =?us-ascii?Q?4m8PL2ox//PhvLSWOMMAZLeJbMzLo4+N2KlDJ38Y7wpBhVrKXCuMN0CD2GT4?=
 =?us-ascii?Q?7M8hIvHpNRU8ULHrrPjj+RZvncfwIbgI+cfpyJ1LxKzXuI5uouTrjDO8eZaZ?=
 =?us-ascii?Q?uKngna/O5RbulZCdR83f4u5bfz5uBvchRJHN8M0hyeg5Fhfi9Q13epJl2T/F?=
 =?us-ascii?Q?SZq9yNIAvolupqAQK+d22R1SYa2P+d+fOMrTtzAPJUpqTaWGqG+9SBfXm8Gv?=
 =?us-ascii?Q?z4EAouyy4RdEKWI1F7ZJe8uouWP+rWNS/PsKvJzyTrGDyiTP7PCtdIcDtCjI?=
 =?us-ascii?Q?cro9sJVn8WaAI6zzyONwaeNH/w0TPIOTKixrmyqMLXoHmSbRYgR8wOKsrlX3?=
 =?us-ascii?Q?SQ4J8do2AHXSC+0LzvpAaEfhvb5OFO8O6kUOH3A4tg6pLNpjhHjX4DmA+sNi?=
 =?us-ascii?Q?PXZR9Z7Q5bg8cr/biwunXTnMmOvTS1kzWc0yklsRuj/xZYcdUK81xeQbzUYc?=
 =?us-ascii?Q?N2Ju/ZXw81bkEI2GAVfArx7h+Iu5H7T6a4QqihGu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652009df-8f52-432f-1bcc-08dc64cffa33
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 02:32:39.8338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EAUEMLJDimQEtrkvTQgK2BXXRRAuCBh2k/ajZo3KgwTC6fwC3OU67Py6cYYJIHggE/Y/4pOXBQNNTvFIbbSTiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Is it okay to drop below static function and just implement the logic in po=
ison creation handler leveraging the ras query api: amdgpu_ras_query_error_=
status.

It seems to me the static function may not be able to be used for other IP =
blocks.

Regards,
Hawking

+ static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,
+                       enum amdgpu_ras_block ras_block, uint32_t timeout_m=
s) {
+       int ret =3D 0;
+       struct ras_ecc_log_info *ecc_log;
+       struct ras_query_if info;
+       uint32_t timeout =3D timeout_ms;
+       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+
+       memset(&info, 0, sizeof(info));
+       info.head.block =3D ras_block;
+
+       ecc_log =3D &ras->umc_ecc_log;
+       ecc_log->de_updated =3D false;
+       do {
+               ret =3D amdgpu_ras_query_error_status(adev, &info);
+               if (ret) {
+                       dev_err(adev->dev, "Failed to query ras error! ret:=
%d\n", ret);
+                       return ret;
+               }
+
+               if (timeout && !ecc_log->de_updated) {
+                       msleep(1);
+                       timeout--;
+               }
+       } while (timeout && !ecc_log->de_updated);
+
+       if (timeout_ms && !timeout) {
+               dev_warn(adev->dev, "Can't find deferred error\n");
+               return -ETIMEDOUT;
+       }
+
+       return 0;
+}
+
+static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
+                                       uint32_t timeout)
+{
+       amdgpu_ras_query_ecc_status(adev, AMDGPU_RAS_BLOCK__UMC, timeout); =
}
+

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YiPeng C=
hai
Sent: Thursday, April 18, 2024 10:58
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 04/15] drm/amdgpu: add poison creation handler

Add poison creation handler.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 74 +++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 64e6e20c6de7..126616eaeec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2080,6 +2080,17 @@ static void amdgpu_ras_interrupt_poison_creation_han=
dler(struct ras_manager *obj  {
        dev_info(obj->adev->dev,
                "Poison is created\n");
+
+       if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >=3D IP_VERSION(12, 0=
, 0)) {
+               struct amdgpu_ras *con =3D amdgpu_ras_get_context(obj->adev=
);
+
+               amdgpu_ras_put_poison_req(obj->adev,
+                       AMDGPU_RAS_BLOCK__UMC, 0, NULL, NULL, false);
+
+               atomic_inc(&con->page_retirement_req_cnt);
+
+               wake_up(&con->page_retirement_wq);
+       }
 }

 static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj, @@ -=
2754,10 +2765,54 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_=
info *ecc_log)
        mutex_destroy(&ecc_log->lock);
        ecc_log->de_updated =3D false;
 }
+
+static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,
+                       enum amdgpu_ras_block ras_block, uint32_t timeout_m=
s) {
+       int ret =3D 0;
+       struct ras_ecc_log_info *ecc_log;
+       struct ras_query_if info;
+       uint32_t timeout =3D timeout_ms;
+       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+
+       memset(&info, 0, sizeof(info));
+       info.head.block =3D ras_block;
+
+       ecc_log =3D &ras->umc_ecc_log;
+       ecc_log->de_updated =3D false;
+       do {
+               ret =3D amdgpu_ras_query_error_status(adev, &info);
+               if (ret) {
+                       dev_err(adev->dev, "Failed to query ras error! ret:=
%d\n", ret);
+                       return ret;
+               }
+
+               if (timeout && !ecc_log->de_updated) {
+                       msleep(1);
+                       timeout--;
+               }
+       } while (timeout && !ecc_log->de_updated);
+
+       if (timeout_ms && !timeout) {
+               dev_warn(adev->dev, "Can't find deferred error\n");
+               return -ETIMEDOUT;
+       }
+
+       return 0;
+}
+
+static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
+                                       uint32_t timeout)
+{
+       amdgpu_ras_query_ecc_status(adev, AMDGPU_RAS_BLOCK__UMC, timeout); =
}
+
 static int amdgpu_ras_page_retirement_thread(void *param)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)param;
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       struct ras_poison_msg poison_msg;
+       enum amdgpu_ras_block ras_block;

        while (!kthread_should_stop()) {

@@ -2768,13 +2823,22 @@ static int amdgpu_ras_page_retirement_thread(void *=
param)
                if (kthread_should_stop())
                        break;

-               dev_info(adev->dev, "Start processing page retirement. requ=
est:%d\n",
-                       atomic_read(&con->page_retirement_req_cnt));
-
                atomic_dec(&con->page_retirement_req_cnt);

-               amdgpu_umc_bad_page_polling_timeout(adev,
-                               0, MAX_UMC_POISON_POLLING_TIME_ASYNC);
+               if (!amdgpu_ras_get_poison_req(adev, &poison_msg))
+                       continue;
+
+               ras_block =3D poison_msg.block;
+
+               dev_info(adev->dev, "Start processing ras block %s(%d)\n",
+                               ras_block_str(ras_block), ras_block);
+
+               if (ras_block =3D=3D AMDGPU_RAS_BLOCK__UMC)
+                       amdgpu_ras_poison_creation_handler(adev,
+                               MAX_UMC_POISON_POLLING_TIME_ASYNC);
+               else
+                       amdgpu_umc_bad_page_polling_timeout(adev,
+                               false, MAX_UMC_POISON_POLLING_TIME_ASYNC);
        }

        return 0;
--
2.34.1

