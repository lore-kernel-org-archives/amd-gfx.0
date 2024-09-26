Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C2FCDE00D
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 14:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 261B210EB6A;
	Thu, 26 Sep 2024 14:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HiPeM66H";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B44A10EB6B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 14:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pql1ujJ0z+zdOQ6RHm1OO9sk4o8EmjRGdriuiyXaDP3AF8fHYeUZlq1MKfC/DLto/AHCsXOpNC1suoGmJDSDLTKS03QTwG8Ua3/zkPCvR6T6tZbhL/DfHjqhISyfmp0vkvsJeVHSLqFYG4Ojw6Xjhmgy2OGoRUMUoOBuvhLj6uiVVx/qGa3NfteofhRQGsoMXcCU4cE/sUmVp+5v+gNOvpDdIZzwU00vZPdpOjWhb0gLjgkxmENwGIZPCwm7mQR5+O3YXQneqADS+R+FrllnLr5mUVhzAmrxJ81G3/KUOXyMn4u7Rrb8BAf6MmT3q6jkdzovIPTXsJGiztKrh3MmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTqR9yXTPWJW90huUdlPcw0Sj86JFCgSdmHuEGs1MtM=;
 b=dBW+9QcSVCdfMxG7UUAg/1sSKmMLby2JBH06mGbsMb1xCEo8ASoZmK665GYSDbvMptrJ0y2HTQo5peuRk0DMnOFjyXScQGEQkKKVS6jWCg5X5KVa/r5sdnFXQvArXXFDIUHJOUFpn6oTy4DK5uRWCeS5Xg7ekBWfTFpQfeb87Liz6AzsYSLxGi6wVN6c5MkX4aOnFn+UY05hQDzrmn9a9EtAo8xRgQjCy8NUchBETrXVmny+jk92526UK8ogNFXVeFnEklrIYfhQ1YhHtbiFIkRSkmkrd+H6m5Acpsss0Epww9lk7Mo90aFV6PG0qJbKRsvbMnEHxso8i1wOHJCWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTqR9yXTPWJW90huUdlPcw0Sj86JFCgSdmHuEGs1MtM=;
 b=HiPeM66HDChG4Ol4DM/NxUoxmgUrdRWWBRR1buHI/N2UpfcjB2TdJsoveLQvSJQT1z1mCikIqBcfWdYBLmBMqtIwGGfVa6gNj+EhqksvM0E1csFfUhwm8pEQNjtQkvERnONr7NavOfgwAdnO84z/uQtBX7soyerrlBnb4+Kyq5Q=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Thu, 26 Sep
 2024 14:45:14 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 14:45:14 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdgpu: simplify vram alloc logic since 2GB
 limitation removed
Thread-Topic: [PATCH] drm/amdgpu: simplify vram alloc logic since 2GB
 limitation removed
Thread-Index: AQHbDZFirJ5o1iio80Sn3Qa6nnB8IbJm+tCAgAACY/CAAcUNAIABZZpg
Date: Thu, 26 Sep 2024 14:45:14 +0000
Message-ID: <CY5PR12MB6369888F85CD5118C63F206FC16A2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240923081931.2126969-1-yifan1.zhang@amd.com>
 <CADnq5_Nm_OdBNbDR+J_w4v2yK4_yH5GxVdRwinJsgZBys69Lgg@mail.gmail.com>
 <CY5PR12MB63693340F3FFE996395FFA97C1682@CY5PR12MB6369.namprd12.prod.outlook.com>
 <CADnq5_PT+A_+3_WnofKF3_4kLB6u=fPFSow5Nc-e8Hbrrg6OGw@mail.gmail.com>
In-Reply-To: <CADnq5_PT+A_+3_WnofKF3_4kLB6u=fPFSow5Nc-e8Hbrrg6OGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=01d41bcc-4c41-4297-b8df-7d5bf3adac55;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-26T14:36:38Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SJ0PR12MB6927:EE_
x-ms-office365-filtering-correlation-id: e2b7bc7a-2b92-41f3-d84c-08dcde39d4ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R1o1MSttemMyUWVmWkJtZmN4eHZqS0ZhYWE4dncyclFTOWRZbUtyUHJUNzF3?=
 =?utf-8?B?K3JtdS9LWkl5eUF4WVIrM2U0ME1wRnJqZjhPdW5LYVVDRUhQMXZ1TjN3bjEy?=
 =?utf-8?B?OThDRklVbW1oV0tZaS9lek5ydDRWek9nZUJ6NUIrcld6K1YvRXBLYUV1RUdI?=
 =?utf-8?B?M1hiU3plbVhVUWJQR2VWWmd4UXJ0NEFQSVFWMmJLN1NNZG5CZWozTGY1TE5v?=
 =?utf-8?B?WWhOME8rWVovUDVEWTZUUmgrdHJad0hpMU5uQ3BFVDhpYnMrUXZrOUxKSGw1?=
 =?utf-8?B?bENMWUdvTlhybFk0alo0RHNmeHlFbHFJdWYxZm5ZY3cvTjhWYzhwSGRsYlJl?=
 =?utf-8?B?VUQ2b040bzAwUGc3eDFEaFJLcWpwa29qSHhVdm02Nk5uNzZwNm9RZXZWTzM0?=
 =?utf-8?B?QmRoR09qVUVqNzlKOFdranRjY3FDK3RyWVk0cjRTZnY2WkR1UTdOKzk1T01z?=
 =?utf-8?B?bCtkQzlPUWVLK0Jaa09NVS9JZDhBa0l1VDJlSHFJNjlwb3BlaVQvOHhSNnIy?=
 =?utf-8?B?eE9yejhGMGkwV2xIblE2bEJqZVZFZ0kzK2ZZMjlBaGZjVkcvZlhjcmp2NXpn?=
 =?utf-8?B?Y3JZUm0rSVo3MTlabVZmYTJTSnI0TmRnWnZ2bWRFTS9XbS9VVGhPZXpxalhP?=
 =?utf-8?B?Y1dCc1Y2b3VHNGdNWkdiZDFPN0lZa3dMVUxndEIrZkZSbDl2M1ZWNVZ5UVZV?=
 =?utf-8?B?bU1TMWl6MnVyUlhCc1NEUFhvRWtER0VCQW9PRXVqR1RzOGx3UXFVcmExYmZw?=
 =?utf-8?B?Z0dNNmU3UE9ESDlDcks1VDJUNlRDM2QyejcvN04xeUV5SjE2TUdFMW1sR2xK?=
 =?utf-8?B?bWxJWE45VlpDUnI5RGZmRlpoOG1xc1JBV1JzVi9EbkhGN1JWU0trWmZGRlBN?=
 =?utf-8?B?UzdCd0Fvby9MdXkyQmdkbjJ2aVdZL3dEem5zL0tNMDJyT0docEd4Wk9SKzQy?=
 =?utf-8?B?T1NFWFZKQW5DcVVuQTRCeWFmMHl2UkRBSEpqRHJZa2VOQzI3S3JRK09jdjd2?=
 =?utf-8?B?dU05VUlWdjhYZSt1NFNLZ3BqeExZVUVmcDZ6Rm9rVGt2Qy9VVFY2QXkwSFV6?=
 =?utf-8?B?YlI4b0trL3UvK3hnK0kwVUJKcjZTakhVcjJEbmJGR0ZMWWV2NzFOVCsyVWxa?=
 =?utf-8?B?aFN1Nlp6UkNPM3lnZStEQmxUWUk0OHVTMys4eEpYRjhnSFN0WHRpck9qRzJN?=
 =?utf-8?B?MSszallSY1pvMHQ0N2k3cWowazFEMEhwaTd3aTN4T1cvSmUrUW80SktIZCtH?=
 =?utf-8?B?OXRkN256U1RrcHRKb0pMVWFML0ViZUNhTVFvYUZwb2tSWGhleDR5YW91R1Y2?=
 =?utf-8?B?ZlZlZUhXR2NkWlFSMEh0bCtNMzNGNjFXbGx1bEhmVmJadUhQUm5VeGJLbE95?=
 =?utf-8?B?VnVYS1luck5hNGM4bm9YdHdHWTVxc3ErRVNNZjhBNjdkYnU2b0JsTWlIM09U?=
 =?utf-8?B?RDlUTFpCYzR4SDJvMmZHWnF0eWU4RVdnUVpXaFNOZWV0T2NBMkY2VXo1RlV3?=
 =?utf-8?B?bEJUTHRaOVRYeTRFMGNQelcvYVl5YjZ5Zi95Y1pJWTJJYTNHYUdmTENBWkdB?=
 =?utf-8?B?SElsM0dPRjBwQnhvTkJNV3VETnNpOFZDR2E4Y00yWkxheEJkYTU5dk5pNm9r?=
 =?utf-8?B?eW1lTGZhTW14eXZwZ1Z6RlBNRHcwaTF4UENhRmVTT2owQ1BRZVVyRjY3WUJq?=
 =?utf-8?B?eGkrb29qMG9IY1ZhTVB0akl6UUdhUGRHTGovMGcyS0lzNFhYNlZCQ3NlUm9G?=
 =?utf-8?B?ZzBmV0kwTE52Q0s1RVVteWxNOWRLZnM1T3FsSjJyVVBudXNhV2lBR3JGbW16?=
 =?utf-8?B?WDAwU1hkNU9SQnNzRy9xZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkVSYnFHUnFBR1RrYWRvVm5tSE9HekphRm0xUGNqWFcwTlBVMndHekFaaEsx?=
 =?utf-8?B?MG8wLytrODM4dXhDRXRtVkhLUnYvRHAvWDRVZHhWMXNRa2xtVGxod2xRTEFI?=
 =?utf-8?B?YkpRMDMxRDhudnFCU05JVDB5bE55YzRMYmtWc01hRWlWMFhzTnZxY1FEMTBH?=
 =?utf-8?B?QkNGWDJCVXVXNFdRMWEzRGxNb3RXd1N0bmY2U1Y1VFYzZytWL2NmL2dWcCtw?=
 =?utf-8?B?S1BwOGNzVHRvSUU5Q3hBLzZ0RkNrZmxIWWF6MG9zS0VpSWVyRDk1T2ZIdFVx?=
 =?utf-8?B?MTFnbFBCL2xRK1dLUExnMXg0TkgzNTM0K040SThjM3ZFd3ViTlJTamlIa1Rz?=
 =?utf-8?B?QWtaeTdvb1daenpxUSswQ05pSnRXUWJGU29IL0FoWkdHVVZDZ3BHSGl4RFBh?=
 =?utf-8?B?dGhsQ0JEV2l4VVBsTkdRVEVrbnBPS0FFdlEwSGlybFRIK0JTbGp4bG9pcnlm?=
 =?utf-8?B?S3JSdlNZc3oyRkxyZHQ2Ulg2b0ZUNzcvL0N4c1p0b2czUzh4eG1FY3BMSkRS?=
 =?utf-8?B?Wkd4RVVzbmtyRGNnRnhpdEhUYzJRYTgvU3NpZGs5L2lyTGZDUEpNL2pkUHY5?=
 =?utf-8?B?UWk3Q3hXSGI1bVRBbTFteldmN0M2WkMwMEcreHpNSmdxeEYxWTRCajlDN0xp?=
 =?utf-8?B?ZngrYkJXMGpRa3AwUVpVTXB0L0NnWXlLOTltaTZ1OE1uK0F0UlhKdmo4SWhl?=
 =?utf-8?B?b3RuKzhZMklBN21Uc0ZPYXJVeVVuWGkvOHh2ZkhBWVlDWXpiUWc3NU91b0Nx?=
 =?utf-8?B?RmJjSlZkZ3NvdFF2ZlQram0xSHJWTFBCejgxOHNQZDR6Sk1NQ3ZCU3gvdnpD?=
 =?utf-8?B?ZlNuVmI3SUJpak1OcHB3d01oVldGYi8wZUFncFpMY1ZuN2JuQ1lvMSt6U1Yx?=
 =?utf-8?B?Z01zcTh6endETnV1UGdLQXQ3ZWFvWExiNHlKQVI4ank4c2NXMjBmLzNSUG5w?=
 =?utf-8?B?VzhqNWRiMkw4VVRIM3pQMDQ1NklhVEZaSDc5bTR6RkloMEpWWDE1YTlUZGxv?=
 =?utf-8?B?aFg3L3JGeEh2TlRPUzBFTGJqQkZuaVZRVWtuVUdGRDIvLytsSHJIbGkzYlpI?=
 =?utf-8?B?ckJZQVhiTTFvdE51eGlCaXRiRFJ2aWhkLzJYWmliYml4WUZaY2NNcW14bjFK?=
 =?utf-8?B?TkRZMVJSL2p4dmZnbndtTW55bG1LYWxpUUVRYmpub0h2RVU2TVdUZm9KZ2N2?=
 =?utf-8?B?VkhUaWFYWmdhaEM2d2NwOUZDUzJtNmRuNlJzU0o1WXR0c2JyeFF6UDgvOUZu?=
 =?utf-8?B?OEp4SjUzRHF2Si84bk15cFEzYllZcGRrd0JqQnlyOGs2TzNLU3ZsZ3ZtS1kx?=
 =?utf-8?B?aDB2Q2FhYldoWTFmdWVlWkJVbTdVWGY0NCtOLzRrV21YK2JNaWVtVDlOdkdk?=
 =?utf-8?B?VjhYSG1YL2d6KzFwaXVRaThlZGdoam82WWZ1a2h0SlF4bXpnSHNIR21rL2xy?=
 =?utf-8?B?NWJoQzVORUF2RGpwd2h6UFRPR0hlOERxNzA2VVRhQW8vcHc1R2tpTWY0Ym9T?=
 =?utf-8?B?eDhqZ2Q4cWRZK25yUUJxdWNPam1YNUhadDgxWndkOHM4OU85blUzOUhhTXR4?=
 =?utf-8?B?aGhxSWRIdEt5ZjE1bVozbzhhYjFJU2NVdVNnMVZITyt2dGFZUzFaK0lSQndM?=
 =?utf-8?B?UzZKem1LdXVHU2QvWXh2Tlc0aUZ5eTkwZzA5NENRTkZQM29vYnhWVTlieDgx?=
 =?utf-8?B?aHdRZG1qeGNKeUFPNjJYa0E2TEZpYndQT0FPU2lnb25XS3pBdnI3MU9NTG1o?=
 =?utf-8?B?ckhNaFFkb1VrRUozQ3Ztc1FkNlgwbmNNRXRJcjM1a1AzeGNNN2ppODlocm81?=
 =?utf-8?B?dGZXZUVDUVhrd29PUUM5MU8wQzdMb1Y5amNlR0puVFJINjQ1b253WlNPbGtM?=
 =?utf-8?B?amVtR25XV0NYSFJ2NUdseS9qdGhLUjR1alY5VHhQUEJETmZDd3JUaThUaDhO?=
 =?utf-8?B?cXlIckxvUWNDWDE3TG50dHlETUhwN1dkTWN6VlJJU0hkckFSNFpzbWVtRlMv?=
 =?utf-8?B?T1VFb2tyU3ZOUmYvUHhTVEE0bmZLdTFTTHdBSHRmc1crSzk2d1oyWVloNVI2?=
 =?utf-8?B?RmpIZC9QeWNxVlpWN0ZobVIyd05ibHN1cWxqZmpZZFlqNkhOL0V5UnhBbDVt?=
 =?utf-8?Q?Jjhg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b7bc7a-2b92-41f3-d84c-08dcde39d4ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 14:45:14.7742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yII0T7f9LLEYpINbv6luFawdaRHl7QkIiRu0JOkwDruVL15kHMt+cqnXRDR+OTAi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPg0KU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyNiwgMjAyNCAxOjE3
IEFNDQpUbzogWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFuZ0BhbWQuY29t
PjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6
IFtQQVRDSF0gZHJtL2FtZGdwdTogc2ltcGxpZnkgdnJhbSBhbGxvYyBsb2dpYyBzaW5jZSAyR0Ig
bGltaXRhdGlvbiByZW1vdmVkDQoNCk9uIFR1ZSwgU2VwIDI0LCAyMDI0IGF0IDEwOjIy4oCvQU0g
WmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IFtBTUQgT2Zm
aWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+DQo+IDJH
QiBsaW1pdGF0aW9uIGluIFZSQU0gYWxsb2NhdGlvbiBpcyByZW1vdmVkIGluIGJlbG93IHBhdGNo
LiBNeSBwYXRjaCBpcyBhIGZvbGxvdyB1cCByZWZpbmUgZm9yIHRoaXMuIFRoZSByZW1haW5nX3Np
emUgY2FsY3VsYXRpb24gd2FzIHRvIGFkZHJlc3MgdGhlIDJHQiBsaW1pdGF0aW9uIGluIGNvbnRp
Z3VvdXMgVlJBTSBhbGxvY2F0aW9uLCBhbmQgbm8gbG9uZ2VyIG5lZWRlZCBhZnRlciB0aGUgbGlt
aXRhdGlvbiBpcyByZW1vdmVkLg0KPg0KDQpUaGFua3MuICBXb3VsZCBiZSBnb29kIHRvIGFkZCBh
IHJlZmVyZW5jZSB0byB0aGlzIGNvbW1pdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugc28gaXQncyBj
bGVhciB3aGF0IHlvdSBhcmUgdGFsa2luZyBhYm91dCBhbmQgYWxzbyBwcm92aWRlIGEgYml0IG1v
cmUgb2YgYSBkZXNjcmlwdGlvbiBhYm91dCB3aHkgdGhpcyBjYW4gYmUgY2xlYW5lZCB1cCAobGlr
ZSB5b3UgZGlkIGFib3ZlKS4gIE9uZSBvdGhlciBjb21tZW50IGJlbG93IGFzIHdlbGwuDQoNClN1
cmUsIEkgd2lsbCBzZW5kIHBhdGNoIFYyIHRvIGNoYW5nZSBjb21taXQgbWVzc2FnZS4NCg0KPiBj
b21taXQgYjJkYmEwNjRjOWJkZDE4YzdkZDM5MDY2ZDI1NDUzYWYyODQ1MWRiZg0KPiBBdXRob3I6
IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29tPg0KPiBEYXRlOiAgIEZyaSBBcHIgMTkg
MTY6Mjc6MDAgMjAyNCAtMDQwMA0KPg0KPiAgICAgZHJtL2FtZGdwdTogSGFuZGxlIHNnIHNpemUg
bGltaXQgZm9yIGNvbnRpZ3VvdXMgYWxsb2NhdGlvbg0KPg0KPiAgICAgRGVmaW5lIG1hY3JvIEFN
REdQVV9NQVhfU0dfU0VHTUVOVF9TSVpFIDJHQiwgYmVjYXVzZSBzdHJ1Y3Qgc2NhdHRlcmxpc3QN
Cj4gICAgIGxlbmd0aCBpcyB1bnNpZ25lZCBpbnQsIGFuZCBzb21lIHVzZXJzIG9mIGl0IGNhc3Qg
dG8gYSBzaWduZWQgaW50LCBzbw0KPiAgICAgZXZlcnkgc2VnbWVudCBvZiBzZyB0YWJsZSBpcyBs
aW1pdGVkIHRvIHNpemUgMkdCIG1heGltdW0uDQo+DQo+ICAgICBGb3IgY29udGlndW91cyBWUkFN
IGFsbG9jYXRpb24sIGRvbid0IGxpbWl0IHRoZSBtYXggYnVkZHkgYmxvY2sgc2l6ZSBpbg0KPiAg
ICAgb3JkZXIgdG8gZ2V0IGNvbnRpZ3VvdXMgVlJBTSBtZW1vcnkuIFRvIHdvcmthcm91bmQgdGhl
IHNnIHRhYmxlIHNlZ21lbnQNCj4gICAgIHNpemUgbGltaXQsIGFsbG9jYXRlIG11bHRpcGxlIHNl
Z21lbnRzIGlmIGNvbnRpZ3VvdXMgc2l6ZSBpcyBiaWdnZXIgdGhhbg0KPiAgICAgQU1ER1BVX01B
WF9TR19TRUdNRU5UX1NJWkUuDQo+DQo+ICAgICBTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgWWFuZyA8
UGhpbGlwLllhbmdAYW1kLmNvbT4NCj4gICAgIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ICAgICBTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+DQo+DQo+DQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwu
Y29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgMTA6MDcgUE0NCj4gVG86
IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZzsgWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFuZ0BhbWQuY29tPjsNCj4g
S3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kZ3B1OiBzaW1wbGlmeSB2cmFtIGFsbG9jIGxvZ2ljIHNpbmNlIDJHQg0K
PiBsaW1pdGF0aW9uIHJlbW92ZWQNCj4NCj4gT24gTW9uLCBTZXAgMjMsIDIwMjQgYXQgNDoyOOKA
r0FNIFlpZmFuIFpoYW5nIDx5aWZhbjEuemhhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBN
YWtlIHZyYW0gYWxsb2MgbG9vcCBzaW1wbGVyIGFmdGVyIDJHQiBsaW1pdGF0aW9uIHJlbW92ZWQu
DQo+DQo+IENhbiB5b3UgcHJvdmlkZSBtb3JlIGNvbnRleHQ/ICBXaGF0IDJHQiBsaW1pdGF0aW9u
IGFyZSB5b3UgcmVmZXJyaW5nIHRvPw0KPg0KPiBBbGV4DQo+DQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jIHwgMTUgKysrKystLS0t
LS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92cmFtX21nci5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dnJhbV9tZ3IuYw0KPiA+IGluZGV4IDdkMjZhOTYyZjgxMS4uM2QxMjlmZDYxZmE3IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMNCj4g
PiBAQCAtNDU1LDcgKzQ1NSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1
Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwNCj4gPiAgICAgICAgIHN0cnVjdCBhbWRncHVf
Ym8gKmJvID0gdHRtX3RvX2FtZGdwdV9ibyh0Ym8pOw0KPiA+ICAgICAgICAgdTY0IHZpc191c2Fn
ZSA9IDAsIG1heF9ieXRlcywgbWluX2Jsb2NrX3NpemU7DQo+ID4gICAgICAgICBzdHJ1Y3QgYW1k
Z3B1X3ZyYW1fbWdyX3Jlc291cmNlICp2cmVzOw0KPiA+IC0gICAgICAgdTY0IHNpemUsIHJlbWFp
bmluZ19zaXplLCBscGZuLCBmcGZuOw0KPiA+ICsgICAgICAgdTY0IHNpemUsIGxwZm4sIGZwZm47
DQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgYWRqdXN0X2RjY19zaXplID0gMDsNCj4gPiAgICAg
ICAgIHN0cnVjdCBkcm1fYnVkZHkgKm1tID0gJm1nci0+bW07DQo+ID4gICAgICAgICBzdHJ1Y3Qg
ZHJtX2J1ZGR5X2Jsb2NrICpibG9jazsgQEAgLTUxNiwyNSArNTE2LDIzIEBAIHN0YXRpYw0KPiA+
IGludCBhbWRncHVfdnJhbV9tZ3JfbmV3KHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFu
LA0KPiA+ICAgICAgICAgICAgIGFkZXYtPmdtYy5nbWNfZnVuY3MtPmdldF9kY2NfYWxpZ25tZW50
KQ0KPiA+ICAgICAgICAgICAgICAgICBhZGp1c3RfZGNjX3NpemUgPQ0KPiA+IGFtZGdwdV9nbWNf
Z2V0X2RjY19hbGlnbm1lbnQoYWRldik7DQo+ID4NCj4gPiAtICAgICAgIHJlbWFpbmluZ19zaXpl
ID0gKHU2NCl2cmVzLT5iYXNlLnNpemU7DQo+ID4gKyAgICAgICBzaXplID0gKHU2NCl2cmVzLT5i
YXNlLnNpemU7DQo+ID4gICAgICAgICBpZiAoYm8tPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVf
VlJBTV9DT05USUdVT1VTICYmIGFkanVzdF9kY2Nfc2l6ZSkgew0KPiA+ICAgICAgICAgICAgICAg
ICB1bnNpZ25lZCBpbnQgZGNjX3NpemU7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgZGNjX3Np
emUgPSByb3VuZHVwX3Bvd19vZl90d28odnJlcy0+YmFzZS5zaXplICsgYWRqdXN0X2RjY19zaXpl
KTsNCj4gPiAtICAgICAgICAgICAgICAgcmVtYWluaW5nX3NpemUgPSAodTY0KWRjY19zaXplOw0K
PiA+ICsgICAgICAgICAgICAgICBzaXplID0gKHU2NClkY2Nfc2l6ZTsNCj4gPg0KPiA+ICAgICAg
ICAgICAgICAgICB2cmVzLT5mbGFncyB8PSBEUk1fQlVERFlfVFJJTV9ESVNBQkxFOw0KPiA+ICAg
ICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBtdXRleF9sb2NrKCZtZ3ItPmxvY2spOw0KPiA+IC0g
ICAgICAgd2hpbGUgKHJlbWFpbmluZ19zaXplKSB7DQo+ID4gKyAgICAgICB3aGlsZSAodHJ1ZSkg
ew0KDQpJIHRoaW5rIHlvdSBjYW4gYWxzbyBkcm9wIHRoaXMgd2hpbGUgbG9vcCBub3cgdG9vLg0K
DQpBbGV4DQoNClRoZXJlIGlzIHN0aWxsIGEgImNvbnRpbnVlIiBwYXRoIGxlZnQgaW4gdGhlIGxv
b3AsIEkgdGhpbmsgdGhlIGxvZ2ljIG1heSBiZSBicm9rZW4gaGVyZSBpZiBsb29wIGRyb3BwZWQu
DQoNCiAgICAgICByID0gZHJtX2J1ZGR5X2FsbG9jX2Jsb2NrcyhtbSwgZnBmbiwNCiAgICAgICAg
ICAgICAgICAgICAgICAgIGxwZm4sDQogICAgICAgICAgICAgICAgICAgICAgICBzaXplLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgbWluX2Jsb2NrX3NpemUsDQogICAgICAgICAgICAgICAgICAg
ICAgICAmdnJlcy0+YmxvY2tzLA0KICAgICAgICAgICAgICAgICAgICAgICAgdnJlcy0+ZmxhZ3Mp
Ow0KDQogICAgICAgICBpZiAodW5saWtlbHkociA9PSAtRU5PU1BDKSAmJiBwYWdlc19wZXJfYmxv
Y2sgPT0gfjB1bCAmJg0KICAgICAgICAgICAgICEocGxhY2UtPmZsYWdzICYgVFRNX1BMX0ZMQUdf
Q09OVElHVU9VUykpIHsNCiAgICAgICAgICAgICB2cmVzLT5mbGFncyAmPSB+RFJNX0JVRERZX0NP
TlRJR1VPVVNfQUxMT0NBVElPTjsNCiAgICAgICAgICAgICBwYWdlc19wZXJfYmxvY2sgPSBtYXhf
dCh1MzIsIDJVTCA8PCAoMjBVTCAtIFBBR0VfU0hJRlQpLA0KICAgICAgICAgICAgICAgICAgICAg
ICAgIHRiby0+cGFnZV9hbGlnbm1lbnQpOw0KDQogICAgICAgICAgICAgY29udGludWU7IC8qIGNv
bnRpbnVlIGluIHRoZSBsb29wICovDQogICAgICAgICB9DQoNCg0KPiA+ICAgICAgICAgICAgICAg
ICBpZiAodGJvLT5wYWdlX2FsaWdubWVudCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBt
aW5fYmxvY2tfc2l6ZSA9ICh1NjQpdGJvLT5wYWdlX2FsaWdubWVudCA8PCBQQUdFX1NISUZUOw0K
PiA+ICAgICAgICAgICAgICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgbWlu
X2Jsb2NrX3NpemUgPSBtZ3ItPmRlZmF1bHRfcGFnZV9zaXplOw0KPiA+DQo+ID4gLSAgICAgICAg
ICAgICAgIHNpemUgPSByZW1haW5pbmdfc2l6ZTsNCj4gPiAtDQo+ID4gICAgICAgICAgICAgICAg
IGlmIChiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMgJiYgYWRq
dXN0X2RjY19zaXplKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIG1pbl9ibG9ja19zaXpl
ID0gc2l6ZTsNCj4gPiAgICAgICAgICAgICAgICAgZWxzZSBpZiAoKHNpemUgPj0gKHU2NClwYWdl
c19wZXJfYmxvY2sgPDwNCj4gPiBQQUdFX1NISUZUKSAmJiBAQCAtNTYyLDEwICs1NjAsNyBAQCBz
dGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXcoc3RydWN0IHR0bV9yZXNvdXJjZV9tYW5hZ2Vy
ICptYW4sDQo+ID4gICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseShyKSkNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBnb3RvIGVycm9yX2ZyZWVfYmxvY2tzOw0KPiA+DQo+ID4gLSAgICAg
ICAgICAgICAgIGlmIChzaXplID4gcmVtYWluaW5nX3NpemUpDQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgcmVtYWluaW5nX3NpemUgPSAwOw0KPiA+IC0gICAgICAgICAgICAgICBlbHNlDQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcmVtYWluaW5nX3NpemUgLT0gc2l6ZTsNCj4gPiAr
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICB9DQo+ID4gICAgICAgICBtdXRleF91
bmxvY2soJm1nci0+bG9jayk7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo=
