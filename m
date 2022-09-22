Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B1BECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 01:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E265010EA25;
	Thu, 22 Sep 2022 01:36:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D5A10EA25
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 01:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7ntqMJmm9uoCS0FXhTpFt2wjWR3OTkmKveNLSIOUuYaQqVAvvyLxxXz2jLRJvx0TIsHh266QMe6blK/7yj7+pha6heBOQtgmbSwCkszS7D6HcybFUsSr3vpiQ3pd47n2WR09NAIN70YtyBQ/F2xj3Z4vuNl8zqGkyJQG1nCgaSA3/59dAozLzJoSGP9r72iYNmJkBn4fDS65o+4GgzxT5JQxKtIGlzlQ90ilsm+xf30LwMpM/eXFqjeyM82YCKuM7r1yVx/frH+Qxgn2xP9M1n8BwgPEXz0Lh1s0S+vsI6k3Y4roLIp74/iKSAZ248MGc0t2dNMgrqNSffMWrzuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgMCtgt8iFu7b4wyWExjWcibFYiEHNy3eY6fB/1mg4A=;
 b=elnYtnJ5nLUi45yB9yZGRFQgAVXjr+z9VGA+c7E88Kj8KsC+wL7rPran8xVt7moHu94kzI/HigdLn/Oeo+4wyr8HA1rDG/TEUhVit5Eo55qHkdADgw9NCeGacLWXKJfnrNNpreaiHeQghQvYj3GyM+fXqUDGjtir5S5el7cIhv2SKcmYCo8M5BDULtCG5FN6xscTS8umEIQnGM7mZ/d4YWI49KB1DBU5aWmK2/H4MSqUq4BzGO66rf9NRwWfiZw5n//3SbSosPpdak1ttS9zxRHq7NOhj4F6ipVkWsWz1T8NcEWG9402TgJYEHM4toRVaYLPSdd9d3WAhKTVKOGzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgMCtgt8iFu7b4wyWExjWcibFYiEHNy3eY6fB/1mg4A=;
 b=4rzQf5WouZ1DKaIrtMIHw9UsynLB9i+ErUj1Syt7k2EuheBvhOUUdjCXN4ZLoLql+AQohUsVaHqw+qCzKNI059k9dP7B1bYC/eY85wezCvm/+nvRp6LZ3bvsWNMEFyaf3ZvRcEW4OFi8v+au6YTS9dNwNt7RX6e9l9mp+6zCUt0=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 01:36:46 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::c5b3:5a8a:5947:be53]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::c5b3:5a8a:5947:be53%4]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 01:36:46 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fixed ras warning when uninstalling amdgpu
Thread-Topic: [PATCH] drm/amdgpu: Fixed ras warning when uninstalling amdgpu
Thread-Index: AQHYzJXMGKVWn+1KKE69SI3uatSiWK3qrlAw
Date: Thu, 22 Sep 2022 01:36:46 +0000
Message-ID: <CH2PR12MB42150879BB1AB00A757CFB3CFC4E9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220920020701.692610-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220920020701.692610-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-22T01:36:31Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=67060bbc-c269-424e-af3c-7725e3c12396;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-22T01:36:42Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: c8a56e9a-bfac-46e2-9ac2-7a2774ee17e2
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CH2PR12MB4199:EE_
x-ms-office365-filtering-correlation-id: 9bda8eaa-ad7b-468e-6a95-08da9c3ae963
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1SLrVc5/sALz5EJh1hR1Ueovxemczji2fbk4FA4Di212zunPR9JOkeBAlxgalEjqTydImfIvAcxW1GcKofyuk9gudNAlmTRn+pugmd9mb2TSuh+zQuPshZxeot8xlfdgrc/eQ8QKCI3feu7tzOxKAGAghknlSkKWC+cdHLhut/ILqYTp8Gw3/s/i58Lmbw6uoYhF+Ny9gW/xSYbIydG8AtLvSXI+8B/Mz5QDXuj7uwT6RMziCByjSs01kvf4ADPqpqR2T0z8lPVjS5mQ8C3ZQSIeQc5ciYEjrPMzuFpmsD764c9Ud3009Ncy68YoZETOBqNDBBIjLVbrHNItyPBgmRi6T3x/Mve6aR90PFElfIlNtw03Ylz8V5a0W/3e8MNoTgggBty5O2LLI/WtPKSpiSjwpiwxziF0LKCORwyFGxV6KkbDywvqjTxPUeyWYxXhRjE+eRxEAoiaRGkwsCR2jHjdaqqcOlj3ZS/dlMTZAJJarX6hHwIDb+nfxXoDvoaH7H62iwZVibbIy1CpaqG5FyKoKOOvLnbGW4pAh+hbzrC5KA4P+ocGFW2wmcVZgnGEvzcEz/B+dzLBB48nIoSqFSLFqQan5rjXZRJA+jNIkbgrwzybNzMe50aoeV9APTVf9DlcdWpCg+Kb0a2tz6ZZejLddApcl3/OG/jqHRBILdGWgWM1esEyoLcM4eSv7CJU8ilJ64lImwIK7gt6hIHGTJpfs4uwhJgeXQw1Fr7qoWnbd16IT3XU6UOfaRHdGJDOnosVHIUfcbT6CDPq3ALZ/4G43tLkURti3L3RXanS08Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(66556008)(66476007)(66446008)(64756008)(83380400001)(38100700002)(122000001)(4326008)(33656002)(5660300002)(54906003)(6916009)(41300700001)(86362001)(8676002)(8936002)(76116006)(316002)(55016003)(52536014)(66946007)(186003)(26005)(478600001)(38070700005)(9686003)(53546011)(71200400001)(2906002)(6506007)(7696005)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EdynsOuc6ctBk+xz8zNAxJwjnMiNXjhwpdTdGkhXIRGCRXqksA2KO7cZm17x?=
 =?us-ascii?Q?jBJmqT6JdGf1X/L1l8EGWAMcQzP+AhFaQbnB704dxXpzy0gwrkC5WecJ/v8r?=
 =?us-ascii?Q?GGCqxWKJKyPz0lmEvw9xvjSZXU33UH0RzrSc1yII2zqBaruDwcGIAH3L/0hg?=
 =?us-ascii?Q?/0bCwzSTNP50g5agQdjWwQVt6EzQfoytpl69hgPF+JpODJLIDBazePM822JY?=
 =?us-ascii?Q?MIjFRi+einFeWS/gJFl4AAej4nEtpxWVNrwKh+6cWPQtWRtKW5zBQzsM1iXI?=
 =?us-ascii?Q?1WqsG22kFBPL73sA6x2mi+1pd4brUuy+Pni2gNC4kY8iMpvUtY21QRgEAsG1?=
 =?us-ascii?Q?gjGVK+o1R0fRl/sIqTFWi6Dw9fCt6M7AhQKfK+fC7Hkn5opyLuhpZyxLcNtc?=
 =?us-ascii?Q?/dNfq8IUuEhF6OJT+V4C79OgSW/fxTeNdRdu3g9AznWP5hOl1A0OF7tSMUVj?=
 =?us-ascii?Q?svKph52hemiyxYByuFSD1LBvqbSS5HkE0vNNfYYmBVPClgETId2QGiWMjB41?=
 =?us-ascii?Q?/C70Drt9BviUSi4WTOJgQuCABsHAJZ4lFSnpGSI5AZvkmQ9Yyj/2RKuTriuJ?=
 =?us-ascii?Q?kJPPdzO3om4jeU65f8ZrwN3p6bg8WUcGfTHtbWp9h8CyHysLteaZ+Um1Rghw?=
 =?us-ascii?Q?fb9R5Tt2EVjahsqH19Q1KR728p2aia5fSka8GjTV9IKbfHStTkw7q5agu796?=
 =?us-ascii?Q?Ew3sd3PvNoFbBSs8nZN7gJ5o83CamXMqVTIxalve5JVUvI81iRMLc9OyJ6CF?=
 =?us-ascii?Q?VJoeWnqzxKAdS2XC6KHi/bwMo79uiHz3R9GvkOefyG8xA540r6zfbK7hVt1F?=
 =?us-ascii?Q?mWWtkDH1pyexX947wWCGs1Sp96Hm1S/Gvoo5NFL1JwIz1+9mpzXH5bDatRWJ?=
 =?us-ascii?Q?c2T4eKbOyFIr8H+E1mB/omEUaOwyfqFJ+2xYuFh6gDSit5gkfOWlRMqh35Pb?=
 =?us-ascii?Q?pwmkzDMm59SXsGVBlPy37aM5fSFilzkcFRiA3bIXHO+By4HEQ++n87DVREeU?=
 =?us-ascii?Q?aXYgL2VnplnOpWktdL9SG9bte4/wAEZjQAuEEvXImXuB1xsGug4pYvWJbM9i?=
 =?us-ascii?Q?j+GXi9MtxywHsdqxz6NcdCqBHxJzmdm88OamGt4U/h/GSp7RZpOgd/boiArv?=
 =?us-ascii?Q?II5nzRhSHyNRTDMPJkNuAKfptOHgI9f/urMbVegtx4vxcMDP2HVCDwEZTipY?=
 =?us-ascii?Q?ExHCMcdNqZiDOad+BZ1uIUsxjgkWn+E+V8pdBUT0Y0mIeEGV4TCbt6Mrab5M?=
 =?us-ascii?Q?vJQPCxNEtO2UowyJJhUwhOuwkvyVmnJ8YT1ZIk0JFtdbos2eCwe4GzNwCe7p?=
 =?us-ascii?Q?S8wG9eQmbRhK4KgvsBVGM7ip3/12xkKPwf/OPAruLLEDP3mNEGaL2KmJ3njB?=
 =?us-ascii?Q?ySrhPgsL27xuU0tc4QVDnlhGW4W3Cyup8f1sVMlN5SIsOBhjzJVD12DxzTAQ?=
 =?us-ascii?Q?yxLai2RDB3XjEQV4wHKLeiGPh9RxNDie93M73rqov7EOJyRSgJONBoDh0ftj?=
 =?us-ascii?Q?2vTJo5RhmS2Lt/Vr4/JAojt4X91Ss3gujq5nQBZDY2VzlF+sQEQNz1QM07nq?=
 =?us-ascii?Q?Z+XFqL4DBzvp/6DHQiQae8+ghUK4Izk884B+8exp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bda8eaa-ad7b-468e-6a95-08da9c3ae963
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 01:36:46.3676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6lZYthLaPO7M7s/23lha22MoP+dXewXFoxBYqw/QNqHa5h2Uv60vuwlcAgV099wrbF8OBDdaLfopCorOk1n+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
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
Cc: "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements,
 John" <John.Clements@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping ...


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Tuesday, September 20, 2022 10:07 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>=
; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Fixed ras warning when uninstalling amdgpu

  For the asic using smu v13_0_2, there is the following warning when unins=
talling amdgpu:
  amdgpu: ras disable gfx failed poison:1 ret:-22.

[Why]:
  For the asic using smu v13_0_2, the psp .suspend and
  mode1reset is called before amdgpu_ras_pre_fini during
  amdgpu uninstall, it has disabled all ras features and
  reset the psp. Since the psp is reset, calling
  amdgpu_ras_disable_all_features in amdgpu_ras_pre_fini
  to disable ras features will fail.

[How]:
  If all ras features are disabled, amdgpu_ras_disable_all_features
  will not be called to disable all ras features again.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index e55f106621ef..3deb716710e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2720,7 +2720,8 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
=20
=20
 	/* Need disable ras on all IPs here before ip [hw/sw]fini */
-	amdgpu_ras_disable_all_features(adev, 0);
+	if (con->features)
+		amdgpu_ras_disable_all_features(adev, 0);
 	amdgpu_ras_recovery_fini(adev);
 	return 0;
 }
--
2.25.1
