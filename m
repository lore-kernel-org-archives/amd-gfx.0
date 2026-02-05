Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866FCECD997
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 20:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E5610E049;
	Thu,  5 Feb 2026 20:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eKab6860";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C84910E02F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 20:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQpVglbXAai4Sx0rlLzAfEJDXbp15W233lm9YVTk55Z0u8KGBGsi41kPCGbq4b1Z+JawLsqcp3EcrxLo2fgrTxqgfwfoNpAapaQ+AdYkYPvjzpqJDlkI2D48OmXxvkpwKwOcM/HEqgaiNHiLixOQi82IvJCV0ktS2c8GcZwkoglpqkzZEvk1fEOEnRKkkklOJoY41LNIDcnHx5ExnxucoeFGdd/6G1r+V6q1jLUb8WIQlQxbmY3HJW1kAT8j7nO8bmmuxlFVW3nq3TwhJLYRLHjOn2nH6jqbC+xuW/qZYkgEHtotNY4N1zWcfPWNAomOvbuq7NnibfQel6kSYZnhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHb2+n/fwvYM5Fobsklhq2hsZA91upq+jWZbTQ4H2W0=;
 b=cCNZNgFU8ljg0Ku20N2sIukRozpj7vnAYtRqKTZzsUAvLl8M9sxiiP+C6ifRy62GKgc7aOau8EaY1iGWKhlPJ9/qB+U5GfgvlUJXGZGjx17ml/Ff7Vwv1e4dOIazXg0hU2CKRs7cdo595wGqUqxLs/CgT1CjRBZcVulHuXhupIHRotDJDQ2B789DFD3pwex5B1iame5/VeiSubP/wBcelYSVgOkuwaDyQxrRdLHv6Nr8nCy7vYT9lDawTdMhSJ9BhYw799gTHidTpFUYfwkycEYn8fCxFDeihft/bAx2ejRQHb3eunrVpHLMReAnUmKNPxBqeMiVo0abFRL5+nX8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHb2+n/fwvYM5Fobsklhq2hsZA91upq+jWZbTQ4H2W0=;
 b=eKab68602azniDzI62wiFVNrUJTbbse3TMmx20i2Qys3MkiK6Rk7UJR69Nu1ReLAknvAQOxYQZq+Njqp+bl3qmANzy8EOqDxJ3x0eTLBupB2gAJMSOV6T04j6oIYJYOaTGa110ODY7tzJbUHcPMqpvDXFEX09LiEKinqhzzcQIM=
Received: from CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 20:22:21 +0000
Received: from CH2PR12MB4055.namprd12.prod.outlook.com
 ([fe80::910c:508e:4578:4d3f]) by CH2PR12MB4055.namprd12.prod.outlook.com
 ([fe80::910c:508e:4578:4d3f%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 20:22:20 +0000
From: "Liu, Alysa" <Alysa.Liu@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
Thread-Topic: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
Thread-Index: AQHclryff3tf3+UVO0Ch0bihHrriY7V0Z4mAgAAknnA=
Date: Thu, 5 Feb 2026 20:22:20 +0000
Message-ID: <CH2PR12MB4055670B034D6220F3577151E599A@CH2PR12MB4055.namprd12.prod.outlook.com>
References: <20260205162846.106865-1-Alysa.Liu@amd.com>
 <f05102ad-0902-46ff-8bc2-29ed809b11f1@amd.com>
In-Reply-To: <f05102ad-0902-46ff-8bc2-29ed809b11f1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-05T20:20:04.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4055:EE_|SA1PR12MB5616:EE_
x-ms-office365-filtering-correlation-id: 8a294f3f-27ee-4096-5d78-08de64f443de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?bzQvNWxVSGNxUnBBOS8veFBwbFJ1VnljblJSenFWbFpKd2I2ZkxlYkhKZFhD?=
 =?utf-8?B?TElkTjZtc01ERGppSFNnSmJMeW13aFFaeU1tU3QwVXE3WkJFK1dHOHp3eVhp?=
 =?utf-8?B?Rm5FVVNFU1ZDOXB2UVVFK3E2eU1SUE9SVFNFdVpFS2pYbnJBNlpnQ1VMTWhE?=
 =?utf-8?B?b0IyNDFCakQyNjU0ckhjWW1WSWIrYVBRNnBHM0F5MlV5eGNORnZsWm9uSDFT?=
 =?utf-8?B?NkdmaThwRU5XRHRONDYyZnBzeVl1RndOYlRQeVBwdkgrTE1EemVrME52ZDNT?=
 =?utf-8?B?NVg2V2VqSE1HNDVuNUNpUElZZ2lwTU5JQSs4YWNsMk1LbUVZZzFxVTZ5S0tV?=
 =?utf-8?B?UFAzQkl5ek5heWFVU1FnYUhyc05VUlhvY0Rqc25vdHJjODVNQ05aZDA2RzJk?=
 =?utf-8?B?YTFMYkJKVUU5UjdHS0h1ZFdhKzcwQWlML1BmMC9TRDA0Q1N2VC9zSVpWMmQx?=
 =?utf-8?B?LzZqNkRzMWxkbjk0bUoxdjF5NE1XMnJHdkZCTTJuNHptWmMzVzlGZ1IzdTRJ?=
 =?utf-8?B?NWNnRHhTazA3ampnQWN5dW5udkJiQnpKWEIxRU1LcUV0clZWU0xTUGtEQlE3?=
 =?utf-8?B?ZFBSZkJ4bFd1ZVZpSUdXbS92TTNzNDJjK2RhS1l0N1FadzhId20wenRxRGQv?=
 =?utf-8?B?R3piRFZYYmJmeXpHYVlENE5peGtjcFVRakZ6ekQyVGxyRzE0Q0I1dXYrVVN2?=
 =?utf-8?B?czh2YStKbnc4Q251bUVNd2RxMzdsTTV1N01jWmtOMXRSZjJybkRWdU5aNFBn?=
 =?utf-8?B?aWlXaWVwOU9mZ0VhRGN4Y1FvdU9ZV1c1bFM1TDNiM0VUN3VkaG9EZ0MweWl5?=
 =?utf-8?B?TVR5WE9nVmxmM0pXZ3pPeTNLT3doNGJwTzBhNHoyaFJiSVFaVWVlZ2ZqU2dF?=
 =?utf-8?B?NzlVdjZIYzIvUzBGM1pMbWdTNEpIaVlzbnNFdlJPS25RK0RLRFBNcEV6Snkz?=
 =?utf-8?B?UU9vU0JOQjUxdlVycW5ZNndPVm54eWthS0FkN1BOTnVHclBaSW10eDVrUTla?=
 =?utf-8?B?UWc3bkc0VFNCcHE4MDBrZkQ3M2VJZ3JwMHNyQUduQzhaTTVyQ2xrQmVBUHgr?=
 =?utf-8?B?dFhrN3I4aWtibitwWVd1aFlpeHlWeUI4L3QyUWNkNFowTFFtSE5kWFVYV3F6?=
 =?utf-8?B?TlZ3RSs4U2ZMK1lUU3VVK2xnNDZ6ZjBYelYxZ1N4V0U4ZGIyS1VCS2FXcDh4?=
 =?utf-8?B?Y2VJQThXem5FZ3ovd3lwUm9mMWlsTjVLT0FGenJwOUlKcTIzUnE3a28ramJ3?=
 =?utf-8?B?Tnp4c1A5aUhVSEQwUmtYK1pheHVlUFF4WjhWU0syU1IrRnNjVXZlQnRTejA0?=
 =?utf-8?B?OXk1eHdrYThEYTVLcmo1QjRHRXZPUnR5VmlTVGxzTitLRDlKNXJDYmgxZHJZ?=
 =?utf-8?B?WDJmMHhCMWZQRVNNakJXV3cyMEc3dTE1dVYzWWpCWlhDaUxDT1NTWWlGMXpy?=
 =?utf-8?B?Vi9ybnBDeEtjampDcVkzRWFXVGJwUkdod0kwVVIwaGdxYm1nY2dsZTZxc1Vk?=
 =?utf-8?B?eS9OM2Z4VldvSWZick1HN0FPRWRIeHVxem5Lb2FkVzZhcHhZSEo2WndKZHBa?=
 =?utf-8?B?eTgxOXNEaXpieDFTRUVXWllmdTI4aFgycmZqS0ZrOTlGSHdEZlF5ZG9pNTBy?=
 =?utf-8?B?U2dMSll5Y3BoVk9oMlg0ZDFIVUhJQWczendOZXlsUENZa1lneUhjTVU3a3Jr?=
 =?utf-8?B?SWMycytIdW5ZNTZYZk9veTNpVi9TdGFkNUhmOWltcFFtbXRjWHFDcTdZVlRU?=
 =?utf-8?B?S1ZmTmhqcTlNcGJ0WW1JUEhIZmpZSXh0bDFRRTN2QkZQUEhUU3BCU2RMaGMv?=
 =?utf-8?B?NnNMY3RBblhIdU5ybDI0V1lvTGkxYTE5clV0NXZvTXJZcno5V2hocFRTNHZ1?=
 =?utf-8?B?WlhGM3JGajVrTVJJV0FNN3ZINzJIampYdzZ6allvL0NBV0lMbG5OVGZCVHVr?=
 =?utf-8?B?b05MbG9GejA5NXk0dXNnMnVhTVg3d3V3ZHRucUZrS0dXVy9qN2NOY0s1cVYr?=
 =?utf-8?B?Zm9kVkFxZGZjQ0xseUVoMURINTB0TjRWSVRqUEhVQ2hIUTZVOVNodmlVQWU2?=
 =?utf-8?B?UDluVkRzY1h4anVjVTRvOEtJM3dXNXRZQ1I5eHlpd1VmbkhqdlZCWnVrSGwv?=
 =?utf-8?B?OGtjamF2NW1ERFUzZlJwR2tHV1dTRmgvNjdxRWxUZWsyTDRCYmRDc2tKL215?=
 =?utf-8?Q?5+JAXiOjneNEo8tH0392+Yk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWtQMWxJRURMaFNuUGdKMS9walQ3dC9RaXc0bktESi9wWkdiSXltTkF4ak9D?=
 =?utf-8?B?NjBJZWltYWQzRERpcVVXaU5nNkZMUEFQTE5DSU1EQ29nZTlwdGRzUTcxanl4?=
 =?utf-8?B?Z2ZuZS9EazZYcDM5allRVlpPdmUvVzNrcWFzRWh3V3dLYXpXTUJpd2lBNllr?=
 =?utf-8?B?RTgyQ2Y4ckdYb2JOVEN4QzhWSHYrQUNuYUphWFpTSzdVK3M2M0ZqdldpZDNL?=
 =?utf-8?B?OVpBdC9wTFBmajNDUURVdytBNnZpTTlmdG83TFZIaXBVTms4bE4yakR2NFhH?=
 =?utf-8?B?bWJTODFKbTlmZUFva3JFQnc4K20wSk12cUZsdXJCZzZZQkN2YjJCcmg2QlFo?=
 =?utf-8?B?MDlZODVBVnZaSVdQWU40d1ZaZDlZc3VpOHhESGJFSHZlM0J4Z1ByQS9tZHVq?=
 =?utf-8?B?bENmOTdtTVhyVEV3OGNwQWN0N3VKWmZDeHlkNnh5WHZ2QW9CSDZuMENxbG03?=
 =?utf-8?B?dGx1NEhacUJjQmErM0pRNGFaeVdhVzNCclIxMGlwQ1h3cWM3R2QwZ1dreGdK?=
 =?utf-8?B?L0xIVi9haFFRb0RPd0tvR3ltYkJ1VnN5cnNpbnBjNU5lbStJMEFkVk01U2hB?=
 =?utf-8?B?TU5OeVN6NnBaa0hrOFY1bVcrM3lncHNTemxKbHNnOTdYVnZxbXJ2MkJDNFgz?=
 =?utf-8?B?MFRtNEdWNGRCdEd6MXVZenNzdUVVRHNUa2xtOFhIWHE4OHJIbVVjeGtrWldQ?=
 =?utf-8?B?OVFJSTlpdVczV1U3bnJxWXhMTXhsWDZHNWljbmdEUmJibWFZU05uUGF6eDVO?=
 =?utf-8?B?am1zejlaRmdxM2lMTlpuV0lla2d1VFJ6RnpKMlFPTXN3WVc3VkJDREdKeDQr?=
 =?utf-8?B?V0kzUG5BS3NMSDBpTDQvK3AyT25JVng3UXRrd1JMUWMyUCt3T0pOWTVhL1NZ?=
 =?utf-8?B?dE5IQUdHZS9laWNpMDZuMDhLWE1Oa20rc3UzRXN3Rzk1c2h1SFhqS3dKY21r?=
 =?utf-8?B?ci9QZEFYWUNTUXEvQlFjdldvZ0NSWnhEZVBZN3Z1SDluWEs3c1JpcVIyOGlv?=
 =?utf-8?B?aDJDSjRJdkRCa2lhaGI0RTcwK3pobVRzNW0rN2Naa2NVTlVHelBVOWVSWisx?=
 =?utf-8?B?bUFBRTFoOFN2NEdXblpNRXFsNWd3bThLQjY2OUNmRDRYUExvZlVNd1ljT0J2?=
 =?utf-8?B?WU9MUXdzcDRMZjNUMlFVS1VraU1GZzhSc1pWWHhnZEFBbmJ5V3ZnY1Z3SWxS?=
 =?utf-8?B?OGdvRUlKSnNMZHhmclgvMk9VcVNPSGJkSG9zMVpMcGY1Sm5adU03RjZLU0FS?=
 =?utf-8?B?SHl5TFpSVWZ6VkxuWnNSMHU3Z1E1bWZFbENjTXVxeXkybWxQSGZRQ09iaTBL?=
 =?utf-8?B?VEtDMm53anRlQUIreThtY3RPUTdmN3U2TWRRVmFuNzcvK2xneDNSaUE5aURm?=
 =?utf-8?B?ZHF5aTkvR1dHTlovbG9IL2Y1RWlvRTByWG5xZ1FqcXRQUHUyVTMwalpxOTVF?=
 =?utf-8?B?aFNpL2l0RFB2NUR4aXBvQmpYSjZlZFRwMWU2YzVzTEZYYWI0d0tFOHJaZlJP?=
 =?utf-8?B?QlAyYWRROFBldmYvbEdESHFuZW1UeUFlTTdsMUFkd25HQTN3Wkx1L09LYzV0?=
 =?utf-8?B?MjdIbkJNVTBDZHZPalZESjROQlZoSENuQjBLWGc0MUFZSm42K212YVI2K0ly?=
 =?utf-8?B?cHJsUXRGTGduanQydGhzTTYzOXZyM2JNdjYyeDJBRmlXcEJGcVBWa1ZJU2tK?=
 =?utf-8?B?ZS9KazIyVmUvaUdpMW0zQWpwcjJ5RzdDNjhjL243dmd6dVA1VWhBQnhsQS9U?=
 =?utf-8?B?TWdzSko0R0kxQ2svT3kxK21Bcm55WlFQamlvTWhPaEpkdEFmQVBndDVTdjJs?=
 =?utf-8?B?Mi82emxLVkZubDI4aERTbzBJT09yV2dCWncvUGx5UDUxRkNNalpUeXZpalBq?=
 =?utf-8?B?a0xhajhYZzRkMk1NSE9WWVFTVHFVT1F4TTlZZ1BlYnR5MzV3ekxRS3p6UlJy?=
 =?utf-8?B?NzdnWFdqckl3MDBEV0ZMU2FHVEhYVDdJWUZQbXRyL1ZOK0RtWkZwNHU5d3Bm?=
 =?utf-8?B?RGk1TWhpWVRUeklQSXZIdWZOeHdQK0pydllHaDhhRTk5VGFZcUMvRVBPTkUx?=
 =?utf-8?B?L0lVZmNLcjVYY0xEZzUxcGVKM1p1Um1NdW1DL1J0cmYxMnBRWlNZTHh0UUJ0?=
 =?utf-8?B?ejY1OTM1bzJQZGFUSlBWOURnc2NQUUE5bXFNaGZUR2hoQ2dEeDhqZFVNcUJI?=
 =?utf-8?B?UlZtcldMcnF4YTdhS1lhVkhFMHBPMnNWWDhTWGFTTW80bW9ONTMvQUQ5Nlhr?=
 =?utf-8?B?OTRBL0ZwM3AzOVJVOVFsWFROYVl2NW0rTy9IOWlqVXI4YVNMcHo2bkJLTFZV?=
 =?utf-8?Q?E3Z/BIA4CFS+3WNR/j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a294f3f-27ee-4096-5d78-08de64f443de
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 20:22:20.6545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iAzEbp2bhJ8qPACUnaBg6xbrO8QuCnjc15vM3DYVWQmf5yFodqqEMFnFiHOTBykafEPC7oiiICSm8S3+YURVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgWGlhb2dhbmcsDQoNCkkgdGhpbmsgdGhpcyBpcyBhIHNlY3VyaXR5IHZ1bG5lcmFiaWxp
dHksIHRoZSByYWNlIGNvdWxkIGJlIGludGVudGlvbmFsbHkgdHJpZ2dlcmVkLCBzbyBpdCBkb2Vz
bid0IG1hdHRlciBob3cgdGh1bmsgb3BlbnMgcmVuZGVyIG5vZGVzLCB0aGUga2VybmVsIHNob3Vs
ZCBoYW5kbGUgdGhpcyBjYXNlIHNhZmVseS4NCg0KQWx5c2ENCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IENoZW4sIFhpYW9nYW5nIDxYaWFvZ2FuZy5DaGVuQGFtZC5jb20+DQpT
ZW50OiBUaHVyc2RheSwgRmVicnVhcnkgNSwgMjAyNiAxOjA5IFBNDQpUbzogTGl1LCBBbHlzYSA8
QWx5c2EuTGl1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEthc2l2aXN3YW5h
dGhhbiwgSGFyaXNoIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+DQpTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggdXNlLWFmdGVyLWZyZWUgcmFjZSBpbiBWTSBhY3F1
aXJlDQoNCg0KT24gMi81LzIwMjYgMTA6MjggQU0sIEFseXNhLkxpdUBhbWQuY29tIHdyb3RlOg0K
PiBSZXBsYWNlIG5vbi1hdG9taWMgdm0tPnByb2Nlc3NfaW5mbyBhc3NpZ25tZW50IHdpdGggY21w
eGNoZygpIHRvDQo+IHByZXZlbnQgcmFjZSB3aGVuIHBhcmVudC9jaGlsZCBwcm9jZXNzZXMgc2hh
cmluZyBhIGRybV9maWxlIGJvdGggdHJ5DQo+IHRvIGFjcXVpcmUgdGhlIHNhbWUgVk0gYWZ0ZXIg
Zm9yaygpLg0KDQpJIHdvbmRlciBob3cgcGFyZW50L2NoaWxkIHByb2Nlc3NlcyBjYW4gc2hhcmUg
c2FtZSBkcm0gZmlsZT8gVGhlIGNoaWxkIHByb2Nlc3Mgc2hvdWxkIGNsb3NlIHJlbmRlciBub2Rl
IGFmdGVyIGZvcmsvZXhlYywgdGhlbiBjcmVhdGUgaXRzIG93biBncHUgdm0uIFRodW5rIG9wZW4g
cmVuZGVyIG5vZGUgd2l0aCBPX0NMT0VYRUMuDQoNClJlZ2FyZHMNCg0KWGlhb2dhbmcNCg0KPiBT
aWduZWQtb2ZmLWJ5OiBBbHlzYS5MaXVAYW1kLmNvbSA8QWx5c2EuTGl1QGFtZC5jb20+DQo+IC0t
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8
IDYgKysrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9ncHV2bS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9ncHV2bS5jDQo+IGluZGV4IDAwZWE2OWJhYTEyNi4uZjdiMjM1OGEwMzAzIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5j
DQo+IEBAIC0xNDMyLDcgKzE0MzIsMTAgQEAgc3RhdGljIGludCBpbml0X2tmZF92bShzdHJ1Y3Qg
YW1kZ3B1X3ZtICp2bSwgdm9pZCAqKnByb2Nlc3NfaW5mbywNCj4gICAgICAgICAgICAgICAqcHJv
Y2Vzc19pbmZvID0gaW5mbzsNCj4gICAgICAgfQ0KPg0KPiAtICAgICB2bS0+cHJvY2Vzc19pbmZv
ID0gKnByb2Nlc3NfaW5mbzsNCj4gKyAgICAgaWYgKGNtcHhjaGcoJnZtLT5wcm9jZXNzX2luZm8s
IE5VTEwsICpwcm9jZXNzX2luZm8pICE9IE5VTEwpIHsNCj4gKyAgICAgICAgICAgICByZXQgPSAt
RUlOVkFMOw0KPiArICAgICAgICAgICAgIGdvdG8gYWxyZWFkeV9hY3F1aXJlZDsNCj4gKyAgICAg
fQ0KPg0KPiAgICAgICAvKiBWYWxpZGF0ZSBwYWdlIGRpcmVjdG9yeSBhbmQgYXR0YWNoIGV2aWN0
aW9uIGZlbmNlICovDQo+ICAgICAgIHJldCA9IGFtZGdwdV9ib19yZXNlcnZlKHZtLT5yb290LmJv
LCB0cnVlKTsgQEAgLTE0NzIsNiArMTQ3NSw3IEBADQo+IHN0YXRpYyBpbnQgaW5pdF9rZmRfdm0o
c3RydWN0IGFtZGdwdV92bSAqdm0sIHZvaWQgKipwcm9jZXNzX2luZm8sDQo+ICAgICAgIGFtZGdw
dV9ib191bnJlc2VydmUodm0tPnJvb3QuYm8pOw0KPiAgIHJlc2VydmVfcGRfZmFpbDoNCj4gICAg
ICAgdm0tPnByb2Nlc3NfaW5mbyA9IE5VTEw7DQo+ICthbHJlYWR5X2FjcXVpcmVkOg0KPiAgICAg
ICBpZiAoaW5mbykgew0KPiAgICAgICAgICAgICAgIGRtYV9mZW5jZV9wdXQoJmluZm8tPmV2aWN0
aW9uX2ZlbmNlLT5iYXNlKTsNCj4gICAgICAgICAgICAgICAqcHJvY2Vzc19pbmZvID0gTlVMTDsN
Cg==
