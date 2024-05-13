Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A36C25B5F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 02:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C02510E231;
	Mon, 13 May 2024 02:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fi0RfaZm";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65ED010E231
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 02:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpWxLj3WRC9ALp5Auf3etLz6z+IypfR7WvDB+IY5wSYrgy3jsBX4aakPOQiOP1lnKNDXmf4s+sPhj5ijVdVpZW/WaNUMUMHsDAhjHsxKUMIeKdIKkxvQWXPEqRhcYIKyNXxck4VilMCVgtWXpwkrDrXkdLeXi24VqzKwyVc/kGUA/ALbnKotBK1Z9LFB2cZ+kqnIAnzVdL3ge6/AnVEzLcXsuUykM+lLTY84I77L2yeoULz3DScU33n68djocy5+uRcs4gNKSgsmgbqFkmif/yl9JfqU3fuBpcaprkSAagbZtI77Y7vgK1cVtsDXY0m9kKZDT83NbtWYqTfrrzxCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7ucrAYCSCURg0C8Ynmkiy9BzRY2jPXSIraJqkAt5kI=;
 b=HsJhWfiu0qYAmIbAHPBYa1KULk3+Dbbj3cSDN6R2ZSW+9hhPN0+M96qsmk90wQgeI+HSqdn2hV3TnhJX0yPuIG/lADrg2MSmEn5KCixF+SBzQA5uOltRZ8vbbPo3e5058q1UpgYuPAiqTu25Xgbu9+bLg52IIJGcaDfRLaY1LOWsFzHGWmIYeocpzjh3DNPNppbqsFe7KxOYTCAhda3HhDb/QNlHptjec9NWqgJSxyGWYVY/fEAYS07fDaZ38RVR8hdo7deU0/lAIDWCNiqiakXxFFr9yTb4ZUCr5v1PFATN69Hk3IyBJPf1fILRSj9f4NhSQtD0iQrCto04XCmM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7ucrAYCSCURg0C8Ynmkiy9BzRY2jPXSIraJqkAt5kI=;
 b=Fi0RfaZmoADs/FIjcnUxvbsagCeW2DnjUQ4XuPp9sVkZpCD/dudHJN56Yh0pqup3gzgl4vaL7mhqfmMBG4MURbGNaO31NZf9T2tJ1uMuN/PVvlklqGroO84TEXJuWA2rROp9XnN1+J37o6EroCx3W16ZZavw9yjIg8RPvWY9A3I=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:19:25 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 02:19:25 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 12/22] drm/amd/pm: remove logically dead code
Thread-Topic: [PATCH 12/22] drm/amd/pm: remove logically dead code
Thread-Index: AQHaooVUc60V9fE0CE64jMSf8XhFiLGUctyw
Date: Mon, 13 May 2024 02:19:25 +0000
Message-ID: <DM4PR12MB51521D83E5EB9FEF7B791728E3E22@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-12-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-12-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d0a7c2bc-019b-4038-bb8e-7c9a76cd5972;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T02:19:14Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA3PR12MB9199:EE_
x-ms-office365-filtering-correlation-id: ab3197aa-5cf8-4dd5-801d-08dc72f31be3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?oznIc3JglaNuFwpl74sUOIODs8USI19plpEP8nmRwks9zdoC838zHtXxdPzP?=
 =?us-ascii?Q?ulfAhTBDjjd1/VNxXvXVVM+OdUrfKYAE7rvULP5H6lp/U5WchRGz8/EYJvQT?=
 =?us-ascii?Q?m7RN0rvC0J2kvwq1VFbUxV6xogVZzQ9mkpOPx8kXhuxt/e9XNlUQ6HyHg2Xd?=
 =?us-ascii?Q?NAu6BjA6tqoaYP/vP1Y5S0/IQEORE1R69p/xif2Hufs/Ib6x0SryMzbdBast?=
 =?us-ascii?Q?tWwI5cl0OCTYKC+jr9EYvtV3x2vuEZqDIUlK7UQXHHzhRBg7QpP+k0HntQZz?=
 =?us-ascii?Q?sCYOgl9IHZ/XSyj0hKbHvosBZwlCMFdVqs3MqHQcP8MHhn1UsxN5J+s7Zc5C?=
 =?us-ascii?Q?sde4wQR6TNOQFANn1xtLmrL4fIi7j/jSsfHBTg3C4IkqXh1IEhK3SABoeKhK?=
 =?us-ascii?Q?kkVl5wjl5uK7D8fggIIJU1YWcUJ0dwEnDxtERTxpjxXlNsKglTPwPs1wDeHg?=
 =?us-ascii?Q?6uGUnqBBJKQ8o+ddTkdMuqpRoxOEMDFPqi78i7BBwtKQE0HraCQCkQ62vyD6?=
 =?us-ascii?Q?JTLqSr03PJ+76QGIxf9I4oNL2UB6WGfq4uahKCYa78a4MHHRAH2kusQxUkmK?=
 =?us-ascii?Q?OWtx3Lmdb1zf3hwvlhdBUNTj6+8s9yOlz7y5IZP4ckeZOF1LhIPkdLDXqYEG?=
 =?us-ascii?Q?zfOEAmFirboBLBx85LVV0A6+ac7PkC1UweCt5805dlgYsvuLRMmza34vBRUR?=
 =?us-ascii?Q?FGA1dcz83UTKCTh6TTaNtJuJiMbt+vMwPd5grA0C4hmDTmj5i7XXS4PFi3+S?=
 =?us-ascii?Q?pxXDBe+je80VOxn1gUd4Ic03/N5XNDsWFpfW8y/f55jreFuaZGxKqpstioIT?=
 =?us-ascii?Q?y4f4mrQp4XK/5YlFfcIXtj9+esaT8T4dP7RSSlpr91At94/mPfF9Z/rhCPhY?=
 =?us-ascii?Q?uO3yyF1T8xOSBR8ZEAYf0tr7iF4Wyf3DEZiZZslidXSFJg99hwzWoFekk9mF?=
 =?us-ascii?Q?6pPei/quDPL/b+zayJu7KYNFy0zZ0XuPfSmkIOoY02/b9/MVg5z1VJTG5KZ4?=
 =?us-ascii?Q?Ykby8nr1Fxmw+szOald05g8dD0Mnkb0h6KR33SaXIS0n/JZaz88oW+Kiez4n?=
 =?us-ascii?Q?ge0cBm3+VHQR4QSxqBQJHhN/TYEa2ZXYCEXrCYRt1/C1gwgK+tLtgtEZkkL1?=
 =?us-ascii?Q?NqxuiOcJlrg2w1X4wrv+nu5bl2XlHau9VOwuzR4DQUoOtbWp2dztCclMKrmY?=
 =?us-ascii?Q?79CEMNX/FJtO6EXG9pKL1mKcuIoRJ5mDsTbAZUmp4ZKKT9ZLlO7eVpidw68k?=
 =?us-ascii?Q?T9Lwo4NFi69maj7+Qypnyw4P5msKYilNY7/n/W0SQoJe7Tb9BCF2GP+cVd8w?=
 =?us-ascii?Q?wBMnCPHOt++0zU/muFamF16P/YUHIjYjaqNAsjgMkvZ+Vg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cW65gx+gmTOM0q6Re83WmFuOC3kZEodJtgkPDf9UgNdwqtQ6Jp7mi8x+fg8A?=
 =?us-ascii?Q?cPrvZ3pt2TsKtfCQe1OgSV2LAFZry5SkwPuALXKOV4bD1uyaSnNDBrSH8kSb?=
 =?us-ascii?Q?gF7YE8VRUWyCEN7suxeF2Vpc+DjN1QwP0BT16LeLBLE/DcHWCWthosCkPHTI?=
 =?us-ascii?Q?PIvdcde86sDxqryee9QXssn8mfN5NsPyi0UHguWLV54DJB2C1m8AbFpMBBXv?=
 =?us-ascii?Q?rNukZXqVUMEx5EQbAWBqcBiiaEZFRicvCIYwxGTcNQo0gmPzexD/44Lvp/Et?=
 =?us-ascii?Q?YOtH7TKRZm1Hx7hBvC1tb4TpZDxRNOCJ+QBbRw68S/2tlN5OltQb/CHxjjD6?=
 =?us-ascii?Q?8LxDf7Q7yH9GPpBxUe+yCDdzDxuqUDWtLIassf3rIHGS+tph4eKyQZY/734n?=
 =?us-ascii?Q?s5Ewyf5XJeoMscQo0OfGlG+B03sVuthor64eyyQyY+JDbFErzaDIuUaOJ+IN?=
 =?us-ascii?Q?BIsmCjuk/W+6iDCuJM+XzkiLGRnMYdLmxaCkT590dKMqx+z7OXmBqAAi4d4Q?=
 =?us-ascii?Q?m0uMn9G+4QRhtn9UleQWeviRKntkoOFFzF9YnWMdxzN8DIJNgnkqVpy4euxV?=
 =?us-ascii?Q?TOq6IYf58eA+liMZJvJyBvH2fwqj2XhM7PafWRFdn/4Nl2cWcclIASrZw5AW?=
 =?us-ascii?Q?nK7gmVFV+6oKKNxJGQ4+H0um4QWOAIJJqJWgfbM/ZIoCWKF62dvWsrx6eKKO?=
 =?us-ascii?Q?luhG6TSRu1Mgy4dsGmMnJVSrW5C4xgKsKe29L8cn2zPrAGZv1J3ts9XKVWSg?=
 =?us-ascii?Q?gTqNBGG2jiKj6VrtVjd9dVFghxx6BptHck8zz+h3lIOD/qMPHjQya4tDMBE0?=
 =?us-ascii?Q?423KRmtclEycN8Aj2IkW5UJ7lcWOEIaD2ibcTgS6r/3WIJ+HhLs/HoUSP/pc?=
 =?us-ascii?Q?S9B/kQJsTzF+xpE+WzjRtCfbvebfA1ASOUywYVf4Wa48Bw0iuogOj2B5rcet?=
 =?us-ascii?Q?iW6W+SKSRRqVe3UmoUDYv5cflD9DrYjZjQYxe1JGm3raizPcEq0iq6aR5fll?=
 =?us-ascii?Q?YzDO+nJbraXd58H1HmMBSIDSl4LPkawl7B7doVSKGfyKd93HpaCLRiyDYCOb?=
 =?us-ascii?Q?Ch9RfqcHw3UhC1HwP9YMOREbMrfAfaAP1qs9+9ivitD/lGOpuG7oziq7D2b7?=
 =?us-ascii?Q?CIgCTAu8sz0FcjhuczbJey20z9DNYjIhCfGeYqA/tSM1SUA++fTD08lqmnyi?=
 =?us-ascii?Q?mE0N3x1N5XcQcGRYUUGBh9C9IF7v0Acvsw50t+QVZg/icywqcv4ZQKPvI2X7?=
 =?us-ascii?Q?vjbm6WQcvCXE2fpEACpF+TMG5Pw4A0xT90GzMTUBGzAnFXUNEvsq24Zm5eLw?=
 =?us-ascii?Q?ioOLI15lRr3ugp26JPRBKHcfInzi+mMIRCfE0Tg/6gZlksTGb2H7ReycXv/1?=
 =?us-ascii?Q?oSxVlFPhFAkKulEKTmGg/pHQ/hN9h7kQJsqQRARRhqop2yYRKFSK4JbBVu0X?=
 =?us-ascii?Q?AVU7F9mxE07vHT08gzySZA3k17E39Ot7TXlsa7vRVOV6rUohnBvK1U+BqX/L?=
 =?us-ascii?Q?3mYciL9Vzo+jj/2urQDa2RkGNvzbRg5yaigkmeLWMPXKiyAnPjkwfdOm2p3p?=
 =?us-ascii?Q?v0pFgwY6yRUNpXzTB5c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3197aa-5cf8-4dd5-801d-08dc72f31be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 02:19:25.0133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MzP/qPfTpsa1NT1J9fNEOFued9D9G6XU48O43P+nBVzdzQEDGpCcq7+8dHF9WGIykoO2UHMIFs+Zqxuo9bTuiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
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

Ping ...

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Friday, May 10, 2024 10:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 12/22] drm/amd/pm: remove logically dead code

Execution cannot reach this statement: case POWER_STATE_TYPE_BALAN.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/d=
rm/amd/pm/legacy-dpm/legacy_dpm.c
index 60377747bab4..e861355ebd75 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -831,15 +831,6 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(s=
truct amdgpu_device *adev,
                                        return ps;
                        }
                        break;
-               case POWER_STATE_TYPE_BALANCED:
-                       if (ui_class =3D=3D ATOM_PPLIB_CLASSIFICATION_UI_BA=
LANCED) {
-                               if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ON=
LY) {
-                                       if (single_display)
-                                               return ps;
-                               } else
-                                       return ps;
-                       }
-                       break;
                case POWER_STATE_TYPE_PERFORMANCE:
                        if (ui_class =3D=3D ATOM_PPLIB_CLASSIFICATION_UI_PE=
RFORMANCE) {
                                if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ON=
LY) {
--
2.25.1

