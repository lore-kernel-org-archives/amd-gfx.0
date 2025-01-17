Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E831C02185
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 04:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B188810EA35;
	Fri, 17 Jan 2025 04:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m+onRET+";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D1310EA35
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 04:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqAgf23PiF23PH13pIltrHC09SUv4keP2042S2Q6EJKJNDwponQZDZ/k9JdzehED1CUEQZ8CJjGyF3yBoM91vmWSfBWHOHgau2899Y8sYpC/xFstrsP6nM3ST9cRLbY3vITg2DuA/FaUb5wmFc9NthfRedxkDCTXSx6YoQ3338tyAMoPyx186zv/s70zCXXCCVR+tGqdF/M0uugVR2mGUWws/nKBzgX1ovoWBO1Ruce+q+mDNNaOxz2vlAKb2GFmCV+zEONRWtxrxvJQJy7zDfzLpTM+wteH5b+EBUKsIxArkD1QcXRriwJbZ0GvCtu/aDQN2MYTIkfpE4DzFKbiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSBFUdwQhr4zpwlg8qp1T1exjtxgyCnNBfrPA5N045I=;
 b=oPTqBfpXxtpjjNeCizKw78TGuImBeVKB7Q2pYtNre/+fMtBq4r0Nvq+CA+f33IJP95FGpBGzfpjMerrims1mZ+yVTz2yOMs8l6h0z7XzxXPXqOk187uON8VPKCDd9lMHcE88dFTzZ4FOlw7YaAbtKYlq4u5m8iv0hADhyI6P7rl++UDy+kJ3+v1w1/kPinG/5uStUoTk45IAd5mEZ/j/EicpoHE/jAZ+kTkzrmCLsAlcyt9nXo/85yA4mWlg4xWAcG4awI1YvzNcDr/ApTtuA8QD4MHpA+l+U9SKXArHCxln/OnQjDnVbXTqxbY9X/HAHekPCId4WSHnOkzxaceISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSBFUdwQhr4zpwlg8qp1T1exjtxgyCnNBfrPA5N045I=;
 b=m+onRET+P6aP0lkmaT9acQ2DSr9Ga0TMwZazFVggUZwfl27TILd1n9259n7jUALvoiqiQpy85JOzC7LykXqKwwiPCa2glkAIU2/FthWGozxZsd3VW4gUwwvKBDtjkbyJ6e4a0pfN97PInnuy+Wwefc1QAp8PL/LpCQ6VH3tmJYw=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 04:20:26 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 04:20:26 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhu, Jiadong"
 <Jiadong.Zhu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH V3] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware
 version checks
Thread-Topic: [PATCH V3] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware
 version checks
Thread-Index: AQHbaIz0UheL3ifmP0K3wfRQVE9rNbMaXJZg
Date: Fri, 17 Jan 2025 04:20:26 +0000
Message-ID: <DM4PR12MB5152EE3B87F48FA675DAB0BEE31B2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250117030716.3835090-1-jesse.zhang@amd.com>
In-Reply-To: <20250117030716.3835090-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b2818ae5-b527-46a9-a7d6-33f0e52acbb4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-17T04:18:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH7PR12MB7819:EE_
x-ms-office365-filtering-correlation-id: fc83e405-a918-4a16-65b2-08dd36ae44cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9phocCv/mvnCK6xVoUgrlQpYI81VjnHgwzx/jXopktAN0M3SxnPmGqftXVe4?=
 =?us-ascii?Q?1E0NqGwhck6gPnz9WwXRcMduegQlKs47JZZ2FTVx4hdB7nZMzfwblbLdPe4W?=
 =?us-ascii?Q?C8MvBIzgTSPBsGeb4+C9tNoDsydnqftTJGJRzwxekVJRdRuOghcV6EdCeHWu?=
 =?us-ascii?Q?KAhLMp7iTC0eyRn/L597l7xXdxmF7/VQockmRYD6Tc4hgmUwMEzAQ3JC5c/w?=
 =?us-ascii?Q?qbiK0wFiftHfLXgfMX4xHL8S/icbY5OLxqwZ0Ar6/rVkrcdsHVrIJq2dxrAO?=
 =?us-ascii?Q?7A0NnMcaEkBWf9OeXze5Vwl/w+X1NyZjjDRe5nHtDyxjjQufzfDkvCZrp9lG?=
 =?us-ascii?Q?3asAAe8eBWEY4TQVFYJbKNhefMrm+RJN5CtQQNds9VtCGNkyie98v52j+Ytc?=
 =?us-ascii?Q?4aW/8BQfebRgHzdEYwA1D7auXmsm+UgEmrf2CL1ryLY6vg8jvTXx0k68qVRd?=
 =?us-ascii?Q?3QLLcEGeMP7TGn+Igt87ckTX15glvLPaOK+pzsJ2jxfzWHL28vWyWBXbJXV9?=
 =?us-ascii?Q?3YUd6++fdmqCC54KHOXRYY3xAFEZDfbhpQ8CKx+sKOXNsBORJU0JRK912LVy?=
 =?us-ascii?Q?usCaB0m+rnMOsI9OEnRykn7t72QjzBJeXPFXoVx4AmQaT386+9PHW/Gv4KBu?=
 =?us-ascii?Q?AOq4sbce7YNjOZEJKUveGqEglOeiaWFRWaAAB3xXuP1cpco0PDDUurMP4z5v?=
 =?us-ascii?Q?JgnRT2x1Ak3XOu8/z9oB6ZgcjR6V5qlibKdSgY+qEQXQWDcpzZMV62XQ05UL?=
 =?us-ascii?Q?NOnWQuYjLXAq1MHPM7SvqeOqxq0UT7PNw52ccLnOmluxRGIrF4QsRdX8vJDc?=
 =?us-ascii?Q?8e1FZb3tymv8o03D+ZtPoqSN+PFNapCr+eQvz1wKNMzVJMLsV4/nPzPKH+LS?=
 =?us-ascii?Q?qLLpZf85XGS0CueyvRylTklovR9tKDwfeejpwCqRlVF9EkT4DJKjmn6q8doO?=
 =?us-ascii?Q?IkOQ3ZADNdn4akvEEmJIJwl0jZxDAT6zeioKelmejh+2aOUGRy+EUsjzjo1D?=
 =?us-ascii?Q?OLxlcL5gZb+6qCucfcjY9ho+Pd/k97kfKACPq7nZJXnrBOkaQazf6lNDrZbQ?=
 =?us-ascii?Q?Mwj+M0/3/c2cA1l/B77WHU/zMh2Ln++hGkG8nWxszJ0Vr2/1DSrkE2sZH+3C?=
 =?us-ascii?Q?WMT+5c2/oLRkUBbA5LQnewODNEE/R1gtL1zWOVC6Zez2dcd8kZj5S5U2aBAg?=
 =?us-ascii?Q?WRqTq3rAjobrV0ephRWXjC2ZSVKvOTxrczbhDJEDC4yLLqlU02pqTo0aw8fF?=
 =?us-ascii?Q?LfkME3oO3ttv5XIQS+2f7MI9dvPCNZ+VuDO/c/2sP4TibzI2hOQFOwov+Vlu?=
 =?us-ascii?Q?mJlUOJjaVS1jSO1uBX+FWSbqym0/azrxwIYckIWzNZg3sVsLh1nmM6axSSDB?=
 =?us-ascii?Q?e3Wwj7G1rtuhKXPq+mGU1DAjPXF0LfYNwCGEwHLHnBsb119Cf841LxfbjyDD?=
 =?us-ascii?Q?GJZGwj4q1b0bxvh4SeUyPOjwkuL4bUiH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BNr9ghf0enw7X8ratw+dmgL+DS0BIsxAVwvvqc/9RDRD3WPAuvEChU7evUs1?=
 =?us-ascii?Q?2AO362AKJU9msWTW1OyLPaNzairsAFYFoscVNWHvC2WmrbUkLYJhi9JYoPEf?=
 =?us-ascii?Q?Pg8EmMh+j/AxMGAavU83mU+uPFM9X0bVFd8SjUOvvBkvNQn2fk2t1RCiAzkg?=
 =?us-ascii?Q?xPGUCbW/WlMvU5Us3X2embCHqk02RH2pdJbeg/75T+40Zmw6uf8TKsTtjzYS?=
 =?us-ascii?Q?u6K6nGRGr3csjUh/SObs6yRAchguAwAoRtvFbkeTusONMBtk8vROD4JEArGj?=
 =?us-ascii?Q?0MDGJ9H8595BkQrl3Erfa4xa1TN014LvI+1qU/qf6AUHc61o4if0oTIM73rh?=
 =?us-ascii?Q?S63YIVbDrsqaT3WsMsoGzGoT50gO01R5jdFnVTZrISQ5OxstkubRIvtWUYS3?=
 =?us-ascii?Q?O1Nz+MI6VfItRMpC+TzE3HIcAbxy3XAMTSXQ/kye1DsUI6DeeB4mSgZ8+NNf?=
 =?us-ascii?Q?SxmQ7CZozV14GiEXtyTU16GYaC/eVVOzkSXVRor87YmujhgH/66GqXJyUlhE?=
 =?us-ascii?Q?0wZWU2kiCa4/jviLBRztj7JAw3Dnxk0ErSYpc4nOQOO06myUpf7DiIbOec2Q?=
 =?us-ascii?Q?fCJXU2gsivFstNDF1y9c9DQhgxv7E3NqedaBPnN7H3zZmiXB8eBykSRsvgBU?=
 =?us-ascii?Q?PgdWsktTnrgdgTEyo5vDBYbpYDjLsDGkLGlUsAdtr5A+xQodLxmQzEktQvZm?=
 =?us-ascii?Q?jWG7ZdUmtIimSfsP/sBRc9ffkAkI4XmuFf+DLteRV2XjrNnTInYWbYwQWkpp?=
 =?us-ascii?Q?ZYVT+38Ino7DIARaOq76uN2HSJYnSZB+/txjqnViRYi4XmIT5zwoN47revYF?=
 =?us-ascii?Q?fSHb8sJshEOahool4CT4NB8FjOsSXkN3LUJv9OIr+lwsP6W6Bwka1xpNUP1h?=
 =?us-ascii?Q?jsbEpbaWkqVM5WkAauCIGZYVMhFWV/I5+qxMznzMMvo12Rsa7jJWnWkVwm2I?=
 =?us-ascii?Q?Hyh47xUXC2/MBSum8Itocr+k8kPbWVtBZhmvaw3jkRVlGCZJo+aTD1ZNamK/?=
 =?us-ascii?Q?raqAPjz9NzSjLoYeC7NiiXMYanlS8U6tWvEEVF8SSOCuB2GtcswonisGcdyh?=
 =?us-ascii?Q?DMC9Tjt2CvRf9LYNHfwmDoFhLkeWQt49EQ06f/BO6NB4dGf9dzJ4Kp9587PB?=
 =?us-ascii?Q?PbQRebcV+FxdXLzOsufjFzZQ14f5bgeVnX3PHLP+IE3uqQuPNdZJkiEITLZw?=
 =?us-ascii?Q?fTs8DqKn0/+1/BUkaEQyLGmI7Tgo52LByhWaoJGl1lLdU4W/UaV8zVYCY548?=
 =?us-ascii?Q?XI21VdNcohIVaA1jeGCZwu7txaD/hRqRulId3WZi3wYRoojAzbdFCgFdKv8F?=
 =?us-ascii?Q?rn0K71BCXwYvh1XEbaaTDF6o90jd+fWmN0VTQaO4mcC90+eBjczMKFh3uSoP?=
 =?us-ascii?Q?F1kszCMnGP/eKtoCm1YAgg5p0TXoz2w0n20xQqHoVGvrRIe1SHCk9tohqK+R?=
 =?us-ascii?Q?RsxaKsTksrSGVhyF5qnJf0QCnpQ++0mE/8ARaOIZxTfR7TwzDUh6cWy5rpAj?=
 =?us-ascii?Q?vlgIaJONE1y0ngOxkQ7dUNMFxLDHoLiOtGFLHwqjbA8Dc8lMZjJGMmsK1ToO?=
 =?us-ascii?Q?s8uljBB4J2uSIePJ73E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc83e405-a918-4a16-65b2-08dd36ae44cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 04:20:26.2435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSHvOqF4tRW/BI0qPeSNmBPh2ujRQ/Zmg8erz03WUB28YPa75lHDAWRvY5D48irhvsd/Mo+TT2qwVjg0xUcMwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
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

Please ignore this and a new version will be updated.
Thanks
Jesse
-----Original Message-----
From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
Sent: Friday, January 17, 2025 11:07 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhu, Jiadong <Jiadon=
g.Zhu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Jesse(Jie) <Jesse.=
Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Deucher, Alexander=
 <Alexander.Deucher@amd.com>
Subject: [PATCH V3] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware ver=
sion checks

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch refactors the firmware version checks in `smu_v13_0_6_reset_sdma=
` to support multiple SMU programs with different firmware version threshol=
ds.

V2: return -EOPNOTSUPP for unspported pmfw
V3: except IP_VERSION(13, 0, 12) which is not supported.

Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 35e2f0662fb5..591466e90f8b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2746,12 +2746,23 @@ static int smu_v13_0_6_reset_sdma(struct smu_contex=
t *smu, uint32_t inst_mask)  {
        struct amdgpu_device *adev =3D smu->adev;
        int ret =3D 0;
-
-       /* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and =
above */
-       if ((adev->flags & AMD_IS_APU) ||
-           amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D IP_VERSION(13, 0, 6) =
||
-           smu->smc_fw_version < 0x00557900)
-               return 0;
+       uint32_t smu_program;
+
+       smu_program =3D (smu->smc_fw_version >> 24) & 0xff;
+       /* the message is only valid on SMU 13.0.6/13.0.14 with these pmfw =
and above */
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D IP_VERSION(13, 0, 12)=
 ||
+               ((smu_program =3D=3D 0) && (smu->smc_fw_version < 0x0055790=
0)) ||
+               ((smu_program =3D=3D 4) && (smu->smc_fw_version < 0x4557000=
)) ||
+               ((smu_program =3D=3D 5) && (smu->smc_fw_version < 0x5551200=
)) ||
+               ((smu_program =3D=3D 7) && (smu->smc_fw_version < 0x7550700=
))) {
+               dev_err(smu->adev->dev,
+               "ResetSDMA not supported: SMU program %u requires PMFW >=3D=
 0x%x\n"
+               "Current PMFW version: 0x%x\n", smu_program,
+               smu_program =3D=3D 0 ? 0x00557900 : smu_program =3D=3D 4 ? =
0x4557000 :
+               smu_program =3D=3D 5 ? 0x5551200 : smu_program =3D=3D 7 ? 0=
x7550700 : 0,
+               smu->smc_fw_version);
+               return -EOPNOTSUPP;
+       }

        ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                              SMU_MSG_ResetSDMA, inst_mask,=
 NULL);
--
2.25.1

