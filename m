Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5B7CDB483
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 08:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F042610E115;
	Tue, 17 Oct 2023 08:03:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8462F10E115
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 08:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA+vWzsD1cJkQbPQhwrehMIvQp0awrYW8EUqEbgcOJh5WSziH6LFYccZVNG/d41oNExrIZh5oMCd6otDOfDpGOCb6T16/Me65ltHBvFqBHx03J1Tnjd7t6hujEVh3K9mvp20Sy6mT/Sb3n2OaHIEyRH1VSO1B5bukWNU0NvitMPJOWHocxSALibX+ppE1JoxZkqtjjsR5UFay+rpO/120LIBersMxyTU3740UFUQI4CnoFL2J82i9KQhzc0WWV6yx72t6UzTTqdUuPVk3HmxQqt7+tN3SXXETz2zKNSuxSLeADDNpslovkUdbVP85tz/R+iFJEPik4QjyKLKTubkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUNLQE6HZNSPQfKyHZT5VFRxR7CfW4BHbVugQA4+/9w=;
 b=nZ545AJWc5t68U9axG3O9FBnpSFIiEVzGcer7Wk7N1kBFyun0tG/wFRSI+viNufhmxkXG0Fs2fDQmhZuaXcLhGXi6wjPC1ml7cx3wVOC4a6IgZwUKKbeIP5pK3w2FkT64w9LG/SdpmZ392j2hktHLENzmaLJTNmKuKgMgtLfLOWi2Z+xiIMrWdMVgBcKpdbiXTgdLqeiKot9pe6gXTX8165e+2P7RqUJVGpV/z6z6MRsAcEh6tFBU6Po59KhYtq7yvMrCo7TkBQHxRpXsy9iqoqko+H6kqUG2WQB0+CZRi7T8ZYPi62FtnFt56bPVF5JUEfIjVCHaM/islZLexuQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUNLQE6HZNSPQfKyHZT5VFRxR7CfW4BHbVugQA4+/9w=;
 b=aZGUy+rEFyO1+cli/Q95KlkXWgUV62v/Lt8p0XoPdFpsxmbV9CX7ku+qk0KzBuoxdFNvOYiWDVuSk3GTlhwl2avNC/Vc2kA8e9r+EiaZyicMtyIGu52T328F3bYB6PZA51dXi6cEyhmbzltaXHjxYVtQc4+OG1MUFjBwzUaqk0M=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 08:03:51 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6863.032; Tue, 17 Oct 2023
 08:03:51 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Support for getting power1_cap_min value
Thread-Topic: [PATCH] drm/amd/pm: Support for getting power1_cap_min value
Thread-Index: AQHaAMqsF+k3iBe5oUi4+ZTxcvnSC7BNmwaAgAADjKA=
Date: Tue, 17 Oct 2023 08:03:50 +0000
Message-ID: <PH7PR12MB5997880AB88B47A7B7672A9682D6A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231017072139.40963-1-Jun.Ma2@amd.com>
 <DM4PR12MB5165D91F95C67DC3DF105E988ED6A@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5165D91F95C67DC3DF105E988ED6A@DM4PR12MB5165.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=42392d93-8588-41eb-bf46-201c27319e0b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-17T07:47:48Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB8104:EE_
x-ms-office365-filtering-correlation-id: 1f703adc-6754-421b-8947-08dbcee7994e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j4ZLffD5SMN4+suR/rZZh556xweX6lh56jnh7nbdTVi8oO96sdFvubh8e9p1zZLCS1sfhzugqle5aSqHK2J1U9sTyuEQUgR20YR6MvI7fut/RoLeROSsgJN2Y25jiPHdG+kdAvizhMxy/HiY4vGFvXzUBqeLpaa/HxBqzFKv5azqY++++LWiofWwzYRlwVJY09vJ9VtxTumfLvlamrTLK5eDOIoB3+YcRv8nQBF2G3Cp0PmtNRwFQbxiCNZ/sN+EGzQpPT/gop1DTCcb8mtABHSajIkS0mXFBwnUzPt88YlHcU6cOnJb724IM2PaGpEaUxtIbLWby0fohCGeutvAUA3tVTASgCYiU0gq4WSfVhq3CYL4aWaZK72YzG/0ix8biOu6Y0aa2WNjA0PKUsGApho+7yykcsA5KHDMv0Cie5o0SuWHGf+/cOYxujQvRjcXJfngw5XPvbWCCMBFnICTyiL7wjhkch6oVOFDsJxxGYyuSM4B0KKDMnzPS1aLwYIP+rPvrhjLXwKNe2WFkZeNn+f9WSop/GjUEg6UuDkUekpE7DMqzEWvnFMfq6CxnxTwYITZUie9vY/3QcyqArbsa8xbrg1GyEkfBtNK+kFKn5Q7vkTkXpHaiAIdvNOhN32j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(76116006)(66446008)(110136005)(66946007)(66556008)(64756008)(66476007)(316002)(6636002)(33656002)(55016003)(86362001)(38100700002)(5660300002)(52536014)(8676002)(122000001)(8936002)(41300700001)(2906002)(30864003)(38070700005)(9686003)(71200400001)(53546011)(6506007)(7696005)(26005)(83380400001)(478600001)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8ufktamZSPNOYwTLjPHle11F1dU51QwAMOGUg9e+nwLl3NnYAtdy1GFGfc/H?=
 =?us-ascii?Q?GY9jo/wgi2Bq0K2uYfXVg768CklMQQplYLr4qD3dZvZybJrSlbd00bGMW8qQ?=
 =?us-ascii?Q?2Tilr8AjMJAY3QSUtmnhNsdPAqc714c4GE/qxBax1ViWcPPkjeNasQYIqcP4?=
 =?us-ascii?Q?pjwoNTc4AlHl8pwkU7psJxACztl3ue6b7sgusw6EGNpLFUtul3W7Iyi8sDwo?=
 =?us-ascii?Q?RZqr4HOmRzS1HBncuzKsTQ4TQGo+Dn9omNBkdSPApE4afZtYXbyPUoYZrfSu?=
 =?us-ascii?Q?X3cj6lwX6aRPMe8ddLCOGGsn36wPCZ61Clb9AXsUmcLwgBHuMKYeMwP3hWBL?=
 =?us-ascii?Q?QPJSJrSth+xY33et63xyb/rzPXXpELXLk2xApJ956G26CuR847h2g+Uphlfn?=
 =?us-ascii?Q?bXHgvx9sYzI/hjsGnHIWYRJJAv4SVPeC8tMz52vqWJS+reTNohyNIUFV6lL/?=
 =?us-ascii?Q?zaU85v1CGAxpJf1Obxjf0qdSpa+fJCvBMJ44ah8tcCq2ARMvi912fdMcN07m?=
 =?us-ascii?Q?qDjcCOg2itkPHyziRjrL/qAw+Dv6qZo9+55wh84P6/iHt66ht3KUy/V7BuUm?=
 =?us-ascii?Q?E9/q9QG+jb/Qbfao4KWvcMZ3U6GpHALVn7TlE/mexfTdWiNMbU6Zwfr3OTgE?=
 =?us-ascii?Q?dA0uUAX0m+tSrSnlWwiwSfbcYsgsZcL6QijAsIVoTwIYWADQ0tX0/0igJSsu?=
 =?us-ascii?Q?9Ff/XEcG/jZ2G2XsGNlLM9dW6PuIANd7kZTEcWD8fCM9Np88DgjtbbscfGmK?=
 =?us-ascii?Q?Kc7OSXj+SMu8lcBgdZT4+q4sgRqD0nU0MjATXBgcp7UkU11eVVZ0g2QcNPht?=
 =?us-ascii?Q?aEpHZAM2v6Tq++i4NsC3Uanq7dSsJ9+PAWplfvLCP+8Em5A35kCQKz9N2WIf?=
 =?us-ascii?Q?0UjPpUHzxksS9v8RS2EnNFmiCqbzls00wUFkHny+/7EjaT/aqbZ5xPdPmEtd?=
 =?us-ascii?Q?6S3ueT4S6DOryx/cLvfjNB07u6nKFJwcGnFvVOmAXnVJ9teDoMoezRlRNXSU?=
 =?us-ascii?Q?GEu+3UVJmaDfc67qikyyxBScFWgVIM/mNGl1cYpw6n91dNxo12UK9vvApJRr?=
 =?us-ascii?Q?g4ba+uLiN6akNRgsxadYa7R1IwC/pI3Pjp7YSxxnVx7AwP9Gbe2DT/X3xtVm?=
 =?us-ascii?Q?2G9FbO2pOQ5GXuvJ+f9ozn82WsHBkzfMs+HA+7fnRzkQfixQ4vTTRN7rQDPQ?=
 =?us-ascii?Q?6P+Prmcey0k+f4/ThmerXwpxwCXDThj3otbStHVhHh3MgoAlM2FKBmnWu07S?=
 =?us-ascii?Q?yf6iW+JRzXSjqGzlvEF+JqweXVUFg4vB9GapHDlNPE0Wy9K6xFWemDQHPhvL?=
 =?us-ascii?Q?HYy7uYEZflopawSLtxjCOcUoZHGbmqh+ZA93HBIXN+IRgy89XuB+KNLoZtaA?=
 =?us-ascii?Q?IyOV6O9tKtYDt5pXzorICVXB1+cUt1dZVHO4G3zoDzF5QjjMHGhL9liXa31/?=
 =?us-ascii?Q?H412ZRAVgzc4hVNwCuUsyddjlqiQGyvK/9PCj+JMuGAs/7A584TdxgHq6iJi?=
 =?us-ascii?Q?PYD1bdyhFWO5SnUyGrjrAEqjXcPucV9aBY2HRF1GRgpNC09XKETh7DUH97en?=
 =?us-ascii?Q?FSGKvYqeugrf/bOvmGs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f703adc-6754-421b-8947-08dbcee7994e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 08:03:50.7805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvq9DHWWo8nQV4z1o/OblOubkH2duYnx4MYA00O5HdcfoF09Odo4njzd5eD8Pw4X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104
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

Hi Jun,

        int (*get_power_limit)(struct smu_context *smu,
-                              uint32_t *current_power_limit,
-                              uint32_t *default_power_limit,
-                              uint32_t *max_power_limit);
+                                       uint32_t *current_power_limit,
+                                       uint32_t *default_power_limit,
+                                       uint32_t *max_power_limit,
+                                       uint32_t *min_power_limit);

Can we make a new data structure to handle multi type power limit value to =
avoid extend function parameter list?
the function is already accept 8 parameters now..

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feng, Ke=
nneth
Sent: Tuesday, October 17, 2023 3:48 PM
To: Ma, Jun <Jun.Ma2@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alex=
ander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Support for getting power1_cap_min value

[AMD Official Use Only - General]

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Tuesday, October 17, 2023 3:22 PM
To: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; De=
ucher, Alexander <Alexander.Deucher@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amd/pm: Support for getting power1_cap_min value

Support for getting power1_cap_min value on smu13 and smu11.
For other Asics, we still use 0 as the default value.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 14 ++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 +++++----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 +++--  .../gpu/drm/amd/=
pm/swsmu/smu11/arcturus_ppt.c | 33 +++++++++++-------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 33 +++++++++++-------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 34 +++++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  5 ++-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 13 ++++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 34 ++++++++++++-------  ..=
./drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  9 +++--  .../drm/amd/pm/swsm=
u/smu13/smu_v13_0_7_ppt.c  | 34 ++++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 +-
 12 files changed, 147 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index c7c29aa24c36..d76c3abf406f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2921,14 +2921,6 @@ static ssize_t amdgpu_hwmon_show_power_input(struct =
device *dev,
        return sysfs_emit(buf, "%zd\n", val);  }

-static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
-                                        struct device_attribute *attr,
-                                        char *buf)
-{
-       return sysfs_emit(buf, "%i\n", 0);
-}
-
-
 static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
                                        struct device_attribute *attr,
                                        char *buf, @@ -2965,6 +2957,12 @@ s=
tatic ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
        return size;
 }

+static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
+                                        struct device_attribute *attr,
+                                        char *buf) {
+       return amdgpu_hwmon_show_power_cap_generic(dev, attr, buf,
+PP_PWR_LIMIT_MIN); }

 static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
                                         struct device_attribute *attr, dif=
f --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/p=
m/swsmu/amdgpu_smu.c
index 7c3356d6da5e..f4a68d107184 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -849,7 +849,8 @@ static int smu_late_init(void *handle)
        ret =3D smu_get_asic_power_limits(smu,
                                        &smu->current_power_limit,
                                        &smu->default_power_limit,
-                                       &smu->max_power_limit);
+                                       &smu->max_power_limit,
+                                       &smu->min_power_limit);
        if (ret) {
                dev_err(adev->dev, "Failed to get asic power limits!\n");
                return ret;
@@ -2447,6 +2448,8 @@ int smu_get_power_limit(void *handle,
                limit_level =3D SMU_PPT_LIMIT_MAX;
                break;
        case PP_PWR_LIMIT_MIN:
+               limit_level =3D SMU_PPT_LIMIT_MIN;
+               break;
        default:
                return -EOPNOTSUPP;
                break;
@@ -2466,8 +2469,7 @@ int smu_get_power_limit(void *handle,
                        case IP_VERSION(11, 0, 13):
                                ret =3D smu_get_asic_power_limits(smu,
                                                                &smu->curre=
nt_power_limit,
-                                                               NULL,
-                                                               NULL);
+                                                               NULL,
+ NULL, NULL);
                                break;
                        default:
                                break;
@@ -2480,6 +2482,8 @@ int smu_get_power_limit(void *handle,
                case SMU_PPT_LIMIT_MAX:
                        *limit =3D smu->max_power_limit;
                        break;
+               case SMU_PPT_LIMIT_MIN:
+                       *limit =3D smu->min_power_limit;
                default:
                        break;
                }
@@ -2502,10 +2506,10 @@ static int smu_set_power_limit(void *handle, uint32=
_t limit)
                if (smu->ppt_funcs->set_power_limit)
                        return smu->ppt_funcs->set_power_limit(smu, limit_t=
ype, limit);

-       if (limit > smu->max_power_limit) {
+       if ((limit > smu->max_power_limit) || (limit <
+smu->min_power_limit)) {
                dev_err(smu->adev->dev,
-                       "New power limit (%d) is over the max allowed %d\n"=
,
-                       limit, smu->max_power_limit);
+                       "New power limit (%d) is out of range [%d,%d]\n",
+                       limit, smu->min_power_limit,
+ smu->max_power_limit);
                return -EINVAL;
        }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 1454eed76604..839553a86aa2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -500,6 +500,7 @@ struct smu_context {
        uint32_t current_power_limit;
        uint32_t default_power_limit;
        uint32_t max_power_limit;
+       uint32_t min_power_limit;

        /* soft pptable */
        uint32_t ppt_offset_bytes;
@@ -821,9 +822,10 @@ struct pptable_funcs {
         * @get_power_limit: Get the device's power limits.
         */
        int (*get_power_limit)(struct smu_context *smu,
-                              uint32_t *current_power_limit,
-                              uint32_t *default_power_limit,
-                              uint32_t *max_power_limit);
+                                       uint32_t *current_power_limit,
+                                       uint32_t *default_power_limit,
+                                       uint32_t *max_power_limit,
+                                       uint32_t *min_power_limit);

        /**
         * @get_ppt_limit: Get the device's ppt limits.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 44e4289b95cd..77c01bfb96fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1285,14 +1285,15 @@ static int arcturus_get_fan_parameters(struct smu_c=
ontext *smu)  }

 static int arcturus_get_power_limit(struct smu_context *smu,
-                                   uint32_t *current_power_limit,
-                                   uint32_t *default_power_limit,
-                                   uint32_t *max_power_limit)
+                                       uint32_t *current_power_limit,
+                                       uint32_t *default_power_limit,
+                                       uint32_t *max_power_limit,
+                                       uint32_t *min_power_limit)
 {
        struct smu_11_0_powerplay_table *powerplay_table =3D
                (struct smu_11_0_powerplay_table *)smu->smu_table.power_pla=
y_table;
        PPTable_t *pptable =3D smu->smu_table.driver_pptable;
-       uint32_t power_limit, od_percent;
+       uint32_t power_limit, od_percent_upper, od_percent_lower;

        if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
                /* the last hope to figure out the ppt limit */ @@ -1309,17=
 +1310,25 @@ static int arcturus_get_power_limit(struct smu_context *smu,
        if (default_power_limit)
                *default_power_limit =3D power_limit;

-       if (max_power_limit) {
-               if (smu->od_enabled) {
-                       od_percent =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+       if (smu->od_enabled) {
+               od_percent_upper =3D le32_to_cpu(powerplay_table->overdrive=
_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+               od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive=
_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+       } else {
+               od_percent_upper =3D 0;
+               od_percent_lower =3D 100;
+       }

-                       dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE:=
 %d (default: %d)\n", od_percent, power_limit);
+       dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (=
default power: %d)\n",
+
+ od_percent_upper, od_percent_lower, power_limit);

-                       power_limit *=3D (100 + od_percent);
-                       power_limit /=3D 100;
-               }
+       if (max_power_limit) {
+               *max_power_limit =3D power_limit * (100 + od_percent_upper)=
;
+               *max_power_limit /=3D 100;
+       }

-               *max_power_limit =3D power_limit;
+       if (min_power_limit) {
+               *min_power_limit =3D power_limit * (100 - od_percent_lower)=
;
+               *min_power_limit /=3D 100;
        }

        return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 5f3cbfff156a..a83bd3f347a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2337,15 +2337,16 @@ static int navi10_display_disable_memory_clock_swit=
ch(struct smu_context *smu,  }

 static int navi10_get_power_limit(struct smu_context *smu,
-                                 uint32_t *current_power_limit,
-                                 uint32_t *default_power_limit,
-                                 uint32_t *max_power_limit)
+                                       uint32_t *current_power_limit,
+                                       uint32_t *default_power_limit,
+                                       uint32_t *max_power_limit,
+                                       uint32_t *min_power_limit)
 {
        struct smu_11_0_powerplay_table *powerplay_table =3D
                (struct smu_11_0_powerplay_table *)smu->smu_table.power_pla=
y_table;
        struct smu_11_0_overdrive_table *od_settings =3D smu->od_settings;
        PPTable_t *pptable =3D smu->smu_table.driver_pptable;
-       uint32_t power_limit, od_percent;
+       uint32_t power_limit, od_percent_upper, od_percent_lower;

        if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
                /* the last hope to figure out the ppt limit */ @@ -2362,18=
 +2363,26 @@ static int navi10_get_power_limit(struct smu_context *smu,
        if (default_power_limit)
                *default_power_limit =3D power_limit;

-       if (max_power_limit) {
-               if (smu->od_enabled &&
+       if (smu->od_enabled &&
                    navi10_od_feature_is_supported(od_settings, SMU_11_0_OD=
CAP_POWER_LIMIT)) {
-                       od_percent =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+               od_percent_upper =3D le32_to_cpu(powerplay_table->overdrive=
_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+               od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive=
_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
+       } else {
+               od_percent_upper =3D 0;
+               od_percent_lower =3D 100;
+       }

-                       dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE:=
 %d (default: %d)\n", od_percent, power_limit);
+       dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (=
default power: %d)\n",
+                                       od_percent_upper,
+ od_percent_lower, power_limit);

-                       power_limit *=3D (100 + od_percent);
-                       power_limit /=3D 100;
-               }
+       if (max_power_limit) {
+               *max_power_limit =3D power_limit * (100 + od_percent_upper)=
;
+               *max_power_limit /=3D 100;
+       }

-               *max_power_limit =3D power_limit;
+       if (min_power_limit) {
+               *min_power_limit =3D power_limit * (100 - od_percent_lower)=
;
+               *min_power_limit /=3D 100;
        }

        return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 28868f64d134..8206a2744272 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -620,11 +620,12 @@ static uint32_t sienna_cichlid_get_throttler_status_l=
ocked(struct smu_context *s  static int sienna_cichlid_get_power_limit(stru=
ct smu_context *smu,
                                          uint32_t *current_power_limit,
                                          uint32_t *default_power_limit,
-                                         uint32_t *max_power_limit)
+                                         uint32_t *max_power_limit,
+                                         uint32_t *min_power_limit)
 {
        struct smu_11_0_7_powerplay_table *powerplay_table =3D
                (struct smu_11_0_7_powerplay_table *)smu->smu_table.power_p=
lay_table;
-       uint32_t power_limit, od_percent;
+       uint32_t power_limit, od_percent_upper, od_percent_lower;
        uint16_t *table_member;

        GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member); @@ -639,21 +=
640,26 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu=
,
        if (default_power_limit)
                *default_power_limit =3D power_limit;

-       if (max_power_limit) {
-               if (smu->od_enabled) {
-                       od_percent =3D
-                               le32_to_cpu(powerplay_table->overdrive_tabl=
e.max[
-                                                       SMU_11_0_7_ODSETTIN=
G_POWERPERCENTAGE]);
+       if (smu->od_enabled) {
+               od_percent_upper =3D le32_to_cpu(powerplay_table->overdrive=
_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+               od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive=
_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
+       } else {
+               od_percent_upper =3D 0;
+               od_percent_lower =3D 100;
+       }

-                       dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE:=
 %d (default: %d)\n",
-                                       od_percent, power_limit);
+       dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (=
default power: %d)\n",
+                                       od_percent_upper,
+ od_percent_lower, power_limit);

-                       power_limit *=3D (100 + od_percent);
-                       power_limit /=3D 100;
-               }
-               *max_power_limit =3D power_limit;
+       if (max_power_limit) {
+               *max_power_limit =3D power_limit * (100 + od_percent_upper)=
;
+               *max_power_limit /=3D 100;
        }

+       if (min_power_limit) {
+               *min_power_limit =3D power_limit * (100 - od_percent_lower)=
;
+               *min_power_limit /=3D 100;
+       }
        return 0;
 }

@@ -672,7 +678,7 @@ static void sienna_cichlid_get_smartshift_power_percent=
age(struct smu_context *s
        uint32_t cur_power_limit;

        if (metrics_v4->ApuSTAPMSmartShiftLimit !=3D 0) {
-               sienna_cichlid_get_power_limit(smu, &cur_power_limit, NULL,=
 NULL);
+               sienna_cichlid_get_power_limit(smu, &cur_power_limit,
+NULL, NULL, NULL);
                apu_power_limit =3D metrics_v4->ApuSTAPMLimit;
                dgpu_power_limit =3D cur_power_limit;
                powerRatio =3D (((apu_power_limit + diff --git a/drivers/gp=
u/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11=
/vangogh_ppt.c
index a5481274052e..d006ebe94aed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2344,7 +2344,8 @@ static u32 vangogh_get_gfxoff_status(struct smu_conte=
xt *smu)  static int vangogh_get_power_limit(struct smu_context *smu,
                                   uint32_t *current_power_limit,
                                   uint32_t *default_power_limit,
-                                  uint32_t *max_power_limit)
+                                  uint32_t *max_power_limit,
+                                  uint32_t *min_power_limit)
 {
        struct smu_11_5_power_context *power_context =3D
                                                                smu->smu_po=
wer.power_context; @@ -2366,6 +2367,8 @@ static int vangogh_get_power_limit=
(struct smu_context *smu,
                *default_power_limit =3D ppt_limit / 1000;
        if (max_power_limit)
                *max_power_limit =3D 29;
+       if (min_power_limit)
+               *min_power_limit =3D 0;

        ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPPTLimit, &ppt_lim=
it);
        if (ret) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 2373a66c7efd..84df7df78032 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1145,9 +1145,10 @@ static int aldebaran_read_sensor(struct smu_context =
*smu,  }

 static int aldebaran_get_power_limit(struct smu_context *smu,
-                                    uint32_t *current_power_limit,
-                                    uint32_t *default_power_limit,
-                                    uint32_t *max_power_limit)
+                                               uint32_t *current_power_lim=
it,
+                                               uint32_t *default_power_lim=
it,
+                                               uint32_t *max_power_limit,
+                                               uint32_t
+ *min_power_limit)
 {
        PPTable_t *pptable =3D smu->smu_table.driver_pptable;
        uint32_t power_limit =3D 0;
@@ -1160,7 +1161,8 @@ static int aldebaran_get_power_limit(struct smu_conte=
xt *smu,
                        *default_power_limit =3D 0;
                if (max_power_limit)
                        *max_power_limit =3D 0;
-
+               if (min_power_limit)
+                       *min_power_limit =3D 0;
                dev_warn(smu->adev->dev,
                        "PPT feature is not enabled, power values can't be =
fetched.");

@@ -1195,6 +1197,9 @@ static int aldebaran_get_power_limit(struct smu_conte=
xt *smu,
                        *max_power_limit =3D pptable->PptLimit;
        }

+       if (min_power_limit)
+               *min_power_limit =3D 0;
+
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 4ddaa372604a..851d7f1c6f19 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2343,16 +2343,17 @@ static int smu_v13_0_0_enable_mgpu_fan_boost(struct=
 smu_context *smu)  }

 static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
-                                      uint32_t *current_power_limit,
-                                      uint32_t *default_power_limit,
-                                      uint32_t *max_power_limit)
+                                               uint32_t *current_power_lim=
it,
+                                               uint32_t *default_power_lim=
it,
+                                               uint32_t *max_power_limit,
+                                               uint32_t
+ *min_power_limit)
 {
        struct smu_table_context *table_context =3D &smu->smu_table;
        struct smu_13_0_0_powerplay_table *powerplay_table =3D
                (struct smu_13_0_0_powerplay_table *)table_context->power_p=
lay_table;
        PPTable_t *pptable =3D table_context->driver_pptable;
        SkuTable_t *skutable =3D &pptable->SkuTable;
-       uint32_t power_limit, od_percent;
+       uint32_t power_limit, od_percent_upper, od_percent_lower;

        if (smu_v13_0_get_current_power_limit(smu, &power_limit))
                power_limit =3D smu->adev->pm.ac_power ?
@@ -2364,16 +2365,25 @@ static int smu_v13_0_0_get_power_limit(struct smu_c=
ontext *smu,
        if (default_power_limit)
                *default_power_limit =3D power_limit;

-       if (max_power_limit) {
-               if (smu->od_enabled) {
-                       od_percent =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+       if (smu->od_enabled) {
+               od_percent_upper =3D le32_to_cpu(powerplay_table->overdrive=
_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+               od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive=
_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
+       } else {
+               od_percent_upper =3D 0;
+               od_percent_lower =3D 100;
+       }

-                       dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE:=
 %d (default: %d)\n", od_percent, power_limit);
+       dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (=
default power: %d)\n",
+                                       od_percent_upper,
+ od_percent_lower, power_limit);

-                       power_limit *=3D (100 + od_percent);
-                       power_limit /=3D 100;
-               }
-               *max_power_limit =3D power_limit;
+       if (max_power_limit) {
+               *max_power_limit =3D power_limit * (100 + od_percent_upper)=
;
+               *max_power_limit /=3D 100;
+       }
+
+       if (min_power_limit) {
+               *min_power_limit =3D power_limit * (100 - od_percent_lower)=
;
+               *min_power_limit /=3D 100;
        }

        return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8220bdcbd927..3ea2031c7f7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1242,9 +1242,10 @@ static int smu_v13_0_6_read_sensor(struct smu_contex=
t *smu,  }

 static int smu_v13_0_6_get_power_limit(struct smu_context *smu,
-                                      uint32_t *current_power_limit,
-                                      uint32_t *default_power_limit,
-                                      uint32_t *max_power_limit)
+                                               uint32_t *current_power_lim=
it,
+                                               uint32_t *default_power_lim=
it,
+                                               uint32_t *max_power_limit,
+                                               uint32_t
+ *min_power_limit)
 {
        struct smu_table_context *smu_table =3D &smu->smu_table;
        struct PPTable_t *pptable =3D
@@ -1268,6 +1269,8 @@ static int smu_v13_0_6_get_power_limit(struct smu_con=
text *smu,
                *max_power_limit =3D pptable->MaxSocketPowerLimit;
        }

+       if (min_power_limit)
+               *min_power_limit =3D 0;
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3c5526babb14..ac0e1cc812bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2304,16 +2304,17 @@ static int smu_v13_0_7_enable_mgpu_fan_boost(struct=
 smu_context *smu)  }

 static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
-                                      uint32_t *current_power_limit,
-                                      uint32_t *default_power_limit,
-                                      uint32_t *max_power_limit)
+                                               uint32_t *current_power_lim=
it,
+                                               uint32_t *default_power_lim=
it,
+                                               uint32_t *max_power_limit,
+                                               uint32_t
+ *min_power_limit)
 {
        struct smu_table_context *table_context =3D &smu->smu_table;
        struct smu_13_0_7_powerplay_table *powerplay_table =3D
                (struct smu_13_0_7_powerplay_table *)table_context->power_p=
lay_table;
        PPTable_t *pptable =3D table_context->driver_pptable;
        SkuTable_t *skutable =3D &pptable->SkuTable;
-       uint32_t power_limit, od_percent;
+       uint32_t power_limit, od_percent_upper, od_percent_lower;

        if (smu_v13_0_get_current_power_limit(smu, &power_limit))
                power_limit =3D smu->adev->pm.ac_power ?
@@ -2325,16 +2326,25 @@ static int smu_v13_0_7_get_power_limit(struct smu_c=
ontext *smu,
        if (default_power_limit)
                *default_power_limit =3D power_limit;

-       if (max_power_limit) {
-               if (smu->od_enabled) {
-                       od_percent =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+       if (smu->od_enabled) {
+               od_percent_upper =3D le32_to_cpu(powerplay_table->overdrive=
_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+               od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive=
_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
+       } else {
+               od_percent_upper =3D 0;
+               od_percent_lower =3D 100;
+       }

-                       dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE:=
 %d (default: %d)\n", od_percent, power_limit);
+       dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (=
default power: %d)\n",
+                                       od_percent_upper,
+ od_percent_lower, power_limit);

-                       power_limit *=3D (100 + od_percent);
-                       power_limit /=3D 100;
-               }
-               *max_power_limit =3D power_limit;
+       if (max_power_limit) {
+               *max_power_limit =3D power_limit * (100 + od_percent_upper)=
;
+               *max_power_limit /=3D 100;
+       }
+
+       if (min_power_limit) {
+               *min_power_limit =3D power_limit * (100 - od_percent_lower)=
;
+               *min_power_limit /=3D 100;
        }

        return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/=
amd/pm/swsmu/smu_internal.h
index bcc42abfc768..80b3c3efc006 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -85,7 +85,7 @@
 #define smu_i2c_fini(smu)                                               sm=
u_ppt_funcs(i2c_fini, 0, smu)
 #define smu_get_unique_id(smu)                                         smu=
_ppt_funcs(get_unique_id, 0, smu)
 #define smu_log_thermal_throttling(smu)                                   =
     smu_ppt_funcs(log_thermal_throttling_event, 0, smu)
-#define smu_get_asic_power_limits(smu, current, default, max)          smu=
_ppt_funcs(get_power_limit, 0, smu, current, default, max)
+#define smu_get_asic_power_limits(smu, current, default, max, min)        =
     smu_ppt_funcs(get_power_limit, 0, smu, current, default, max, min)
 #define smu_get_pp_feature_mask(smu, buf)                              smu=
_ppt_funcs(get_pp_feature_mask, 0, smu, buf)
 #define smu_set_pp_feature_mask(smu, new_mask)                         smu=
_ppt_funcs(set_pp_feature_mask, 0, smu, new_mask)
 #define smu_gfx_ulv_control(smu, enablement)                           smu=
_ppt_funcs(gfx_ulv_control, 0, smu, enablement)
--
2.34.1

