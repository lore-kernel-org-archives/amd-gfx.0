Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80593C02199
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 14:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313CB10EB25;
	Fri,  7 Feb 2025 14:37:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VtgUSo2e";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2803F10EB2A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 14:36:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtCWgoj5r8jXee7X8VhlzfiQ74C7TYkjS33OeH9fHX1EG+tTolorEYoGAR7bWL4KnFMtaU9+220NL63Jc55wWJ4f0sOxUOPTFZUXizmLfymanNVH3GxVAcfZX6Cs66oCiqIyGTI0jSROXskKyJYNq8EiN58zK5EP87ufU0rJVYDCYX3QdY31s3Tsdh0kEfjhBEIdf0pN8P/mwZ8UA5Nuvb2cUBytJeHbrBPhUvmDoboTJF/DDbAuLOgjCWaHhG/elSZNegbtmJS2mQh0C16aVo19pncMA2Pfn4oUO1lF9iktC05hNvZzel38fFKCgANFfyaNPksvxV7dG3QRz27izg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s5NhgYstRSaK9vNBOfGFLIIMC9geaO7lBslnnyRMOk=;
 b=lhc3Dx7XD2cp9JkFI/TQrtDmfXFCWcaSZopqs77syAByvCqXyw6Xebb93jJ5D57ZeMpCc7w24gM3OUZUiW8tHerWj6M6EOWVTLmADWKSjHNUrO+ExdUvxR3v59oE4YxdT7YZ/cCvz4jHCohFi8QVnKbWzo7BckSlrt0JZDYN/+TzZV15yOCP/0uH7byv+paAtyTjMXv+BGndmyPN65MiLzU4JFdtfilTGljxdzB6AOiznujTaZ+ieuhO0FzZXSYNC+DyvPKUjktQ4Ox80VM9ODKoc0JF+ZpQRBAc6TRf+IN3zMjOQBLyKzuR5pAq82HxCv9qy6+op9zyNeIiO6SRqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s5NhgYstRSaK9vNBOfGFLIIMC9geaO7lBslnnyRMOk=;
 b=VtgUSo2einh+sltE2+W2S2SGXzkDyRMbP5MVJpFcwSxMneHEEXl7KMTzEwBIQepcEAAx5CZPDgw8WCVQTWY/D24Tt7PLfhqxaY/g7VUY4p+pLf04xD5U7VBHdGLQmFaXKPN0ZWL9TlnuKd+krnbmXLRSKb0E8UBq98vphXN3rwY=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 14:36:10 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 14:36:10 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Topic: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Index: AQHbeJjnBkTSX11A7kaLj0Yc6dV7/bM66/vQgABLTACAAKRScIAACgyAgAAAHPA=
Date: Fri, 7 Feb 2025 14:36:10 +0000
Message-ID: <CY8PR12MB7435100E613BA33C8CD4B2DD85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-3-lijo.lazar@amd.com>
 <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
 <22d2c3e8-98f9-4ea3-9737-08e9812d312a@amd.com>
 <CY8PR12MB7435B4D359268091F915407F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a5bc0dcc-3aba-404f-aee4-f664a71b7a1b@amd.com>
In-Reply-To: <a5bc0dcc-3aba-404f-aee4-f664a71b7a1b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=218e0082-6b46-4e5c-b4fa-2a8bbb6004be;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-07T14:35:05Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|IA1PR12MB6235:EE_
x-ms-office365-filtering-correlation-id: 07731fae-c387-4487-931e-08dd4784c3c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Wk5ONko0dkNaSU9YL1FvdWdxYlhXTjE5bzhmbHBOck0wZS90UmJjWWpqRzRw?=
 =?utf-8?B?Ri83OHBSMXcraGtzdXV2Nm5CU1BrZ3ZRSnM2UzJxRGRwcEFraUx0K21lTmN6?=
 =?utf-8?B?Q2F4QlMxYVlKQjdxekd5YXJZOTFXSXRQOWVBZ01HQ0hUb1lpUlRQUnB4c1kx?=
 =?utf-8?B?b3M3cC9MOXNJT1BNZ1BXNTZQcWZ5MlVrSi9kK05HdzBMQmJHa29xc0Nneito?=
 =?utf-8?B?eHF6UWpSTUoyOTd2MTM5c3BmUm0zMEhmMmtoWUFzK0ZGbzFMM0xWcE9HTC90?=
 =?utf-8?B?TFZGTEpvL2JDTlNVSEVXcG5xVGw0dnRQNDlKUTlZc1JnUHplM0lLRnhrdkZi?=
 =?utf-8?B?S094YnVnalhKYUljaFlNMlhwM0NFSndzWDVQeTNZVlJPeXdtb1JNNUYxdzhH?=
 =?utf-8?B?MGhEMGk2eGl3RE5sRWphVGR1TnhRczZoZFNEemhvcnk5WWpvM1FvbERyd3dh?=
 =?utf-8?B?OXUvNWx1aHp3S2JiS2U1Rlc0RVV6R2NlMFBEeklxQWw4VEJBbmNLUGxsVGhM?=
 =?utf-8?B?NHNxQlFjdHZkVTA2a204WXBBRHBibHQ0M2VYMW9aOENJWEdoYlJCaVRJTWI3?=
 =?utf-8?B?bGVEZEhlbWN6WkQra3htRG5KQjBDRVJhUmRsMXgybENqTUhLZ0FQdVZPd3d3?=
 =?utf-8?B?MHRCNERMcFJLREJkK1hCYnk2YktZQ0xML0g5MjdxYjlTWEVoV1ZCMWtud0J3?=
 =?utf-8?B?bVk2RkRZV2xJWHovWVJKT2V2ZjBadk5oUnJBQ045TDFxRDZ5OUhXUllaMjR2?=
 =?utf-8?B?S0Z4Rkk0YWdFbEZLMkt6SW1qcFBhNjEzVHE2bTFvemd0RzN5RWk3U05CaGFX?=
 =?utf-8?B?Z3pTSzJQcTU2cGwrWlhuWko3K0Q0UDZNYkUxSE5lYks2VnpISnljcTdYcW9F?=
 =?utf-8?B?K1M1QkU2d24yNFpOdy9IVXZxQ1JHc1M5eGlzKzgrZzlQSEo2M09Oa0dWSG4y?=
 =?utf-8?B?Ni95Smw3VXZNdmxQeEh0bXpQd082V2VuekttV3lXVVUxekFRbWRLRGFVT0Fv?=
 =?utf-8?B?eXpOaktteDJlWGNDbTJlNUVkQzFrbXhOSUZLRTNKL1MrOUhPWUpmQlJNMnpr?=
 =?utf-8?B?RFp4V2JxVWtXWkloR05BMzRzdmdVdWJzekNHMG9GVnpzeUhIS0picDMzU3l1?=
 =?utf-8?B?cHkxdnlQVmZlU0NndGRIbW5tb24yR2dtY21qdVZBODBxaGk2dHoxL2xmWXZl?=
 =?utf-8?B?K0dUZmJ1b1BmcnM0bkltcGZyb2Z2NnZLOTNlZGFzUTZuTGdhR1VCMTZQTExh?=
 =?utf-8?B?eHo1RDdyaFl1cUV0M0pZTzk5MnZhRHUyTDJEVTZFbkY5L3VWbFNuL0xsOWJ5?=
 =?utf-8?B?dllLcnorb3RRSy9aZFh2a2wzalFYR3owUytPUjlwblpEZG1KKzVvbzg1U2U2?=
 =?utf-8?B?U0Z5Z3FpbC9BaXVzc3pNSFZ4ZGlrYlVCMTlCeUJ6Snk0TDBlMmRPNjEzM3NV?=
 =?utf-8?B?TWdBektiQWJJaGcvd09QOFpmekY5WDF1eGRUbkowdEwrY3BIc0RFQ3p6Mmw3?=
 =?utf-8?B?cE1iOTRmT21sWGRxVWwzdDhHU25BTjVmbUtCQ1FTaVhSLzNSOExqVnVVUnNF?=
 =?utf-8?B?Y1daT1pZMHBOaHo1Y21lWkNkWnJqSlcyc2hWVUZsbU5aMzNrNmZlQ1RtOWcr?=
 =?utf-8?B?Wko4TGZzQ3Q3VUhGNGErTE9SL3dHSW9YSUo1N1BGYXZJUGxhSjRMVGVmVkht?=
 =?utf-8?B?cVFpbnBiVEoxTGw3cE5OOTRJSndnZmtCWk1YcXVERHh1MDFTTmc0ZU5HQ0Ny?=
 =?utf-8?B?QTN5NkprU0wrY3g2MURFTkpwNDg5ZzlBOHFWVlFUdE1DQlNvRkRkcDk0VCtK?=
 =?utf-8?B?VjJZY0ZLWHNueWN3VFZjVldVVnBWYjVXNkZnQ3lLNkpRN1lCaXFyZUJVamxB?=
 =?utf-8?B?dW1LOXpRUTZEUUF5V0VER0NaaE80UVdxeWwyaUN0ZGtOcTNvTWl1ZTdEOXdx?=
 =?utf-8?Q?AqxnRNhAZ3F6PhTU8lO4g/Xv5H8MU+IF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dldIZ0J0T1RoK0lSRFpJVnNycHFrdnN6djdhbHlKMVBXdExyZ2xSaGNmcDZs?=
 =?utf-8?B?b3NDSmNGQTRkZnRvM1FoT29MbCtXejlwRFVkcVFMRWNkLzBYdVFoQlNsbnFq?=
 =?utf-8?B?bUd2RnhQY1d6Z255aFA4YnNQRmZrMnd2MUl6cnJLQlZ6SlBPa3hZVk1PSHQr?=
 =?utf-8?B?eXRlRkI3aGlOeGpQZ2MvZXg1ci8va3pOV1dRNDNLWjFucXJnZzVWcXNSZFN0?=
 =?utf-8?B?Zm9BL0pGQlk2LzBpUTEvenlydHZiUUFONDh1aDVCWlZMaFBMcml3WTZ2RTRm?=
 =?utf-8?B?SmE0UlV2NjdUZ2lrMnhQeGFDSHJZQWtYVkVtYjVvRHNnKzJmUk9jdnRVVnBL?=
 =?utf-8?B?T3FEMFp4cmhqcnNHdmIyaEc5TW1pa01hUXlQczMveXVaVXg2S1Z2WWJVa2N0?=
 =?utf-8?B?a1IrZDVOZEh1UHlWWHhGUEhCQ3lmWDlsd1l0cHBCVTZ4WDE2NGVzQ0pHd0s2?=
 =?utf-8?B?aVpsb2JnZlZkMG8xZ0NsZFQ1c1ZuOGhYdENPdWJ4bnlUem5vN2NyR0gvQkM4?=
 =?utf-8?B?eE50bTFSdVp6N3AxVCtuU2VxOW9oNVV3bUVPK29FdXBseDZxb0NWYTlBZlZN?=
 =?utf-8?B?ZGdCNE13V2JBNm9wamRiWEErVWc2WmlTcUo5M0VTb1F1R1U1UmRjRDRRekx2?=
 =?utf-8?B?elp3NHZIZUpOVUxIRGx2YU9TcW1EbHhHajRVejkvaFlUUTZYT0tHNkNlMnBn?=
 =?utf-8?B?Q3RSZzJUL0drNkFzOEQ0Q3V0T3hBMzBsOWhMbXNnNEZ1anJBZ3V4czEraHlm?=
 =?utf-8?B?YStuaXJFT3FRcyszc25VRTJjL1J4SFVSeTNFZ3Ruazl6S1J3cDJHUjJWMlAx?=
 =?utf-8?B?bWJSaUNiZTMvd0RQeEt4VFFUTkVaQkVIQ2Q3VUYrWlRoVjllWFE3SHNwRW8r?=
 =?utf-8?B?VzN0L2Vsek56clA2WHY0TE5yTUtlRVdXUUZuYWN3ZVkzTGJjTzQzUTZucXVN?=
 =?utf-8?B?c0ZDSFNrU0RFekZOZGd1Z1BobU9RWml5WEx1NlByMDFxdGlVcWRIbHY3R2pn?=
 =?utf-8?B?LzZrMXZjcWdUSDl4WFpodnl6T3oxKzFEazFrMDBKeEtVM3dBRkVSYW5JZjBZ?=
 =?utf-8?B?NVRuV0N3Y2JDa1RDd0RJS2QzYjdOSWxGbGtQZGN2N0dFa2s3Z1pYUDh5akJl?=
 =?utf-8?B?UUNLNWZTQjVWT3dQSi9ITHZnT0dGZ0lvdndueDFqVVNNSmMxdEczVjNtZWNy?=
 =?utf-8?B?U25OWHZwTEx1MHVyZXV0My8zanZwc3BReGg0dUdKdFp6ZFFjVlFuN3dIYkFD?=
 =?utf-8?B?Q0plQk5WaWM1REJ0aUIycnQvc3BXclhqb3g0cHNFdlFFZkdhL2tuSjE5eU1v?=
 =?utf-8?B?OTNvWkcwQlM1QTlYdFRNZitBeENGdzRZNm9nK0lJYzRjeWJYQ0lJclhqMGpn?=
 =?utf-8?B?blEvaTNHUk1KMEJnSm1xekxvckRSUlo1YVZnS0hKMndkSGQ4ZkJsOEk1YU5P?=
 =?utf-8?B?NlVzbXN5d1JnMU5JY0VpSlRFQkhaN2hESGRwNEszVXpFdTR1WWk1dDJweWJR?=
 =?utf-8?B?OEhmdWNvUzdZSDdnNEhqTVo3TjR4NFRXUUg5Mi91d2tNSlh5czg0cUJXNjg0?=
 =?utf-8?B?TmprbEhPMWhYMlZ0cHdYaENQKzV2ejVablByNDhxQ3BsazE5dG9qOXc0QVBQ?=
 =?utf-8?B?dkpoV0piaFZwUGNJL0srcHBDSDFrL0tCem1Hc3RDZkgzTFg1ZVpCY0pNUkdy?=
 =?utf-8?B?NTJyOEQ5TTh3a09Fb3dKUERIcHRiVDhKMzY5V0g3b0J0SmJXYU9od3JPa2F0?=
 =?utf-8?B?TGZ3Q1R1Y3V1QzE4VlBNRU10V1drNit3VldNL002RHdsdndiVDA0K3dDb0di?=
 =?utf-8?B?Ri9hTVVnUGFNcUFTdlBHZW14c1B5Mkczbmo0MlhyMkFQcC8wb3VoekNJNHBr?=
 =?utf-8?B?VFdxZlZrb05WcnpBc21HcVVvWE13NVk3dktpRXVkNWM4MDc5SGhPa2VwK0Q5?=
 =?utf-8?B?Ukc2cDYxQlZ6RXZMOVNrWFhlWGtPdmlRa2ZxZnZCZ1ZuMlVxZlFrOVFsOWVs?=
 =?utf-8?B?bXRNblhKbVBqM0V5WDZ3bVo3b2FYY0MxeU1qMkdQT0pOcE5lVWtwL2lLeG1p?=
 =?utf-8?B?ckxkdHM4OWFaMUpuZGJMdjhEQzNNcFpmcUw3a3J3UU9Dd0RTWDdNNDBNUE4r?=
 =?utf-8?Q?iQk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07731fae-c387-4487-931e-08dd4784c3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 14:36:10.1537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7airxvBMB5UZ3Jp08+LnhR1dcSe98LymUiw2RPvlxY66wrTfWoGu2TQK2d1c1Ef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDcsIDIw
MjUgOToyMCBBTQ0KPiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzRdIGRybS9hbWRncHU6
IEluaXRpYWxpemUgeGdtaSBpbmZvIGR1cmluZyBkaXNjb3ZlcnkNCj4NCj4NCj4NCj4gT24gMi83
LzIwMjUgNzoyOSBQTSwgS2ltLCBKb25hdGhhbiB3cm90ZToNCj4gPiBbUHVibGljXQ0KPiA+DQo+
ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IExhemFyLCBMaWpvIDxM
aWpvLkxhemFyQGFtZC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA2LCAyMDI1
IDEwOjU2IFBNDQo+ID4+IFRvOiBLaW0sIEpvbmF0aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+IENjOiBaaGFuZywgSGF3a2luZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHJt
L2FtZGdwdTogSW5pdGlhbGl6ZSB4Z21pIGluZm8gZHVyaW5nIGRpc2NvdmVyeQ0KPiA+Pg0KPiA+
Pg0KPiA+Pg0KPiA+PiBPbiAyLzcvMjAyNSA1OjAzIEFNLCBLaW0sIEpvbmF0aGFuIHdyb3RlOg0K
PiA+Pj4gW1B1YmxpY10NCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4+PiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiA+Pj4+IFNl
bnQ6IFRodXJzZGF5LCBGZWJydWFyeSA2LCAyMDI1IDg6MTMgQU0NCj4gPj4+PiBUbzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+
DQo+ID4+Pj4gQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBLaW0s
IEpvbmF0aGFuDQo+ID4+Pj4gPEpvbmF0aGFuLktpbUBhbWQuY29tPg0KPiA+Pj4+IFN1YmplY3Q6
IFtQQVRDSCAzLzRdIGRybS9hbWRncHU6IEluaXRpYWxpemUgeGdtaSBpbmZvIGR1cmluZyBkaXNj
b3ZlcnkNCj4gPj4+Pg0KPiA+Pj4+IEluaXRpYWxpemUgeGdtaSByZWxhdGVkIHN0YXRpYyBpbmZv
cm1hdGlvbiBkdXJpbmcgZGlzY292ZXJ5Lg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTog
TGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgfCAyMCArKysrKysrKysr
KysrLS0tLS0tDQo+ID4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiA+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ID4+Pj4gaW5kZXggZWNhNDMxZTUyMDM4Li5k
NGVhZGUyYmQ0ZDMgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ID4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ID4+Pj4gQEAgLTI1MDIsNiArMjUwMiwxOSBAQCBz
dGF0aWMgaW50DQo+ID4+IGFtZGdwdV9kaXNjb3Zlcnlfc2V0X2lzcF9pcF9ibG9ja3Moc3RydWN0
DQo+ID4+Pj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPj4+PiAgICAgICByZXR1cm4gMDsNCj4g
Pj4+PiAgfQ0KPiA+Pj4+DQo+ID4+Pj4gK3N0YXRpYyB2b2lkIGFtZGdwdV9kaXNjb3Zlcnlfc2V0
X3hnbWlfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPj4+PiArew0KPiA+Pj4+
ICsgICAgIGlmIChhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBYR01JX0hXSVAsIDApID09IElQX1ZF
UlNJT04oNCwgOCwgMCkpDQo+ID4+Pj4gKyAgICAgICAgICAgICBhZGV2LT5nbWMueGdtaS5zdXBw
b3J0ZWQgPSB0cnVlOw0KPiA+Pj4+ICsNCj4gPj4+PiArICAgICBpZiAoYW1kZ3B1X2lwX3ZlcnNp
b24oYWRldiwgR0NfSFdJUCwgMCkgPT0gSVBfVkVSU0lPTig5LCA0LCAzKSB8fA0KPiA+Pj4+ICsg
ICAgICAgICBhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBHQ19IV0lQLCAwKSA9PSBJUF9WRVJTSU9O
KDksIDQsIDQpKQ0KPiA+Pj4+ICsgICAgICAgICAgICAgYWRldi0+aXBfdmVyc2lvbnNbWEdNSV9I
V0lQXVswXSA9IElQX1ZFUlNJT04oNiwgNCwgMCk7DQo+ID4+Pg0KPiA+Pj4gQ2FuIHRoaXMgc3R1
ZmYgZ2V0IHJvbGxlZCBpbnRvIHhnbV9pbml0X2luZm8gYW5kIGNhbGxlZCBkaXJlY3RseSBpbnRv
DQo+ID4+IGFtZGdwdV9kaXNjb3Zlcnlfc2V0X2lwX2Jsb2Nrcz8NCj4gPj4+IEJyZWFraW5nIHVw
IGRpc2NvdmVyeV9zZXRfeGdtaV9pbmZvIGFuZCB4Z21pX2luaXRfaW5mbyBhcyAyIHNlcGFyYXRl
IHRoaW5ncw0KPiA+PiBzZWVtcyBhIGxpdHRsZSBjb25mdXNpbmcuDQo+ID4+Pg0KPiA+Pg0KPiA+
PiBJbnRlbnQgaXMgbGlrZSB0aGlzIC0NCj4gPj4gICAgICAgU2V0IElQIHZlcnNpb24gaW5mby4g
VGhpcyBpcyB0aGUgam9iIG9mIGRpc2NvdmVyeSBhbmQga2VwdCBpbnNpZGUNCj4gPj4gYW1kZ3B1
X2Rpc2NvdmVyeS4NCj4gPj4gICAgICAgU2V0IGFueSBzdGF0aWMgaW5mb3JtYXRpb24gZGVyaXZl
ZCBvdXQgb2YgSVAgdmVyc2lvbnMgYW5kIG5vdCBhdmFpbGFibGUNCj4gPj4gaW4gZGlzY292ZXJ5
IHRhYmxlcy4gVGhpcyBpcyBrZXB0IG91dHNpZGUgb2YgZGlzY292ZXJ5IGZpbGUuDQo+ID4NCj4g
Pg0KPiA+IFRoZW4gd2h5IGFyZSB5b3UgcHJvcG9zaW5nIHRvIHNldCB1cCBzdGF0aWMgaW5mb3Jt
YXRpb24gaW4gdGhlIGRpc2NvdmVyeSBmaWxlIGluIHRoZQ0KPiBmaXJzdCBwbGFjZT8NCj4NCj4g
SSBkaWRuJ3QgdW5kZXJzdGFuZCB0aGF0IHN0YXRlbWVudC4gVGhlIGZ1bmN0aW9uIC0gYW1kZ3B1
X3hnbWlfaW5pdF9pbmZvDQo+IC0gY2FsbGVkIGZyb20gZGlzY292ZXJ5IHNldHMgdXAgdGhlIGRl
cml2ZWQgaW5mb3JtYXRpb24uIE9ubHkgSVAgdmVyc2lvbg0KPiBpbmZvIGlzIHNldCBpbnNpZGUg
ZGlzY292ZXJ5Lg0KDQpTbmlwIGZyb20geW91J3JlIGxhc3QgcmVzcG9uc2U6DQo+ID4+ICAgICAg
IFNldCBhbnkgc3RhdGljIGluZm9ybWF0aW9uIGRlcml2ZWQgb3V0IG9mIElQIHZlcnNpb25zIGFu
ZCBub3QgYXZhaWxhYmxlDQo+ID4+IGluIGRpc2NvdmVyeSB0YWJsZXMuIFRoaXMgaXMga2VwdCBv
dXRzaWRlIG9mIGRpc2NvdmVyeSBmaWxlLg0KWW91J3JlIGNhbGxpbmcgYW1kZ3B1X2Rpc2NvdmVy
eV9zZXRfeGdtaV9pbmZvIHdoaWNoIGNhbGxzIGFtZGdwdV94Z21pX2luaXRfaW5mbyB3aGljaCBp
cyBzZXR0aW5nIHN0YXRpYyBkZXJpdmVkIGluZm9ybWF0aW9uIGluIHRoZSBkaXNjb3ZlcnkgZmls
ZS4NCkEgd3JhcHBlciBjYWxsZWQgaW4gYSB3cmFwcGVyIGlzIHN0aWxsIGRvaW5nIHRoZSBvcHBv
c2l0ZSBvZiB3aGF0IHlvdSdyZSBzYXlpbmcgaW50IHRoZSBzbmlwIGFib3ZlLg0KSWYgeW91J3Jl
IHRyeWluZyB0byBhdm9pZCB0aGlzIGFuZCBrZWVwIGRpc2NvdmVyeSBjbGVhbiwgY2FsbCB4Z21p
X2luaXRfaW5mbyBpbiBhbWRncHVfZGV2aWNlLmMgc29tZXdoZXJlIGFmdGVyIHRoZSBJUCBibG9j
a3MgYXJlIHNldC4NCkFuZCBwdXQgeGdtaV9zdXBwb3J0ZWQgZGVmaW5pdGlvbnMgaW4geGdtaV9p
bml0X2luZm8gc2luY2UgdGhhdCBkb2Vzbid0IGNvdW50IGFzIElQIHZlcnNpb24gc2V0dGluZy4N
Cg0KSm9uDQoNCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+ID4NCj4gPiBKb24NCj4gPg0KPiA+
Pg0KPiA+PiBUaGFua3MsDQo+ID4+IExpam8NCj4gPj4NCj4gPj4+PiArDQo+ID4+Pj4gKyAgICAg
aWYgKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIFhHTUlfSFdJUCwgMCkpDQo+ID4+Pg0KPiA+Pj4g
TWF5YmUgcm9sbCB0aGlzIGNoZWNrIGludG8geGdtaV9pbml0X2luZm8gaS5lLiB2b2lkIGVhcmx5
IHJldHVybiBpZiBudWxsLg0KPiA+Pj4NCj4gPj4+PiArICAgICAgICAgICAgIGFtZGdwdV94Z21p
X2luaXRfaW5mbyhhZGV2KTsNCj4gPj4+PiArfQ0KPiA+Pj4+ICsNCj4gPj4+PiAgaW50IGFtZGdw
dV9kaXNjb3Zlcnlfc2V0X2lwX2Jsb2NrcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4g
Pj4+PiAgew0KPiA+Pj4+ICAgICAgIGludCByOw0KPiA+Pj4+IEBAIC0yNzY5LDEyICsyNzgyLDcg
QEAgaW50IGFtZGdwdV9kaXNjb3Zlcnlfc2V0X2lwX2Jsb2NrcyhzdHJ1Y3QNCj4gPj4+PiBhbWRn
cHVfZGV2aWNlICphZGV2KQ0KPiA+Pj4+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4+Pj4gICAg
ICAgfQ0KPiA+Pj4+DQo+ID4+Pj4gLSAgICAgaWYgKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIFhH
TUlfSFdJUCwgMCkgPT0gSVBfVkVSU0lPTig0LCA4LCAwKSkNCj4gPj4+PiAtICAgICAgICAgICAg
IGFkZXYtPmdtYy54Z21pLnN1cHBvcnRlZCA9IHRydWU7DQo+ID4+Pj4gLQ0KPiA+Pj4+IC0gICAg
IGlmIChhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBHQ19IV0lQLCAwKSA9PSBJUF9WRVJTSU9OKDks
IDQsIDMpIHx8DQo+ID4+Pj4gLSAgICAgICAgIGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIEdDX0hX
SVAsIDApID09IElQX1ZFUlNJT04oOSwgNCwgNCkpDQo+ID4+Pj4gLSAgICAgICAgICAgICBhZGV2
LT5pcF92ZXJzaW9uc1tYR01JX0hXSVBdWzBdID0gSVBfVkVSU0lPTig2LCA0LCAwKTsNCj4gPj4+
PiArICAgICBhbWRncHVfZGlzY292ZXJ5X3NldF94Z21pX2luZm8oYWRldik7DQo+ID4+Pg0KPiA+
Pj4gSWYgeW91IGRvIHRoZSBzdWdnZXN0aW9ucyBhYm92ZSwgeW91IGNhbiBqdXN0IGNhbGwgYW1k
Z3B1X3hnbWlfaW5pdF9pbmZvDQo+ID4+IHVuY29uZGl0aW9uYWxseS4NCj4gPj4+DQo+ID4+PiBK
b24NCj4gPj4+Pg0KPiA+Pj4+ICAgICAgIC8qIHNldCBOQklPIHZlcnNpb24gKi8NCj4gPj4+PiAg
ICAgICBzd2l0Y2ggKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIE5CSU9fSFdJUCwgMCkpIHsNCj4g
Pj4+PiAtLQ0KPiA+Pj4+IDIuMjUuMQ0KPiA+Pj4NCj4gPg0KDQo=
