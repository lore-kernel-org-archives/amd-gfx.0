Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37BAC7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 13:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8C010EA3F;
	Fri, 27 Jun 2025 13:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lbOD+R6A";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E8C710EA3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 13:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVqmzDyy1eBIRYbI5I6o3PVsK9qvv4WgqpdAtTvlcWfibzoUAF/FUIdUBMcZQrG/VLxc4mwGOlT4hVMcSvl+FOozu3c6S19ug1KGz9jS3jisLFppP9pObpARhBbY2q2E6s5PPn3aBOnSaSMpr9M+dx/DTBVYbL452qCuDDEcim8902g+Uz+ZRowHHYlJmR6lHVnvETf0jstH8z9OHLTcXPPk6NRMcSihsByf1jp4smsmiugz9BO9ZkyD7wArZcVrEuZwi/RDEUtNDdBOP2MGpgAmkS4JYV/Vz7LfRLAOFMInqcFarc6BggCztVnpkkhlPPfp19l7uD3FODwonxN+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WKCpUCOMqCvCCijE6yV5vE36MVqQAFmSci5Mg9VMKo=;
 b=C1xa1nLpQyDVtj3X9/y4nvB/jRN2mU5NVznessnlsqFZFa6OUhDc00Y6lQsEyU+oz1rrZHC6cmr6xhsVVGf5fn4kJ/eiTehRI5Iu/7WsThn9xcw2bVh+iAx9huvkp+LaXN5TKpqJpr7ewZHXA+kKq20yZYk40hrzLq7cFxSa4Sm0fflnkXgZhnhloHD1qUOL8eEraQhma8T2IZfxCqy5EsMevjyOwYbK5quPSsRnLj1Cz/xB4PfKLD77f23bBGBe8tlGcSWmodNcTCfzGfziLAZH4gbbYW6178UQJls6tdRChaJmDNIZ+HdaGXlk5fAB/mhRfwZ/OUoppD/g9TFv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WKCpUCOMqCvCCijE6yV5vE36MVqQAFmSci5Mg9VMKo=;
 b=lbOD+R6ANyqMEGeSxPQhvqlTxc1JVVqLZ7Q3+jcrZvqfd/b9G2sVL6RcLlc6vqV1upOEd7SUHYacz9ycuWPGYwUNN97n1SIXmyfyVqH1TdpQlXIf5MiiONyudjqJZhSUJvZUHyBk/uenPtt2FLqiIhBmspi6SOOyaJgTAxalwCU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Fri, 27 Jun 2025 13:35:02 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 13:35:02 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v4 03/11] drm/amdgpu: unify the userq doorbell object
 destroy
Thread-Topic: [PATCH v4 03/11] drm/amdgpu: unify the userq doorbell object
 destroy
Thread-Index: AQHb5ORluL0Lp/RkrU+FZMLWe+9qW7QTg7KAgAN6qAA=
Date: Fri, 27 Jun 2025 13:35:02 +0000
Message-ID: <DS7PR12MB6005AF913DA49F4DAE419E6FFB45A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-3-Prike.Liang@amd.com>
 <52b2c11c-9bac-4bfc-b690-9e05acdaeac1@amd.com>
In-Reply-To: <52b2c11c-9bac-4bfc-b690-9e05acdaeac1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-27T13:05:02.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM4PR12MB7503:EE_
x-ms-office365-filtering-correlation-id: adad8857-a81f-44d8-3cfb-08ddb57f6b51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bEdHL3BQdUc3Tko3dUpKQlpKVVpoNEpJZVF1NDNDdytFTVdiaEhvQzdGUkor?=
 =?utf-8?B?L1crOG9qaXBkeENyMlRSTC83MUtqbzcwVC9lbDlHT2xvY1pCcmdsSFIrclBs?=
 =?utf-8?B?ZDdJQnVaVzVINjhiN2ViVnRyZ2FOWXI2RlVsb0JGRndxK2lTdWJHcVNVNnRQ?=
 =?utf-8?B?d1BUekFjR2NmRkdlaUNmMTNrc0hHaHFITjZVeXFqTkU5b3B4UkpyQThGRVJ6?=
 =?utf-8?B?dEhRbmRieU1tT0h4UXo4TjR0ZDZGbko3MnFmR2dYeUpkOVQ3V3R5cjdodnZW?=
 =?utf-8?B?RFlndTJLVk5QQXpSM3ArZjYzalpULzV6R2JxNS90dGxKcTBSaG9wRlo0aUI0?=
 =?utf-8?B?TFRVa3M0Z1A5dm1QVU9GNEJid1p3Si9GTjU0ZVhrTXVBcENCVnVvVDlCbFM3?=
 =?utf-8?B?WXFkZjlQUGNYWkxtdFJXOTBRYnJza0ZGQ1c4am9CcXU3NUFyM05oRXdMcjRl?=
 =?utf-8?B?cjd4K21weU1nZi9VcjBETEFRN3oxdkdEbVo2NngrMjRzUXhxYk5mVmlyWkoz?=
 =?utf-8?B?WXJneFZsT1B2NjJpOGJBcnllcGF5N1NvSWpZTFp1ZjZ5Y1BWbW5nTXMyQXFv?=
 =?utf-8?B?RkhjVHd0ZE1jUmxIakx6RW41K3JDWkQ4MlVpMnA2WEQzZzVhKzhYL1Ywb1di?=
 =?utf-8?B?Q3I0WE00S01hNU5qRHNUbWFyUEhSTmdOU204cUZVRXJMaDFpWTQ4dWpCU0RJ?=
 =?utf-8?B?RDEwUk8xUUZTNGhzQTgwL0ZjcENWR0o3MGliMXBJRXdoZldhQThlS1g0OGYr?=
 =?utf-8?B?VGxWc2RlMko2MHB3YXFKWXVDZ3VZR1BHajE4ZjJITDBNeFFxTDUrQ3R4NDdC?=
 =?utf-8?B?a1hQZVl6VHJRZ1NWYWJjR2x5VU1aelpHSWJROUE4NGZmZDFOQzJPVmo1VTF1?=
 =?utf-8?B?aTdqazNYQ01ZVG1yOExhOUFhNHZDRFM3d1ZFTitFbmNNR0J3azh6MTZvb2pO?=
 =?utf-8?B?cCtKcVErbXVRNkU1enk0NXQ2OHQxQVJlamJFbDBDTHowTldrbTBoYS9OWURz?=
 =?utf-8?B?Sk0zcEMzcWo2SFlGNHoySVgya3RsWEtxelgzU1g1L2tZaEZGZGw1RmlHdGh1?=
 =?utf-8?B?N1FPMTlhVWxJUkdLNDFmVU04cHc2SXlSVXNIY2Ixc1VBQStpKzdEc2UxdHQy?=
 =?utf-8?B?VkdoZnZlT3EyYW1aQkc2K2VldzV5eTNBRWZia3ZTak43bU9tL1p2WHYrKzFX?=
 =?utf-8?B?aFh0WGsweG9sTUYvaDl2c3NXVHVUazBLVnRvVDdWVjVTUlIzemVpbGJRb2JB?=
 =?utf-8?B?WnVVZFJKdzlwZVdZN0NTbDFEN0VSTCtoSW5SUmtjZU1iZG5xaHV6K2ozT3Nm?=
 =?utf-8?B?V1VscFkzdDBPUmN2MXRZb1pUYXdmcUo3Z1lHK2JGNEZzWWZZcGZLRnRJRGdC?=
 =?utf-8?B?L0Y0S3VtYjFBQ0lYemNqb3FkZlVlWDJkdEJDWTQ1WS8ybDBDZHFjK0NDMW45?=
 =?utf-8?B?Qmg4UngxMUxtako1M2dYN2RCRzlPbkxoZ00vbXRLclZweGdYSFZsZlF4K0xJ?=
 =?utf-8?B?bnFkNndhRWw1dkc1b2JsQUdUWU5MOHdZYld6SjR4bTA4TVdWUGljZCt0QzNP?=
 =?utf-8?B?OS8wa1JEa0JuWmRRWUllOG5YSXdpUzVFMWRBWWt0Z3ZhOFhLZzlzYm5ybVkx?=
 =?utf-8?B?ZGw2eGZ5NXhnVWhQRFFqSjhEN3hwL3I4UlkyTGlGZnl6MFlRbDczVk9QeFU1?=
 =?utf-8?B?dFJVTkhvZy9TYmFvQVZFSTNxQnZhcWN1OERTWFByY2E3QzZjK1hKM0VOSjk3?=
 =?utf-8?B?bi9xNTQ0blNHN2R0aHJjNVNaYjNCRk5zRDBHZGdYZWx1WGFEd3o0dFNXUWx0?=
 =?utf-8?B?ckNhY3BNcmNDcEh1c3lUU3NLUWZsYUdZQnpwUUpBVTg3YXNwUVc1UFpXa3pU?=
 =?utf-8?B?Y3IzcFI2NWRaenJQb0tXYUtsZTB5VnJGZ1g2VVFWMDlxWGFNeUlTc0lXTldy?=
 =?utf-8?B?eElXTDBRQU9OakZmUEVIajhWa3FLa3ZjUGJETHRYMW8vSEhhVE5ibG9KNWt6?=
 =?utf-8?Q?w7xeXxx9j8B7FipRJGDd5+nDN8C1oE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWtLb0RmaG00ZG9IMkczYndFcDNNN084NnRZYWRtbjJReGgyMVRkY01PRjlw?=
 =?utf-8?B?YWxNK1Q0U0dHZXkvd0tOdmp1a040dmxwYkl2Q0xzaHVZT0l4cjcwTkwvbFJj?=
 =?utf-8?B?TC9xZDVzWjZWdDB1VkhKWUhhYkloZXVDelpEc05OUFVMRTJLUlUyNFUrQ0hK?=
 =?utf-8?B?R0IvUFVNSWNJc1lwdEVOWm9hUGY5SzFXbXhXL2ZncTA4bmxnVlZiVVNJNnRs?=
 =?utf-8?B?aFZqdWdOOEcxZkJUQWVmK0FxRVNlZjBLSHIvemFrK24vRGlNY3FBa3NlZFlj?=
 =?utf-8?B?czZ2bjJ3U0ZhaWlsR09TZm44U2pHaWkvSnJtU3hmckNQUG5veVJLWXhEYmNs?=
 =?utf-8?B?UElYdHYva3RJRHdKbWkxcjgwYk1nQzNmODh4WFFCNGt2MG9BdzRkUks0ZzU2?=
 =?utf-8?B?ZDdrQjh3amdLWmR0WXlWaE53NzZCTkUxYTMyRzg2c3BVNlpRZGZVL0Z4TlRT?=
 =?utf-8?B?S3JDT1RvU0Y4WGVwWW9nbkRFRVZ2dHNOZHkyMDJUTGpsSWVxMFQzUjRIRHhl?=
 =?utf-8?B?a1JyT1hkRGl2MTV5QXg4Y0NBQzMrcTNydlE4cmhGSU8yS2RGbENvSll1bUdX?=
 =?utf-8?B?VkoxREo1QXlRK0tBZDNOazBJbEQ0bmU2SitFTVgxYkNiWnRnVVFrNjV5NzVT?=
 =?utf-8?B?M0RTSlFMbXp1L3BzRkhrZ29yMm1zUjR4TjRkbXhwalBTRzRtVVhFbTgydFhr?=
 =?utf-8?B?eFlqNHFqOS9IUFdVWVB4UW5DRVc3MllqTUFkSGxVdDhhSHVMTzdVTHRDWUk3?=
 =?utf-8?B?Y2dWTDZna3BOL2NJczd3UkE5U01WdEI1aE9TdXlyRmx1b1kwMGJMYXR2ZG05?=
 =?utf-8?B?RFBEUnRDOHR4TmZUK2JocEFpUDVQWWl1WnpMYW95MWZwSWxvSlJHU2creFZs?=
 =?utf-8?B?ZHIwc0JwbmkxaVBxM21neXVmaDdDc1V5YzFrUGFXc21HZEFtSzhIM1RWWElH?=
 =?utf-8?B?cFZsd1FTWmtHcjVXYk1WbFdRclFrZlkxdWs2Z2VsQjVsKysrMjlGL3ZwbnU4?=
 =?utf-8?B?aEtBWjdGY25NWlh0SGZyMDNwL0wzcVVzR0RENmVkYUQ5Q1d0Ykp1VlVsekwr?=
 =?utf-8?B?SEJIYjBNTDYzQXk0VmFyVXRRR1grVHJhc1U5S1FoSXd1bjF6WmZaRURtVUln?=
 =?utf-8?B?UHc2SkVaY2RLY0NxakVXYVZxd1FqNXI2VWFWNDhJMjRLOHMzU0dDOXlyeEZH?=
 =?utf-8?B?TnE4NUNmZmtxU29FM04xSUhYOTgyQzNhaVE2Ui9rQ3BZOWNUNzZYWk1aUzhF?=
 =?utf-8?B?ZWRMcEtiTDl0U0RNNVptdUdNeUZvaDE5RmlBWVFlWW9CVk9yaWd0YnRGWXpk?=
 =?utf-8?B?c0g3TWQxYjFubERYc3crUEdBRWhCaXJpUWtXbkJCcXhQY2dLdTVTRXFzdDJy?=
 =?utf-8?B?KzBvR0xCY3JienVRY3d5UllJSXRDWnZnRkhjdkhCVHBPZElVT05VcmZ2WkpE?=
 =?utf-8?B?OEJ3V2JLM2hRQW1IVnRVYmI1REVhU2Fqck5MTGxRN1AvOXRKWDE5TzFldHp5?=
 =?utf-8?B?S3piSGxHTEcrVjYrQ2VtL3BaTUlMYXVOdFJFaE83T0QzR1RrMWNuMm5semJL?=
 =?utf-8?B?YzIvd1l3emt3My83eHovZnJwSHNaRWVReDFSMHhYWlVVR1NDR3Z1U2pubmVU?=
 =?utf-8?B?RnQxdk1lOTlGRU9BSTU5R2FPOVFkV0w2WnFvaE5pSXBhaHlzWktuSWp0ODgx?=
 =?utf-8?B?cVROOTBOTXVZdVJLMjBxSVZzUGR1T0lJTWVkVWp4VC9PNU9UQy94TnJncXFp?=
 =?utf-8?B?VTFBakNubXUyYWt3MlRPejg3eENxY3VBWS9yWGExZU8weVd1ZnFZMWg2QSsv?=
 =?utf-8?B?V1R5T0hJTWdVcjk1UU9MSGxlcUZOaW9VWE02VXdSNitQUzk2QUhmWkIvQTdn?=
 =?utf-8?B?aGhvU09jNHgrTGNBeGhPRXNhSGtrS1hMUlowNUFrcVdmMXBoNzhud3VKQVVC?=
 =?utf-8?B?UmVXbVZhb1FxVkl3ZzVNNWJmZ1k4d1JYbVdSTm0xZXpvdjJKd2lZQWRzekFI?=
 =?utf-8?B?Zk5qclVQWkJQdlJiamU0QU5WWERSVFY5azhkUDNjcXRoYm9PdElRcUhtNUt2?=
 =?utf-8?B?SW43TmJFZlJROWtiRElkQ3JDQWNBU0x2SzZxd2tkMnFrRWFEMDhMdy9HSy9a?=
 =?utf-8?Q?pGRQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adad8857-a81f-44d8-3cfb-08ddb57f6b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 13:35:02.2258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+5vlyvfcOf61Ro/uz5wx/BzXxx3mY9Jq2OKVlecZgY3/LVrlt2cf+D8h5fcz9L6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDI1LCAyMDI1IDM6NTcgUE0NCj4gVG86IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDMvMTFdIGRybS9hbWRncHU6IHVuaWZ5IHRo
ZSB1c2VycSBkb29yYmVsbCBvYmplY3QgZGVzdHJveQ0KPg0KPg0KPg0KPiBPbiAyNC4wNi4yNSAx
MDo0NSwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4gVW5pZnkgYW5kIHJlZmluZSB0aGUgdXNlcnEg
ZG9vcmJlbGwgb2JqZWN0IGRlc3Ryb3kuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBM
aWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyAgfCAxIC0NCj4gPiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMgfCA0ICsrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBpbmRleCBjN2M5ZjllNTk3ZjEu
LmFjYWVhNDQxNmVkMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXNlcnEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91c2VycS5jDQo+ID4gQEAgLTMxNyw3ICszMTcsNiBAQCBhbWRncHVfdXNlcnFfZGVzdHJv
eShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHAsIGludCBxdWV1ZV9pZCkNCj4gPiAgICAgICAgICAgICBh
bWRncHVfYm9fdW5waW4ocXVldWUtPmRiX29iai5vYmopOw0KPiA+ICAgICAgICAgICAgIGFtZGdw
dV9ib191bnJlc2VydmUocXVldWUtPmRiX29iai5vYmopOw0KPiA+ICAgICB9DQo+ID4gLSAgIGFt
ZGdwdV9ib191bnJlZigmcXVldWUtPmRiX29iai5vYmopOw0KPiA+ICAgICByID0gYW1kZ3B1X3Vz
ZXJxX3VubWFwX2hlbHBlcih1cV9tZ3IsIHF1ZXVlKTsNCj4gPiAgICAgLypUT0RPOiBJdCByZXF1
aXJlcyBhIHJlc2V0IGZvciB1bm1hcCBlcnJvciovDQo+ID4gICAgIGlmIChyICE9IEFNREdQVV9V
U0VSUV9TVEFURV9VTk1BUFBFRCkgeyBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L21lc191c2VycXVldWUuYw0KPiA+IGluZGV4IDE0NTdmYjQ5YTc5NC4uZGJhY2RmY2I2Zjdi
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVl
dWUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUu
Yw0KPiA+IEBAIC0zMzYsNiArMzM2LDEwIEBAIG1lc191c2VycV9tcWRfZGVzdHJveShzdHJ1Y3Qg
YW1kZ3B1X3VzZXJxX21ncg0KPiAqdXFfbWdyLA0KPiA+ICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnF1ZXVlKSAgew0KPiA+ICAgICBhbWRncHVfdXNlcnFf
ZGVzdHJveV9vYmplY3QodXFfbWdyLCAmcXVldWUtPmZ3X29iaik7DQo+ID4gKyAgIC8qVmFsaWRh
dGUgdGhlIGRvb3JiZWxsIG9iaiB3aGV0aGVyIGhhcyB1bnBpbm5lZCBieQ0KPiBhbWRncHVfdXNl
cnFfZGVzdHJveSgpKi8NCj4gPiArICAgaWYgKHF1ZXVlLT5kYl9vYmoub2JqLT50Ym8ucGluX2Nv
dW50KQ0KPiA+ICsgICAgICAgICAgIGFtZGdwdV9ib191bnBpbihxdWV1ZS0+ZGJfb2JqLm9iaik7
DQo+ID4gKyAgIGFtZGdwdV91c2VycV9kZXN0cm95X29iamVjdCh1cV9tZ3IsICZxdWV1ZS0+ZGJf
b2JqKTsNCj4NCj4gQWJzb2x1dGVseSBjbGVhciBOQUshIFlvdSBhcmUgYnJlYWtpbmcgdG9ucyBv
ZiB0aGluZ3MgaGVyZS4NCj4NCj4gV2hhdCB0aGUgaGVjayBhcmUgeW91IHRyeWluZyB0byBkbz8N
ClRoaXMgd2FudHMgdG8gdW5pZnkgYW5kIGRlc3Ryb3kgdGhlIHVzZXJxIGRvb3JiZWxsIG9iamVj
dHMgYXQgbWVzX3VzZXJxX21xZF9kZXN0cm95KCksIGFuZCB0aGlzIGNoYW5nZSB3aWxsIGFsc28g
aGVscCBvbiB1bnBpbm5pbmcgIGFuZCBkZXN0cm95aW5nIHRoZSB1c2VycSBkb29yYmVsbCBvYmpl
Y3RzIGZvciBhbWRncHVfdXNlcnFfbWdyX2ZpbmkoKSBhdCByZWxlYXNpbmcgdGhlIGRybSBmaWxl
cy4NCg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+DQo+ID4gICAgIGtmcmVlKHF1ZXVl
LT51c2VycV9wcm9wKTsNCj4gPiAgICAgYW1kZ3B1X3VzZXJxX2Rlc3Ryb3lfb2JqZWN0KHVxX21n
ciwgJnF1ZXVlLT5tcWQpOyAgfQ0KDQo=
