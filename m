Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826C1C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 07:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FCCA10E4EC;
	Tue, 21 Jan 2025 07:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="upm9NMEi";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2D210E4EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 07:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2UsPMkihIt6mQyrlC5Yyf4e4+S2g3Y6H5Rw/GHIQFBP5h//Il9hJKfj8bhG6Sw3RZECg2TK3kEq7tm80tfxD6SiV1w3II7HBSnjK6kS59697kik7XmMILV79JPcuG2JAWzRIJF9hRbPiFIuNlT5DPI1X0UjR4mJRZQFVo/i6UAxvoA6wVN8/setLlV1Znyyiuwvu95xmG2pXhufCKOP8BdiuDKlSjvXmLZ4il6dhO3dPfd+nMPxysT+ndzDAC2fhqHdZgttOUkRon8CZ+GvmNJ0JNheEADR/vD9tHu3aACqcYG/ZWWXnwQ19uUoWXOtgzKKtKIRujIi2k2z4X5C8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Csj0JuEwFWK19NUeA73/v5NFfZEjyFRw89OooBJnztQ=;
 b=WDz9evxW1J4s18QLLURQKDKQI6bOk9uq7pTpIaD57wFvcIR7HwVQvtEPsitDMIF5dAlKQP598PJ4Nv6QrL/p+MB3DtnvZlFNcmdBpvskm/AF05j/I6NtnMO7XAy/7uPR3fm7GmDz/6G41adDVhHSBmHZuK7OdSsHSLQADah0ZSIGCFGXoSk7JM01M7WRZF/VefJyQqS3wx5nD3Zq8qnY47fJ82KUrP4Exu9WdDqemoq/ru10cilqZHHpqOqMI2Pk88BQ4nMrWTCod/kisJ5CgldR3o6JHeh8uuE5VCirsigEfPQAk23PciJfDPNq6JW6DfbtG9I1BKcQFqmwdNwFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Csj0JuEwFWK19NUeA73/v5NFfZEjyFRw89OooBJnztQ=;
 b=upm9NMEi1ZCLcqIDZYhf0miOzHNJnjR1+6tb1arqs6rIQdDdevsx+3NWPywsTnX4dz5269fgjf0GKlc7xC6VjzSlew+powuxdRzHajyngY3Byj556O1Ss6EFlY4WP9SezfTGtg4vrBZF97+MOMSfQhsdpqCJY8ShMKKZpLfZdEg=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.16; Tue, 21 Jan 2025 07:57:19 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 07:57:19 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v4] drm/amd/pm: Fix smu v13.0.6 caps initialization
Thread-Topic: [PATCH v4] drm/amd/pm: Fix smu v13.0.6 caps initialization
Thread-Index: AQHba9gH0ZF9+iiARka93pbcwNyfo7Mg3EKQ
Date: Tue, 21 Jan 2025 07:57:18 +0000
Message-ID: <DS7PR12MB6071F10C97A94780E3E233418EE62@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250121074208.1559798-1-lijo.lazar@amd.com>
In-Reply-To: <20250121074208.1559798-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9ff76fe4-e91e-41f4-94b7-805c6b111772;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-21T07:56:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DS7PR12MB5743:EE_
x-ms-office365-filtering-correlation-id: 750aee60-ebd0-4f04-a136-08dd39f13aa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?N4VXIiIAF5hGb1mU6AbauemxvDxO0pYPYBES7BlHMfaBIJKPxCTPgcJVtZF+?=
 =?us-ascii?Q?fs4oHDvNGl9c1Ei3KrRM7OXqz0fUtUaJbFFxnGKo9jr01A9/QpEHbD4iAD5u?=
 =?us-ascii?Q?PYRS8BIsjlUKbElyg6KvgR/OF1OGCtVGlpMJ+NforkYUuUG/tHywD0QVDDzf?=
 =?us-ascii?Q?Cup36jWqI0VL4Pfg6jeQ1jenkAixfqWd+2sWQuJP2LOhWJvVORmIbMPyW5Ld?=
 =?us-ascii?Q?iXbxQRvARiy+LWn3HGxYjmSZBJ+8zc8pWCEyMd7oSOjmOEI4IOaTzY3Qis5d?=
 =?us-ascii?Q?ciziLXqhM1KAw06a/GfwUp2hDuObtUOguNssSnUIZSUsLcMZtODVoZgnLFBb?=
 =?us-ascii?Q?M5ZNdTpCoONjjKp/f3LtG+TxfEpNz5h+n+TL0JiqtbY0dhqIhKLfusjCnU76?=
 =?us-ascii?Q?zuboEWfWHPH5t7Gez5Y216FrOMQLPy8+B6887d+IVR/YH25NSFwNCgxjFafo?=
 =?us-ascii?Q?EparZLo+GfehPo8hX7pVY/sN/V2cS8b5s60BIOAZ33KMVS94A9V37o7QBgcz?=
 =?us-ascii?Q?VB3TzYSU9ucR8E23BX3/kSK1o7MnM3dTqhGup48vloIWGZNQa7Upy5NQ7sj5?=
 =?us-ascii?Q?n67l0un4L42sXF+vI2TbToHuqsoLcMkqyhVGDtbU33IbNqz9fG4yX4aLPaS4?=
 =?us-ascii?Q?Yg4vpnVsEnFrGRezMAn+ionJlqrHIVf4wdhSvAcRZ5dUtlTPHXLNHWqfYhvs?=
 =?us-ascii?Q?4oG5dkSr+499oTaZAkxMG/GnndRLritJ6BB3AsPY/5NIq/jrTSXxIxifEQ/i?=
 =?us-ascii?Q?LUnSLPd5JdDG0x0Jou0rwcyswUhlhkLpYB/Yu8y8Amzw1tflRtyg1zyZsv2v?=
 =?us-ascii?Q?/0k3djKfRzWqu9sQQRXzHUbszIbb4qFrHhDeDSNdIBJ4Ug15h2HornfjRrZ3?=
 =?us-ascii?Q?qMu80TWEEYrKYHr8qLaPCRRzxsDAYoVtbYLfSf+aERVcZa0pQgxqsjJUVkFE?=
 =?us-ascii?Q?1doJHi9UmTAQkuL5sja3/qR42TmNbTa/M5fKDsm7hqjbBbogN0ljoiACSrvm?=
 =?us-ascii?Q?bxgPSuzrI4z+UY3YABpfdgRtuqTMqVQ6pMCXxOe9O3HzqfwCaQGDAv+77LOR?=
 =?us-ascii?Q?K3AXpjKV3nqCeX9FXP/CIYv0Lwtd/S7YOmquYrvBq9Xr5gBYcVKgv2khedst?=
 =?us-ascii?Q?23GuBQGfSPWWsvYW0O6vR9qbsCNW1ULomSg91yqXZSSNiEWR20CdxlQ/ULnR?=
 =?us-ascii?Q?t0ybdmLtIF7atPj3wwBHhrzwZaENnHDj6MJ0Wj/BT8Fp7H5Q+QmHJ++AMXWD?=
 =?us-ascii?Q?5j2BbSJ62PT3sR6+rEWMTRkdjuIeWLJPN7jfUXD+fE/X9TMriwmP/fXjp76Y?=
 =?us-ascii?Q?pDtBeCGXxG7GVNHn6Ri0+RLI5bU75foOg78izIl+EzDKVsyvZOWGLygvjU2B?=
 =?us-ascii?Q?4MspUH3n7zCXvpWQ9bQd6Cpxbmlj3U4IdXSjg1frAL/c9ZEd3cBCVdbsecx3?=
 =?us-ascii?Q?KfVPc9B2Wgra/qEyY3D0+JMtVX52DJPi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1oxQ+3zXncWBzgK3VwfKJJawDvrRLznQgUY9K41zrAWBVjRcsCzqoUixgqff?=
 =?us-ascii?Q?cdAn43bdVo55IpwqYi+pin3VVvihxzBeVjaHY36rwTlf7YdA3bt2PbXLJGmN?=
 =?us-ascii?Q?Mxt+Z/JuwWIptftmEHR5dFHUlT9MFeC2tO0XgTcx4ogeVmzEaMXlMijCbtGJ?=
 =?us-ascii?Q?Ugpq/Sz6ECDTUuytwFDQU72oKoQuzsNyy3VMfLTS3LAMKr+77hWmrTXSxdSW?=
 =?us-ascii?Q?TeDj9xVgUdZCSoLviVkttIdZq8yP0AQpOdcawiCoKz5ObWAWzoEzNA1cc5Xx?=
 =?us-ascii?Q?aek0J4K81rMoxCaz+q1CnFbWnj2QUPotUHwA2MiEAvuiMGgP7/YduU196BUq?=
 =?us-ascii?Q?r5GcCLjC38eZ7mgvffvtXM3/Kojx7hBeRpK8pph9f+vhpQMOtxUza4zGEDdN?=
 =?us-ascii?Q?bZw5ClERBC+9NVdN2uuy2pEHgbZ4QDd1Y/MrxPRrPclvdeJTkEG2ifPKklW3?=
 =?us-ascii?Q?i/vZ7yGETM0V/N/cORJBkkJJ/HxEGmTmvlqYqiUZ0PsWP8qTAU2lHmCTZDfI?=
 =?us-ascii?Q?GkNf089ujOEB8d2tvdWHCB+/O5zVGL82RAlsk7AAcq9m/oMtJIXaD9cwi9mi?=
 =?us-ascii?Q?E5wHjrE7MfkpdIV5zj+YOpSvKFuf4l7FIpGCfGcm9/g2eT5GytRtEB/N7dXL?=
 =?us-ascii?Q?CJobwiSgs32yxc3JLmhMwuvo+ZrE/IECxHY+IqWTfySZv6+s3vp57+N6ooMz?=
 =?us-ascii?Q?aZwWsdkgOAGV4ZyryrDzgw+U68/J4A9+NURuonh972NXpawGCHhTlZZ+C+0g?=
 =?us-ascii?Q?/UWHCmyDez+DfypZ9CkQ0gCZPOq2ARzfYN7zctehlyY/inSnLwA3KRZPU8bR?=
 =?us-ascii?Q?NBXXZRoFLlQVuZDtIDRwxpDRBoZRduPhWIM2C80wDyWdRwitNRupxu4JURsv?=
 =?us-ascii?Q?sxHZ+G01yVNEfBO/hEyUsL2p1T5X7OGgdTMjRLMSlZwchkD2MwccokdwFZYb?=
 =?us-ascii?Q?6Ps/cYTP3k0Z9TI3ydlfG/8UZnkKSQBdw4/wWy7DsHtGPA5CwmpOea1TYaXP?=
 =?us-ascii?Q?tCJlTxjmXyidrz2dKvUU7tL7mKSBXol9va0GRpbkFiRY/QqiutcHQMk856er?=
 =?us-ascii?Q?du8K0CYZnJeXyGBqr4AdRL32jcI85HKl5DTGmLAuEFFkiGEKqtIN7GcTkBjQ?=
 =?us-ascii?Q?9jfGLvsPvxdhAV9QppLmDIm1HqYD/qK9jw9GIZ75uj0XCl2GF0QNytGtnW9O?=
 =?us-ascii?Q?6IRaL9E5aptUwgfObmkqyOfzTcs3oCiuuaX0ORT8MooZ0e9LBDDxRK5QlbAn?=
 =?us-ascii?Q?2dXwBxopebUqX2k/RO49fTwV/3PRPj0J5Y2aiaQKUycwePYFsDfox+OoorG0?=
 =?us-ascii?Q?7uMe2p013OUvVAAsP/JNkKPkardYLkaiMttlncFJT6xi0m1irPEuYDebJ28P?=
 =?us-ascii?Q?rEKDHZGvTSCplnc5e3JC4bob5b2DP0jHWDBtwoq25iu73To7deLdQjynyPtl?=
 =?us-ascii?Q?X0qIQej1/cix9LENypvD9Nw0bN7nXpV6k74ZwXWYnQRNqO3zXmFc2oty1FIy?=
 =?us-ascii?Q?OaKonGxADYX9J5MRV6EPbCm6b4rZHm5FlqqsJXEfJV7SnXikTlRACEfJ99ID?=
 =?us-ascii?Q?VrF92lNpEZas82zAUR0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750aee60-ebd0-4f04-a136-08dd39f13aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 07:57:19.0075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+DY1Q3kObRyFRXveZ5H6GdNYk8EeEfD9hDIes2TN/AjmFGKeUzvBC3JmP2zQIskcI2WG1bHflUMfyQmbsQ0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, January 21, 2025 1:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH v4] drm/amd/pm: Fix smu v13.0.6 caps initialization

Fix the initialization and usage of SMU v13.0.6 capability values. Use caps=
_set/clear functions to set/clear capability.

Also, fix SET_UCLK_MAX capability on APUs, it is supported on APUs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Fixes: 9bb53d2ce109 ("drm/amd/pm: Add capability flags for SMU v13.0.6")
---
v1: ("drm/amd/pm: Use correct macros for smu caps")
v2:
        Use caps_set/clear instead of macros (Alex). Commit message changed=
.
        Use BIT_ULL (Kevin)
        Fix SET_UCLK_MAX capability on APUs
v3:
        Rename to cap to indicate operations on single capability (Alex)
        Use SMU_CAP in enum value definition also for consistency
v4:
        Rebase on top of the new checks for SDMA RESET cap.
        Add SMU v13.0.12 initial caps values.
        Keep CTF_LIMIT cap check common for SMU v13.0.6 (Asad)

 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 239 ++++++++++--------
 1 file changed, 134 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f8821783a099..fa11e30bff24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -101,26 +101,25 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 #define MCA_BANK_IPID(_ip, _hwid, _type) \
        [AMDGPU_MCA_IP_##_ip] =3D { .hwid =3D _hwid, .mcatype =3D _type, }

+#define SMU_CAP(x) SMU_13_0_6_CAPS_##x
+
 enum smu_v13_0_6_caps {
-       SMU_13_0_6_CAPS_DPM,
-       SMU_13_0_6_CAPS_UNI_METRICS,
-       SMU_13_0_6_CAPS_DPM_POLICY,
-       SMU_13_0_6_CAPS_OTHER_END_METRICS,
-       SMU_13_0_6_CAPS_SET_UCLK_MAX,
-       SMU_13_0_6_CAPS_PCIE_METRICS,
-       SMU_13_0_6_CAPS_HST_LIMIT_METRICS,
-       SMU_13_0_6_CAPS_MCA_DEBUG_MODE,
-       SMU_13_0_6_CAPS_PER_INST_METRICS,
-       SMU_13_0_6_CAPS_CTF_LIMIT,
-       SMU_13_0_6_CAPS_RMA_MSG,
-       SMU_13_0_6_CAPS_ACA_SYND,
-       SMU_13_0_6_CAPS_SDMA_RESET,
-       SMU_13_0_6_CAPS_ALL,
+       SMU_CAP(DPM),
+       SMU_CAP(UNI_METRICS),
+       SMU_CAP(DPM_POLICY),
+       SMU_CAP(OTHER_END_METRICS),
+       SMU_CAP(SET_UCLK_MAX),
+       SMU_CAP(PCIE_METRICS),
+       SMU_CAP(HST_LIMIT_METRICS),
+       SMU_CAP(MCA_DEBUG_MODE),
+       SMU_CAP(PER_INST_METRICS),
+       SMU_CAP(CTF_LIMIT),
+       SMU_CAP(RMA_MSG),
+       SMU_CAP(ACA_SYND),
+       SMU_CAP(SDMA_RESET),
+       SMU_CAP(ALL),
 };

-#define SMU_CAPS_MASK(x) (ULL(1) << x)
-#define SMU_CAPS(x) SMU_CAPS_MASK(SMU_13_0_6_CAPS_##x)
-
 struct mca_bank_ipid {
        enum amdgpu_mca_ip ip;
        uint16_t hwid;
@@ -283,100 +282,143 @@ struct smu_v13_0_6_dpm_map {
        uint32_t *freq_table;
 };

-static void smu_v13_0_14_init_caps(struct smu_context *smu)
+static inline void smu_v13_0_6_cap_set(struct smu_context *smu,
+                                      enum smu_v13_0_6_caps cap)
+{
+       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
+
+       dpm_context->caps |=3D BIT_ULL(cap);
+}
+
+static inline void smu_v13_0_6_cap_clear(struct smu_context *smu,
+                                        enum smu_v13_0_6_caps cap)
 {
        struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
-       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
-                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
-                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(CTF_LIMIT) |
-                       SMU_CAPS(MCA_DEBUG_MODE) | SMU_CAPS(RMA_MSG) |
-                       SMU_CAPS(ACA_SYND);
+
+       dpm_context->caps &=3D ~BIT_ULL(cap);
+}
+
+static inline bool smu_v13_0_6_cap_supported(struct smu_context *smu,
+                                            enum smu_v13_0_6_caps cap)
+{
+       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
+
+       return !!(dpm_context->caps & BIT_ULL(cap)); }
+
+static void smu_v13_0_14_init_caps(struct smu_context *smu) {
+       enum smu_v13_0_6_caps default_cap_list[] =3D { SMU_CAP(DPM),
+                                                    SMU_CAP(UNI_METRICS),
+                                                    SMU_CAP(SET_UCLK_MAX),
+                                                    SMU_CAP(DPM_POLICY),
+                                                    SMU_CAP(PCIE_METRICS),
+                                                    SMU_CAP(CTF_LIMIT),
+                                                    SMU_CAP(MCA_DEBUG_MODE=
),
+                                                    SMU_CAP(RMA_MSG),
+                                                    SMU_CAP(ACA_SYND) };
        uint32_t fw_ver =3D smu->smc_fw_version;

+       for (int i =3D 0; i < ARRAY_SIZE(default_cap_list); i++)
+               smu_v13_0_6_cap_set(smu, default_cap_list[i]);
+
        if (fw_ver >=3D 0x05550E00)
-               caps |=3D SMU_CAPS(OTHER_END_METRICS);
+               smu_v13_0_6_cap_set(smu, SMU_CAP(OTHER_END_METRICS));
        if (fw_ver >=3D 0x05551000)
-               caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
+               smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
        if (fw_ver >=3D 0x05550B00)
-               caps |=3D SMU_CAPS(PER_INST_METRICS);
-       if (fw_ver > 0x05550f00)
-               caps |=3D SMU_CAPS(SDMA_RESET);
+               smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
+       if (fw_ver >=3D 0x5551200)
+               smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET)); }
+
+static void smu_v13_0_12_init_caps(struct smu_context *smu) {
+       enum smu_v13_0_6_caps default_cap_list[] =3D { SMU_CAP(DPM),
+                                                    SMU_CAP(UNI_METRICS),
+                                                    SMU_CAP(PCIE_METRICS),
+                                                    SMU_CAP(CTF_LIMIT),
+                                                    SMU_CAP(MCA_DEBUG_MODE=
),
+                                                    SMU_CAP(RMA_MSG),
+                                                    SMU_CAP(ACA_SYND) };
+       uint32_t fw_ver =3D smu->smc_fw_version;
+
+       for (int i =3D 0; i < ARRAY_SIZE(default_cap_list); i++)
+               smu_v13_0_6_cap_set(smu, default_cap_list[i]);

-       dpm_context->caps =3D caps;
+       if (fw_ver < 0x00561900)
+               smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM));
+
+       if (fw_ver >=3D 0x00561700)
+               smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 }

 static void smu_v13_0_6_init_caps(struct smu_context *smu)  {
-       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
-                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
-                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(MCA_DEBUG_MODE) |
-                       SMU_CAPS(CTF_LIMIT) | SMU_CAPS(RMA_MSG) |
-                       SMU_CAPS(ACA_SYND);
-       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
+       enum smu_v13_0_6_caps default_cap_list[] =3D { SMU_CAP(DPM),
+                                                    SMU_CAP(UNI_METRICS),
+                                                    SMU_CAP(SET_UCLK_MAX),
+                                                    SMU_CAP(DPM_POLICY),
+                                                    SMU_CAP(PCIE_METRICS),
+                                                    SMU_CAP(CTF_LIMIT),
+                                                    SMU_CAP(MCA_DEBUG_MODE=
),
+                                                    SMU_CAP(RMA_MSG),
+                                                    SMU_CAP(ACA_SYND) };
        struct amdgpu_device *adev =3D smu->adev;
        uint32_t fw_ver =3D smu->smc_fw_version;
        uint32_t pgm =3D (fw_ver >> 24) & 0xFF;

+       for (int i =3D 0; i < ARRAY_SIZE(default_cap_list); i++)
+               smu_v13_0_6_cap_set(smu, default_cap_list[i]);
+
        if (fw_ver < 0x552F00)
-               caps &=3D ~SMU_CAPS(DPM);
+               smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM));
+       if (fw_ver < 0x554500)
+               smu_v13_0_6_cap_clear(smu, SMU_CAP(CTF_LIMIT));

        if (adev->flags & AMD_IS_APU) {
-               caps &=3D ~SMU_CAPS(PCIE_METRICS);
-               caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
-               caps &=3D ~SMU_CAPS(DPM_POLICY);
-               caps &=3D ~SMU_CAPS(RMA_MSG);
-               caps &=3D ~SMU_CAPS(ACA_SYND);
+               smu_v13_0_6_cap_clear(smu, SMU_CAP(PCIE_METRICS));
+               smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM_POLICY));
+               smu_v13_0_6_cap_clear(smu, SMU_CAP(RMA_MSG));
+               smu_v13_0_6_cap_clear(smu, SMU_CAP(ACA_SYND));

                if (fw_ver <=3D 0x4556900)
-                       caps &=3D ~SMU_CAPS(UNI_METRICS);
-
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(UNI_METRICS));
                if (fw_ver >=3D 0x04556F00)
-                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
+                       smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS)=
);
                if (fw_ver >=3D 0x04556A00)
-                       caps |=3D SMU_CAPS(PER_INST_METRICS);
-               if (fw_ver < 0x554500)
-                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
+                       smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS))=
;
        } else {
                if (fw_ver >=3D 0x557600)
-                       caps |=3D SMU_CAPS(OTHER_END_METRICS);
+                       smu_v13_0_6_cap_set(smu, SMU_CAP(OTHER_END_METRICS)=
);
                if (fw_ver < 0x00556000)
-                       caps &=3D ~SMU_CAPS(DPM_POLICY);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM_POLICY));
                if (amdgpu_sriov_vf(adev) && (fw_ver < 0x556600))
-                       caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(SET_UCLK_MAX));
                if (fw_ver < 0x556300)
-                       caps &=3D ~SMU_CAPS(PCIE_METRICS);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(PCIE_METRICS));
                if (fw_ver < 0x554800)
-                       caps &=3D ~SMU_CAPS(MCA_DEBUG_MODE);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(MCA_DEBUG_MODE))=
;
                if (fw_ver >=3D 0x556F00)
-                       caps |=3D SMU_CAPS(PER_INST_METRICS);
-               if (fw_ver < 0x554500)
-                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
+                       smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS))=
;
                if (fw_ver < 0x00555a00)
-                       caps &=3D ~SMU_CAPS(RMA_MSG);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(RMA_MSG));
                if (fw_ver < 0x00555600)
-                       caps &=3D ~SMU_CAPS(ACA_SYND);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(ACA_SYND));
                if (pgm =3D=3D 0 && fw_ver >=3D 0x557900)
-                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
+                       smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS)=
);
        }
-       if (((pgm =3D=3D 7) && (fw_ver > 0x07550700)) ||
-           ((pgm =3D=3D 0) && (fw_ver > 0x00557700)) ||
-           ((pgm =3D=3D 4) && (fw_ver > 0x4556e6c)))
-               caps |=3D SMU_CAPS(SDMA_RESET);
-
-       dpm_context->caps =3D caps;
-}
-
-static inline bool smu_v13_0_6_caps_supported(struct smu_context *smu,
-                                             enum smu_v13_0_6_caps caps)
-{
-       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
-
-       return (dpm_context->caps & SMU_CAPS_MASK(caps)) =3D=3D SMU_CAPS_MA=
SK(caps);
+       if (((pgm =3D=3D 7) && (fw_ver >=3D 0x7550700)) ||
+           ((pgm =3D=3D 0) && (fw_ver >=3D 0x00557900)) ||
+           ((pgm =3D=3D 4) && (fw_ver >=3D 0x4557000)))
+               smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 }

 static void smu_v13_0_x_init_caps(struct smu_context *smu)  {
        switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
+       case IP_VERSION(13, 0, 12):
+               return smu_v13_0_12_init_caps(smu);
        case IP_VERSION(13, 0, 14):
                return smu_v13_0_14_init_caps(smu);
        default:
@@ -715,7 +757,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_=
context *smu)
        MetricsTableA_t *metrics_a =3D (MetricsTableA_t *)smu_table->metric=
s_table;
        struct PPTable_t *pptable =3D
                (struct PPTable_t *)smu_table->driver_pptable;
-       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS=
));
+       bool flag =3D !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS))=
;
        int ret, i, retry =3D 100;
        uint32_t table_version;

@@ -911,7 +953,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu=
_context *smu)
        smu_v13_0_6_setup_driver_pptable(smu);

        /* DPM policy not supported in older firmwares */
-       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM_POLICY))) {
+       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM_POLICY))) {
                struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;

                smu_dpm->dpm_policies->policy_mask &=3D @@ -1088,7 +1130,7 =
@@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
        struct smu_table_context *smu_table =3D &smu->smu_table;
        MetricsTableX_t *metrics_x =3D (MetricsTableX_t *)smu_table->metric=
s_table;
        MetricsTableA_t *metrics_a =3D (MetricsTableA_t *)smu_table->metric=
s_table;
-       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS=
));
+       bool flag =3D !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS))=
;
        struct amdgpu_device *adev =3D smu->adev;
        int ret =3D 0;
        int xcc_id;
@@ -1101,7 +1143,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct sm=
u_context *smu,
        switch (member) {
        case METRICS_CURR_GFXCLK:
        case METRICS_AVERAGE_GFXCLK:
-               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM))) {
+               if (smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM))) {
                        xcc_id =3D GET_INST(GC, 0);
                        *value =3D SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFreq=
uency, flag)[xcc_id]);
                } else {
@@ -1788,7 +1830,7 @@ static int smu_v13_0_6_notify_unload(struct smu_conte=
xt *smu)  static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu=
, bool enable)  {
        /* NOTE: this ClearMcaOnRead message is only supported for smu vers=
ion 85.72.0 or higher */
-       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(MCA_DEBUG_MODE)))
+       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(MCA_DEBUG_MODE)))
                return 0;

        return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,=
 @@ -1933,8 +1975,8 @@ static int smu_v13_0_6_set_soft_freq_limited_range(s=
truct smu_context *smu,
                        if (max =3D=3D pstate_table->uclk_pstate.curr.max)
                                return 0;
                        /* For VF, only allowed in FW versions 85.102 or gr=
eater */
-                       if (!smu_v13_0_6_caps_supported(smu,
-                                                       SMU_CAPS(SET_UCLK_M=
AX)))
+                       if (!smu_v13_0_6_cap_supported(smu,
+                                                      SMU_CAP(SET_UCLK_MAX=
)))
                                return -EOPNOTSUPP;
                        /* Only max clock limiting is allowed for UCLK */
                        ret =3D smu_v13_0_set_soft_freq_limited_range(
@@ -2138,7 +2180,7 @@ static int smu_v13_0_6_get_enabled_mask(struct smu_co=
ntext *smu,

        ret =3D smu_cmn_get_enabled_mask(smu, feature_mask);

-       if (ret =3D=3D -EIO && !smu_v13_0_6_caps_supported(smu, SMU_CAPS(DP=
M))) {
+       if (ret =3D=3D -EIO && !smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM)=
)) {
                *feature_mask =3D 0;
                ret =3D 0;
        }
@@ -2434,7 +2476,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table
        struct smu_table_context *smu_table =3D &smu->smu_table;
        struct gpu_metrics_v1_7 *gpu_metrics =3D
                (struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
-       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS=
));
+       bool flag =3D !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS))=
;
        int ret =3D 0, xcc_id, inst, i, j, k, idx;
        struct amdgpu_device *adev =3D smu->adev;
        MetricsTableX_t *metrics_x;
@@ -2516,7 +2558,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table
                 * table for both pf & one vf for smu version 85.99.0 or hi=
gher else report only
                 * for pf from registers
                 */
-               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(PCIE_METRICS))=
) {
+               if (smu_v13_0_6_cap_supported(smu, SMU_CAP(PCIE_METRICS))) =
{
                        gpu_metrics->pcie_link_width =3D metrics_x->PCIeLin=
kWidth;
                        gpu_metrics->pcie_link_speed =3D
                                pcie_gen_to_speed(metrics_x->PCIeLinkSpeed)=
;
@@ -2545,8 +2587,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table
                                metrics_x->PCIeNAKSentCountAcc;
                gpu_metrics->pcie_nak_rcvd_count_acc =3D
                                metrics_x->PCIeNAKReceivedCountAcc;
-               if (smu_v13_0_6_caps_supported(smu,
-                                              SMU_CAPS(OTHER_END_METRICS))=
)
+               if (smu_v13_0_6_cap_supported(smu, SMU_CAP(OTHER_END_METRIC=
S)))
                        gpu_metrics->pcie_lc_perf_other_end_recovery =3D
                                metrics_x->PCIeOtherEndRecoveryAcc;

@@ -2571,7 +2612,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table

        gpu_metrics->num_partition =3D adev->xcp_mgr->num_xcps;

-       per_inst =3D smu_v13_0_6_caps_supported(smu, SMU_CAPS(PER_INST_METR=
ICS));
+       per_inst =3D smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METRIC=
S));

        for_each_xcp(adev->xcp_mgr, xcp, i) {
                amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask=
); @@ -2602,8 +2643,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct =
smu_context *smu, void **table
                                gpu_metrics->xcp_stats[i].gfx_busy_acc[idx]=
 =3D
                                        SMUQ10_ROUND(metrics_x->GfxBusyAcc[=
inst]);

-                               if (smu_v13_0_6_caps_supported(
-                                           smu, SMU_CAPS(HST_LIMIT_METRICS=
)))
+                               if (smu_v13_0_6_cap_supported(
+                                           smu, SMU_CAP(HST_LIMIT_METRICS)=
))
                                        gpu_metrics->xcp_stats[i].gfx_below=
_host_limit_acc[idx] =3D
                                                SMUQ10_ROUND(metrics_x->Gfx=
clkBelowHostLimitAcc
                                                                [inst]);
@@ -2711,7 +2752,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(=
struct smu_context *smu,
                return -EINVAL;

        /*Check smu version, GetCtfLimit message only supported for smu ver=
sion 85.69 or higher */
-       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(CTF_LIMIT)))
+       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(CTF_LIMIT)))
                return 0;

        /* Get SOC Max operating temperature */ @@ -2816,7 +2857,7 @@ stati=
c int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
        int ret;

        /* NOTE: the message is only valid on dGPU with pmfw 85.90.0 and ab=
ove */
-       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(RMA_MSG)))
+       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(RMA_MSG)))
                return 0;

        ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_RmaDueToBadPageThreshold,=
 NULL); @@ -2830,25 +2871,13 @@ static int smu_v13_0_6_send_rma_reason(stru=
ct smu_context *smu)

 static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_m=
ask)  {
-       struct amdgpu_device *adev =3D smu->adev;
        int ret =3D 0;
-       uint32_t smu_program;
-
-       smu_program =3D (smu->smc_fw_version >> 24) & 0xff;
-       /* the message is only valid on SMU 13.0.6/12/14 with these pmfw an=
d above */
-       if (((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0,=
 12)) &&
-               (smu->smc_fw_version < 0x00561700)) ||
-               ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 14)) &&
-               (smu->smc_fw_version < 0x5551200)) ||
-               ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 6)) &&
-               (((smu_program =3D=3D 0) && (smu->smc_fw_version < 0x005579=
00)) ||
-               ((smu_program =3D=3D 4) && (smu->smc_fw_version < 0x4557000=
)) ||
-               ((smu_program =3D=3D 7) && (smu->smc_fw_version < 0x7550700=
)))))
+
+       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
                return -EOPNOTSUPP;

        ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                                SMU_MSG_ResetSDMA, inst_mas=
k, NULL);
-
        if (ret)
                dev_err(smu->adev->dev,
                        "failed to send ResetSDMA event with mask 0x%x\n", =
@@ -3167,7 +3196,7 @@ static bool mca_smu_bank_is_valid(const struct mca_ra=
s_info *mca_ras, struct amd
        if (instlo !=3D 0x03b30400)
                return false;

-       if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND))) {
+       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND))) {
                errcode =3D MCA_REG__SYND__ERRORINFORMATION(entry->regs[MCA=
_REG_IDX_SYND]);
                errcode &=3D 0xff;
        } else {
@@ -3456,7 +3485,7 @@ static int aca_smu_parse_error_code(struct amdgpu_dev=
ice *adev, struct aca_bank
        struct smu_context *smu =3D adev->powerplay.pp_handle;
        int error_code;

-       if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND)))
+       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND)))
                error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank->regs[A=
CA_REG_IDX_SYND]);
        else
                error_code =3D ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_RE=
G_IDX_STATUS]);
--
2.25.1

