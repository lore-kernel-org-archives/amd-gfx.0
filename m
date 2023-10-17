Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A647CDB483
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 07:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB1A10E285;
	Tue, 17 Oct 2023 07:48:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E63F10E158
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 07:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0xB3cK81+enZtEl8/ym3NoI6uEaZCcYSvwRAjkXtau9a3xOtVe2y5VYxtIIlezYx7vg4gtosbf7A9CVBy0D3la1stHVvHRdWwYvsbDfJRg56HpPI2i95ovLSlJbDK/flg7ccsj8YWw4G/ExGtivLU0S9yamCxbQTogaJcY/AbLr9Ild70msugQSz9MIFbjPx9zTiAjeKAKi1ma0cud9IkoDffxzzBLc9SVEfCrhs98/U0fO0A9D+0ELltms2gXe4UCky/HrD8WfWd9wAt6J1+BAJIbqFrm0Y2X1Tw3ir3ff3CJyRuh/hmktvQv5COoGb8eU+BnfBWnXFsMpk70qCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE01qC6A8WNmHFt9m5/ZOJL+1+Ytyx8iFz5Cmy53VTs=;
 b=ZfGy5v31UDAaxOYZKcLgZgqonJnF1iacTcujKmuqncX2bt6jznW0rnfrmnwTvYy7T5GJLUGt42WV7FNBb4IPbS4ILU9BoQZXAAboLpDpjmY+Qlykk8ccd/viShtPBwLxKcaPabPuEgHDwP0jyGaur3JkbpCcG4a0GjDEchdSxiQNF/n9ryrkVSqKzy8I7XGlNx53ICvhFi6HgvrjyBIgbnux0KjuXtmSlcP/5qnkIqq53sXdNPHG2ezu5+8VWbfuZ710N0EoGtNVff6QIw1B0CuvkhiwbRA5pGrjD8hweBbfo5SfQ092+IV8aVVL3KZlXKDwz1Hx4SjsTbVNzTzxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE01qC6A8WNmHFt9m5/ZOJL+1+Ytyx8iFz5Cmy53VTs=;
 b=2CJPY1i9oW8RDm3zo7Jpe09A+W6zD2x4As+eOug5oChmxf/7L7jiybu8tmeamYL7n59FJO+zyAx3F26/JCIqFDW8u/b3LtRUsMVf1pFw3OJCD+yHvspOF8Ax3PnqZqo3ip0FWxt21iy8o86IyTOWyvBxAX6+/9K+Iv7P2hf1oVc=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 07:48:23 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::ab3f:4dad:c638:6b53]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::ab3f:4dad:c638:6b53%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 07:48:23 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Support for getting power1_cap_min value
Thread-Topic: [PATCH] drm/amd/pm: Support for getting power1_cap_min value
Thread-Index: AQHaAMqlLM5ykiBFeEWBnI3pNfSC4rBNmt2g
Date: Tue, 17 Oct 2023 07:48:23 +0000
Message-ID: <DM4PR12MB5165D91F95C67DC3DF105E988ED6A@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231017072139.40963-1-Jun.Ma2@amd.com>
In-Reply-To: <20231017072139.40963-1-Jun.Ma2@amd.com>
Accept-Language: zh-CN, en-US
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
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|CH3PR12MB9341:EE_
x-ms-office365-filtering-correlation-id: 81b43ccf-36bf-441d-5e39-08dbcee57093
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QLmrhuSxMca9UHEgjtxd5UHLarPqD6GtJpa0jiCXV126ZtW4m7EkOmpi3/n5QPGjLIXVnBfahWSOm7oSQuUQLbV1HQQkfn+Ow1egeGn3XE24eTw7sOhTIFR+hXuZHLJqF6E8IeLpiYqBJT2XCL5IO5IVAds6jDqa5F98sQdN3KPwNUdaCKfvKpkIhSZUKit2m6RX2lwP3C9xxAB13s68GXag1s7BQOB6xpa+BZy1uoDdMyR774P1epGbrweIGqz2ueyhMqlYkeag9k6p1BgfUyWrYE60tcCZ9xB4Y7i59e/rslDfJsy6lDNJmhhTX0dPYXxEtHjheo37Ha8Dkrea34V3EEN8AWHiboKuTbwlhWNTvJOXhsJzgcW56chga6Bg/j0ahZ0CO603ZbNou32WbeekmR38u+qMEqpb/78uETG4RNo9+58ZDOmu+DASp15SfSmwJS49LvhEYzCJGGOWtfWv5JqLomK/5yZ+jUJT7uL97mjGhu2T3MfvGwYnjCcLVyv8eg5R54Cc6SbsAnqlVo1Pgfn46fFj46peMHBeOKcRQrFZ1oKTrpSxnHJiF6qUIm1AlI6YDHZVrmWQZn5AMEeHrhznSzd11sTk/x0hLaoxAKDSGoV3O3m9wSzOC6G4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(316002)(66556008)(66946007)(66476007)(66446008)(64756008)(76116006)(6636002)(110136005)(26005)(83380400001)(38100700002)(71200400001)(122000001)(38070700005)(33656002)(86362001)(9686003)(478600001)(55016003)(53546011)(6506007)(7696005)(2906002)(30864003)(41300700001)(5660300002)(52536014)(8676002)(8936002)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lte/StwF7qPaYxGNQbuI0ks/TV39uBaF9KMDra/9SEl/I4E4dMQXzDFSlCv/?=
 =?us-ascii?Q?M/NiQ6RFR3e8H0mkyl2z3SaLGmVtB5xzFPBahAdgqSCgw+73LlqhHLsIiqtV?=
 =?us-ascii?Q?UEMh8Jd39mWYErvbcnKE7TNSJnDki8sLNrz2pjdEyLbZ4IzQC63yeUd3dwtB?=
 =?us-ascii?Q?8H4ehGmWdawpdWgK6yLgAQGtfly44VXsYsYiatHPBcu+u3A6fMKynSKSbMjL?=
 =?us-ascii?Q?VMyFAsyQVdyLopovPjsPYF3FRKorioZQrj4oHTVkjMOHUZPeCXr+ZqMVQ0+m?=
 =?us-ascii?Q?S1ZT/3bnlhtJdrmMO+JArZH+9hQH38beOs0zL4IeGwMwaRNLwFW7/S5IAytN?=
 =?us-ascii?Q?7QzckAjsre+ntFxOFu8H/h1wx7xG3WinrdTqAtBLIs36D3BOc8iGWzuj7oh2?=
 =?us-ascii?Q?TGrZ4sRTmeD0lYi/pbjg0nEMV1HtxjCd1ZXDozzv4s4A0NAl0THqnma+sRy4?=
 =?us-ascii?Q?HtFjj5dLMTN2CHvLOnMIO9cVCNQepySk0OR/o0Qf0JRx0Trp5Zprc3LWxYvR?=
 =?us-ascii?Q?IIx+Jk1p0fXWI9+qoCdi5SAY3lJmpFX8UPCNUIa5X/YrgSoZV5Fl8QKO6khg?=
 =?us-ascii?Q?V0fj0WjhpKULmVNT2p3whCCG3pxCIP1Lqp9P07zx+dClTaZW53pifRoF5IT3?=
 =?us-ascii?Q?5vZlBIN1lrNvO/LN9mCfWfuZSp8Ed80Rz+wrzmepwLBbMCAFPp/roydAp9vc?=
 =?us-ascii?Q?UJXS01H8ytUQARIoLPCq6GqpIBndVQ2tkRQNbJg/9Gqz1NchFv3XlDmy2ASg?=
 =?us-ascii?Q?XJRCP+fU6cNL/xiLNOnNmSiDro7NzAlvW7IZxUfiAxco0G4XCbE2+zz3tIpv?=
 =?us-ascii?Q?7rgdjXVx2Hpl+UdTdyFol/H4IwOs7WnhTQn+vJhXuJ+ddzhv4qsTTuQR58Mr?=
 =?us-ascii?Q?tmzWR9BNuJzVm77gYnfIEhxpNvBGynOp9YRAO1Fyc9BjX+Dv8ZkN7KsrKZvI?=
 =?us-ascii?Q?OvyfCYd/3dcoQfZXq9xxUhgoGqqUrEMchiIq9yQOTrCkJ6g3XEykIozSJC8o?=
 =?us-ascii?Q?atLjGzkRab2q8ouF3WyKVDQklK6IBXSuk1WoKpiEtIBmQY10qAFqXKSJLY8y?=
 =?us-ascii?Q?mG1xnjcqkZejkVqzUj8zHQymFfV6YD037YEMwYhzBZ8oxYBSYzAhrrmfvton?=
 =?us-ascii?Q?x13gEc5p0u4KDHx70WesDQ8El4LTqO0qBt90dwdK+FUThLxv46gqjzR2It3Q?=
 =?us-ascii?Q?W3/narbWUlnlKpMlrhfaWCDawqkpyNe/xME5y5+JnPjczawL6ZHQcwu62BRB?=
 =?us-ascii?Q?ZVN9po/MyJChfjPV+ViaLOrNA1y1sMH/p+ocav68d8kEpUrRf2Wku0+3Xy+8?=
 =?us-ascii?Q?Bk6V26Dt3gKAXRmvk3FSrJGo2Iu07TiCzROMK8YaOdKxKnDB46kWAXI5M9bc?=
 =?us-ascii?Q?m2aYUyY3ognXTmxtnk++obnbVQtoLzsjMIyO8QV+g4T5HVmgEINjUEiHTIKM?=
 =?us-ascii?Q?rX/gkf7gcMd+PqlP1vFzd63Ur8bH1fb0RMHvsMpzPdbTpi042M6kp0jJNrX7?=
 =?us-ascii?Q?ChrXHEAW/YgUrJaagLf9WM+F6pujRL0Qk3p/7LsQsUXBVhAF4OkYPOZD2N2A?=
 =?us-ascii?Q?m+PP63FE8DW+RfhfN88=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b43ccf-36bf-441d-5e39-08dbcee57093
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 07:48:23.4489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmMnT9dAq6leXbmfBstQwJAiCVheWFCTHPr6tiFtYjXN++i9/SbJnbFxHdTC6hNg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341
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
        return sysfs_emit(buf, "%zd\n", val);
 }

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
                                        char *buf,
@@ -2965,6 +2957,12 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(s=
truct device *dev,
        return size;
 }

+static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
+                                        struct device_attribute *attr,
+                                        char *buf)
+{
+       return amdgpu_hwmon_show_power_cap_generic(dev, attr, buf,
+PP_PWR_LIMIT_MIN); }

 static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
                                         struct device_attribute *attr,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
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
+                                                               NULL, NULL,=
 NULL);
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
+       if ((limit > smu->max_power_limit) || (limit < smu->min_power_limit=
))
+{
                dev_err(smu->adev->dev,
-                       "New power limit (%d) is over the max allowed %d\n"=
,
-                       limit, smu->max_power_limit);
+                       "New power limit (%d) is out of range [%d,%d]\n",
+                       limit, smu->min_power_limit, smu->max_power_limit);
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
+                                                       od_percent_upper, o=
d_percent_lower, power_limit);

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
+                                       od_percent_upper, od_percent_lower,=
 power_limit);

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
+                                       od_percent_upper, od_percent_lower,=
 power_limit);

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
+               sienna_cichlid_get_power_limit(smu, &cur_power_limit, NULL,=
 NULL,
+NULL);
                apu_power_limit =3D metrics_v4->ApuSTAPMLimit;
                dgpu_power_limit =3D cur_power_limit;
                powerRatio =3D (((apu_power_limit +
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
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
wer.power_context;
@@ -2366,6 +2367,8 @@ static int vangogh_get_power_limit(struct smu_context=
 *smu,
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
+                                               uint32_t *min_power_limit)
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
+                                               uint32_t *min_power_limit)
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
+                                       od_percent_upper, od_percent_lower,=
 power_limit);

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
+                                               uint32_t *min_power_limit)
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
+                                               uint32_t *min_power_limit)
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
+                                       od_percent_upper, od_percent_lower,=
 power_limit);

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

