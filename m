Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27BFC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 14:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5E410E0F8;
	Wed, 29 May 2024 14:48:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u9QYeSOW";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D3910E039
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 14:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkiap5oseVix5uJbOENRA2+WQgKZ5GLXM15eemhz/jAXERLkqYLtGYkgBaS3RnExJlUlwY2hGRKrUP9YqnQaXkjy80x8KupiwBZRj0SxQyB4/PY7Biv/alnrzOTsr7MWowyQiaI7s9hIc2mtcz4/FrRnAqUPdrRzwLPyrgLaUjFgCnANeBR35sByYcxAqOOx539hwxI5YMeLOYTMaPGSOaznjfDhX3pnrnDlCgyfsiWV9eRlvlZJnEfWKVfj3/p1Gz11ytPZgGIh5kghplNvw1+ZnJXn3BkIZ5iI7Ej/4Qqy+v+wSpeNY17Fdv1cKnXXW24wVjFmU6PGYJKGqdI8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TWVvsU7fXf66/FDT9QIhmMUVKK71eRviGfo+k/JhwA=;
 b=iSbIc0zVy4ckLLU7WHU43U59dnoWzWWU9qIsi1sgoAmhf8/Jl9ohOTEUC5NS2Rq/WxZnDKw8Pv6zY3O3yzOEiU6wm1FmpJFPzKZU6hnKfqn1sIIYbhZQhli8tAEdav6HelnBq8DkoYotQF9Bc9Rr0plpYpTVVkypWlx4UHWKDUL40J4VNVFDhrLvAJiHFoArjw5UJORvdg9KEmpjROoubzncicjtWUSUlSZgA6tCZ6NXBF2AOqsar1OBWJIY+HIQlnX3iyBMI3BDwQSsKDGdYjEk+QEiUUilId5kRQTOuGHAy+9NUzIgdF84jF0LxgYylD63v0Pqqr32B1m2HeBing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TWVvsU7fXf66/FDT9QIhmMUVKK71eRviGfo+k/JhwA=;
 b=u9QYeSOWrwPF6tfXvPu++dWYgqQyzrS3FLfuCQ07PUXqdGB/QRZIS8QFxqGVkW2fXM+e4mF21S631r9uuFj6uA9P8zB0mfsK3O/VNd91hUIskwdeGclyLRvzzpjUlY1y+VgfUNjwVjc2Jd/wiJz9b1UoC1NHxnd5z7ysI/4bdn4=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 14:48:33 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 14:48:33 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Thread-Topic: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Thread-Index: AQHasSPj5dWiHd7YP06y4F37f071D7Gtw2cAgABr2bCAAAeagIAAAj7AgAAEfoCAAAmBwIAAAW0AgAABqLA=
Date: Wed, 29 May 2024 14:48:33 +0000
Message-ID: <SA1PR12MB8599AB4284E5B4415D92FF14EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
 <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
 <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <a1e40066-f980-4490-a0b9-d8f3be34ad8f@amd.com>
 <SA1PR12MB85996538350B30F80330C0EAEDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b646408e-9b50-4e2a-b2b1-ab1ff9f4b366@amd.com>
 <SA1PR12MB859960F8F2B9B22E726EF6D2EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b35b5556-9919-4806-bea7-f7ed94844a04@amd.com>
In-Reply-To: <b35b5556-9919-4806-bea7-f7ed94844a04@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b1f090d0-9ae0-4a8d-8ce5-c158c6b194f2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-29T14:41:02Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|MW4PR12MB7357:EE_
x-ms-office365-filtering-correlation-id: 0da1c373-1782-42ae-d1a5-08dc7fee6a1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Q1VxZnJ2enVDa253eTdIVU8wbkpRMHFIcjFKaUtxeDhaS09NUTY4d2dxS1dz?=
 =?utf-8?B?WHZEdVJXclgxUzFzU25BTXZ4K0thenU0N3VhWVBVNkNGNEM4S3E5T0JDYVhS?=
 =?utf-8?B?U3plRlBaV1FLV3hUUzJ1UFQ5R3U1VXU1Mk92dG4zWWJVVzJ4aW1oU29sVDlF?=
 =?utf-8?B?OFBVTWN6TTV1SXJjOEo4WTgyRVdNSFlobFVxSjNaeDVaOFgyOFAzQ0c2VWVF?=
 =?utf-8?B?ZmdicGgxcVhOckFEdmtYR0NVMjNtdXdORzZ3Ukx2QjQ2VkFFRVVzcy96eUJQ?=
 =?utf-8?B?dlBhQjQ2eVd1N0thQzdwMDZ5VmcxTjdKam1OSzJxRndlTGpYbkw0TGdlTE9M?=
 =?utf-8?B?OHhab2dEUlpnbzhsZTlUNGp2L1pBMHZ0MlBia0p2WGQ0U0QxQXBiQ2pGTzB5?=
 =?utf-8?B?L0FIK2FUa3JQbXh5MVRuNnRlcWsrQ3NGRjJjSm8vV0xWV3hlQ1RraS9wZG5J?=
 =?utf-8?B?SHdQZVAxY1AyRFdQcU1YS2lERVd6Vk9tUlUxREJmSGNBVWxtZ2FvZk9ZeFFK?=
 =?utf-8?B?eTJIZ0lEVUphUHRnUmw0dXFWckZKQjNTVHNrYThFRVVDM0hvWUVGRDQ5WEgx?=
 =?utf-8?B?N29iQnJwUHc1MU4zRVBKdE11Z2M3dUtWUUJlRFVuWE1OMVFnNGZpY0ZCNDNM?=
 =?utf-8?B?ZitzcG0yTmJpTlZ1anF4V2UrQ052aGFQeS9YaGxlM2FtSG5NRzhybU4xMTkx?=
 =?utf-8?B?d1N5c1lzMHBweFNzN2kweUNoWGtSQ3ljang2azBOMlp1cnoxUFVaL21XUVZU?=
 =?utf-8?B?Q0pvRXNYZExTZ0Zic0RLYUg1ai96TDRjUWExRHdXQkZSN21vSmxEdG9VNENn?=
 =?utf-8?B?NnhWU3JWYzJUNEhoeTNXQmdhbUtKcWQ1cW80NEpYNityOVhsU3BxQVpHNVVq?=
 =?utf-8?B?Qll0ZUM2ZDFyc0M1NmdHaFhQbTNxRjVRQ2g2c242TmR6TGNpUkpnREQybk9a?=
 =?utf-8?B?Ry9yRVh2eFBVNTF3U2Z0SWhYbjd4QW9BSENjdTdHTnBKQ2VYKy9rbW1oRGNn?=
 =?utf-8?B?bE44SUVXMFdsSG0zZFphclI3bXFnd2RZWXVaemRFQk5QRm1MU1ZkRnBzcDBJ?=
 =?utf-8?B?QUIrWTRYbmNhcmRqUkNReVdPbG1LbjBPOWZZY0U4MTBZZEgzSHNsY0pyOUN2?=
 =?utf-8?B?dUhZSWxiZGNnKzJETW81alNMSEtCdlg4d0k2QzJ6Ny84aVUveUJOSWpxcWtX?=
 =?utf-8?B?dHEwS1NMeUVCUkVIQWcxdDFydGJmOVR1T0VNNWNnaC9WeUVtcTB6WDdPR25q?=
 =?utf-8?B?aXFtaC9lSVNZRk1sZFhIVCtlSURmRWpnckxkZ25relp1Y2M0MTR2VGZ0ZEU0?=
 =?utf-8?B?QU5FMy9IblZGVHFnLzRmdDdOV0QraTlLci9ldEpqdmJ2ZmhhRWxueE4xaUx2?=
 =?utf-8?B?SENIZkhidjVMWFBkSysyZ1dHa0w4U3dNRHpNM2dJZkFsbTlWZnVjNGJLMlRp?=
 =?utf-8?B?dGkrZlk0SFd5SzE2bHIyNnlVbUczZGVHOHJsTGMxZ2hlSjllZ0luZHZGMmEx?=
 =?utf-8?B?ZTJUZm83b2U5cERveTYwUi9VdlY1OWhrYkRaQVVIL2R6RUdVSlFEMzdRdUdt?=
 =?utf-8?B?T3Q1amJtYmpSZ3hBVCtGU2orcTZhM2d0NjBzVVFKMkR1Sm5wUmVEeUpDS0lv?=
 =?utf-8?B?R2NqREN2VUZTbjhYZndnV1YzS3ZmUXhsR0s3N29qWlRCa05mMStXM3AveERZ?=
 =?utf-8?B?eURJZ2N2bXNxcWFaMWVTZ0h0N1hMdkpXb1pyaktFbS9vb3NCSWg0WGU4djZm?=
 =?utf-8?B?c1EwaERZdHFKTFQyVFZVUWdackNQS3pCSm5zbUFlQzRBRlZrelpxQVhpWXAz?=
 =?utf-8?B?eTlTVmovRTVJZ2dWTUhxZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzZPSkplWnhxK0VRdmtRdk1iK2hUV1JuSUtqQmJUekhINXNHT0lUSGJpdVow?=
 =?utf-8?B?akxPRnc1NHF3eHBObGNkVDBiaUZycG5qUTlkVW9FV1BhQys2MktrRWF0OW9Z?=
 =?utf-8?B?aE15ZkNwUFJBV09ZcHI4aXRZYm1sc0VIUlBGUTUrQi9MdkNqdnRjTHZjL1h1?=
 =?utf-8?B?b0tkTFBiYWZEa1ZDNkIvR1h0TE4rcUpCMnZaUXJlc2plWFFMUjV4TjlzTGJ4?=
 =?utf-8?B?dHN3S1ZZNXVHRWNHeXZzTDZVbU1nWGo2N05vS3k5dkVSMms4MEFDdm9LMXhG?=
 =?utf-8?B?dEJzUG1tUnVoTjVPTDZxMzdlRkhHY1kwMXNtWDJUcDkyTzNLMmdwV0RaTGRm?=
 =?utf-8?B?VHJxbjRPRHRaNkVPN2ZMWG1yL1Vuayt2NWxURXBFVDlPKzZQVlNlZktQR3lw?=
 =?utf-8?B?R2t1UGNKWGdPQ2E0THVmVGN6R0hTR3RqSVY4SUxIQzMyYjRWTlJxbzh2SE4r?=
 =?utf-8?B?UjBMSS9LOGFnWFJFd0hzanB6Rm45MW1PbG0zWmY1azErK3kxVjM0Zm5QSExp?=
 =?utf-8?B?eUdpbzZGZklSNU12TE4wWk8yQWR5WkRacVlCZjN4YXh2QWNWRjNoV0VyL1hD?=
 =?utf-8?B?K0ZmeEZlQzRLMnZrSWo5UkhqNmZybFBWcjc0d092d0Y1YjZwZFdDUTNjUFN3?=
 =?utf-8?B?UUZDM0h2ZE9sd0pqbzY5RzhzeXd3REMxSmdlV202U1lJK3JsVXJ5OHl1Vy94?=
 =?utf-8?B?a1VaMDdnb3cxYlp5Q29CZzYrTTF4ZkloOWRlbm9rM0JscFprWG9mazcyOTly?=
 =?utf-8?B?NHJMYldKZHErWlRTV2JTSGpMeVdYb2x1TEpndUtqL2ZZN1NtRzAwZWZiL0d5?=
 =?utf-8?B?NURhU25TYlFvNGoxNWZNNkw2VG5DNGlicUJyZUlxRUo0dVQrOUFJYVptZy91?=
 =?utf-8?B?OXJBN0pMOGxNV005RFNJUVNPUW9vOEpwZUEwemtBenRnVVpxbjFqSDhxSUY0?=
 =?utf-8?B?MnhiWFlwRzk5WXB6b21kbm0va2x6OXNic3ZDOCtTNmNZU2QwNi8vM1RlajV5?=
 =?utf-8?B?ek9LeWdNUVIxM2xkeEhFSmZOYkN5MnZ2a0tiL3NOUWRjeWFMRTR1WDFhd0Vl?=
 =?utf-8?B?WXpMTnJaRk9GaXkwak9rQWh1K010aWs0YjVxLzVzUEtUZEpkcGNLeW0yTWdi?=
 =?utf-8?B?eitiSFZYVnR1cW5ZQUlYbzBoY2ZqWlFkQUZONGI4S3V0eEZxa091L1dsanM2?=
 =?utf-8?B?Z3NLUWd3MEtLMkNDZVlHc0cxQXdHdEUxM2dURHphZzMvNGx2VUZVN2tYKytk?=
 =?utf-8?B?MmhXdWFIbU1VMDlJRFhzQitKbXlETFRuRmcvZVF6N1M4dzdrRkthbGlibm44?=
 =?utf-8?B?Ri8yNVFiOFNyUW1aUXhLc0FqN0xvckNFejlVWXYrcWZGQUI0d3JtU0REeUxw?=
 =?utf-8?B?RXRwSlZjWHNFNGpTU1ptMmxSSllJTVc0YzAzek16QUdaN1ZNelMyZzBjdDVJ?=
 =?utf-8?B?K2EySVRSOFdBSTh4b3pCeXMvSGlRWHF1Wmo2Ky8rand5dGNrUm5UNHB0NFFr?=
 =?utf-8?B?bXdQQXQrVFdZb1gycVd4Rk1LbWsyNHQ2dVp0eHRubS9QeDF6QkEySFh1TWE2?=
 =?utf-8?B?L1hZM2EyQjl1VUxybkNsRUljQkkxVlNKRFQzZnVRZ0N3YWJmejRMTVpWWXN0?=
 =?utf-8?B?UEhFcHdOc1J1MUxVRFdTNms2MUo1a25RVUhjcnVQYWplanczTk43SWl6UExl?=
 =?utf-8?B?R29VU2dVSy9LSmozczdDdU1IUGRlT3V5WWwvM0I2ejNCN0xxQjZJZkpIWDk3?=
 =?utf-8?B?aGZNdGU2emxaTGdVcUlBVU41eCs1NTRROUZIbndjTzVNeUk0VmY1dTI5QkhV?=
 =?utf-8?B?bGhFTE5QVnhtUk5Mcm8rcmtHeTQrRjluZzk0NXFCU3NjbXF5bE11NjZENndq?=
 =?utf-8?B?aDBBVVAzRTVvb1NPT3BOUml1QXdIWVBkY29HLzlJcmhFRkt6WitXZHNHbm1i?=
 =?utf-8?B?RWw3UC9KMEtPUVRkbDVlMGJPQThWMURheDYzUzRPNmFsU2d2RVpuMGhJbWI0?=
 =?utf-8?B?S2VEczQ1ODBVK1NyL2tmc0Rhb1l0Uk8xekVOMDhkK04zT2NBdkpUS2FqOU1p?=
 =?utf-8?B?NE11ejNXdFloakhZRXpDTGlISlozaitrVkdYUnZlQXp6NmpyS0tTdERmWnhw?=
 =?utf-8?Q?iv1w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da1c373-1782-42ae-d1a5-08dc7fee6a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 14:48:33.8612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFzZcn28AOyGIaUtLGezdAGFxPNfmvqbB8HCD95pXw1BvzY7AAhYtGXN9xZQMv0BPFPMcXjqvZLETCH64/NYFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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
Cg0KPiBZZWFoLCBJIGtub3cuIFRoYXQncyBvbmUgb2YgdGhlIHJlYXNvbiBJJ3ZlIHBvaW50ZWQg
b3V0IG9uIHRoZSBwYXRjaCBhZGRpbmcNCj4gdGhhdCB0aGF0IHRoaXMgYmVoYXZpb3IgaXMgYWN0
dWFsbHkgY29tcGxldGVseSBicm9rZW4uDQo+DQo+IElmIHlvdSBydW4gaW50byBpc3N1ZXMgd2l0
aCB0aGUgTUVTIGJlY2F1c2Ugb2YgdGhpcyB0aGVuIHBsZWFzZSBzdWdnZXN0IGENCj4gcmV2ZXJ0
IG9mIHRoYXQgcGF0Y2guDQoNCkkgdGhpbmsgaXQganVzdCBuZWVkIHRvIGJlIGltcHJvdmVkIHRv
IGFsbG93IHRoaXMgZm9yY2Utc2lnbmFsIGJlaGF2aW9yLiBUaGUgY3VycmVudCBiZWhhdmlvciBp
cyBzbG93L2luY29udmVuaWVudCwgYnV0IHRoZSBvbGQgYmVoYXZpb3IgaXMgd3JvbmcuIFNpbmNl
IE1FUyB3aWxsIGNvbnRpbnVlIHByb2Nlc3Mgc3VibWlzc2lvbnMgZXZlbiB3aGVuIG9uZSBzdWJt
aXNzaW9uIGZhaWxlZC4gU28gd2l0aCBqdXN0IG9uZSBmZW5jZSBsb2NhdGlvbiB0aGVyZSdzIG5v
IHdheSB0byB0ZWxsIGlmIGEgY29tbWFuZCBmYWlsZWQgb3Igbm90Lg0K
