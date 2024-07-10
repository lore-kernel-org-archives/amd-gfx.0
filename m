Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F410BC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 15:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC59A10E827;
	Wed, 10 Jul 2024 15:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jomMo0F/";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EBD910E825
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 15:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLnv+TVrsxupUUcxyRVIxuFkLy6dLpD5PzgmVCTBgqszhAwmFJpOQQA+opgOJsKQ0I+EWG+JyDWs30CNe/NDP2US90eGi12z1z4Mg38/6O2dRstTj3w3C4nqB2TxpQNaYhUZ2YjXs92ruxlu6uOeTzabgNN/INQA1Dy3it0ZQZN5vZMcmezuwrVIGXsO8Qxw9PuMq/AvFoO46Oi5voGY0QAPTp6t8u/AkmFTLMosGgI02S1/Sf7FAieWSAdVnMf/5x+JF5c2gAButxjbYytsCYjDe0VZKTDaqQTGg+KceXtTqRmm23qLFVeJuHPtxJRu1PiQIWWJXbxHgbSQw7oxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJX1FmTnuUKcGtNZ9jjkMe35GlSlK9VEqYfTNOg7D5Y=;
 b=GTa0lsI/lT2rSqJEeq4e2jL/6BehDjcYjZuCcCPxvXJ0MbMPqxRg1X/mI8PtmTD8dV9M7K24Ggd7b/yHF43Tr2n1IDm0Sryk11wOgpcn0tlr5d0NgY6Dgw7jXJqA+5vv3Uczr+gXtxbyguY+WVQXKRmpIikLpEBmW3g3Ka09NQwBZ0LPxDElqmOeEfWSnfTF9iQugx6r9DTQLGYxLZ11aYiXQsHm+/PyP6a9ncOcG63zlzy1eDr+dfGsrsZd+DrU6ezZeHjX2er2OPPAwAH7NqIAs/EkH3QBMKdbqNlMqKwsCfsX30KbjV6eBjamGDtdnXTV3YPBkhWXN8YmrPil3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJX1FmTnuUKcGtNZ9jjkMe35GlSlK9VEqYfTNOg7D5Y=;
 b=jomMo0F/B86Kbn3F7oiJF/aiYgkiUJe8lpao5gX+Y00eYzAKF8hjG7nr52YVYMw1Vv4pzBeOcXhRhPT76+3sSim80nIkr/omNfoS8BJIL39WIecEP9mEoac1wUXswl1blJ4Tn2hxZPFKyQBcSKIlk4DIUs9QT4Xh4dTnbERiGAs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 15:54:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 15:54:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes12: add missing opcode string
Thread-Topic: [PATCH 2/2] drm/amdgpu/mes12: add missing opcode string
Thread-Index: AQHa0YDwRo2EW9G7Ckyg6lcr8KF3DrHwH95A
Date: Wed, 10 Jul 2024 15:54:45 +0000
Message-ID: <BN9PR12MB5257418FE35FC135AF2BF537FCA42@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240708215041.529979-1-alexander.deucher@amd.com>
 <20240708215041.529979-2-alexander.deucher@amd.com>
In-Reply-To: <20240708215041.529979-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f1a30516-bef2-48e0-b4fb-8e62e646ca75;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-10T15:54:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8198:EE_
x-ms-office365-filtering-correlation-id: 26314816-f817-495e-54d3-08dca0f89e9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fXj/m+nKsN6Mm4hfePdFeyZ9JjCcPiIGng9TitOAA1RuvaDwbNDw8ANgWuww?=
 =?us-ascii?Q?03miNrIMWLQpkcGgjYXpgPnNiVTNiIubbYoF9gKy52Ppa2SrP/lWpkQZKgTf?=
 =?us-ascii?Q?37EKi/QtAnoCNT//oGLTOwAVLMU4Lk/K+hV3rv9+OAkSXhhJNPLacqhCWm6G?=
 =?us-ascii?Q?Tv6Sssodsb6HwB4ziAbc/m0ayNkrel8poxETsc231VljvFmJGXil6+McfN/B?=
 =?us-ascii?Q?8l7YMOQlTl2Mkaci2aiYx6/QrVeJl20oZq1lUyQYY1+ViFZ+oj1g3mH56Fwm?=
 =?us-ascii?Q?KqUGOd4gD9HCXkhrVsveR4D2GHNfzMB+wTqxiWEkYBhAnFS9X4pDqz8suTfA?=
 =?us-ascii?Q?MlhaswWk6qjDrniTY192mV1ABRMp/suwuk8HesUofQOmw2lqP8SNcwJhd8I0?=
 =?us-ascii?Q?LHiLsDi7GIXXpjPCU9QYW6WBu7OqUnV0RWMopLrnhyflII4K1YMZfOLVsJBy?=
 =?us-ascii?Q?94YmWp6thOI61b91E5nvj5TX+s3tnj/fNumdQnjWnVJ11phu/Qkl0M3yvRVj?=
 =?us-ascii?Q?z1gmBTVIdJHJZpGYk841xHkiOQcMwSjX3OdZqr82UNjVvtTE0hh/Vxel01Sz?=
 =?us-ascii?Q?EIS/PPTvxDos6a3AEwa4NjA44zFDswEvFCHbVODaU1gLnaZffpKhzzDWTiiJ?=
 =?us-ascii?Q?V88htCCNKtlGxdg6Dwi3zmSmfpI9TTbtljKvJlO6R6u67S3SdnQCG8ohy4tD?=
 =?us-ascii?Q?8ohmpHIHwlv74uHyIq5NgabzYT8RtPXuBo50oGz0DOAgWEN1hkFqGei8TMyX?=
 =?us-ascii?Q?L86p7eWBOmEKPd+34i76NpF+0lnPwGO+KZ1sIOfXNWoNsif6GIIbtT9+F89v?=
 =?us-ascii?Q?weLX0jsLqKwPM0XtmyrwlY6Bnhq4Bp/vJOO7gyxQu/9I8p3M71YjkMcCH3tc?=
 =?us-ascii?Q?rphSeCnv7kIRSE3Zwmtu9injXO4GAatsBqkTi/DYOBpzTOO9NQwFztk4O7sT?=
 =?us-ascii?Q?9jrtN/7HEiQo+bIARQAh6nArWx5st5fNY8NEH0ohfAClDOyvBAz7D/ukOgqS?=
 =?us-ascii?Q?Vw17FAkpe7fdu9x0jqSTSGa8b8jbol4kCACUGkwbo2r2pUDdW4Quq/nIi0+J?=
 =?us-ascii?Q?61VNPiiglfDaG8LMFqWEjQdpxDWhyt2dNGtct7KoOGWCv6OmTtsRgj6ZnRfl?=
 =?us-ascii?Q?pWCy8AMRcnrO/UkryWOOV+lx3/Gl0pwq/MQrTVvNewoiVm+QL/dv1X4aZRRk?=
 =?us-ascii?Q?oX7M1raRG69UoazM1hqA3o9qtKGXxus8a2cuFTIjcA3ZW7SSSoVgoX/UEXUQ?=
 =?us-ascii?Q?Q9+Ip0vgAjwJP8znLfmiKR+miRkkW6JtCXjyZsZIfC5aPcGDlezXYXohJt11?=
 =?us-ascii?Q?un/PH9Wk8qEEGN/y6OfOsSA3B+NwxeT8Eatix7/TY6xhp5AoI9JbhcbPQ1AS?=
 =?us-ascii?Q?lQjzlUoIqI6FdKQ2Q8W1nV7yZdaRaKdCsomzkS9P0ArEZiWXbg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OvpbNp9SbMAX6D1HcWOL8DIVnX1YgjzEOYirpx/fg3Qqklu5w5qLhDD/pDck?=
 =?us-ascii?Q?6WXvzeZBMG2q8Ht8Akg09k/gVGXBg0Qd5FS5x7IRMUyRw+sie1Vc2l8Vylkq?=
 =?us-ascii?Q?Lu1boPC4dp6GvhVOtSbH9OSIgVMFMdxxLafiMXm2Ei9z6aOEbhVLIFnezUAu?=
 =?us-ascii?Q?dLsMFw24hFeTApdA5ap+wWGpPI12W7NMpc5DM9udYm8ef3wRV63qaFUBkUpl?=
 =?us-ascii?Q?t0L3E7JmhYdAFzX0qgq8FAZeiAk5w8MEFgHzCOmkQ7yBkX8DJNTlqBxr2AJw?=
 =?us-ascii?Q?fID1HI7wV6V7Kty6DyWeXxsOFjFWYf34yn1n2UrZqPyqxlJJ2ttv2x5TEpmL?=
 =?us-ascii?Q?faKN30fFhBegWqAeV/NStrH/a7IBMab3WembKUntbTx8K3PnSUwF1aoghNdK?=
 =?us-ascii?Q?2orZByt9PIGGpAtN28kOglfkLl0uxIFPBkXj08vK4cyqOD/mQ2vVzLCLjkL4?=
 =?us-ascii?Q?M9EVMTB2viSchERsK2GH9VmNXIqTq63x9hc7Ajhb7MEovr2rZhShfiFffPgs?=
 =?us-ascii?Q?ZPPROWCjBQfCFB9eBpEA1aCK1hKS5ZgFr36zZy6lgF/NYCjMTYnN/Zj5a/xB?=
 =?us-ascii?Q?Eg1Uzmi184mbWkjTWmxNyho/7d5ceqnaes5Z/QuWjwOOF6CNVYGt9dXrucM+?=
 =?us-ascii?Q?ESA+8LfXidXbFc7fYUSGj8eGk73uQxtlDpm120O0NfnZSAQx2/2Z3i1SAQJb?=
 =?us-ascii?Q?bsJBATvlBjuVamkFhSGlr3fwhlM5dSCd1a7+wwrwH92TS451XoOwD7aE+lgG?=
 =?us-ascii?Q?auFlEfZ4d2OPEO4DVdqIPTTFe/BxR3y7KhCD8cH++VaMOWWVNzesG69wgX8P?=
 =?us-ascii?Q?vwlfmQ6E7n2E2/T68TVoHYQdIymUhUGYHXSg4tEqJJB20uzYlBnjer+KJtXr?=
 =?us-ascii?Q?Yc+CdoRZexWqKusYRjWUUZHpRjKZbluPjFtXjBurhcs/WEoKdTqo8Id3X6s4?=
 =?us-ascii?Q?/5S+/kEFbxqx5b8U/0OBKd3ta3HbTzVFmh8SLe8+Mzwkg/mIiZLiOKvxAIaT?=
 =?us-ascii?Q?caH9hbL4RX3FRKNNH1h4uSfya0S72HxZbcgQCIsINzLpFJfszkSNG6JaLhPX?=
 =?us-ascii?Q?aTEzZcO9eKMJSMUUEtspinHth5ascRfhvu/js5NnENlCBLAFCl6ek8Zsb0gs?=
 =?us-ascii?Q?SyJ6JZ6+ts1X4Z+eeJTzRUwcGSkAkq1ErJJqSDNhhQWr1xSTdHbjDhWs97mN?=
 =?us-ascii?Q?LUg9rxuwticFEPPuygfzyeQADrkO1rnV7EjE3UxfZLvJKbQ46naw830xh1Fo?=
 =?us-ascii?Q?8FVK0Idqs1m5a0XrJIVkeolh5j2as4cXOIWhG/5pdQEcP9ns11TuRe5EIii/?=
 =?us-ascii?Q?lZTnj+/fhv5Xx79zQpWMhd6ON0Elkmf+aG8hIIu89hMCBJvrT2pRde/wgmHE?=
 =?us-ascii?Q?8qWrCm1X8kXMmFARZOPQ0tBHaoS8VBYDZ+/ipNaY8v8eyFK35hQY/EkwNVIf?=
 =?us-ascii?Q?gdW4x9zZbIM7EIDkzTTCiew1IwMJFyGacRba8ybPefQp2ZkQpSkmwS7GE8lD?=
 =?us-ascii?Q?owEsquL1bJm59jS8AskR0Mmrz4Q4CXbs4HwIDa18JHUyCZKaxCz8CfRzLNsb?=
 =?us-ascii?Q?Pv8XZCWF8ALMRFCqx6g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26314816-f817-495e-54d3-08dca0f89e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 15:54:45.1470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZtAyvuzLkqgREaF08XiMy8QeDxIUM6mhou+AVXYAQqxvSvD2NyZu8n7UfPxkUrsXgeK/Z78T9nneJau9sP+0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, July 9, 2024 05:51
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes12: add missing opcode string

Fixes the indexing of the string array.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 106eef1ff5cc..c9f74231ad59 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -99,6 +99,7 @@ static const char *mes_v12_0_opcodes[] =3D {
        "SET_LOG_BUFFER",
        "CHANGE_GANG_PRORITY",
        "QUERY_SCHEDULER_STATUS",
+       "unused",
        "SET_DEBUG_VMID",
        "MISC",
        "UPDATE_ROOT_PAGE_TABLE",
--
2.45.2

