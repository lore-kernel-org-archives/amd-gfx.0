Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31634C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 07:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E5710EB08;
	Fri, 11 Apr 2025 07:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yTPgHdO0";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC92010EB05
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 07:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCK2ZDErmATFiRE+9ZAslxdTruNyLbPm9V1o5QJtASp4tN8H/YBdkVbCFIUTy+HMduWcZv2NlkjgPla5HiOgMN5AG7y+XUN6/cBVbUps6gDiZW//IGnMApXcRTR9PVtsCLorjk8KfsudLHobNo+i6WLWniv4G2dsH5jeW2QMeDr5Suiuf09xmlWfU2oWV6PuMlKYqZZFn6tq5+c3Pnba3VWe7jnuNipQyLFtJ8J1zYd2vvpFux2VFJ/hl9lhwsI9ubsfgAwOZteCOnshgyUHkguYxglMaUgKa4iUa8gmPoaBP25/TTVCpnM4vq1R379ON2N9rcU9YkEEiya+5g8P3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BgJLC1aQx8Y77pjP2atbUhvysRzZC+sREzkbM7sJg8=;
 b=knw4TyyVUVmKBZw/s1gJTlfesXWJFfnShVtKiUXvZACO/nGfxfU0upbwi0yHXzhzYXcx4UR2exxaPw3XNHy0AFY0dsayxk5GY1UCzPsF8PfSIwmq+w6dSQXKIa/c1GDwUt9+J7GYS5J9iEPfSw/+30mEo3Zj33PPJwTOQmkkfn5mSr8aaG6zO40VZcvBuBh+FxHLK9KR6T7cP4xU+SmwK2skM7UGqLwzAUnWAIp+s8ZFFwg/q0R3ohljrvSjcMo30GbKMcQaXiHWWLCxGCqYxdfnt/GeD105uVUPL3tzG6yOMvI9td32+vUao94KAmYQGHLyySUE14GirOzSP+BqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BgJLC1aQx8Y77pjP2atbUhvysRzZC+sREzkbM7sJg8=;
 b=yTPgHdO0XbIjNS4IbJpLvvaSLumnwR2GGFBshW48q3rFm/iSUleXb7e2xq6W8gPuODxSQcgzmg9inw1KECNZYZbmNIMQlh0fRUGIPRHVr9PNmeUlW63QS0lYV1WOFMUVF/zi/TVODH+OZCG9Sb7O3zONWzIG7KtmjwaUww0Myf0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Fri, 11 Apr
 2025 07:09:04 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 07:09:04 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Set RAS EEPROM table version to v3 for umc
 v12_5
Thread-Topic: [PATCH] drm/amdgpu: Set RAS EEPROM table version to v3 for umc
 v12_5
Thread-Index: AQHbqqEi7g+gaUKvvkaB4WiiR4IHdLOeC+2A
Date: Fri, 11 Apr 2025 07:09:03 +0000
Message-ID: <PH7PR12MB8796FF0EACD1D5CF3BBBEBD4B0B62@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250411051703.320093-1-candice.li@amd.com>
In-Reply-To: <20250411051703.320093-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=701c6d1b-5016-48b5-915d-a80115dd5a62;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-11T07:08:57Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY8PR12MB7706:EE_
x-ms-office365-filtering-correlation-id: 82fc1a22-b4ea-4ec6-dfa6-08dd78c7be03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3Nss3fa0QysC65SLxnshfUSFPVi3p2K9VSW7Ihu9iiVS0GcUawTuqg83e66n?=
 =?us-ascii?Q?LX9XKrWkh/3EAYIApT9/2kpUzPnVOYD9BLNsiWRQupDLSAZ1QCrhnl1WeaH3?=
 =?us-ascii?Q?Be5Om62S6KWQsg4ksRRDHspy05ef5fDXRQz/HUw2LChcb0Yu7/MekyOjXe98?=
 =?us-ascii?Q?eHXqGxlvW3f4KR/Nb+nF6p7Df9THoGoev8M6rtNR5mwMQFCRo/wQKbBaD7QZ?=
 =?us-ascii?Q?zalekoYeGM0gP2C/Cec5/683EYfgzcV3k/EOrk/2I9ln++scJCP6XVDHHDBR?=
 =?us-ascii?Q?n4snkaz8YO10qhIySG8aOJAYxI97fOdwZ7FkiLg1RPMQY+I/E+TyjQlZmPfg?=
 =?us-ascii?Q?5+fBV7F3O/6+gc6gJ1i8yLKIm1xNDx2U5BjCTYFI7Un8llgVmwfk2Zb5xyFv?=
 =?us-ascii?Q?RatNebO7S9knVHGqC74SC2n2nSzw3rFwsrBTxIdon+R2bea7zIvbl9K6k4JO?=
 =?us-ascii?Q?z5kjXU9s1SELcAtVYOgcEkV63HRS8mZH+G/ac8pNHtIEroouWnu5LCbZNeFC?=
 =?us-ascii?Q?bx3AS+KqNupybBrYkV/2vUbDix2xszYmIitL/EatcExcIw5xjKGq1//vILFs?=
 =?us-ascii?Q?7MOow3zJ9hlDgV4ydbYM1amYOuqHQOSaTIZ+SJAPFgCWI1KDs42hpdo+PWHi?=
 =?us-ascii?Q?hGx/6ETjeYIHMkyYiMG+Oy0VnMuq0KguJ6gRUoOIl3T9+3EuUIzUOX/Einjs?=
 =?us-ascii?Q?4bZkkPPYhegWNIjY4BfpZorrsYSrqC6IwyTX6JHt2NN+azqZDizR6ltHe5MS?=
 =?us-ascii?Q?gUzMVS9gbMYOsQsN82c5cb309WxXVnlHaYgke8F8C0AUXFAFUiIaGF7gwdVT?=
 =?us-ascii?Q?aBvpWEbJgiZKDzuegkKGjmrYzFYM3Qnk8rbijkTyoc3+fWqhJCZTDQr/Ua1Q?=
 =?us-ascii?Q?ZAFcDJ1ez0oPC60ZaZIbAcQQcE3t7Z3C8CHxpK5N1+fGxarP/NYq0KQbFUnF?=
 =?us-ascii?Q?9XGJoLaHO1LQGD/3DBUfV+48aIQmZJ5fEIhN8EZBZ5KGkXSVWS9oCVR5j5ws?=
 =?us-ascii?Q?KyHk/M6oNl2BtyLyU+7Kiury8/qzcxeGWZRDsAhkhHiP9si1Fg3Wzr5NFlOw?=
 =?us-ascii?Q?jE0a5tsktqd5O4eVf5VmrzISjWC1PTpX0xFl0RO0h4W5IL2FKMJZzFs6RL95?=
 =?us-ascii?Q?pwdua8Eb+QRcd0Z8WzHg3cTA03mLESOwJ1qJpcD73maNk9a0Xi6IX+nQNfKH?=
 =?us-ascii?Q?kzOkbYdNfwqd73TbsnlO5RuU9/bTyfEjgnWeLKQJmUuercAWs4KpiHN/2yem?=
 =?us-ascii?Q?M7EFqjJ2uq74ik4joZxRcFjj/9Ktc8hn5UfIawbnfP1I5VfqufUDasA3rzg0?=
 =?us-ascii?Q?OfTk3swzIX87meZb2cSNo8G1YeCGUFUy2YypWLqPXfLwPmM6n6PKWTVt4IUB?=
 =?us-ascii?Q?E4EWJRTPdNI9xoWKxrPTo4VwptkVEHsNwxKM33qMrHs2710SAm967ibd+nPw?=
 =?us-ascii?Q?ucYAmfuL2jGNkOG09xzF+ScGW3mH6BSB3NnB920plVhjw5VQHsxXrw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xsw8HM5WIDUlHNJLHY6Q6ZJaHLQVPxwihZhie7tWqTjdLi0jx3Cr2e5XnsJn?=
 =?us-ascii?Q?/xyFT/RSTPA3EBMnqzV6SXiw9XD879MPBycvodvJ3rkdBThoOnlhW9djlEyx?=
 =?us-ascii?Q?fF1NzXdEsmPebwd/X/kOI/nxXani2/+9CubdnpUPvZyqMGD2MHorqt7E3ICA?=
 =?us-ascii?Q?v9KUvORS39a0Gwt3WY+LnxKUc3BGMhPyo1+fFxEuMt62g8Jc6S4/YtnPv/Ne?=
 =?us-ascii?Q?ik8I+ZJOF5qDKpdG9ur0JGwpJMXrlSxRQ0caR2WhqiMCYtvDXc3WhkCIT8RT?=
 =?us-ascii?Q?I2f70F+y4ORo0kIxIFK1zpalHba6N4hJEoE9KBQ9/Mwe5vhD3OFe+/J/w2GS?=
 =?us-ascii?Q?iZ3mhmOf4TfwsgjDtGdn91U5bhCdQXxRmtCN/jOYhWKInOWTo0+NeL+peg3C?=
 =?us-ascii?Q?tUpio2AXuS1RMY/Yy1t4NeTh9XxasLqtGzPhbBo4qbSsz7lnKwfOt+sL/vNO?=
 =?us-ascii?Q?q0IjZZMuw/kl7BA8yAm6yBXX2R/wTI9P0hiYTdfz2d6QVW5ec7TQmzM4Ts38?=
 =?us-ascii?Q?yk8rnxmez3ayg2tjdNkKy90ho0p+NhE/DlxK6YMN2nBAqn7pGhXeocOaG1Ud?=
 =?us-ascii?Q?7Wr3aoqp1FKPsUVT3qtFqBWTbE+o0rmKVHJ5tHvZA/7oajj1MhRJKgTLrYPS?=
 =?us-ascii?Q?Dl1eYjrB8DtmCmQBZxm5j7XYVkzulCzmnrhs1D6rBKdSMmzP/GelkyW3VjiG?=
 =?us-ascii?Q?1BDHj7uDFO5wH4vrm/USg4qJQlLpHuAj8ZJhagKeVWyBTCpqXxALx6mL8e5L?=
 =?us-ascii?Q?JqFN5k92fX2b+tS6v0VnOU92BFqo4SC2PSv1riOqlBoua2eaTFowhKl10pf2?=
 =?us-ascii?Q?s5pSnLeuZfDu+6o82hm316njwwioppkek4AGX6NNnRPk5qRv+2Ciq7N7bx++?=
 =?us-ascii?Q?tihc9bpmFIcSol8OQZo/k3AC6P0VUJvJVgyv3atrZiNHowsKyTWZPDGGxgdc?=
 =?us-ascii?Q?4F4Z0PDm8ieUR9awXXLwFdE1EHJBxMDXDKjCFwVKOk63eFzfV6VOwH8843hB?=
 =?us-ascii?Q?5U0ZAD5wSF/FSqnm9csn67jaqe0WW4oII9si0cvOlA5f4e3tU9PM8Qs8e8AY?=
 =?us-ascii?Q?GHBgw6ABePAXu/s80+GJyDKTLYrMiz1A+UMT8pWJ0D9XMMYZAbX8ts0TRWyU?=
 =?us-ascii?Q?tWlPjqpAeWVIjKG+gZK0gTOVndrCcYGrE6/5fvyLByZI75A2Ywhk21N8dHWb?=
 =?us-ascii?Q?12UdM/rNMcVrdCMZxW0CW7VkjYlkE9g5w9ZWlRWBowKqYivIw1XNzgoEdiRq?=
 =?us-ascii?Q?vhllDkh8Rk7HJSHqch9o71qQRyGXQIV091i9IhtXfIEsloxXkYS36JyhVXRT?=
 =?us-ascii?Q?MP5Wwj9djA7E3obvJZIT9rNl145HC1+d91xeyJO+uc0jdnxIdS3eyOqLshJd?=
 =?us-ascii?Q?dk7KVN09tRpDnb1/oIl+wKTlpzoLNIVvhfrUEOrnvD4A5YISTdYbCVNyBT+C?=
 =?us-ascii?Q?Yq9bbk8WId20YENFB3+95VdvVxn4piSKh5gEnvRGMRMnr26lHxeM2+fpZ2Ta?=
 =?us-ascii?Q?aEOwUqb3yYoBZx/UISyYZc7KHizFMwIBVd/rB74UF4LUt8a9icEFiavVCvEu?=
 =?us-ascii?Q?591HhvwWGG33aBqgpFQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fc1a22-b4ea-4ec6-dfa6-08dd78c7be03
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 07:09:03.7804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHBgkqOpoLHsYeubdgk08Lb8sap77aM943gdFwbkdx/XL6pU/ZtjwJa3omfzsIU3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candic=
e Li
> Sent: Friday, April 11, 2025 1:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: Set RAS EEPROM table version to v3 for umc v=
12_5
>
> Set RAS EEPROM table version to v3 for umc v12_5.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index c985d58fdd7ddc..2c58e09e56f95d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -418,6 +418,7 @@ static void amdgpu_ras_set_eeprom_table_version(struc=
t
> amdgpu_ras_eeprom_control
>               hdr->version =3D RAS_TABLE_VER_V2_1;
>               return;
>       case IP_VERSION(12, 0, 0):
> +     case IP_VERSION(12, 5, 0):
>               hdr->version =3D RAS_TABLE_VER_V3;
>               return;
>       default:
> --
> 2.25.1

