Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FB7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 01:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDDE10E101;
	Mon, 28 Mar 2022 01:26:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 182D810E101
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 01:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIEAIZkezlN85AFtpHE8tUM8pPm1UQhFIUDtA94h8N4cDCcE03AXqfsEqKD+y1uNrzjlxKWcks3b2dTKycG+45nCV3dsoeteIBexweCqYHZm5P9Q5Am38oP4nKY4NlPqgS3U9iQ7lpxKTpOGwEEd/jVGtmNx5eT9+4ng0m7mvyL75Fi0j2G/ukjxst6oy/mWkiz+72DNxXTNZOBcirWOBiq+wVMk7h8K8tt6KLzOyGJZLKQpfXc8lwntYnwSTelyZB9SL+rbiFh4e02CJ1xOxE5XxIUIvkbbO/nt9yVcVfAtwDxVlj/lXy26or3UBuMx0H+ScgEMgkr5yXYCobnc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVtNlt2eLMequ6EZPvloV1U3QUp6Ay3Je+iUks33UVE=;
 b=Zo1et5QfW99qbxUTnBjCm2OY5ZA4shW9Aqdf41qrQQp7APksp/2gw0Q4A7u/k9NwHg1+4G5NMTqxwIExxQv/Fh9Zx2x/t2VUXF9+ZRm6lBgxYCRhXCysKktUqtOkejPMOfLignRCrj0Jbr4upSR2zJoEams8pZupec1QzD7/tG07PB5uDUpk4xtMllOg29hMlEVc2GgEPVhX9V5tRbryIIeFgLf0+mvNFxhS0ZRyI9DDIvIkzNDLwqoteeanYVgI8c9nmUW2dfZypjOdUsl9vSmlval2kEk4iuYGRYR59uo20juSZJypcbqPnre7iHtWKEd3py7bJrDYcCFTm2wNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVtNlt2eLMequ6EZPvloV1U3QUp6Ay3Je+iUks33UVE=;
 b=ZYaykLwwq1Ly+k4p/M1us/AhwOZ/6URpKPRN/fN8Qa41SqIwfSPSRs+VIDfUwzccRzpmF2mz3EIXZ0nt/mjkl2+J7/fBqU6qMpccKdJpkb0IMl9q5mo3hHmVO7KmVL8rL9bHOXxue7bZgJ0Os390J3r8zHX1vd+noWsYR0t2phM=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY4PR12MB1813.namprd12.prod.outlook.com (2603:10b6:903:124::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 01:25:54 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::dd89:5054:25de:2942]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::dd89:5054:25de:2942%3]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 01:25:53 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0
Thread-Topic: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0
Thread-Index: AQHYQcx5XDW17ZrXr0mvlVZY1KuRWqzUAdiA
Date: Mon, 28 Mar 2022 01:25:53 +0000
Message-ID: <DM5PR12MB2469F8E803B628080BD1A247F11D9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220327111857.1372675-1-tianci.yin@amd.com>
In-Reply-To: <20220327111857.1372675-1-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c899a33-f44b-4162-ad38-08da1059e6e7
x-ms-traffictypediagnostic: CY4PR12MB1813:EE_
x-microsoft-antispam-prvs: <CY4PR12MB18132E8E3FD7B7398DD88122F11D9@CY4PR12MB1813.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qe1LaQrBbTMJdSX2Y6wkxHf35cXpT43sYWP2lohV7WIWzEDjZxr7Pt7bDosEizAgUyCMGOXXDYVGB1MLNuN/3kq2+79FX4UMwO3ljch9Yil705SDqx+sE2J0apD5em4cTunLjjhlRXiUfkE3VKh9RzEWGQy5GPPjKHZmj8ab9Tg+TtRGzhkVfQBiIM2pEd5lgiTOAjJ42Xm3Pw+f4VL+wqkktcb7y4GAScVFjAF9AHNCzVzqxq28NrN/dj4jkv2qCl8IBoZB9PyMuE0bmiQhDfhq5QR6xmbUezM1m+OXoSilCBA0FR4fArmEJ5jWfSSb0tqPk7YE5s5B8Xdx8vyOy2AR4IlLT2Cam2CFx+hltcxLwmF3mju9YgHNa55UU4/qYAiOMrwaNqiikF2U2P5vras8JbHmlGk513g2MnGk3IvlTO2BRdpXKEwFYv+k99qRA0VbMVkiSE5hBu6yK80xIBgiQ/uBg8Xzm1A24FtoQpSU0hGBMg1RxkLjG5jiKjyviTiUP9MzSuCqk2B3Ur+KHXEzTVl07RvD00zGJY1AEb/mI23ocIEFgpDCj5/uI+sVkyqCG8pA7LFgG0a3CycDoGJCy/LoXlpjKdlw2Oy7/5bIlsmJNsmYLcGcbb9B+1DFrbaVefWCbocJmoqbBEOFlEcei13kpIMGNEQpn1jheNwoXHUYQd7i1ZYLFWWrBzD3qI8FEpxKXJ/xyFD8xRw2kg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(83380400001)(52536014)(186003)(110136005)(4326008)(508600001)(38100700002)(64756008)(66476007)(66446008)(7696005)(6506007)(66946007)(54906003)(8676002)(26005)(8936002)(5660300002)(122000001)(38070700005)(71200400001)(66556008)(33656002)(55016003)(316002)(86362001)(9686003)(2906002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AWzH9w+h9Ji4nW5U6Y+UgGe42F0AV+KkmM2evx2dA1w/Hc1pF2RZX66HH9PH?=
 =?us-ascii?Q?woG4+ixv8goUqfcjhBc4kPvv3LVHtwylG7llL8ORVBLKusimHfmzWCZqL/Am?=
 =?us-ascii?Q?6Uumt1ubMHc8dX2HCEh6xUoLp2MAMAgdLBdylnjCKkFaeAybvJwBX3EiIFUy?=
 =?us-ascii?Q?PinyEcH23ho/sQ8J0Sw8HbmWDksXDajYxAmNNAml8JOTc2U7Woi1DgApIMxL?=
 =?us-ascii?Q?t8gmv6DAKAlWG4vRmLenpc8VehgkWfIw9z6rheIAyMlMjt0xU7qMMuUblL5L?=
 =?us-ascii?Q?8Kvj4pPfYf/DHuasi0nWR06VqrRBr8vBtCBeQ+/mU8OKKUHF1bz2mhC3Rfjc?=
 =?us-ascii?Q?esLRC8R/cozRKoUmaHfrRY2af0jX6jGwu892CkNjOUrzCFrQuMjjj+cdILKp?=
 =?us-ascii?Q?6tVqEgA5Lv01BAqVdZAVVWmccwRX1DV9ZS3YSFlHtRNTk5x7KOQSGL1yr9JX?=
 =?us-ascii?Q?aqtwqxmvB9T0jGCw0mR4fomtO8BNqg5UdxHM4cqc/iU3448cYYsLqerfsEp+?=
 =?us-ascii?Q?zz0J78JTLmIpWNyvxtT1+rBDKPEm+Wl63OfVvNSre2pX9AWpljU/zRUyVpGX?=
 =?us-ascii?Q?w0Ibub1R88Y6EdLJ8MVjW3B2ULUgBC2CAxy1QBVQuZxZLFNm91J7t1CigIoD?=
 =?us-ascii?Q?gyd7vD/W/n1Cw4cK2fHLtTrUyU9P0rrF3H9uU97O0oN6xZs7C46TnpIMVw0b?=
 =?us-ascii?Q?YOuwqwztXyUm5yUpps7H4czmR5m95Q1izI22mn5B8zImOc56zyAnP8EtwRca?=
 =?us-ascii?Q?ZP3YYcb8OUKBRwYG/4aoRU1Uzth4Vet31UQeTOTIZynf94ivkFCtYGHbTcS+?=
 =?us-ascii?Q?4x3JDpNLqK3M8TDPHZgB95JBls9I8HfC7aIafKw+wcu/S6RV3FXyBeVXfwpc?=
 =?us-ascii?Q?ZFtm424ZZKGwErhyWHblh4m0AEElPYa4UjmDjUDIVs36vxHVbzsfKsFkxQYV?=
 =?us-ascii?Q?UO73Cfggf+mBDcc1xSUjyKqO9GXinEbaxoykBhGlDMAsQtahdJVLfTnF6Xy7?=
 =?us-ascii?Q?ME1gyQIsdMP8dTPaoTgLFIZaIeKYsfhge+PlevnG1RFzpZfQt1ZkySrO6jwf?=
 =?us-ascii?Q?dhyhceBvyZdgM2pKA4sh22nD2sr7Eem4rhGP7lwrJRmaY5ayGWTszuZhmFCU?=
 =?us-ascii?Q?8mOI+QPcc709etqJE97utXaq+4ihrVpgQGjH5iYy6QrXhgVSsJGaRYinsNBk?=
 =?us-ascii?Q?BqNtGlJ3p0uKEypba4JGJm4bGnexjmctfpApbICjefEoh7t1QLM842EOMOl3?=
 =?us-ascii?Q?2Cs6LLVIhGC+zLnFShsoTJTsOb6+pfvEn7D6Wqx2BR6Vl/tFky0KuNnkUyGi?=
 =?us-ascii?Q?9tionSgHQ7rv4wlOWwFjMT2qoQDnVVdU9ugw4X8w1n1JfL6lPH6/qJDmoHk7?=
 =?us-ascii?Q?cbxpNvZLO2Q7LovDV10gLrYUWqMizRKUwQXs57FZpsv+nj/6UaPqvHcpXudq?=
 =?us-ascii?Q?PFHfTBc91Ok8QM1beagCK9LhvvF9vSmTid82RhjaTjYC3U0NfrF4rTO44Cwy?=
 =?us-ascii?Q?aqdDdkaU9i+njOOdtR2SpOiyx09m9CDJElBHypZWQzFYUMZfxNKMt81dgFbf?=
 =?us-ascii?Q?tlFHOmWEGa60Cci+9AK5ejdS3xUkn+3KY5SmwdfKrocHrgT3B1rlFaB8kP8K?=
 =?us-ascii?Q?1svWyC3DiuS2n/5fmsXXq70m+lRqSqg4qSNpFoXG1LNON9GLmTyopSZKCV8O?=
 =?us-ascii?Q?/juhWmNEM3UG8aA3Jb/r8FCaF2JsrvM+9KRbuzAZhWZ6jddIcM9YMYVkKtbB?=
 =?us-ascii?Q?ISKLUNPJiw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c899a33-f44b-4162-ad38-08da1059e6e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 01:25:53.7485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T9gA5OUqBhD5IGVX5CCaVfRF5ZT94jvODMm4gLB6L2hyeySpe8sb6hmelqJlYeQTRm++WGBzQbOh3yAFZXZfkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1813
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
Cc: "Wang, Yu \(Charlie\)" <Yu.Wang4@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "Yin, Tianci \(Rico\)" <Tianci.Yin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com>=20
Sent: Sunday, March 27, 2022 7:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhu, James <James.Zhu@amd.com>; Wan=
g, Yu (Charlie) <Yu.Wang4@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0

From: tiancyin <tianci.yin@amd.com>

Some video card has more than one vcn instance, passing 0 to vcn_v3_0_pause=
_dpg_mode is incorrect.

Error msg:
Register(1) [mmUVD_POWER_STATUS] failed to reach value
0x00000001 !=3D 0x00000002

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index e1cca0a10653..cb5f0a12333f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1488,7 +1488,7 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_devic=
e *adev, int inst_idx)
 	struct dpg_pause_state state =3D {.fw_based =3D VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
=20
-	vcn_v3_0_pause_dpg_mode(adev, 0, &state);
+	vcn_v3_0_pause_dpg_mode(adev, inst_idx, &state);
=20
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
--
2.25.1

