Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64891C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 03:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F172D206BE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 03:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lPSW8uaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F172D206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0D66E199;
	Mon, 24 Aug 2020 03:12:32 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750049.outbound.protection.outlook.com [40.107.75.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 146116E199
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 03:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBet2+lvIiHz4mm02CMDoSNwuWtoGMCKBrQqtFxKT/kJGYMKaI7LjXH9c+QB9ydIY2wNdsy705pdVTfWFToSjRtqEVroeJTwZ3AlAV1UDk7H7Sx4fyPjoxIh7Q0VtyNAOnztOBIe3jHUSTbEo1hB2RN89YmmdiEsDS/rl+h9qJQLsoxyBq7b/qiZDon0rbw5POFQt1xk3Zz5nDBbyrY8Fkdbfoxm73LaBwjjxP9M3JKlDj0pl0tUanfML6ihtbUHrtc+zgXJ/E7c5xk/HDU+mhyWAKF7LD0p07kqw1WUwQ6BAXF5aLclFFhZZIEJemSPOg0Uf0fBOINOQHCwwGX/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyRfYu1Av+GCin5kUQnDu8ugffs+l0MBa1++1ALZ5ww=;
 b=euX9xj/LBDLsmy9zr0F5v2490ZguoJOP075ufxl7YxBYvR2RlnGRqZxJopEBElIw5U0Cb6cry7UTXriALVaROh16+OfyAc3hdyFCHsKzkKPpFqJAqr25unXEWXtLsMF+Nfzer/Y+Eg9nLLqn78niVWQxQzYZjS4sOYbbuNbljy4VmyxskHwI+r/hTYJZNNwW+DSN0VLo2hyrSsjDqFs1wz8trRXUnn+Zg2NwZUx6caMnx2Ce07J+Go55+ibuf23/Sr6MUPSx0rQNubUnOcTyoiTXuq6uqzviqFdaQRNfAKcGLweRSc7eRk+Jke1v+QSmw1Zd9FxVsC+g85CGyuv7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyRfYu1Av+GCin5kUQnDu8ugffs+l0MBa1++1ALZ5ww=;
 b=lPSW8uaAmkwg40kXpWWtauKlzTDlqyEh0sN9UbXxKWPUfovSllU7dqviufNPOKRWL+rROLjY4hfsbMrBoYYuIGpGuAgsFVwvl2RFTn5Nv4Cb9aYTFs382aYPfOiXMvzJt1cf6sWTRQlXw+pQ029BiDr3iPYsIbEARv4RC3MT6g8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Mon, 24 Aug 2020 03:12:26 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 03:12:26 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: Fix hardmins not being sent to SMU for
 RV
Thread-Topic: [PATCH] drm/amd/powerplay: Fix hardmins not being sent to SMU
 for RV
Thread-Index: AQHWd9A6lg3o0HL+d02mvlKkGl2muKlGmRvw
Date: Mon, 24 Aug 2020 03:12:25 +0000
Message-ID: <DM6PR12MB2619DF60B3D8AF3297D350A4E4560@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200821153145.498408-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20200821153145.498408-1-nicholas.kazlauskas@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bd657f90-c18f-40f7-a5fd-f4910eaf601f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-24T03:12:17Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53e4f20d-9fea-4a51-40f9-08d847db8703
x-ms-traffictypediagnostic: DM6PR12MB3370:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3370F4FA4AFB34FE7E9BBF72E4560@DM6PR12MB3370.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E85hs5zFb5ZZRVLfHzLqphxyCyEvu4iqbdMMsYJLIf2quiKdCG18fZIR+tgKVMuf0nRm7GzT4JZn7jVD9+mF/1gdSg1cdP7eLOrC5YJQ9/TNRCKTxJLRsLf6+5q+jQ3cj5rxinQ9ohLxQep+Vf5DS1OHH5Ah2RXE/uQG0pT5g4Yg0bTUEsq7/lS1NbixRdaPvOcby4Gf2s+m+8bt/dc8yn0ULgwFmrMn+Fc9Ck4uUfzS5vy4zIGkbvi8misl6WkS5NTZgnA6jOIy+TfXKaFdZawT3sDemQdTph25zhA+ucLGyAINB2XtFEmVgDFuj4sR+8CHj2Pgkx6OQfPVR3IyN+FeUWuf7JfwF53AP6ZyCvM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(53546011)(55016002)(7696005)(2906002)(6506007)(966005)(9686003)(478600001)(186003)(8676002)(71200400001)(5660300002)(52536014)(86362001)(64756008)(66556008)(66476007)(4326008)(26005)(66946007)(316002)(33656002)(76116006)(54906003)(45080400002)(83380400001)(66446008)(110136005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 9JEoPLMFHcg2h4GiIpRkR4Pw8Kup3eyC6GwkYuHP87baX1zgmfGw6ylgGPFQU2XlTPysIz6firmm9q4SF1+OeeZVeMUegkYh79pmwNyBO9B0P77dCEyX8E89rkk0GEMAaNYJTj3wEvhUrv6q6oIYB24Mr9EY/P8yUC0GMbiHwygg2NX+FbmD+07O5KQco2TO/93UqrGufp8H4Hlkj0vSr/zRxy2vhneLPW/gHbgbwRAB3RTI5aNtnDKldW8IYsxh3mJXfksS6Gaae56uBMvSPdjYQQrRerSkGkuOi+UeEbX/NkPLQjeeqM5uXRu10xlZZcFNkfxDi/kg1ghxAmhqpFxRkN54IN5Qt5zDQJrjV+AFl/D39xU3so/k0pJkY5mkoNBPEdI/jp0Q+yVbehIgCpvsP8k5C3BXREXRBbIw8qavEuPsi80d76mwds1C2E/ysqqqRf0lvrD51PbCGcR2O2UxgnqwxZvrKQQONO35ZYr43EoSn44SChYZkbe8P/9JFHaw4fJhE/4RtBQfoiOxtCocVjkir7Fq0tStS0se+IIwmBL4WVF+GKl/j6mWEacdiV5vJVqDbZeMUTdt/Vl10gD72uDBcdpNxZRiY6Kc6uS33dTX1+HYcIHDMcgiJdYT03uzl0YV3dnrf3HjZ4lRZw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e4f20d-9fea-4a51-40f9-08d847db8703
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 03:12:25.9473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: si/e80q7LPqgQZKGjSds2/wVnxGfEfy4euQgrpiB9lQIlRo7ZxoHM3e+O7scj7XO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3370
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
Cc: "Wu, Hersen" <hersenxs.wu@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Nicholas Kazlauskas
Sent: Friday, August 21, 2020 11:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wu, Hersen <hersenxs.wu@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH] drm/amd/powerplay: Fix hardmins not being sent to SMU for RV

[Why]
DC uses these to raise the voltage as needed for higher dispclk/dppclk
and to ensure that we have enough bandwidth to drive the displays.

There's a bug preventing these from actuially sending messages since
it's checking the actual clock (which is 0) instead of the incoming
clock (which shouldn't be 0) when deciding to send the hardmin.

[How]
Check the clocks != 0 instead of the actual clocks.

Fixes: 9ed9203c3ee7 ("drm/amd/powerplay: rv dal-pplib interface refactor powerplay part")
Cc: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index c9cfe90a2947..9ee8cf8267c8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -204,8 +204,7 @@ static int smu10_set_min_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr, uint32_t clo
 {
 struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);

-if (smu10_data->need_min_deep_sleep_dcefclk &&
-smu10_data->deep_sleep_dcefclk != clock) {
+if (clock && smu10_data->deep_sleep_dcefclk != clock) {
 smu10_data->deep_sleep_dcefclk = clock;
 smum_send_msg_to_smc_with_parameter(hwmgr,
 PPSMC_MSG_SetMinDeepSleepDcefclk,
@@ -219,8 +218,7 @@ static int smu10_set_hard_min_dcefclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t c
 {
 struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);

-if (smu10_data->dcf_actual_hard_min_freq &&
-smu10_data->dcf_actual_hard_min_freq != clock) {
+if (clock && smu10_data->dcf_actual_hard_min_freq != clock) {
 smu10_data->dcf_actual_hard_min_freq = clock;
 smum_send_msg_to_smc_with_parameter(hwmgr,
 PPSMC_MSG_SetHardMinDcefclkByFreq,
@@ -234,8 +232,7 @@ static int smu10_set_hard_min_fclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t cloc
 {
 struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);

-if (smu10_data->f_actual_hard_min_freq &&
-smu10_data->f_actual_hard_min_freq != clock) {
+if (clock && smu10_data->f_actual_hard_min_freq != clock) {
 smu10_data->f_actual_hard_min_freq = clock;
 smum_send_msg_to_smc_with_parameter(hwmgr,
 PPSMC_MSG_SetHardMinFclkByFreq,
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cfb748092bae64ab5310b08d845e757fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637336207270141080&amp;sdata=Fx4uvt6aq66As36HOBIIkGzMmIOS%2B2JbEpQzSGC6RfE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
