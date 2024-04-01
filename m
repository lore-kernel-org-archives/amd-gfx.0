Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863CDCD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 11:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D244B10F0C4;
	Mon,  1 Apr 2024 11:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="42mooGZd";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2092.outbound.protection.outlook.com [40.107.244.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A5510F0C4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 11:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifYtLfAa81xl+e5EHzcgu+mef7F7HuNGYkm1Kmx3iNCPbQw0lEttmugKoX2bc/4gAcAA/Mzsjw0l9fDljGYv0d8lkAsH8huNG5UrltKkg031vc4l8cNnSOB1q9jpNTSrO6gnKkaB4PHC7f8Q6eKP43tcU8a5O2vZQMGLRc22wWdzfKBGk2x14L+asQ5OI7hRz+K5aC5Tek7M8Z2B352WKgQyJkBbHb2yN8HA5gV790j9WaYTxBa2XcKDNBwfRqq897fqPLPxWbUa2xtCarAAOAsvd+C1jRZ5Zc6hJAJGjPMqqfTLI0IYNd0wLuHU/IPVmruuwkei/2uytrw5uZkCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LwetxqAdIToQ9ulhyiXdDUJSwga6yJrHeA+dBqiPas=;
 b=R/en53kFNFP6MLZEwSmbZxrO5g9MTMpiBiyjRGXPLye1CqCkSqPMX5Z/FyiU1Q25zmk5bYJybH3k5nnCAGDndoLnqdpL3g63sB+XzmXRnO1N/08HELiQ6RWR3Jyg+I7j4OgFiX7x9fgImUr9BtTjgVgkuJWBVJXIthF4pv0sAq6YHcqxiKzYczIJxrM2zWqA7k+kungCdMm3CHhqHXtf36Vf+gt4Cwam5c3yQE/j74s1XDJc9iwlJvSbx7hycDK1d9srLPk/iIYI8BhfRPjSvJCYns6VjjN3IAYflhZ7a67kvwaZywjnqdRkQtxEJytzcGDrXyZkuoSKPyXHZGDIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LwetxqAdIToQ9ulhyiXdDUJSwga6yJrHeA+dBqiPas=;
 b=42mooGZdEs6fNrsGFnSwaWzS+Z4Pk1NtaAFxkFp9SL7Dv0o80a9Ly8aErO9iePW6tHptZXVjFMIbu5/ynTtz2WIbMAZJXm3lwK87sxhoHEZy3iw7RIMztaVA2GvFV92pG6KcSlYTxyM0W/lmHATVNbkmsXqLCP8jQEG2aMhyLsk=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 1 Apr 2024 11:33:46 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1%6]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 11:33:46 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v2 1/4] drm/amdgpu: Set fatal errror detected flag earlier
Thread-Topic: [PATCH v2 1/4] drm/amdgpu: Set fatal errror detected flag earlier
Thread-Index: AQHagLi7wCe7hug/lEKbzRjJT2j0cLFTTutA
Date: Mon, 1 Apr 2024 11:33:46 +0000
Message-ID: <DS7PR12MB60718B9EA63A740B0F0056878E3F2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240328023544.820248-1-lijo.lazar@amd.com>
In-Reply-To: <20240328023544.820248-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=252d4289-de76-4914-9541-516cee456f41;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-01T11:31:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DS0PR12MB8478:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0SMh22uj4hm1HIqvKycxtZwcN0iG2yxNnH9HezthUqCfLIl8UuZhGT3+zbHDAJcU5K/2MaGNM3PaNQwSC4dpt5wlsVfs92BE+nOnknLl25Eywdyt981fUC4/6J8mIyEJTK2dqPE9i+x7XAXekOQd236HeF+brpJMjt6RCkexf09JBV2EWfZSxRhhtylpVh3jS2KRx93EK03xcLkL+MdlboxJyNlfnEhXjcuvL9ocg1BshmMMb0lPA1xXwoPyTl5XYqElnL3YPn129hm99mUNj2Cu4cIjbnH+ymRpEAxqa/oN4nVgw6grh1+O5u6JXb9zmzabakN/AQxD6WvVAO1wkVjVMAbaaX4v6C1dVvKjHxqSgnHAukxu3+FyXNs+Gs3671Jw2Inxn6vJYA1P8/rU75ScO1TtKye5cpLRi9IXO0dmA3GdG6qWbdnIvHQv+Me2WuM45azc4v3YPFxhjzPyl+uB1AvDgRym0on8URwxaHT3+sueb8fS9m5pw2PuRPvvw2+2IKhJoIe8kZX2R6kxnZJe0gb9Qrv8ru3UAftMTtldb/Evbd9pz4o0iFo3z8tzNFr+DFEIK58p7pe1wdhhrQKMTxRqJ/EUI1EyxmYYrAMY0JuYCfp4ZPuQdaoyyLpx8xLCs4ezoU6KnnBbeG3amcNuVcGFOUcDImpN9LrVr8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xBsBBGCF2+SZLXDNHbn06cOF4AjemX9O72eA2MtF75kFD4MQhpoU68CwgvLs?=
 =?us-ascii?Q?kcUDHdPJUFSqltn1u+kJbSEvJKl8JQwv+VyndrIuxMIv3qZe43++9CkDCxzn?=
 =?us-ascii?Q?HEf1JwLbWhXJZA8ZU12XWVriKf6tqpmnDZsaBFlfLvD8sz+JIDi9Rs0FwMv9?=
 =?us-ascii?Q?1t0Qbe1Dx2JocR7yn1DprVN1u/CcgTuk6yrQ4yEHP9cDxnR3l7XQJrxIQY+U?=
 =?us-ascii?Q?w4AfJugEX2YhezomG5ZXrfoF9u7dyzNLIIdHK7Kry92tecceH0jVktuMZR50?=
 =?us-ascii?Q?htJs4brE20Qk/mvdsfEDk+liyKW/LCbG3snWTrEeB/5lVzBJSMYrEJx15PLz?=
 =?us-ascii?Q?My/P0yiVf8IC9deFyuCeQtopeyoeRnRZ6OTVq4ez6Ius3NIB0MJN80I4MaFf?=
 =?us-ascii?Q?N7a/Ey0ibrj7Jbek9h01GfcwcHN12irhKM/fZLGEqbitiS04dC51qjbJb680?=
 =?us-ascii?Q?3rc6ykGzKRhhFjv3jHCYPKpOee+gCwXI/EwdAcCnFVVa/6Oh+/WEQz2URj+1?=
 =?us-ascii?Q?pieYgy6/lltRPY7T8cn19lQsiTNSGGOonM6wfbi4GSNzWo7aj9AUOJVxe7dR?=
 =?us-ascii?Q?44BkJwTLN3ZBIZ1J4367olMS/b9VsEBU3Rl59F47w5Y7YXjkTV2Z6u/3RJBX?=
 =?us-ascii?Q?+0z2pk6jl+QpJzxap8r8/eQTzXHyjZBlz7YaLc+GcxeQyPOLQ01Cw7PK4Xe0?=
 =?us-ascii?Q?567I6aZiXEiOXSvgRpo+RNv9XKSc0nu8eRWSK9RePGf9x+dpZ3dtTPcAFQyC?=
 =?us-ascii?Q?7jBYixOHw0JVt72itY19C29nSXpFSJYrXrswV7yTRiDTfwt4Dd8ON90ZlTet?=
 =?us-ascii?Q?cLYz00fXfU+EYie2Yf5iOFVT0p6sa2M4yux7edMkbpSpO5Jcch40FduVLsVw?=
 =?us-ascii?Q?G3TL1BqeeXIFcCJuBaH9x0TqFTeYc044dKjzQeIozRkGzudoVSBl/imkY8Xa?=
 =?us-ascii?Q?Eeln9w+fysXIFKJdVPLyTGmWrQg9sH+4niixtLvx0pKM7DUUOMZSI8bknyjL?=
 =?us-ascii?Q?tcesTKHvCm/aIxvOkF3XA4SrMvU4BC6EyeM/x3gVERwYitfUwi1v/aDbzZZd?=
 =?us-ascii?Q?Ewtkq3auNSas7OtvdneRPjPP94m5oFlGCyBA42E4s9yb3lKbNDKT5XRhU+lg?=
 =?us-ascii?Q?1TJ1GYHg96p9WSlM1WXoON7o/0ZCg9VhOaXPhfSToYj5eUOjY6xmjXnqVQyp?=
 =?us-ascii?Q?DCsUEKVL3cLAxkURIHzdcu6u0PjNADwBvSSl1kT1f07CqgxRT0Y3CtL90RRM?=
 =?us-ascii?Q?VfOiZbk++gIN18CaDOblsJ9tRX9YapaTTe6r5/hgDeQAHUWB7IgK93hlY2h/?=
 =?us-ascii?Q?3eS4jtf8VfYW+2s8YF2FMlcvW4Y0Iqf+kGTMacK1qJJ2dnQWaZmVbmCrSWSs?=
 =?us-ascii?Q?N9LELdOjIJc/ERQk02gHenEJy3OLscrQaggLRZvVo/iKOL9tsMrirazokQ0a?=
 =?us-ascii?Q?Lo0MfXJ4ThuczA56R4TypSeXDG+VY5oVypniCxnqB0dL8owGaoqsFxJg2FK6?=
 =?us-ascii?Q?p88hx1TSTvZkP+SIItnrXXMGOBH8KBvNR0Px+K9WtoR7/qLpPEv27OAW+w4o?=
 =?us-ascii?Q?cRiLqupW+W0tp8Po8Tk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b114d9-f050-41b0-05a1-08dc523f97d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 11:33:46.2906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQ4xJ+YtCKOVNTvZJRar9aIGXHjkHzA0/FLtsWuA7p0pgPV3MqOwJnvuMMmCBazegeU4MfVSWQrPU7/uIjovXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478
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

Series is
Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, March 28, 2024 8:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Set fatal errror detected flag earlier

In case of fatal errors, set FED status when interrupt is received. Set the=
 flag on other devices in the hive before RAS recovery work.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Avoid accessing hive in interrupt handler as it may take mutex path (Ke=
vin)

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 41 +++++++++++++++++--------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b8c7d0bf8fb1..352ce16a0963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2399,6 +2399,19 @@ static int amdgpu_ras_badpages_read(struct amdgpu_de=
vice *adev,
        return ret;
 }

+static void amdgpu_ras_set_fed_all(struct amdgpu_device *adev,
+                                  struct amdgpu_hive_info *hive, bool stat=
us) {
+       struct amdgpu_device *tmp_adev;
+
+       if (hive) {
+               list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.=
head)
+                       amdgpu_ras_set_fed(tmp_adev, status);
+       } else {
+               amdgpu_ras_set_fed(adev, status);
+       }
+}
+
 static void amdgpu_ras_do_recovery(struct work_struct *work)  {
        struct amdgpu_ras *ras =3D
@@ -2408,8 +2421,21 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
        struct list_head device_list, *device_list_handle =3D  NULL;
        struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev);

-       if (hive)
+       if (hive) {
                atomic_set(&hive->ras_recovery, 1);
+
+               /* If any device which is part of the hive received RAS fat=
al
+                * error interrupt, set fatal error status on all. This
+                * condition will need a recovery, and flag will be cleared
+                * as part of recovery.
+                */
+               list_for_each_entry(remote_adev, &hive->device_list,
+                                   gmc.xgmi.head)
+                       if (amdgpu_ras_get_fed_status(remote_adev)) {
+                               amdgpu_ras_set_fed_all(adev, hive, true);
+                               break;
+                       }
+       }
        if (!ras->disable_ras_err_cnt_harvest) {

                /* Build list of devices to query RAS related errors */ @@ =
-2454,18 +2480,6 @@ static void amdgpu_ras_do_recovery(struct work_struct *=
work)
                                ras->gpu_reset_flags &=3D ~AMDGPU_RAS_GPU_R=
ESET_MODE1_RESET;
                                set_bit(AMDGPU_NEED_FULL_RESET, &reset_cont=
ext.flags);

-                               /* For any RAS error that needs a full rese=
t to
-                                * recover, set the fatal error status
-                                */
-                               if (hive) {
-                                       list_for_each_entry(remote_adev,
-                                                           &hive->device_l=
ist,
-                                                           gmc.xgmi.head)
-                                               amdgpu_ras_set_fed(remote_a=
dev,
-                                                                  true);
-                               } else {
-                                       amdgpu_ras_set_fed(adev, true);
-                               }
                                psp_fatal_error_recovery_quirk(&adev->psp);
                        }
                }
@@ -3550,6 +3564,7 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *=
adev)
                RAS_EVENT_LOG(adev, event_id, "uncorrectable hardware error=
"
                              "(ERREVENT_ATHUB_INTERRUPT) detected!\n");

+               amdgpu_ras_set_fed(adev, true);
                ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                amdgpu_ras_reset_gpu(adev);
        }
--
2.25.1

