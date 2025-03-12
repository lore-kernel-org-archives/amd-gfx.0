Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC32C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 05:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB0F10E304;
	Wed, 12 Mar 2025 05:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zKiwdrVA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25EC10E304
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 05:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHu/lfXs0WRVZJCBCyk88hX72ZsbQa3JDUa4M06vvdrHpTgXBH7+Q9PMpAVztEvjyC97KBlob9ZVTA6amuXswCzcOD0wFCUGYXqKbyI6nfaqsyoRS6hWA0C4ZuyE3wfAF/XPr5M12xMyoIH8SorZ9UtzKsTEb17jomia1C0mZ3mkE3fGbxHJX1nxMGroVbrqHo0HfTQk6g6UCVPvaVmlVTGqhZFZ3+o3Iz+Bt/MLez7TP3KwkL9WpP0348stN5fVYuwMeOeVQ/lGlc1QayTQjvlgBdVb9l/pyO+vngfBy/MhZwAUXgfmRN4VI+cvYoS0aBUZqacct6j7YXZfWhga3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTc4NBeG9kX91iYZidAxBAWUxMdub7ctG9Sw2/LrrWE=;
 b=KbhnM+LJdk2o4/ufF1rEKk10uUO2ilUl+9fWjkEC/jBAONcD74xtdRrUa9Ti5sZo0ivCDmWfAZtCd8qWk8IhS3leD5IlbPLmsmLPC+8GDtKrfa7mOtHRrOBVRJrBwvj6CgkeiF3SJZjpfhwBfOQ/jw8Uz4xRE1epf3zaYnJoC8+Fsq+ZpnpK1M4JO/mLnlIjxgH9hKtlU1FFPMPXDCa7fvO8Mz5vC/ymbH0de5vN6HccE8loe2E4tLTngQEpk3nk/B9Oxvy/V2rwx82MK9YHEvL8ddSd4FuUJ15tXpG2JgWuFSu1ms7WeKOQSy8PSEyw0G8YdG7pWsfq3zxTN1gDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTc4NBeG9kX91iYZidAxBAWUxMdub7ctG9Sw2/LrrWE=;
 b=zKiwdrVABl7eobMFTG0CRBqmdtlL1rRSVmEW+0jGXPt4oH17FeqohWGJHaB3QUrZ1PODC9Wihxb8Vhfgfct7ucbKnn1sjpX0SsjLf41W8G51hhzFevwUpaNv/qGlV6UrtnPkLBTHUrkMJWljt4u4ruI1duS1sgN5NxeOOH4BnxM=
Received: from BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:06:09 +0000
Received: from BL1PR12MB5158.namprd12.prod.outlook.com
 ([fe80::b9ae:fa61:11ed:4e3b]) by BL1PR12MB5158.namprd12.prod.outlook.com
 ([fe80::b9ae:fa61:11ed:4e3b%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:06:09 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: wire up hwmon fan speed for smu 14.0.2
Thread-Topic: [PATCH] drm/amdgpu/pm: wire up hwmon fan speed for smu 14.0.2
Thread-Index: AQHbkpNgZCCCEaHfvkWV//2oktgU0rNu86Og
Date: Wed, 12 Mar 2025 05:06:09 +0000
Message-ID: <BL1PR12MB51584BFA14662634B820775F8ED02@BL1PR12MB5158.namprd12.prod.outlook.com>
References: <20250311143851.1931589-1-alexander.deucher@amd.com>
In-Reply-To: <20250311143851.1931589-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=307d5c47-407a-4124-bb85-89a5aa852215;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-12T05:05:38Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5158:EE_|MW6PR12MB9000:EE_
x-ms-office365-filtering-correlation-id: 855e5c43-04e0-4fca-666b-08dd61239a58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Uly1+yoOLLvVP46ZY1+VVemveAMlwJ+Ui3xaJOsIBV9sqmCN9oquH6jOVLS2?=
 =?us-ascii?Q?//IMMRNSnRYS4MMB0YbJ/GhI1EPLyYAmp7F1gKw6rSfdwL8DaVV1RFqCX6Uv?=
 =?us-ascii?Q?pqE5rQFNkJkbNV7xYvHW8dK7U7n3ufneaR5/07WKWbIutwARg7ASEZqO8D/Z?=
 =?us-ascii?Q?y52WQgIha2HFmRljjJwR1mJqqRk4Ht1Cb6RMua/P4/ohZbUIuv1Vhs7wWyR7?=
 =?us-ascii?Q?6ZJXJa2goAyxIzoQqOKZ+A/zi0Uiq7/lvXeceDxf13vPRIjNjULDobyVzOUu?=
 =?us-ascii?Q?Vx0EViYjASp2UFhRgSsu4UjeITgTenkrZ4NdqAj3uJ9rX0DVFlnCXHAzXAsO?=
 =?us-ascii?Q?f1loYF1yryklYR5hZi0WwDc9pCh77W3JLdcqFYc2QF/2u3Tq7ngJeckO49fm?=
 =?us-ascii?Q?vpOsmGKl+NSsreZapoBmDK+V5hgUETGJcrEAxeRL4CULPNKJOJrcUAQc/hA+?=
 =?us-ascii?Q?3odlF+fwdTfBMouxtC2HXBvIDcYGoXN9tc0kpDfMDEUM/R9JZrPLNb7UvM2X?=
 =?us-ascii?Q?xihQocKE0BNBiUEdJ+pUijG7iHf/iZEuNJRdphEv1pYObkVL/cgz4MEH+2oY?=
 =?us-ascii?Q?q34NdEgWbVgMjf9gHvhvMJVqsehKNcc1yJ/cwVn5LaNyiIF8dufA865eTurV?=
 =?us-ascii?Q?EdmrDGKMjnQS6UWoVE6vvfwkYNnRvE8xGnbravnqli3ygArivPZskif+GSGK?=
 =?us-ascii?Q?iEtBC8niXlVZjwSsxv69kDLpET7c+3nkGFasnxhPuNMxv8t1kD7xyzAj0Muf?=
 =?us-ascii?Q?4b4lLg8K9tBXjiL5JGU++nxFLL+dDbqxxozr4Psrl9mwgdns8cBhpnKLbq06?=
 =?us-ascii?Q?ztmD+BVDpVFkFN96fH13QeSBkonRFyT20VwWXpx48BBqC6DPcF58AVLaVPvR?=
 =?us-ascii?Q?2lXt/EG9izBZ397z33PocgP60L3yQiHu2fPFDmkEWG28vYaYPchn4GUmO+jc?=
 =?us-ascii?Q?AXTviJ04hNLHL9P0B1MZ8Y5wGFNp30NxgLgeIZ8Z1436fOLJeRas4o9WIdlC?=
 =?us-ascii?Q?MqW2w6iT7XGUEVYRjrgJ1yVimXRyE/EF4g7z4g0qnsbgJrNbTP+aF14Yuj5m?=
 =?us-ascii?Q?AVWw0a/8MUjtFR10gmTzPJRJYL8WjNde3vi6rCNWbY0LzmZd6vuUJDyjM15t?=
 =?us-ascii?Q?eULKUrfg0Sd7FEq+jImNmwBv7kHeaodyYQqK6OWFrp2kZSzfYmW968iXfgYR?=
 =?us-ascii?Q?O5G0RaPmhN4WGJWyCLQL5XRA6VDa/KDitxLgpI5lFqEWMeMJN0KF3pDasBSc?=
 =?us-ascii?Q?vN54FlR265dhfh0kiSJ2U9wRPh6T4OGYuffv1wrAR5oCgU0vhN0YaNusDFS6?=
 =?us-ascii?Q?IGgZjRRODkpSxMAUZ5AY1gqy0WKyz54whTsW3AuSSVgEBMvqUR5mif41WnNw?=
 =?us-ascii?Q?DDiY75pdhvhOTYoe+UtbcqXM2hPCc+u/KXMAcTCU9eD3W8yauA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VlwNKpS4eUrwTEFstmz74046/BHNgE5ZqLkhIcOgoucysQbQ+TdKTmbo1vKQ?=
 =?us-ascii?Q?7k/187LgjVXPPiFjU8nB4d7+sP4jN1R/cj0Q0o79o22ye0h16yJuwJTEDIqE?=
 =?us-ascii?Q?19M1OkUej8qFXCA+RQfcw6MjwLRB6fovo34/zNGuNcOyNh2D7v+rlBhuNNQS?=
 =?us-ascii?Q?+zjWCcWCDKxbh9X3wweoW2KvhQyC+/urkacevBTEgXU32td+YDA98QZmGjfL?=
 =?us-ascii?Q?nOF462lt2z/22kBX81uk2czr9LVCCVObMGY9TF7X6U/+12L6IUdTgt9IRYld?=
 =?us-ascii?Q?KHLHJ2RXbHLWhEVAcAIZioBRo+AVrTdWQTrMZnFDQRkaT8XZPyoo+1n2VnFY?=
 =?us-ascii?Q?g1trbIBQFvDZIG4Dc19IXdVLem1tpv6zOh2JGXExXPK5VgP4tltRQYnTMHvv?=
 =?us-ascii?Q?bRPYjdFAc5CEHmBdr1K/yUMpnGivG/30eQfqOXvwOXjST6JUakhJN0SeNdo7?=
 =?us-ascii?Q?7zKvRIDPBecP/e39pmAEEN/1TcGya1HnerCIBj5yLSbotwJT5HzQcRKnnnfW?=
 =?us-ascii?Q?k9IyP23QxfvZFNLW+fRpmFBtrjnLyDecH6E6g3P+e6Auk5g8urcpYco5n53g?=
 =?us-ascii?Q?PJwa3KV0tsqzLiuADg409DQqL4lqYB4GMLJVPsh30/e7zCjVjjICJeAp7nZk?=
 =?us-ascii?Q?ao2hUdABKmpjDpwM7s/aI83OwWVHEprq2DljzGfMBrCv3wI150uaceb4hnOV?=
 =?us-ascii?Q?Jpm1G6INNsvwvKvx4QiAUFVFp3oDlv6rEOltSviGbjWg6GcnOqy13G/u1ppu?=
 =?us-ascii?Q?7GoTCkPNp1m6kKTxqZiHE3ZMru/YBndZKl2ES0ZhfPtADRg+onyGSIFAzOeA?=
 =?us-ascii?Q?Uo5uU1UWTQWxV38XAgO3JU9W2shbhqpJTlmNKHoYqbkZlkrDsW1YRUfElf8A?=
 =?us-ascii?Q?icPy26vBhAMJWxwo1G8IKtPGKbPf/6yCCznMgYz8HmwuoOSb5KYrfP5JKWPv?=
 =?us-ascii?Q?svaOTrcYIYT2CQeyL4pfVXHvBl//qH2sDXrM74Dh/yt9beFYjb/YG+9xaNLj?=
 =?us-ascii?Q?Z8EAPxiYWsEISQPZDM7O4jXrRqR0Hb9OfIHnOwAj2gQrxkZecCC3D4UqTjYh?=
 =?us-ascii?Q?AXRl79UGOUp0ggK2fd6kbSqNKqc9U/aseCE+nNZ0e6QH2oYpBK1R03VnCzM+?=
 =?us-ascii?Q?C/GxQtrCJQIN84E5b5gACNbGvN5V+13utMKHHOk+eabXP/OJBORbnXEOJQrw?=
 =?us-ascii?Q?IZVsDAg/R4h5XqCMeDmfry2OZsLiRfZy9TbodxugqgV5PKf6fay7pZo+XGpO?=
 =?us-ascii?Q?+6Zp4/TikVDXkCdA70sVMtR6kIBlGQR4TUPwzYTgk/ey+a8t6uRi9k5YhmrL?=
 =?us-ascii?Q?duVAcrrJZ6I91OHl8VkKH+JoEXlwyVE9IZhEu7RVWTqo9dZ6klrNqnRTSc7A?=
 =?us-ascii?Q?DNQQGoPZp/SS6jUTtrsAclqWS9LKYskVLlHhHTapMPUO8XdpH5Vc4Xdk5F2P?=
 =?us-ascii?Q?ulWvLye2Lp4kmK9Dj6ey/d9AtUcMC9fqCrE+0ECq2Kh8SaoXDMypCaYakhe5?=
 =?us-ascii?Q?RLVE8l6GGWhwUX7TAWvsGT0ehmm6T7fQhGqQx1JULMQYu6xhiH2akoTstqSI?=
 =?us-ascii?Q?jB2xKSd9seNlyfnaSaE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855e5c43-04e0-4fca-666b-08dd61239a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 05:06:09.7074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoXwb6/Bxh5p/yNf5pGVo3f2ZbZSMeAnWFHPILXKureuiAbq4bzGgNoA3I1SjGS0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Kenneth Feng kenneth.feng@amd.com


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, March 11, 2025 10:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: wire up hwmon fan speed for smu 14.0.2

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Add callbacks for fan speed fetching.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4034
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 5cad09c5f2ff2..e4089fd58711c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1627,6 +1627,39 @@ static void smu_v14_0_2_get_unique_id(struct smu_con=
text *smu)
        adev->unique_id =3D ((uint64_t)upper32 << 32) | lower32;  }

+static int smu_v14_0_2_get_fan_speed_pwm(struct smu_context *smu,
+                                        uint32_t *speed) {
+       int ret;
+
+       if (!speed)
+               return -EINVAL;
+
+       ret =3D smu_v14_0_2_get_smu_metrics_data(smu,
+                                              METRICS_CURR_FANPWM,
+                                              speed);
+       if (ret) {
+               dev_err(smu->adev->dev, "Failed to get fan speed(PWM)!");
+               return ret;
+       }
+
+       /* Convert the PMFW output which is in percent to pwm(255) based */
+       *speed =3D min(*speed * 255 / 100, (uint32_t)255);
+
+       return 0;
+}
+
+static int smu_v14_0_2_get_fan_speed_rpm(struct smu_context *smu,
+                                        uint32_t *speed) {
+       if (!speed)
+               return -EINVAL;
+
+       return smu_v14_0_2_get_smu_metrics_data(smu,
+                                               METRICS_CURR_FANSPEED,
+                                               speed); }
+
 static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
                                       uint32_t *current_power_limit,
                                       uint32_t *default_power_limit, @@ -2=
804,6 +2837,8 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs =
=3D {
        .set_performance_level =3D smu_v14_0_set_performance_level,
        .gfx_off_control =3D smu_v14_0_gfx_off_control,
        .get_unique_id =3D smu_v14_0_2_get_unique_id,
+       .get_fan_speed_pwm =3D smu_v14_0_2_get_fan_speed_pwm,
+       .get_fan_speed_rpm =3D smu_v14_0_2_get_fan_speed_rpm,
        .get_power_limit =3D smu_v14_0_2_get_power_limit,
        .set_power_limit =3D smu_v14_0_2_set_power_limit,
        .get_power_profile_mode =3D smu_v14_0_2_get_power_profile_mode,
--
2.48.1

