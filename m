Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CDDC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 08:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81BB10ED71;
	Wed,  5 Aug 2026 08:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="brNOic0i";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208C610ED71
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 08:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnfKV4IGxUbPgjcjJwPHA7sfpNcIOwM8VzZvj2SzXZZeO6xf6cXyMajX4kCxpA9VoirVcLRVPxMoMqw6MAaqqYuIdzeZg5n68HCO+ApUL/BaTUGAWSqfW9GMqQC+FBhi4kyCVmEWiJr9OutfrxSk+ua33Xo0dFr6LmFFuf1B8QHfMsf4MNOQaJk54mzvXFzSBVf6TEtdnbwuLojrISkb+C425U0n7DHz5ny3sSrH5LcQ7EyIvFiFVq1cEfjfKBFRv+AjQEG+IHCfK1WeZnfUp3Gd/i/ZIaqrpNvzBMdo28Wqw1p60ARSAxnRlJT0l4qNFNb3GHQ7D28zmi/zMwHiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pv7y2hV6oTPp2XNNci6plh8LvJNuEmRSdntoFlJ/MXA=;
 b=avT5kHiSCHGumxXuQDRXIKu3HzEMR+6LuVt9dVwIEUIhdc9CG7fFtWd1WsRkEXyPobzddb2iKZNXroRRtMkwF2nBWuhAFSV05yvoUNlcSvcByE+bxio6S5b6JvsjupW8fh0HLYuDxusYkPwuDOLEpL50qcKF5D4iKf4h8X2iG4ORTszP88skcIF36kDDsjEzcxLgTPhIDjZWx5M0oQ4rWNfhJ+qRgzU3G3IeIgPYsx4g69+5skf6WjyGn52oW3ZGS0pOBZRLLdHCRpVoJ7+I48yaD4+BQUg+OkLrMuW7Ny7WoqA/kXcN8yCjUbfD3urKxnrDB+qhUSsL5NSNqDx9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv7y2hV6oTPp2XNNci6plh8LvJNuEmRSdntoFlJ/MXA=;
 b=brNOic0iOnMdEUM2kDksqSo5LOcoLLLEMLFOku2alIm23QZY1FM9y8JAGfoO7aWx6H7sgEpy08YieKFyng1e+PcCWSMDaJssP06uCu/5AngFpCwWSEMZkq28rnwEqkXWw7kiD93dc1IpeZ4A6SYXt5k0oVD6KhpGsA5VUR/rkVo=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.18; Wed, 5 Aug 2026 08:27:46 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%2]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 08:27:46 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: Implement notify_ac_dc callback for swsmu
Thread-Topic: [PATCH 1/2] drm/amd/pm: Implement notify_ac_dc callback for swsmu
Thread-Index: AQHdJASgzL7LI+IY8kSaKakTgXYKLLaPIIfA
Date: Wed, 5 Aug 2026 08:27:46 +0000
Message-ID: <DM4PR12MB5748ADFA3FC08CD24B69E7DD8ED32@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260804112945.2974903-1-lijo.lazar@amd.com>
In-Reply-To: <20260804112945.2974903-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-05T08:27:41.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|DS2PR12MB9638:EE_
x-ms-office365-filtering-correlation-id: a5ebea6c-ca2e-49aa-8880-08def2cb6d97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Sx1pjIfzT+xOe3JAXw4keoOd+av1ShL/jsxmDyfIn56peh+wNb11rxiStUTrHL1RcnvueQ0WWQMPwyrN67xDlISHYAEbJHLLdOcflgwBAu+qRmno80YXLz0rQDOi6buUdowjv4y0sAeY9IOMCs2e0DxUCVvVFAEsI3uw3w7jTPr32s+m0XicywhwRjihg4/A3TGiASxKMH9bx3AIqO/Wrr5enbWo9WjFRl1jvMLaSXM1rOq5gm6UX1ZWDFE2t4KEbvVL5sYao0teLgi4ZcCOnbVolNRP/TI13AK6p1wdywV4KEZA5lH1cscweMiCtAvZREw6eMOxyCbteKnJyhOmnT36Ph7o1JZrHbasUrK9sMLd25J9Ej4O1Vqp97FmExarNV12bVMk2SqqW/jeJ+HDG5CvLAhBFF4WjtzVpyLQKLDibCXXAdFYXAa48YaGvQllHhqtfjvIu++YIkoCCcEApOSRV0cVekV5IZsHCYah0KN9tR+8tMFZ2OGomnJ/iIE2QC1aej42xmlcMR7bFvjYF93QWE+m7taQXug0VSqkfb9Z9JLPn+HzV7dIfD7mJZhqXiNHwz0XCpHDON3vnR35s9nfmpvMenwOuanlhj+iiHR+Y26LFq7kQRIUTM1+noqQJKTR3S9rgGtG4Yw0MgcUx8/WOTbjNSlNiMQco2i+PiMay0mILa9KHUwHY7bPyifvpQx8tMYOTA6zYUZ7xI65eU4nNkEBCRr1PFf1IH+i9yU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A6DVRH8Z1ouynzyiyygSWrKj2v+U1ItUgPoZEubAWfk8tEMzf/ZV8Zbt0VTu?=
 =?us-ascii?Q?p5lXQD6kW5uTKWLz4wnAU0NH3QS8HVTSc1zvUDrKUGIVpgCG4vheJjsComtg?=
 =?us-ascii?Q?N+dItjDYfFqjJOuPNjHcK7BbzNcublWf1qIxmRKxkviIu18SMeaMvxduyZgh?=
 =?us-ascii?Q?Y6/nrywDxTAPJmqyUf8TopBBF1eXhIsHSmqCmTCGjVJJUOACzvVVE56P1aRP?=
 =?us-ascii?Q?bi+1MzSCGRJ/u4YhkF+zNV5L+tKt7r0dQJBH5oiD3+mJEN014uNKLbfWfk9U?=
 =?us-ascii?Q?Fgfi9CH+8PICj+6YNkB9HFkprZKVtdXEIYUHFFprdPrwxe8Ilg7hxrzCGtL9?=
 =?us-ascii?Q?oGZbpRcQNwGaXzAUkrXZOc8rEa3vhJg6ljs3hHdF99r4TVkl5Z9hFRUDUO2r?=
 =?us-ascii?Q?4qIa/+kgsetoNFBJeNFlF0ZmlPHQcOBNqhG8LIUDOqt3BY0EMWCh7L8NQAWg?=
 =?us-ascii?Q?8+o9swq9Uh0tsMO9nbdXF2nCvUwZYhI4rxuQXFQ62/SbSnUdFf9HavrWC481?=
 =?us-ascii?Q?tFpRgN5S3jaMCgirPCIrfbDpcmYHMputu3OUvJ1xy3f697kbH78srG2XSkw2?=
 =?us-ascii?Q?In3oam8RIAKz6PsFUGt34PBB3fEq+q1wrOWejY7OV8/YwG8hanFbUQacCDMs?=
 =?us-ascii?Q?Hw66y2A70kgIJtJHU5CXwHH8ri23TBG/tJF5MpgqYWMW6yEqhme/Bj3CLKoa?=
 =?us-ascii?Q?3RBvAL5L06eDhIJddrYGXYslUpHI9yyM/rPp7yt5VABgId957jeuBut+6/Iz?=
 =?us-ascii?Q?virU2Kp9uMGLgedD8CyzCyUcNFo8yqBGAkqzgnzv6KGHg00tC7+IT+ij0n6H?=
 =?us-ascii?Q?bV91f0YWrWsf4eG5L6r4wmllyRnMb4qao4SmNPZqFXz8z4K2+xOWskapaX+M?=
 =?us-ascii?Q?t+0MZL4O3ZOtiXPXxRUbJrBTRYOJp3b9CeYFbm8Hew8gXOGY2f5k0cPRIkG4?=
 =?us-ascii?Q?dcPWfMrW7jOe7R4YM3t3Ipq4JVKQu429cHMzASsB5sF8w8klhee4q5KFUiGp?=
 =?us-ascii?Q?xjHnOt1CZN3C+DFX52eddTivUy+92o9fiqcgN/GKpCusr62Mg56PAXSLhDp8?=
 =?us-ascii?Q?KMyLQDWE1RZhkyo/PvlHttaj7uVAPeYakn4yreuPLnM5dVdMUGF0S0ln51yA?=
 =?us-ascii?Q?DeyW9b0JWe4+WT+1NWMofW3J+BFG+4kmlsNwchbHX2RrFBzlY3u/yPiysolZ?=
 =?us-ascii?Q?Yei5r1q84iyEp4Hu500IzxMuL8TgBg4D8K63ZJR6mPoKqXTwAImO/6SKSGyk?=
 =?us-ascii?Q?RrHgilGIWGcAYIo6DCB5F02UriUrjjHduA/N78Z7GQBuyNoQ7K2sR1uJBigh?=
 =?us-ascii?Q?Q1tEQ08DkQDaTMInHf5Rc0dkzH53UJxZgVxNw/x8MTmaHHVsryN4IvESD+tw?=
 =?us-ascii?Q?QNL2YHWdwmRMH5sX/Bn2vyOcY88zJVODalg9VvrCXeIz52V57xwddqsMSA3h?=
 =?us-ascii?Q?pI8eDEo+a41mvjlSdbu8YbZiF0wlpo+uG3kx7T4RQg0bDfPsrnVvehcMuHyi?=
 =?us-ascii?Q?US/dy7lJ1c57gTynfjlQpWNKrrG0kFqPD8GJLJWUTHW5516GtbKWWr+7wZEg?=
 =?us-ascii?Q?v8SmmZcY9ERXhxy+d+YTlOTgUJw78uqfpuxP8Lk6Jghh8WfTQE8/WDjAJFCw?=
 =?us-ascii?Q?JsSxxY9Tn5QlgretU6fUbAB/Wzzm/vVPf9d7HZPytO6V7BUApUDOGgkDrMO/?=
 =?us-ascii?Q?BjCv85ioU7BdT6MWRGdk3tnLFlXM807G3qoSxTvNh5wcr3SH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ebea6c-ca2e-49aa-8880-08def2cb6d97
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 08:27:46.3207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhldsGqAXnAS0fdr7sudZ7D/BrjrBSvBdxYOMjGEGKTKm6gaEvnaUmMrOyoTdQ9XQ4cks+ab+HA+5v4dEZxsUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638
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

AMD General

Series is

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, August 4, 2026 5:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Implement notify_ac_dc callback for swsmu

Wire up the notify_ac_dc pp_funcs callback for swsmu instead of special-cas=
ing is_support_sw_smu in the ACPI event handler. This keeps AC/DC transitio=
n notification through the same callback path as used by legacy powerplay a=
nd legacy-dpm backends.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 ---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 +++++++++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 --
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index ce526db4d24a..107448fbda46 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -507,9 +507,6 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device =
*adev)
                    adev->powerplay.pp_funcs->notify_ac_dc)
                        amdgpu_dpm_notify_ac_dc(adev);

-               if (is_support_sw_smu(adev))
-                       smu_set_ac_dc(adev->powerplay.pp_handle, true);
-
                mutex_unlock(&adev->pm.mutex);
        }
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index cca32f74abf0..84ac824837ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2774,7 +2774,7 @@ static int smu_set_watermarks_for_clock_ranges(void *=
handle,
        return smu_set_watermarks_table(smu, clock_ranges);  }

-int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
+static int smu_set_ac_dc(struct smu_context *smu, bool
+restore_ppt_policy)
 {
        int ret =3D 0;

@@ -2800,6 +2800,13 @@ int smu_set_ac_dc(struct smu_context *smu, bool rest=
ore_ppt_policy)
        return 0;
 }

+static void smu_notify_ac_dc(void *handle) {
+       struct smu_context *smu =3D handle;
+
+       smu_set_ac_dc(smu, true);
+}
+
 const struct amd_ip_funcs smu_ip_funcs =3D {
        .name =3D "smu",
        .early_init =3D smu_early_init,
@@ -4000,6 +4007,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs =3D {
        .set_pp_table            =3D smu_sys_set_pp_table,
        .switch_power_profile    =3D smu_switch_power_profile,
        .pause_power_profile     =3D smu_pause_power_profile,
+       .notify_ac_dc            =3D smu_notify_ac_dc,
        /* export to amdgpu */
        .dispatch_tasks          =3D smu_handle_dpm_task,
        .load_firmware           =3D smu_load_microcode,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 3ec65630ab99..92658eb3886d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1952,8 +1952,6 @@ int smu_set_soft_freq_range(struct smu_context *smu, =
enum pp_clock_type clk_type

 int smu_set_gfx_power_up_by_imu(struct smu_context *smu);

-int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy);
-
 int smu_set_xgmi_plpd_mode(struct smu_context *smu,
                           enum pp_xgmi_plpd_mode mode);

--
2.49.0

