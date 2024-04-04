Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3F5CD1284
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Apr 2024 07:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99431112CE6;
	Thu,  4 Apr 2024 07:35:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IHWWcsIb";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2125.outbound.protection.outlook.com [40.107.92.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB4F112CE6
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Apr 2024 07:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfzpAqOxqJeuAgaHvmUSADOGBrCEFVvXq441PDCVEFzQxEYmIKbNbBHb/BQcLaCQ295M+SvDq26TVoXpLfvTZLfau/enyHcWvVz2wXKv8ahzqvD9uUXq4zzFPG8yjpspLfsCxXKEKNQC/qBBP/ogxTdvdZECJtL7q4tWyN6RZ8aAuzCRpZFeRye+y247luaUne7dJhGN8yLBCSZfHW9PlBpWAEMUg28zMHUgmdRSOCYVC2IVL3roLMTmTW+2fCwoYnyZ/jLq40ox7O7xvp09T3fKxwO9D7NN/aA7FMIJJTG9nqoYV7Dlq+Wyzm4TlWA0c7LTIhwqUQ8CIlyGuXJ5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5kSK/pBqjXHr4SY0+C5Ak8xoFdzmON5CkGT/osVnaQ=;
 b=JTrmvNUPt7SxNxsfN6EkAPzkKFxn/YMTvfvl23QFUhSNDEAWJqAzK5Xv96TZkGKlwCJA1X3mRDJt6OsssRkCH1m7kl+tWaTt3cx2SR+/zdOKdvRM5g4fft//1rXFMCYaqZuCaR52h6+3Vz94eAjutU96ahu9Y/LGaxS35HSw6QR9R1brN8j+5hy1yC6JbsmkeDXH17TDT2lM6r4FTswjUR1LwNOm7YSuc+TVm0WQ1Fh9yvWmhnuOjt5mmw6b4bNNbHx/F0UH5a6gVyPW9WFVT5FyDXZyzQ36Hi/r4XnbHqrf3M6sbr6Q7eLX8JA0vPExGmSWotnbSM628uLHfNYUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5kSK/pBqjXHr4SY0+C5Ak8xoFdzmON5CkGT/osVnaQ=;
 b=IHWWcsIbvCOxT0hHuEqf2QL8hFj4JBCZiE9IOLgBaCbEtuiRA+lB4/Pqa9bFLZms4I8PV5rDkHbfydBh82fwXNpUkx4+62KObYOh8Sd91A6BHAiJu/psm5K+9TwV79BTb2QUTI6gGO70keb3Zp9q+QWdwRvEVChxYsCzaKeebvg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB8606.namprd12.prod.outlook.com (2603:10b6:510:1ce::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 07:35:41 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 07:35:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Allow setting soft max frequency in VF
Thread-Topic: [PATCH] drm/amd/pm: Allow setting soft max frequency in VF
Thread-Index: AQHahlzFFWRbTuk+NkyN0rOiIuQWt7FXuJNQ
Date: Thu, 4 Apr 2024 07:35:41 +0000
Message-ID: <BN9PR12MB5257EBCB74313881B250C607FC3C2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240404065256.47765-1-lijo.lazar@amd.com>
In-Reply-To: <20240404065256.47765-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9fd72544-f3b6-4695-8ce0-c86567aee17a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-04T07:35:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB8606:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GQLVwhK7mWb7wHsucjnNJjwq5Zu9pk4lO4r75CtmvdrRheV7rMU0ib/bwv67Ih6DSxt+yLlndPIln7D3N9Ar3ZmyBJ/Evt3UQBjG6c6ymUP7zadzlOk7SLpCnS6KsZ294JkkaE43ZonYTErLN5e9wuiXvJX47B3sDWra8x5ySXymVA/hdmRvdHagExFgT3lhrbxCYMS7aDHpenban1067/p933ygTdPy6ZOJfKZaiyulR2YTtiIUlj0UazRC7Hlp/9uEbOAl7elEPW+XCa1XpEEo223W5ylUaJlpSeF/8+I/1t6BReC9b5lYCEda/jumFCNEPVZp/n7pR9p/4CYsvQwQSbNVLNBdeOunvk4iUGIjMwQUcBjNLgl01Hu7X9WTeGDs7hLpL44evxg3X+kq5u2j+q3bvfnm9Ae+rZjRmpKYt+O1CJybaYp+HIw9nYaSqLAK5Ri2iZd8UaWqmxET78FiwVJrTrV1gmgDb93U1WotDSqb7LbJhNMArACsRsN3KlTEvt7pP2PQEuKpQukGSKgE29pTnFnX0HmFNjYP+dS/gldVny5I+X6nI86fKW9VKb47Tw92YEOd34vijWoXDJVCP1m0ATpYCmLZm399tYMujL/s4bVlkCQqOQYGN3Wn8FSRQdrJNwFqI1P5UbCJLl1liwcaCkpDuslGcob41o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mpYWeoUG7+SJPPfxoOwD0F7r1ikkdC/3G02E1R5TB2OJu3ZMzdsmWkqkUxVk?=
 =?us-ascii?Q?kt3jBTDPiStEecaCFAoMOHwZUyFbF3OyXwvxz6n1EEsiGS2E1s1YqSuDWscj?=
 =?us-ascii?Q?s/RsIpiDAvzMYWFgN0ZktVBjz18nfuaVUD5k+VpvHHSUpzUgXTwcIvd1JGIT?=
 =?us-ascii?Q?UMvIW/MzC4pixifmOJIBuIn1HW4Mm2G8X5EUYJhIxa99KPkIktcKNB5pYhB7?=
 =?us-ascii?Q?nHZSvC2kN6YKCbqEfgo2MwL/+Z5Aku0HxDtEC8QVQip1fgAswGzmeVDzayvV?=
 =?us-ascii?Q?3537UI90OSnScay1UoiclRC9gffownFBOZN9HGvi3Fvx6Ob7iYuYjBIT0Et2?=
 =?us-ascii?Q?fLfEpRQDhl8jdpIUaJleQhobVNVpT/rouYDwqv8TKHdyfyEGL1ibC5Ov2NHs?=
 =?us-ascii?Q?P4gfXYVJv73UlNyeOi2BJwwkIvOCxPYEP2WZqK7GtbUP8ZnW0AM4kUxxLQUp?=
 =?us-ascii?Q?7GXzLs43YX2OHN/7mavpU1vXLOZT9jXaAsdfnCRNLnMu7/IGtt64OCY2k99W?=
 =?us-ascii?Q?Yb/t173i7YWqprykCCbsZss1pqW46enBkwsFbEZkTKI7j050x8VWWAOmFiYj?=
 =?us-ascii?Q?a1rWHn2oJtieTyN+EI55Y20Fd00GAO9nTOwz15fweApoMlX1XZF/hjA2Ol8I?=
 =?us-ascii?Q?OyWnQaPaExBbOGkOKluaZXUGA7BW027soTufPQhSGK7v+6n6Aq3whLjenASB?=
 =?us-ascii?Q?NTRJC5E6+SzIvVhKEM0Mx/pwF40mrbyeXnKxG9k+E5d31y4iNNofp3VWFE8G?=
 =?us-ascii?Q?pSNfVniZvclCnBMNqaFqo9OZJYIjcVDphpgHKcG6q5XmmF6u8l8WYUqSackV?=
 =?us-ascii?Q?ir6G336yaXr1pdodGdHRjbWHnNXJF1+s2bKWMFelVdzThN3DHTlS234yqD3/?=
 =?us-ascii?Q?GiDKiMcDqEQNeXy5TlCeuajfaV2hYIpgFCHi+0KBI0Agu/Nb93fX5raPwEfH?=
 =?us-ascii?Q?YJmPq8JwRMPBy4Pm0GXMs9JBiMZQEQSN6uqxXK6BdTkkjWwyoemXOTszYId4?=
 =?us-ascii?Q?OrLSp0VM5joW8OWoOZ/XUh5qt5U0yDdLH+6F7tSGc/2GYAB7OESDptqITt9f?=
 =?us-ascii?Q?FrZJjOcSh6CbdPMEtXptxNYlXN4+uRsTG9On1YV5EGchF/mkQI13Mp2uAQge?=
 =?us-ascii?Q?IkRQDWbZPudfspWnpw5yjeGBQ9v5Q/AnqV7qlougnWiIDw2jNY73PLKEMiy/?=
 =?us-ascii?Q?qHnIfeCGMPtwsaKIKZyG8NZX4/90gwYCpk1mDjwZwf/zKE1AmWJxLkPzDG10?=
 =?us-ascii?Q?7JWpPS8waKyUh47oz1fjEWgYxYn9Dktc6PEE2FYRhsD3uChydceJiiXIeyOa?=
 =?us-ascii?Q?ymM+Wg4vBHU1vMrKJFAuIJ91cDa10UH5Ga14m0I3g+o4nV6vMS5HWvt76uXf?=
 =?us-ascii?Q?ssfmo3v81eBoQ+UhgD/Hzeq2UeXt7hryENlF+CP44VjISRmnPeyCj1Ws+a9v?=
 =?us-ascii?Q?yGZwJNGv/+SDdOwqbYwZBJrNEPdS1wcRtfzuMycwwr/s/Q9QtHHtecrddHAO?=
 =?us-ascii?Q?q3q9H1S8T2sdEriOMfK8ICrcIm+tP2AnsBp2qsZTQMBRtXX/MG0BPWKw8Pyk?=
 =?us-ascii?Q?P062mRi4dfTkivwYEz5PzjrwjyfuhHRe2HVabs6G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214af686-5cc2-47d7-44d2-08dc5479d4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 07:35:41.5262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/wQ8Z+IohnwzD8Vvp5fPyInNtccXVAhSJ/a6a7+g2WlPUXLstIbskXURuAKp5NVmJ+WwtpNqP9eYjjCcQZUqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8606
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, April 4, 2024 14:53
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Allow setting soft max frequency in VF

Setting soft max frequency for MCLK is allowed in 1VF mode in SMUv13.0.6 SO=
Cs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a09c89b3db96..d6d5be26e222 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -138,7 +138,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(SetToolsDramAddrHigh,                PPSMC_MSG_SetToolsDram=
AddrHigh,            0),
        MSG_MAP(SetToolsDramAddrLow,                 PPSMC_MSG_SetToolsDram=
AddrLow,             0),
        MSG_MAP(SetSoftMinByFreq,                    PPSMC_MSG_SetSoftMinBy=
Freq,                0),
-       MSG_MAP(SetSoftMaxByFreq,                    PPSMC_MSG_SetSoftMaxBy=
Freq,                0),
+       MSG_MAP(SetSoftMaxByFreq,                    PPSMC_MSG_SetSoftMaxBy=
Freq,                1),
        MSG_MAP(GetMinDpmFreq,                       PPSMC_MSG_GetMinDpmFre=
q,                   1),
        MSG_MAP(GetMaxDpmFreq,                       PPSMC_MSG_GetMaxDpmFre=
q,                   1),
        MSG_MAP(GetDpmFreqByIndex,                   PPSMC_MSG_GetDpmFreqBy=
Index,               1),
@@ -1676,6 +1676,11 @@ static int smu_v13_0_6_set_soft_freq_limited_range(s=
truct smu_context *smu,
                if (clk_type =3D=3D SMU_UCLK) {
                        if (max =3D=3D pstate_table->uclk_pstate.curr.max)
                                return 0;
+                       /* For VF, only allowed in FW versions 85.102 or gr=
eater */
+                       if (amdgpu_sriov_vf(adev) &&
+                           ((smu->smc_fw_version < 0x556600) ||
+                            (adev->flags & AMD_IS_APU)))
+                               return -EOPNOTSUPP;
                        /* Only max clock limiting is allowed for UCLK */
                        ret =3D smu_v13_0_set_soft_freq_limited_range(
                                smu, SMU_UCLK, 0, max);
--
2.25.1

