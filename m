Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653F2C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 05:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B559910E9CE;
	Fri, 21 Jun 2024 05:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zzzbdNI6";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA0410E9CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 05:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W91bhik+8EFh6KfH70/cF/6HLNqw2TizWmj6oP2loRYACEWCXyymwirOZr75ritaHAivkNFQ3OO1TqqGVSzVRHWl2523rqNTwxyuECCVZdQIZ3T48cDzlce6S9Dcf4ful8ss0vtO6Q+WgGQU8bMAHFXn53xUR1pJpx4WQcxICdncFyBf6HnhXxhV215NyFSbTTvRrHlnEYavlTJYjbzayTWDog0eYP9Ow/GqvjaHiOsjBCl0TvmKGVyYUOWYsp5TttshsP55CiHkxGGVK0wC8E5FLEImYb97v+xDvNeFjc++9LOpVCjUu3SWKuL9xWFBxwos6yQz21rWGWZIQ5FtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZ7C9+0373AzBNMh1tbjteZ9GhQUfVDk4zMsnCTFAvQ=;
 b=G63rdDuzbxDOkOOV2zY/qw/wPXpXjajLAtdYPi2iZCCabqgYvCEOKYtMohOLmdCeQDadlLau5lZNHlIc0lTZJikmtzcd5IG68t9KwVH0H+iECfgmo+OBndYfiUGpUgJpJhdGRMQax1zlrlUs7/63T3bBozktaz7jUav+W/KHi756R0YLVbgsPKewL05tz+kggtCPfaun/x+lPLnl2IHbNj7ERj+Ic4V9Jp4uEmNjo9XttAzyPusdyiYk0YuE1leN4iWFbqvJFAymTNXozHmG/v23TiNtw4UAJOxz0e8etqIdtSJDwGNIzL2/Md5fhRx63Xu60z4vJexdPTTvtefjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZ7C9+0373AzBNMh1tbjteZ9GhQUfVDk4zMsnCTFAvQ=;
 b=zzzbdNI6liCqvHe7ZY0XbVBgDDMEARKo/T01Nka2343YeKItWd/ZN437IkAklh9hiZoVxmL5SfVyWqMIoJVTd5GJDkZdwNLnsZk1TzKY8HHibphMSoScIsl2ejZxSo+w1WZBpn6Wt1Z+D6QnMDXaLz9h69bKIAwAVe1L/SGIVF4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 05:58:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 05:58:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Gao, Likun" <Likun.Gao@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update MTYPE mapping for gfx12
Thread-Topic: [PATCH] drm/amdgpu: update MTYPE mapping for gfx12
Thread-Index: AQHawX/dRd5WBcibiU+GxWxHWaBA4LHNfSsggAQ/wcA=
Date: Fri, 21 Jun 2024 05:58:12 +0000
Message-ID: <BN9PR12MB52579917C3FBBC94D24B76AFFCC92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240618130033.3721-1-Frank.Min@amd.com>
 <SA1PR12MB565900CF1142A9A43F8B0921E9CE2@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB565900CF1142A9A43F8B0921E9CE2@SA1PR12MB5659.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=50346356-e01e-48f5-987e-0e61ff1c3f72;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T13:04:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB6008:EE_
x-ms-office365-filtering-correlation-id: 9550217b-1c6d-4894-d6ed-08dc91b722b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?5cZP+PGL0yB/HyNYwR5JJ2bIIevSvBYNe6aOCgEud9/FlFQbK0cQjh+Hoxa5?=
 =?us-ascii?Q?V6Jf0qXpoDq7xAZewTzMZ+bF7pP8s7K4I6bwUmZUb9qcQRVL++Ik9vYQKrC9?=
 =?us-ascii?Q?/npMqMC84jxtu7Kf0tlk/6OUgnuSkPhC4EHR+pKhIb0xkRMZve+QzmMAp6bi?=
 =?us-ascii?Q?a7xQ65ChighLPhClU1gI1drh0eNgV8TOZ+cIoJtoJxu7rKPGYneH49TPv2IW?=
 =?us-ascii?Q?Xs5Pt9vaS5BDBkQWJQAo5g7Kb13Pl3Jkt8NVXg9EiOMVGprgYZD5r9isTLcK?=
 =?us-ascii?Q?WRj8cDobIAe8cD55+3X7FaGAXmX/T2LGSnpYXLpegjzQp6qFRg6cLyW6cIGA?=
 =?us-ascii?Q?VOYa1u0gzSKNLk5XFLV5gHsO2BTXoeFpFWUl8cgQdOI4zCnjR/STVeuYfmjO?=
 =?us-ascii?Q?bFFX8dGEdHFo4z5vt0JPepT4QIkAUozAXJzSU3Aooi75fPdlN+Fo7vgKtIdy?=
 =?us-ascii?Q?fDDCmagp6A8iIqRLWe9fm/ZToi08oBpZpnwyQQ6Bzpjr58vdVgd4ixX6pw4M?=
 =?us-ascii?Q?3jC6zScDadNT+lm1x2BE+Yg95wUuRESqrSU7uBDM67PCEHMaVu4UZQZLi1vx?=
 =?us-ascii?Q?XTioWYbJrdn0JQzRVxqrfHnUX33qToscNqTZZQH8pHinp7fKYHsLDYvnGXwy?=
 =?us-ascii?Q?38nFudla/S+vOJp7nU54JiUUK/6DcIsGllU5BznDrwZNno99P6PCh5/8WBrN?=
 =?us-ascii?Q?cF7js2PLrSRmhoqQnr5dnW4qQRiuCteC6fRWE+recweBj/Sec7zRwmRVdTXN?=
 =?us-ascii?Q?sLjkPVomkg7nLKof626az7jas15YhpVyPxbm9FZBNWwqPuo+Xhre90b5DtUe?=
 =?us-ascii?Q?dMRxQArbcfPUPtsqk/YWXtqqj9InKcD976SykwVWgrscN99lZgq7mGlg9SSA?=
 =?us-ascii?Q?fbWKWTC82EFMe5evslGCEjsuRJIGuP7cGf3xhhz/xqCMJ3a89rSN8BbJh4Fa?=
 =?us-ascii?Q?RAAzSuCM1NzUpZYrwN6WQYfiHN9HeT6OTz5vp9Rf6v1CCgsDDPpDRYkKJvrP?=
 =?us-ascii?Q?S+NwC4wNOXxl2pIwcAspyAiFzB1DpfqnwhwBHF6fm2hcpsII5c7/OwiEQwKc?=
 =?us-ascii?Q?/1ifK08WMvOXilyW3O1uWZ01D9kHMeTZzsrw0SZsXENPcXUL7OTYJvmfFSq/?=
 =?us-ascii?Q?D8pf+EE5tTFOAWjs/Wg0ggZfkS+YTpb3vEK4ozWoLtPG7mp5t8xIziavlql7?=
 =?us-ascii?Q?BA5gH/7Mctp9TvRTG6rghZu5ILSMPpLaPPey0ISZ4/xV6bcPKL79OCtphetu?=
 =?us-ascii?Q?YgU3keUqfQWIAMicaoIyiG1b+G5vZV/LPgqd/bEgXfG5rXUhBNtX2aH2hOOg?=
 =?us-ascii?Q?QjJyE9enX7sT5M/bDoh+dSI3G5wmf8fzBhJj89V3CykQ6XOVZxlXnRLlIYEM?=
 =?us-ascii?Q?Vk8Kp80=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?06IitPdFomqbdinAt5/anZOl/cqn9yvT+5g+fV9Oy6nHQ84k06rmuR0fEfY9?=
 =?us-ascii?Q?uCTmTnN8azbTIaf/Ovt5VIu+wixGDA8haX+tfXgCAd7STh0ZUfIXJFBcX8Sw?=
 =?us-ascii?Q?RFZ6TXCLpp3GGzCOkU3M7kQxEUoW7BJDVlNOhHSnXnUJDwvbWe70VuHsbBqy?=
 =?us-ascii?Q?F2+6lbspajYYHjmGW7HihDDChomNzosxpEJkMGpBRTtRKDynyVqtE+bmiHef?=
 =?us-ascii?Q?CbrJaBytykdqqTbBefMy+pZrGcFhXkbC7p/Ec99bpprXqo2JZCa5UhHfbRSx?=
 =?us-ascii?Q?Eyp66YQvqpVrjNnXOanewHnBDlZ99OqlwJUUK65f8U8ABmOee8t8+YNPl3Ld?=
 =?us-ascii?Q?WPnKxFaeoE1PpFcPuq8wuCJ9DpD5Yeu8vEeoaUZ/WF0ExS3t14bzZnUq2O85?=
 =?us-ascii?Q?PfNKPEX2lbLWBa5s0hBmi9Iv0qfbbtiLeqwcRV7AhgwMZWFRSdFNo2Fd9pc2?=
 =?us-ascii?Q?ClkHcRHr0e7COfHeS0TNK5wuUEFvEGRwuR5wW78ttV4wRQOAD/LPcZmnZbFi?=
 =?us-ascii?Q?H41uhf2KqiIKZioCAJ8PsPgweC6KE2kceK6z7XJV+ATWg2sytZo7kMn5wzpK?=
 =?us-ascii?Q?laXe0v6Dcc7kN5mrlXDA9h1211JpilMdHLP9R4MoM7+5p13A3LN3dCY2tina?=
 =?us-ascii?Q?d2YWC3QWOuHQqFXYxL/UTeftitGsvvN4uUFY8K3TQSVqyyXf9GoT5urDnP0P?=
 =?us-ascii?Q?aSOg55+0t4gr/jJb8huQMvL8f+Ara0neUBOseZfVGbBhGJfEjcjxJha2DSK4?=
 =?us-ascii?Q?RgseTOT8OBz21PMURDAvvFrwHBiESmJh7ypBqwkAJJf0I4qH3mwt+gVQNrg4?=
 =?us-ascii?Q?0B/LedMpz35TFxHEM4mYhd9Fal9xs07tn2sm2Ip5/RgTghsQ2OixAOYCBbm3?=
 =?us-ascii?Q?FN2DwxSwYB2CqkFAOt3vHP65zZ4D3fwGELunPFFZYFVj5+Lp6rBQLj0Aekd4?=
 =?us-ascii?Q?D2XmPsIbtzGhGsWONFgpJLNxtI6NjWCN+IWjoZl7om8v5RRKPMWgjh/A1qbG?=
 =?us-ascii?Q?g8CaZkIa4fcZ0vEttyfyetuE6BMnB+zgx7G8PMHnJssJQAUD0kogLCRi4Zlf?=
 =?us-ascii?Q?nIsBf5q7N6OkIhPslqjJGGr2E2gb+j/g0prg9XV3HGg2BbvPSlWGTUkIzKNp?=
 =?us-ascii?Q?SdQ22QKrEYXeZPJ9Xzw6CxdqBYgh5zQzt9zSPlwquNTZOuNRh/QGg52DRXBL?=
 =?us-ascii?Q?2gPgnIye+lIFC1qvz8hRLOzBEouiaYenDAe8FEyw6lKQZqW+AFxK846N8TN9?=
 =?us-ascii?Q?a6eEXx1+gARLjJ6KktUx56T5oBrLDyaAAZ9aTIFbeRIO0CLmAUXe5baT9Oaa?=
 =?us-ascii?Q?a2FuMwZXeMbiNxx7fB2sQSBc9pyOJYwLwKKZOzJZmbu2PKH+ss9gXt2RvAQk?=
 =?us-ascii?Q?qsK3lBwukK7JlbAMURD3US8JyovTSiQfdToZ2c0HJoQziTvtfWG0Ib5N4CiX?=
 =?us-ascii?Q?GgB0YvsXdHEo/Vgdl4KNltOn99pwa1BeR5uUnIvAJ5lQ6BNxIUmkemHklILI?=
 =?us-ascii?Q?kt3fcRuJHsPbgfSs1M6jD3rLLDlEXOJtcKZTFKhcuzFiFnu5gcAKu8M6Oe/0?=
 =?us-ascii?Q?PtUQvyciXHAHkAMP0QaZyCqbCevD+owdPgvQfPwV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9550217b-1c6d-4894-d6ed-08dc91b722b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 05:58:12.6805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAdGEB8Exzok0zsVbXQeowwljMz0UP3VYRJ0DENArBUumN2KZiXMf5d//dTQHfqH5r00PvHmim/tU7/rhQEQQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Min, Frank <Frank.Min@amd.com>
Sent: Tuesday, June 18, 2024 21:07
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>;=
 Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christi=
an.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: update MTYPE mapping for gfx12

[AMD Official Use Only - AMD Internal Distribution Only]

From: Frank Min <Frank.Min@amd.com>

gfx12 only support MTYPE UC and NC, so update it accordingly.

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c
index 26122c8cfcc3..61db331adcc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -464,10 +464,6 @@ static uint64_t gmc_v12_0_map_mtype(struct amdgpu_devi=
ce *adev, uint32_t flags)
                return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
        case AMDGPU_VM_MTYPE_NC:
                return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
-       case AMDGPU_VM_MTYPE_WC:
-               return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_WC);
-       case AMDGPU_VM_MTYPE_CC:
-               return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_CC);
        case AMDGPU_VM_MTYPE_UC:
                return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_UC);
        default:
--
2.34.1


