Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7093DC5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 07:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D775110E3B1;
	Fri, 14 Aug 2026 07:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rZ1EUxQG";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013011.outbound.protection.outlook.com
 [40.93.196.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E877810E3B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 07:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dk88VjJiyNMrRsq7FifaearqUdRcG0aGfxDeV4upR4goW+ZyxQ5fe6T1pvdTDk9YjjgTTJNtEdaHyPhj5IG+4m7CuowHxhOS28/mApn4lPYVOwCJg5LeOZdMsqp64/J0SN9deZ5+Pa4pBDkxRMuA1LNr9iTtN9id+4FII8krlrloVt/j+4jPTDXQ+r0shqk13HnBsAQsze0wjU4vZ+8gfuQv9dv1iSN2SV/NBw6PIVdBsVD+U/pLK8l7sqUU6/o6T6sc0qM3MkzfTpOiWpJw3DToCtUOAA/2rTr867bdR2RHXxqEL52eG75vGLRnnEp2s7UjPjssHEypVIbmazZiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGp2Nw4t9gtZOhYjlRh3KKlaO2JnhB3Q1zvwmqwswOs=;
 b=q6ghMMRrUOgC+yCn1UncAJ0hheJUeS4JcKdwmnP1g3Qn55zokpDeD5ydAn6xHcjXpE28KLnSim9iR06loKTfpCZD6V0qPja+Um4tfjZtPwwrcqpJ/UImeBRiZq7WpKv7BaVTlHKL+k1f475rz/5xKchUlGtOoBmLEcDrfI/uRNW/yg9/eZW7usK3LVpkPWSmKpTTPlW6j5CEjA5wlK6CZDjsSygfAaEHAuG1VV21VOgGVoNidF30tlECkTJNMcQ1eGIL3e4zGObF9O+vwFs5qgKL43GhoSVFpOk1bMpE71JQ1DptrOg1l+jH+7cPC9zY+m5xF6UPX6ROtaIEYumr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGp2Nw4t9gtZOhYjlRh3KKlaO2JnhB3Q1zvwmqwswOs=;
 b=rZ1EUxQGV/2kWoJ/qt2+lltk+BaeM/Pv0tBD26VP2jLPr8isWUaVbbYTRFRXd1c5JwmyHwQD4LWk8D9WFOmiWrQESZyPwESYjEezUn+gea3+1LpU2JoqMjKyM54ZtpIDZH6G5zKjKWb3j36Qj8i4WOSN7IZ86UHkLUGPUqYYrao=
Received: from SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 07:06:24 +0000
Received: from SA1PR12MB6799.namprd12.prod.outlook.com
 ([fe80::6d46:bf1d:4a60:76c5]) by SA1PR12MB6799.namprd12.prod.outlook.com
 ([fe80::6d46:bf1d:4a60:76c5%7]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 07:06:24 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Snapshot PPT limits for suspend and reset
 recovery
Thread-Topic: [PATCH] drm/amd/pm: Snapshot PPT limits for suspend and reset
 recovery
Thread-Index: AQHdK63TJyo+Ag9jC0SJPjvNE+e8d7adHdRA
Date: Fri, 14 Aug 2026 07:06:24 +0000
Message-ID: <SA1PR12MB6799C72ECE491AD37C1E1E5D8EDA2@SA1PR12MB6799.namprd12.prod.outlook.com>
References: <20260814052848.1293509-1-kevinyang.wang@amd.com>
In-Reply-To: <20260814052848.1293509-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-14T07:00:30.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6799:EE_|CYXPR12MB9320:EE_
x-ms-office365-filtering-correlation-id: 52fcf9ae-b003-467b-f79a-08def9d28d6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 8SqY/WqFmDOsVhTqIXlzJVeI9iQs9ngDYaybTvrI0OuzxFcaU304Ob0Q46fqJcKCM+/RDJnYyKdMkz/BjAJqG5aNesCMRb84XyzrFaFfUdJ8eOJ103EoB/UlQtlYRv1svX/1sh9E6XUovYkvT0PTqEruuVNCODzI9ynZsMX1m/YiwwTEmPZa31gYoDikIw2x31VdZ+Gxrx9W5wO8cFdVRejTM2xunTaQFTU9RwMwFRKmFRnn5yK4KI8riMNH2+nLjtbnB8E05NwCdYBxo3zDic3vOn0e8pp5PoN/vjfnPB66nF8LVy+AjWEf41+WA5XR6wN3cbcPdWAexvH70w27ovpC/uayS5rI+qH2VPj6qrl6ke2ZDfXHZPkOHqqdYQ81PIBUZ4jarHe6CiT78luqM8Kn+JRQl46vuFq5NwnAuiI7ngmBexBFP434hhwZ94EpOKkIDcPAIkDGJp4dEfya/pJaaQW4OymkF3KIs5kAdd5J2+YR9o/Mv3Zr/rFSec123R5vkuhaBbdodo+99fg89XzCpN1oiuiHc44dmbN4cmSw5QlU4n48CTKJoffqQNmrhbYJ3nzsvLb6qzdlNvRble3fGN07kyzsMtwjDpY81cL2qj1sQBVuPvHuTDtUxcjaLPdVMki3VWVRAJ3Bn10lM5yOMC0O28htEFUvhxbIgKwFNIjy4yOXAqBDu1SXKQMphUmHxEUCDLjFbh/866moc9iMdQV6vGdJzOddU6EHMmk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB6799.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YHIDup5UmbF4sfhsg0iwlm573pVuxKMc79m+pz4ykEnlcVNHssHHYE8iSQzN?=
 =?us-ascii?Q?3D9fqnPQyGPxkqlr6wSgLJTXykP4Jg6QMdDPu84eMKhR8mfNOM1xvD0J6fyk?=
 =?us-ascii?Q?SjlnvR1B31aStWQSYFuIn3g9HyJxS0K0C567X1VFVOzuYLqsLRBBxAPH0zD6?=
 =?us-ascii?Q?yaRsal/hY8NusEFQOn6bWoT/jnTqfn8hhxoCfUZa8QN34LPQ5TrLgM9efFIK?=
 =?us-ascii?Q?YSGf08tNvp2+NZqbcQlf72Esa9V9AlOaFYwvtZuqBWDbX5Xyr0oxXXZfCAi3?=
 =?us-ascii?Q?K6R2OAtKHuqsQuXtq7ZheZUIICZNPx2+wX64JUvilOHZP0ah15SptneIN5Us?=
 =?us-ascii?Q?vlnrDU61d0U+BHgfFw42zyRN1zaUTbCjGwpey1aQOA3o3qG+acHDf3cRgxsu?=
 =?us-ascii?Q?y2oX4G3BeXegprZEYYtyVpGjZZjPnlY3/mFFImy1h+p735j2ru02j2OaMNpm?=
 =?us-ascii?Q?CtLkdovPk26ig5ZBI09SYqHoyPQEVJC6Py49RIegSKPY8hi7c16QBoGczqcv?=
 =?us-ascii?Q?NkW0gRNWQVhE6ql3BaHedSbAUFBOZmqjBeHwbg+TWqC2Mg9P54xGIgnMm6iP?=
 =?us-ascii?Q?PPy/5zou/Q0fgVa2Fe3fqx+We0gCuyJuI+DbsW1ZDTpj6oFztiCQY1dhlmYJ?=
 =?us-ascii?Q?Vz0+gDc3fFoCeDRMjxjChjlay+CNQiiNt0YTUd96Lh+kGCvKC7WHVGO412pG?=
 =?us-ascii?Q?lsWSpIow2xTphj18+MrJk+N9HUDtyRL47HQ4S0DO3N+LMra5Pi2rgv9oixj6?=
 =?us-ascii?Q?tDhGvpdbywAU2kP51ulRF9xeW9p4YlR5VA6DfbgGJkul9oqQjnjyGiFQNwNC?=
 =?us-ascii?Q?vI8X/eZEgclC1N/RYGrltXBiRBPxYWmkgcb/WV8wiyEGqYT7JeUHM86dXtvp?=
 =?us-ascii?Q?GJvsrMHyvY5ZQT6Px15nix7ZiC9PugDF/SSEMhUKEEj2foX1trDFwX2To8S7?=
 =?us-ascii?Q?KELKFcHtsS5Z7aDjeflhkXjeskitUylnGVzHdNNUNP2+F75n7cvwXUu0rec5?=
 =?us-ascii?Q?BQn/rYvl03oc00U5fAMBKU2KiDzNgkU/SsnYjfGCg5fMOZFKVTwiypSWo9xp?=
 =?us-ascii?Q?98uJPdlfklNbzyCcBCpQee/cB5+j0qnANBRVKKPZoLyQgXZKAlhYwlc73y7C?=
 =?us-ascii?Q?cIWBZHgNedrdkBo1EG8Prd2YcqETMBONWvfkPyKSJtUvuwvgmGGwYC3m5dnt?=
 =?us-ascii?Q?sAM600gXHUIYkHhCeAZS2EMkxSOgxksPH/bXVEvclZqC1CXXkqCPhrTkr78O?=
 =?us-ascii?Q?Tm3b8/rJKnqJKrtvZfNwQidbBkzCW8FsVKztgsIibI7mN+ztenVGTlt8mTsg?=
 =?us-ascii?Q?2FOcgjYpSZPVt72Y0KYbCVLUQAxPzPgXyVV8GkVkHgLqsLty5C8kuz8vQ16c?=
 =?us-ascii?Q?jyqJBxX98ZRgqXg23zEGPYgIvdm1JJcdnpbC6p2nxfzBu3+Rti3Br/gNDAHx?=
 =?us-ascii?Q?1qhAHk2ClPhF9I8v6UCkzhferpVtRNpqJl6b3IYGH29zgbdLV+dg6i0p/12r?=
 =?us-ascii?Q?Uvd1XP2JOIqo3s+smJg50cR3yIImaINyPRvsXapkJatmstSeV6SS/lYUcm3A?=
 =?us-ascii?Q?kFdMxiMlH2RkWJmGHX2S3kRhMvBiV3vqdZsM8gtWIgLTzK7A3XmoXh+iFDOl?=
 =?us-ascii?Q?S9O0VuUgkSDymWBcZK1W7H7KALODWS/rPjzX92J0bAmxkeXGqlXXPc7vpoT0?=
 =?us-ascii?Q?wN5ta3qjFTKdO1k1D5+G+UAgybyNEXo+D5QFYWd1Lhi2x7Ny?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6799.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fcf9ae-b003-467b-f79a-08def9d28d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 07:06:24.4027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2n5VBZCCApU1PxyqBw8Np1LDTrfw57rKMB0KUJs16ULb8lc7hW/jEkWflDXX3u+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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

I guess the latency to retrieve the power limit before mode1 reset is accep=
table.
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, August 14, 2026 1:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: Snapshot PPT limits for suspend and reset reco=
very

The DPM user profile records driver-programmed policy, not the effective PM=
FW limits. Replaying it after recovery can restore stale policy.

Maintain a PMFW PPT snapshot:
- Query supported PPT controllers before suspend and mode1 reset.
- Save successful queries with the current OS AC/DC source.
- Clear the selected source mask before capture to prevent stale replay.
- Refresh the OS power source before recovery.
- Synchronize the current source with PMFW before restoring PPT limits.
- Restore PPT limits only when the snapshot source still matches.
- Do not replay PPT policy on normal AC/DC changes.

Capture reset state before DPM and PMFW teardown.
Add debug logging for the snapshot, restore order, and PMFW AC/DC sync.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 152 +++++++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   8 +-
 3 files changed, 117 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index ce526db4d24a..c3688b3b12cc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -508,7 +508,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device =
*adev)
                        amdgpu_dpm_notify_ac_dc(adev);

                if (is_support_sw_smu(adev))
-                       smu_set_ac_dc(adev->powerplay.pp_handle, true);
+                       smu_set_ac_dc(adev->powerplay.pp_handle);

                mutex_unlock(&adev->pm.mutex);
        }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index bfe2c0bf426d..e5cb8d0420ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -489,44 +489,122 @@ static void smu_set_user_clk_dependencies(struct smu=
_context *smu, enum smu_clk_
                return;
 }

-static void smu_restore_ppt_limits(struct smu_context *smu,
-                                  bool restore_defaults)
+static void smu_save_ppt_limits(struct smu_context *smu)
 {
+       struct amdgpu_device *adev =3D smu->adev;
        enum smu_power_src_type power_source;
-       struct smu_ppt_limit_range *range;
-       uint32_t restore_mask;
-       uint32_t limit;
+       u32 limit;
        int i, ret;

-       power_source =3D smu->adev->pm.ac_power ?
+       /* AC/DC is maintained by the OS and driver power-source events. */
+       smu->ppt_limits.saved_ac_power =3D adev->pm.ac_power;
+       power_source =3D adev->pm.ac_power ?
                SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
-       restore_mask =3D smu->user_dpm_profile.ppt_limit_user_mask[power_so=
urce] &
-               smu->ppt_limits.supported_mask;
-       if (!restore_mask && !restore_defaults)
-               return;
-
-       smu->user_dpm_profile.flags |=3D SMU_DPM_USER_PROFILE_RESTORE;
+       smu->ppt_limits.saved_mask[power_source] =3D 0;
+       dev_dbg(adev->dev, "PPT snapshot: source=3D%s\n",
+               adev->pm.ac_power ? "AC" : "DC");

        for (i =3D SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
                if (!(smu->ppt_limits.supported_mask & BIT(i)))
                        continue;

-               if (restore_mask & BIT(i)) {
-                       limit =3D smu->user_dpm_profile.ppt_limits[power_so=
urce][i];
-               } else if (restore_defaults) {
-                       range =3D &smu->ppt_limits.range[power_source][i];
-                       limit =3D range->default_value;
-               } else {
+               ret =3D smu_get_asic_ppt_limit(smu, i, &limit);
+               if (ret) {
+                       dev_err(adev->dev,
+                               "Failed to save PPT%d limit: %d\n", i, ret)=
;
                        continue;
                }

+               smu->ppt_limits.saved_values[power_source][i] =3D limit;
+               smu->ppt_limits.saved_mask[power_source] |=3D BIT(i);
+               dev_dbg(adev->dev, "PPT%d snapshot: source=3D%s limit=3D%u\=
n",
+                       i, adev->pm.ac_power ? "AC" : "DC", limit);
+       }
+
+       dev_dbg(adev->dev, "PPT snapshot complete: source=3D%s mask=3D%#x\n=
",
+               adev->pm.ac_power ? "AC" : "DC",
+               smu->ppt_limits.saved_mask[power_source]);
+}
+
+static int smu_restore_ac_dc(struct smu_context *smu, u32
+*restore_mask) {
+       struct amdgpu_device *adev =3D smu->adev;
+       enum smu_power_src_type current_source;
+       enum smu_power_src_type saved_source;
+
+       *restore_mask =3D 0;
+
+       if (adev->in_suspend || amdgpu_reset_in_recovery(adev)) {
+               /* The power source may change while the device is suspende=
d. */
+               adev->pm.ac_power =3D power_supply_is_system_supplied() > 0=
;
+               current_source =3D adev->pm.ac_power ?
+                       SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
+               saved_source =3D smu->ppt_limits.saved_ac_power ?
+                       SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
+               *restore_mask =3D smu->ppt_limits.saved_mask[saved_source] =
&
+                       smu->ppt_limits.supported_mask;
+               dev_dbg(adev->dev,
+                       "PPT restore: saved source=3D%s mask=3D%#x, current=
 source=3D%s\n",
+                       smu->ppt_limits.saved_ac_power ? "AC" : "DC",
+                       *restore_mask, adev->pm.ac_power ? "AC" : "DC");
+               /*
+                * A snapshot is valid only for the source under which it w=
as
+                * captured. Do not replay an AC snapshot after switching t=
o DC,
+                * or vice versa. The current OS power source takes precede=
nce.
+                */
+               if (current_source !=3D saved_source) {
+                       dev_dbg(adev->dev,
+                               "Discard PPT snapshot after source change: =
%s to %s\n",
+                               smu->ppt_limits.saved_ac_power ? "AC" : "DC=
",
+                               adev->pm.ac_power ? "AC" : "DC");
+                       *restore_mask =3D 0;
+               }
+       }
+
+       /*
+        * NOTE: Synchronize PMFW with the OS AC/DC source before restoring=
 PPT
+        * limits so both sides use the same power policy. GPIO-controlled
+        * platforms perform the synchronization in PMFW.
+        */
+       return smu_set_ac_dc(smu);
+}
+
+static int smu_restore_ppt_limits(struct smu_context *smu) {
+       struct amdgpu_device *adev =3D smu->adev;
+       enum smu_power_src_type power_source;
+       u32 restore_mask;
+       u32 limit;
+       int i, ret;
+
+       ret =3D smu_restore_ac_dc(smu, &restore_mask);
+       if (ret)
+               return ret;
+       if (!restore_mask)
+               return 0;
+
+       power_source =3D adev->pm.ac_power ?
+               SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
+
+       dev_dbg(adev->dev, "PPT restore: source=3D%s mask=3D%#x\n",
+               adev->pm.ac_power ? "AC" : "DC", restore_mask);
+
+       for (i =3D SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
+               if (!(restore_mask & BIT(i)))
+                       continue;
+
+               limit =3D smu->ppt_limits.saved_values[power_source][i];
                ret =3D smu_set_ppt_limit(smu, i, limit);
                if (ret)
-                       dev_err(smu->adev->dev,
+                       dev_err(adev->dev,
                                "Failed to restore PPT%d limit: %d\n", i, r=
et);
+               else
+                       dev_dbg(adev->dev,
+                               "PPT%d restored: source=3D%s limit=3D%u\n",=
 i,
+                               adev->pm.ac_power ? "AC" : "DC", limit);
        }

-       smu->user_dpm_profile.flags &=3D ~SMU_DPM_USER_PROFILE_RESTORE;
+       return 0;
 }

 /**
@@ -954,15 +1032,9 @@ static int smu_late_init(struct amdgpu_ip_block *ip_b=
lock)
                return ret;
        }

-       /*
-        * Explicitly notify PMFW the power mode the system in. Since
-        * the PMFW may boot the ASIC with a different mode.
-        * For those supporting ACDC switch via gpio, PMFW will
-        * handle the switch automatically. Driver involvement
-        * is unnecessary.
-        */
-       adev->pm.ac_power =3D power_supply_is_system_supplied() > 0;
-       smu_set_ac_dc(smu, false);
+       ret =3D smu_restore_ppt_limits(smu);
+       if (ret)
+               return ret;

        if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
1)) ||
            (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
3))) @@ -997,8 +1069,6 @@ static int smu_late_init(struct amdgpu_ip_block *=
ip_block)
                return ret;
        }

-       if (adev->in_suspend || amdgpu_reset_in_recovery(adev))
-               smu_restore_ppt_limits(smu, false);
        smu_restore_dpm_user_profile(smu);

        return 0;
@@ -2202,6 +2272,9 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_blo=
ck)
        if (!smu->pm_enabled)
                return 0;

+       if (amdgpu_in_reset(adev))
+               smu_save_ppt_limits(smu);
+
        adev->pm.dpm_enabled =3D false;

        ret =3D smu_smc_hw_cleanup(smu);
@@ -2263,6 +2336,8 @@ static int smu_suspend(struct amdgpu_ip_block *ip_blo=
ck)
        if (!smu->pm_enabled)
                return 0;

+       smu_save_ppt_limits(smu);
+
        adev->pm.dpm_enabled =3D false;

        ret =3D smu_smc_hw_cleanup(smu);
@@ -2778,7 +2853,7 @@ static int smu_set_watermarks_for_clock_ranges(void *=
handle,
        return smu_set_watermarks_table(smu, clock_ranges);  }

-int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
+int smu_set_ac_dc(struct smu_context *smu)
 {
        int ret =3D 0;

@@ -2796,11 +2871,12 @@ int smu_set_ac_dc(struct smu_context *smu, bool res=
tore_ppt_policy)
                                smu->adev->pm.ac_power ? "AC" : "DC");
                        return ret;
                }
+       } else {
+               dev_dbg(smu->adev->dev,
+                       "PMFW controls %s mode through GPIO\n",
+                       smu->adev->pm.ac_power ? "AC" : "DC");
        }

-       if (restore_ppt_policy)
-               smu_restore_ppt_limits(smu, true);
-
        return 0;
 }

@@ -3057,12 +3133,6 @@ static int smu_set_ppt_limit(void *handle, uint32_t =
limit_type, uint32_t limit)
        ret =3D smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
        if (ret)
                return ret;
-       if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) =
{
-               smu->user_dpm_profile.ppt_limits[power_source][limit_type] =
=3D limit;
-               smu->user_dpm_profile.ppt_limit_user_mask[power_source] |=
=3D
-                       BIT(limit_type);
-       }
-
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index d30951121e1f..9f85b302060e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -238,6 +238,10 @@ struct smu_ppt_limit_range {  struct smu_ppt_limit_con=
text {
        struct smu_ppt_limit_range
                range[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
+       /* PMFW state saved before suspend or mode1 reset. */
+       u32 saved_values[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
+       u32 saved_mask[SMU_POWER_SOURCE_COUNT];
+       bool saved_ac_power;
        uint32_t supported_mask;
 };

@@ -251,8 +255,6 @@ enum smu_memory_pool_size {

 struct smu_user_dpm_profile {
        uint32_t fan_mode;
-       uint32_t ppt_limits[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
-       uint32_t ppt_limit_user_mask[SMU_POWER_SOURCE_COUNT];
        uint32_t fan_speed_pwm;
        uint32_t fan_speed_rpm;
        uint32_t flags;
@@ -1954,7 +1956,7 @@ int smu_set_soft_freq_range(struct smu_context *smu, =
enum pp_clock_type clk_type

 int smu_set_gfx_power_up_by_imu(struct smu_context *smu);

-int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy);
+int smu_set_ac_dc(struct smu_context *smu);

 int smu_set_xgmi_plpd_mode(struct smu_context *smu,
                           enum pp_xgmi_plpd_mode mode);
--
2.54.0

