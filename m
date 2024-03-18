Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39333C54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 03:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9474910EFB2;
	Mon, 18 Mar 2024 03:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OwlJ5IQF";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0082010EFB2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 03:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpBbt5smtb6+VRvq+SMBiMIpft52880LB2dG0vH3JsbaE/R8kk/VEcDhLv7CobkDOEEqDmsMC4IZ3WPqm/XeSVIb4lG+VPS0v4yWgxX9/qK8bKHCc/QMHSjeI6MsHqSlRJFDUPdtYaI7tIrDBPck2hFNK+F2iZs/hR5l1NV6YdOVdRDFKko/X9Rdnu+w2n1s4FuO8TQekIpigYGXao9oEhZ8TWUR42YvsBTMiaSqbAp3F85VFTejLFMI925ecaa3C+nT1HhBKKiCDOl9g0bMrMfJEBgRp1N9py2oXkCfFwDPVAC+JGZznR/p8Ep+eWurIHImC31JosXsjC1zW7iZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFhQaQgGmU+1tuSvuI4R4PvsnLbHB0XjRm4Mof4Dnh8=;
 b=l+6tttJVI47qLiIgZgqTbSOe+FEHJsPTwu8FbYhvvCJiJ26dZj3eI1BTqJ/CuUjGOf3UK3FSkettYnYejvSRVYsCSVoNNGfspjWhd/Vkq9uMWnmnwfW0yF944lr6g3eVS8JKoCRu2eZmrXjuarQBXfxQzI39gd+I/CeoVVNs3NjnlWWFNB/IInnkVmFVNSAjigJqT5Jeqo0jyucjHGsTNS/QP4VglvDpRtPrUex9394H6OdH3mov3+Nx89y9IMVcyqq7WYP6+nxiGHw1zEcAev/5q8t6sPsZPyhyNtzaAlpmFLk+eR+R1xx9NmZC1/ZkE2lppkqur7TczmSNeX+HNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFhQaQgGmU+1tuSvuI4R4PvsnLbHB0XjRm4Mof4Dnh8=;
 b=OwlJ5IQF+n93++AonfNV9U4FUBYKUEuV9GDqsL1emGR1RfC9dk7gMhpJInePOePzQMHrSjYHg7JCE3/vZYFCCvsd+f6ihQJQG6lDwnYv6b4QweV2FpRDJFKF75aJrkyURxzGyoZ/a2O4QD1shfPXRil/mztmFwDrVSJfbX6cIns=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 03:50:57 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 03:50:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Saye, Sashank" <Sashank.Saye@amd.com>, "Chan, Hing Pong"
 <Jeffrey.Chan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: trigger flr_work if reading pf2vf data failed
Thread-Topic: [PATCH] drm/amdgpu: trigger flr_work if reading pf2vf data failed
Thread-Index: AQHaeOW/+svTPKZWYEeJlkAE38PFOrE83QXw
Date: Mon, 18 Mar 2024 03:50:57 +0000
Message-ID: <BN9PR12MB52571276D9C05999D614D370FC2D2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240318033733.5824-1-Zhigang.Luo@amd.com>
In-Reply-To: <20240318033733.5824-1-Zhigang.Luo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f6810cf9-8393-4df1-b2b3-c9f9b43f888f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-18T03:50:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB6385:EE_
x-ms-office365-filtering-correlation-id: bb0594b5-edef-4cfa-79a4-08dc46fe9ea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2zm8wXEIgEmyB1QVh5yHQu5M1GJXrlGhcUaUtQbwraNLgAL05aS3s0ZnGylMQ9dqXvF0gQhNOyp5iMI2GYFi+nVSFcmJIxUoOQJV76lszejaKvbdSkgD63Dq2Llc+AJBIDXIXhnYYgqHg7IU04dvKLsCtYrwSS2rr7jIutU3UK4MA9h/qT5vxxh5Ghi3PhoUTWf3QKZwMl4H+cv9B3keEmETNVOdUu8n5LNrq2HK4D8BImXu3BRB9isBeCnuHV3qehSC5rQiHeqvsAyLD+0d+WzZYlDiVU6pxMyapq4Lb3fRojkiPAe5WDi5LhiGTLGBuDOiNYTbPQm0mde96i/52UbV9a4t02hKxKxeeC6fCeUiBm+LJ0JCWoH+aewvAzlpk5nVn/KiQTTiU65fb429UpWZwRr9TgJjoVHurkY/9sqsMc/UDwx2CQtAv03mOy8bSbYNW4kczDdxeZWM5PLVazlPIaAjg9gqQfam5P9WHCaymnDk9GCmV8pakPjWV6N5H1UyODRonp3fzG2N0geZCwXtM5iJTYM8c6+JgoFy8Lim2bewKvt5rfu+8kpUXwqqgc16RcQFAAT/JvNsE81mAlP9WqDEiE6BAjP2bqPliYZe/Kh+mNDPcuy5ANPVZcFK9t5UyzqlW+Y+80XSBZNOsgyax1yO/7xUejdL68s+X/nrhmzCQZ1Mbs60Agys0C8ys9k85Ne3sBTFjJ9KgcPVcDt147/KUUIZkPm/b6wAkDM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MDHPT8C0V/dB9O4hF8HtcOIOVVRjQcKRvM2VJeZhoxRr8yZPjJo5LxvDlu8z?=
 =?us-ascii?Q?kfnxd6tpF6JECQoQZuasJoh57FIKp4t0GGVscnf0TMC/prPyzBeQ36TWfnGK?=
 =?us-ascii?Q?Mcz5AH9OpWNldX4yvuHVHIhIsZxQYM6Fek3F/rae+4hmKgNpNC/d2BApXVSb?=
 =?us-ascii?Q?xVon3mWft0g0rRcpQYRJhycqZoow2WMr+esp6/MEKCzVldVABLgqTwjzM/iQ?=
 =?us-ascii?Q?n3dz3NwSoSKvTEaIilymwMHhNv1fSh9KNxqrDlIaiTkz4ZonYYxCkcNr10Yf?=
 =?us-ascii?Q?PBQ0V4AGHOO0vN0xn6wAJA6qoIvt2hbCMa9Sp0jagUzrSs2qJpkZ6I1+Be+t?=
 =?us-ascii?Q?GWU+YrItTpOnCQHIoeK/HR+QGE0FuUxO6Di1h+NxNZoWS0HE0sDZ2lh6XLay?=
 =?us-ascii?Q?jCfOkRt2EKzpNSVNXlk7W7acGpqa36XJaSXnhtODqHvHW+776XDxH1aZASTU?=
 =?us-ascii?Q?gPor7QJjaCgTK0rzpOc3RAogbZGnaYZYsUkU2cfxX3C85y1QZcH222YoiItO?=
 =?us-ascii?Q?NPsYNErbn5c6aGMSMlq42gxGpiKUzLV/w5A86N6nGfpCF4vFIQLnqy/KyI2b?=
 =?us-ascii?Q?M+RUiilgdjyRJz2AmSCs8CCLoHnHRDBYHseY8VoLXYLtgEYzPWadf2ivcNSQ?=
 =?us-ascii?Q?ksD0U2wcxujlKW44j64u3UnEfuFQSNNovTpSfo8FUHnxacPRmSQdNxwnNP2g?=
 =?us-ascii?Q?uepq5MfpmdKPX9JV86SgU+caobjgeXtk39eVXftzI5BtGtjeLncW8+zDh5RU?=
 =?us-ascii?Q?jl90yo/8cWU40nVSFvVCapd5JUpG98mr2SNrbBENduVC2HR3nIO1+XOuk7an?=
 =?us-ascii?Q?mZ6GPqaCvJNd457cM79iOPihWTIYLIeg9L0eSBMfMibA9xHiFrIgXilXxjow?=
 =?us-ascii?Q?C+MO/HklbmBcEmvFQ7D2WLhNwVueIHf5J5C2ZuPTzTRKB5K7PyW7/UAFKvwX?=
 =?us-ascii?Q?WVescxVHrkxAlTSAmkz0NZ0a8eIytyFdJAuHHKczdXAKSlBJsBopvQwIC4Zl?=
 =?us-ascii?Q?6qMhKdZSkbqTxx5UtQ/dqyomB9UO4W7XYSztYSnc4SqpxD03mQ+/I/sctOee?=
 =?us-ascii?Q?8pPT9wdX8iLwO+F11pP2AjMQknxbk+an9Pj9Ax6yHyl3CB5U6oIQupfYhx7u?=
 =?us-ascii?Q?noDVZTeSRagRRIfD1SeXMozUwvZEQWAK6h0x/a8Mqr9udgPXpWEEBezQekRU?=
 =?us-ascii?Q?eJilgdCbx5zmNNe8g02nNPqtzDhZg8VnxlVNRfnVReJjpjF2pSmMAjTpNfN2?=
 =?us-ascii?Q?LM5HMLdCWp+V/rhEJJW2l9tWqoUw+UXSq5y+53RaRecJak2HVFPAZ2MonAXX?=
 =?us-ascii?Q?4I83ZmTqa7bknRkvEKST3eq6nErrG1Us54l0soUiga7sIDNMPNN7Hdd19CGv?=
 =?us-ascii?Q?GZUdJBxtArnJE7umcHA1Gftox+8HXjxI8jIxa8XAk4s3FxYLrce3xkwXIuwd?=
 =?us-ascii?Q?4tJ6CmxpvuR4RSC6T1MvEP9EPp4ZV6xJf8M0z9OZ0PH1X0wREsuXIX8HLCkv?=
 =?us-ascii?Q?CRDTrXlxyLOkVtmM1uT70jZZ87NXssi5M5Gc7ehW3GOMJJnBOLJ8s1WulDek?=
 =?us-ascii?Q?AEoGim0+DC8OvYZNr4Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0594b5-edef-4cfa-79a4-08dc46fe9ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 03:50:57.6412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVOS7AdHKmGUzIT5jBmoN0Li46N6Ca1oVHF0m7vr/Xsedxf3fmS03CKqa8cdRelsiZW1W0FG6GgrAC3wglMyVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
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

Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Luo, Zhigang <Zhigang.Luo@amd.com>
Sent: Monday, March 18, 2024 11:38
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Saye, Sashank <Sashank.Saye@amd=
.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@am=
d.com>
Subject: [PATCH] drm/amdgpu: trigger flr_work if reading pf2vf data failed

if reading pf2vf data failed 30 times continuously, it means something is w=
rong. Need to trigger flr_work to recover the issue.

also use dev_err to print the error message to get which device has issue a=
nd add warning message if waiting IDH_FLR_NOTIFICATION_CMPL timeout.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Change-Id: Ia7ce934d0c3068ad3934715c14bbffdfcbafc4c2
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 29 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  3 +++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  2 ++
 5 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b37113b79483..70261eb9b0bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -143,6 +143,8 @@ const char *amdgpu_asic_name[] =3D {
        "LAST",
 };

+static inline void amdgpu_device_stop_pending_resets(struct
+amdgpu_device *adev);
+
 /**
  * DOC: pcie_replay_count
  *
@@ -4972,6 +4974,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_de=
vice *adev,
 retry:
        amdgpu_amdkfd_pre_reset(adev);

+       amdgpu_device_stop_pending_resets(adev);
+
        if (from_hypervisor)
                r =3D amdgpu_virt_request_full_gpu(adev, true);
        else
@@ -5712,11 +5716,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
                        tmp_adev->asic_reset_res =3D r;
                }

-               /*
-                * Drop all pending non scheduler resets. Scheduler resets
-                * were already dropped during drm_sched_stop
-                */
-               amdgpu_device_stop_pending_resets(tmp_adev);
+               if (!amdgpu_sriov_vf(tmp_adev))
+                       /*
+                       * Drop all pending non scheduler resets. Scheduler =
resets
+                       * were already dropped during drm_sched_stop
+                       */
+                       amdgpu_device_stop_pending_resets(tmp_adev);
        }

        /* Actual ASIC resets if needed.*/
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 7a4eae36778a..aed60aaf1a55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -32,6 +32,7 @@

 #include "amdgpu.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "vi.h"
 #include "soc15.h"
 #include "nv.h"
@@ -424,7 +425,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_de=
vice *adev)
                return -EINVAL;

        if (pf2vf_info->size > 1024) {
-               DRM_ERROR("invalid pf2vf message size\n");
+               dev_err(adev->dev, "invalid pf2vf message size: 0x%x\n",
+pf2vf_info->size);
                return -EINVAL;
        }

@@ -435,7 +436,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_de=
vice *adev)
                        adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
                        adev->virt.fw_reserve.checksum_key, checksum);
                if (checksum !=3D checkval) {
-                       DRM_ERROR("invalid pf2vf message\n");
+                       dev_err(adev->dev,
+                               "invalid pf2vf message: header checksum=3D0=
x%x calculated checksum=3D0x%x\n",
+                               checksum, checkval);
                        return -EINVAL;
                }

@@ -449,7 +452,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_de=
vice *adev)
                        adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
                        0, checksum);
                if (checksum !=3D checkval) {
-                       DRM_ERROR("invalid pf2vf message\n");
+                       dev_err(adev->dev,
+                               "invalid pf2vf message: header checksum=3D0=
x%x calculated checksum=3D0x%x\n",
+                               checksum, checkval);
                        return -EINVAL;
                }

@@ -485,7 +490,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_de=
vice *adev)
                        ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uu=
id;
                break;
        default:
-               DRM_ERROR("invalid pf2vf version\n");
+               dev_err(adev->dev, "invalid pf2vf version: 0x%x\n",
+pf2vf_info->version);
                return -EINVAL;
        }

@@ -584,8 +589,21 @@ static void amdgpu_virt_update_vf2pf_work_item(struct =
work_struct *work)
        int ret;

        ret =3D amdgpu_virt_read_pf2vf_data(adev);
-       if (ret)
+       if (ret) {
+               adev->virt.vf2pf_update_retry_cnt++;
+               if ((adev->virt.vf2pf_update_retry_cnt >=3D AMDGPU_VF2PF_UP=
DATE_MAX_RETRY_LIMIT) &&
+                   amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
+                       if (amdgpu_reset_domain_schedule(adev->reset_domain=
,
+                                                         &adev->virt.flr_w=
ork))
+                               return;
+                       else
+                               dev_err(adev->dev, "Failed to queue work! a=
t %s", __func__);
+               }
+
                goto out;
+       }
+
+       adev->virt.vf2pf_update_retry_cnt =3D 0;
        amdgpu_virt_write_vf2pf_data(adev);

 out:
@@ -606,6 +624,7 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_devic=
e *adev)
        adev->virt.fw_reserve.p_pf2vf =3D NULL;
        adev->virt.fw_reserve.p_vf2pf =3D NULL;
        adev->virt.vf2pf_update_interval_ms =3D 0;
+       adev->virt.vf2pf_update_retry_cnt =3D 0;

        if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
                DRM_WARN("Currently fw_vram and drv_vram should not have va=
lues at the same time!"); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vi=
rt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 3f59b7b5523f..a858bc98cad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -52,6 +52,8 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503

+#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 30
+
 enum amdgpu_sriov_vf_mode {
        SRIOV_VF_MODE_BARE_METAL =3D 0,
        SRIOV_VF_MODE_ONE_VF,
@@ -257,6 +259,7 @@ struct amdgpu_virt {
        /* vf2pf message */
        struct delayed_work vf2pf_work;
        uint32_t vf2pf_update_interval_ms;
+       int vf2pf_update_retry_cnt;

        /* multimedia bandwidth config */
        bool     is_mm_bw_enabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c
index a2bd2c3b1ef9..0c7275bca8f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -276,6 +276,8 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct=
 *work)
                timeout -=3D 10;
        } while (timeout > 1);

+       dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+
 flr_done:
        atomic_set(&adev->reset_domain->in_gpu_reset, 0);
        up_write(&adev->reset_domain->sem);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index a1bad772d932..89992c1c9a62 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -309,6 +309,8 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct=
 *work)
                timeout -=3D 10;
        } while (timeout > 1);

+       dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+
 flr_done:
        atomic_set(&adev->reset_domain->in_gpu_reset, 0);
        up_write(&adev->reset_domain->sem);
--
2.25.1

