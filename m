Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EF7C531DD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 21:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DABF510E395;
	Thu, 15 Aug 2024 21:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rbv9OPKu";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C93B210E121
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 21:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W72DuQo5UUu3bzy0JVriHJviCQmDMQzZtojjU2FNUcSSEj7aoUiYFUJdBsRYTGAxc5MckOM8o3sl621B39huWYafgacVPBal8Wb144yULEKGpNNb3XMIMlwrh4yGMR+486rysCprJsKLpnPaWMFOf4Bbc7Fws0Te1rJs2X6pXLjb02H+dfRbliv7qE5CHZ9UNG1IWVXoRG9PzBQfkLJPwF+Bap9Dg2Du/S7Mm45Bg/jq6RV8r2v9vAQGZ0492rVtZYr4C3LFAOybVYZ6qdjRsuB5ucVfol/3TaCfV4/dTykgs0WpMcjDQ3Fggnb24PgwQ5y53UowBvn3bxcX1u9l/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpcd3s3qGG2VeUV16o0hAPXfxJdF6xqmEZG4+COJmeo=;
 b=Ari/E0iK21voSnUzfDqdCo8IfHtS7NCzcYPIwf5pGFiqCoq1J6zDdFmJcR3a+tSwUnJf4PWpI9eDw2P2VJD1jXPKnj3aKzgOX1tre7dMTbXJGvkyTap6s1YfmP+qjOyRP+/24eERWpzTWZ3tjS2+rESWGk4KGFytIb9/SC/2/puH61km2fZbZAB+3+p8PgSQsrgO9EKXiE3aNvbPQjn27M6NRMUxsOQe9zAKl/gT1Nh9FYidQn3VR9ftJARbmGODrR4gBBwnNfXnt4Q6d7tPJfh0w/oDVIfwDTuYH2uu6J55yG99tWDGncS19zMbk/ZpJUjpu2MXjWFYUmTjQsiuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cpcd3s3qGG2VeUV16o0hAPXfxJdF6xqmEZG4+COJmeo=;
 b=rbv9OPKuCkWjg3QBSTQ4ggivdlZn3QRgTetjVUe1r6hdmPSFPDaM7WK38dC2YF13/5W3My1XMVhTrE/BHnf2Sx54zvo8/Ao2FtlXtXpUH3xKhueZSNoyg1xAYQ60zYvcooHyKMxyBysnVrzt0HxZjNqxQASaFFoxD36KkdxIFBs=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 21:08:30 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 21:08:30 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCHv2 2/3] drm/amdkfd: Update queue unmap after VM fault with
 MES
Thread-Topic: [PATCHv2 2/3] drm/amdkfd: Update queue unmap after VM fault with
 MES
Thread-Index: AQHa7qG70kh1YB0qsk+oN+T/sxdD6bIoo68AgAAoEbA=
Date: Thu, 15 Aug 2024 21:08:30 +0000
Message-ID: <BL3PR12MB642552D8C303F61844BFAF8FEE802@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240814232754.1119319-1-mukul.joshi@amd.com>
 <20240814232754.1119319-2-mukul.joshi@amd.com>
 <e60025db-2cf9-4976-9351-67a69973f6b5@amd.com>
In-Reply-To: <e60025db-2cf9-4976-9351-67a69973f6b5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0b22e845-d173-443c-a550-12f3d906577f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-15T20:48:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SA1PR12MB8600:EE_
x-ms-office365-filtering-correlation-id: 30a4e0ca-2d90-4279-f630-08dcbd6e6a38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YTFWNW45emdzRmlsTHZmc0I3cVRPTi9wVXFQbFVYS0lidmJ2RnphZFdWenFE?=
 =?utf-8?B?NXQwRlFoM2lwRGpTTHlBS2oyeDNDdkxHYkZSV3Rrd0x1WEdGZElmSHFBaWor?=
 =?utf-8?B?MXFVMENZNE5KTWZZT2E4QUpvaCtCUllWbDdFeU5CSk8vUkp6ekNZSS9zeW5N?=
 =?utf-8?B?Y21ybklLVWpnUklXWXlKS1RXc2lGbFVzWnJLK3BnNlk3bVFSamNaS2NtbUlr?=
 =?utf-8?B?TzJMZXJ5dTFPdG1uclAzUy96VzZYc1hrSitXOHdrc3NxbGxXTTNVUk45VlhN?=
 =?utf-8?B?MlpoNVJtVXQyVTdaM2o3K3lLY3NRdzFvS3E5MTVWL3d6dzRodnNZT0E3WVY3?=
 =?utf-8?B?V1R2MVlPYUtoOTJtMDVZendDN2pQbHd0YUkrRFVkNEJSNzhWb1pnN0RYWWRo?=
 =?utf-8?B?Y2dxbFVhQng3aS85TEhpZTVGc1dyd3N4TitQaHVoeGNOSXl4b1VNMXNXc3Ra?=
 =?utf-8?B?a2R1b2RIL0F2OUdMRGhObDdhY3h2QmZubXFUSlBKeFplaXNzYnlTdG9XVmFz?=
 =?utf-8?B?Wk5ncWRxOWtJemNzNzhlR3BIVHZ2OVBjL3AycjdldXJ0dXd3dlJhcFFYUDFs?=
 =?utf-8?B?QmlVOG1WSFV3c0RYa2trN0U1RGQxTmlKY3Jkd255cG9mWVJmaTBqTU1VaEdS?=
 =?utf-8?B?aUI5aWcvSUhzcnFtTVJEcGRpby8zWmx1WGwwNW5mVjFMbWdjWHFpNWllT1FO?=
 =?utf-8?B?TjdPSFpEdHBFbXBsWk9yVkZJeGZWQS9yTXNnWEFSZHdrWnJ1V0FicGtyZFlZ?=
 =?utf-8?B?ZHpiMnpUNlZydnpreVM2TVJRYkxZK1hOSnVjYzJDbXY0WjBMTFU2Rk1UaUlj?=
 =?utf-8?B?c1RxVWRRVmFpbVlOOUQvRDNVWGNTYzRmQVRpbDVyYVljU1A1Ty9NUVJQWWNL?=
 =?utf-8?B?Vm1OcXNyVVpPQlZZL0I3aEZNbEhURFNhVTNpZDdJQ2NSeG44R0EwRmQ1TW4w?=
 =?utf-8?B?VENxRENOM2pKdkFVTTdVSDEyRmJHU2ZPektqSEh2ZVhtY25hTWlvVkdHVzIz?=
 =?utf-8?B?UXZQMFBBTUx5RTNhazZZZHJreXlLV3ZSZ1RVU3JoSTZNY2doYVRhMXc3dWoz?=
 =?utf-8?B?eEUxZzdLMHZFOWNWZEx4d0VFSUhMN0FhNW44alo4VnMrNGo5ZVlKSHJUNjR0?=
 =?utf-8?B?L3VSUm9IQWFBcUlqS3hpS1RPb3ptRFF0NnpUNjJhZEEvRkFBbStUdnp2Yjh5?=
 =?utf-8?B?YjNKSHBtRmpTYzYvWXlmZWs4Uk5ZS0NtMVRxL0t1bkdMR09yWG5WTGJHM1Nr?=
 =?utf-8?B?aTcvMGxpc00zNUZ1U01zNjhNTmZMMnZrbkFjTmtDdXpmVUJ6YkNDWGVBY1NI?=
 =?utf-8?B?clprTFhHRGFYWmU0M0V4UjJsb2ZxUHVEcVdudmU5d2kreC9rUGpjS0s0dEFU?=
 =?utf-8?B?R3UybVdIMmRmeGY1bmM0a2l6eWlnNEJFa0dvNDgyRFpwWU9DdHZXVnV1RjNo?=
 =?utf-8?B?V0xDdkZPNXJ6ZmlzTmdXeG1XQUVta1llTy9ybm0wT0syYzlzcDBRTitSQjBE?=
 =?utf-8?B?K2hSRU1tSzd4bTRtUW1SYSt6MnVUMUJzakgwUnY3MkI5QlE4Y2NmL2RRTDVL?=
 =?utf-8?B?YlREMzZjVXZwakMxZlp0YlJCZ1JaUG1Samd5RmJUR3RlWXlPWmVBRkNKc1dh?=
 =?utf-8?B?TlE0SWpTc1hjYzJkVG9vMGtGNk0rSHdDMzZhR0lYc0JEQlNqMWgvQmJMc05V?=
 =?utf-8?B?RU94cjZuMlFIdWlWanNJaVIveVZCUnVtY1RkdlVyaEl1ek1PRUxjOXo4WlN0?=
 =?utf-8?B?QVp2WGpVRUo3VlU1Y1BUMWRUVi9HeWVabEdrcWVOTEZlY3hnbW1wT1hBaDA0?=
 =?utf-8?B?a1RGdGpleU1wWnpPYmo5NE9xbVlwQ0lTUnFQMVAvZENiZnp4QUZ1YU95ZnVh?=
 =?utf-8?B?Q1ZhZXREMzE4bHZoWUM1R2JYL0Z3VS9PR0x0R1M5aHFnSVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGhxd0hnMTJocHgyUVdwanBqdG5EYkcvSEJudFVDRWJVS002enNyR21iYlE1?=
 =?utf-8?B?eDJwS085eGRxSklRS0xSNEpmYUpqQXFVQndQZGgrS1U2Y2djOTF5MFZ0Yzdx?=
 =?utf-8?B?bGgxbjNVdlZmVEE4RmcxMVlpWTFaRDRVMjdSUFMzRW5SRmM4Y2xldXpCbkJF?=
 =?utf-8?B?WHZLbHp5S3RZTnhYeUdWMTJMY25uWG0rOWhDN0hQTStuYUlET2JlSzM3VzQr?=
 =?utf-8?B?WG1OYllJbE9lUmI2SS90L3RkRFlWRG8rZmJEWXNzakhwYkRuU2hIZk9ZZVJL?=
 =?utf-8?B?cDJRaXJ2eFU1OW91YU11VUNERjdVRTBRdXYzbVFuekNYT0M3VDNvRVdKTm1H?=
 =?utf-8?B?OFl1VysrbThlbUJnaDgzbVBJRnlBbGFMdnB4Y3NkK0pYSnNCUFlkNmFmZW5o?=
 =?utf-8?B?MVFoV1VOVXgyVDVTcXdlcjl1Z0xpUVV0OUZ4dW1abWVBemVrOXl5QjRkMGVS?=
 =?utf-8?B?MFordFVFcXdKWGZnemQ5MzlKRzBtNCtwVERtcUlRNUVtYzBoSExRTFA1M3hz?=
 =?utf-8?B?TUdQajdBb1M2RXRJdUNnWldkVk04TzIwOWFzL2tvbTZDYlhkdnZCejdTTVZj?=
 =?utf-8?B?Um9YU3I3K0JBcTJMc3NYeVdFR3ptNVovOGVDS3ErTS85TU1XNVZuMGYzZE1v?=
 =?utf-8?B?R3QvRm1jZnFTYzVZZEc0RzNTNlR0OExHaFBHcTlSNnhoVHp0Ukw3ZkNubVVu?=
 =?utf-8?B?eWpJd1NneEd2VFVacWN4NzFPMUVHZkI0dGllWFZndzN5WUxSWG9KUEVuRmJa?=
 =?utf-8?B?YUpQSm9nSGRRYmo2VFZzU1pkQUVqM3V0QTlJU2ZGRVFPNzQvNHF4cXdqdEIv?=
 =?utf-8?B?UCtqeklCUlQySkRBVXdHNXJpQTdZblg5M0pTaUIvQXZqNE1KcDRicUIyaVhn?=
 =?utf-8?B?cnlzWmdSRUJYUTlaeGpnKzF0TGNieWxhVGRLQTB5YlpmMHpad25XK2huYXB6?=
 =?utf-8?B?eWoxR3FaVzNob1pUcWFLU29iY0tOUUYyM0lCRHplWGR3RDQrR0dGTFk3eWV5?=
 =?utf-8?B?dXNGVm1VVjdqbVpCQ01KdHBmN1ZKUWxtWHloK2JXM3l3ditTNWVhbEgrWkUz?=
 =?utf-8?B?MGdzUUtnWE9MSlhUZjNHK1lEVXhQb1R4ekxkenhmU0tZbS9ZTEtZaUZhd0M3?=
 =?utf-8?B?dU5IMHF5SnB3eGlHeU84R0Jydmt3bStlMlNQakd6RnR2MndkdWN0eWJtZkZD?=
 =?utf-8?B?Y3grQy80anhoNTZ2dlB6RTVjclE0UG5LVURMaGhIbXhnWE1FVkVyZUVzV3lv?=
 =?utf-8?B?UndYaWhPOFVEYVlRSFdjOVJxeDUwNitVYU9veWVTa2ZlYlB4K3R3dDJ6dG92?=
 =?utf-8?B?R1dnT2hDUVVxcmp4b1ZpWWRneG5CT0NjMUh4MG0rREZUUnp5QjRxUS83ZlJV?=
 =?utf-8?B?cEhRK0FSVVhySzN6L0F0eEJucE1MQUxDRkpVOUI5ZTF1a0VRdFRxOFlISy9E?=
 =?utf-8?B?NjQrY1Y4VnZiYkV3M3hMZ3JIeDBCcmtkeG5mMUhuc29KS1FmMStlclFpVDR2?=
 =?utf-8?B?T2pWQTNrQWVTNDdXdmdWMHVjdzRwVkdORDNVVkg4clFpT0QrMGhYb0l0WnRt?=
 =?utf-8?B?UmdTZGJOMUxQNjFJVi9nSVYxV01xdjFEYmRUSllrSitTaUhlZzNMeHUyNkdC?=
 =?utf-8?B?cVFRc2pxM2VHSlRKalNieFhEekw5K0pvcVNpV2VFWTA0M3BxdHY1K3pLWGFK?=
 =?utf-8?B?QjlKSWxqRElZM1F4NVMrdEYrVTV3MGlKYmV5VXorVm52U0dscTB1QllqU0tP?=
 =?utf-8?B?aDdJQXhQdU94S0dWWHI4YUEwWlBwMWxORnRwMjBabStqZTRQQkE1ZnpVM2xu?=
 =?utf-8?B?WFRUcEFreE5JTXlPNjBqdGFycjZIUGl2djBMTnk1cHRRRmpvUUNOYm5DY1Vl?=
 =?utf-8?B?T0JYLy9vOWh6R0pheCtVSVRhTzMrWjc2MHJ1Zi9EckpIVFlaa0luZ21NaUhq?=
 =?utf-8?B?SDkrUDJPT3pKKyt1M2ppRjZja0REa3Z4VE9XZGYrNDUzd2VSS1daRkxtMXFV?=
 =?utf-8?B?RWV4R3c3WVUxV0hiYzVEeUUzQ1FvM2k2UHVhK3pKUDdmSlhsZ1ZOSnZSSmZO?=
 =?utf-8?B?M0VEUU9MdjZ0djVaRTBjVE81VElaRXpLRGF0OExMV25sbXRRRVkyNjlEUTNi?=
 =?utf-8?Q?B82c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a4e0ca-2d90-4279-f630-08dcbd6e6a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 21:08:30.5329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZI2Z0D8zD/lUN59jIhQAmVL8+BIK2p5veBgLKQYRZ0lZtu+Q6R6bAEJ19jo4yDIO7l4IMUfvZAT7v/bKq/8ECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600
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
Cg0KSGkgRmVsaXgsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3Vl
aGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwg
QXVndXN0IDE1LCAyMDI0IDI6MjUgUE0NCj4gVG86IEpvc2hpLCBNdWt1bCA8TXVrdWwuSm9zaGlA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0h2MiAyLzNdIGRybS9hbWRrZmQ6IFVwZGF0ZSBxdWV1ZSB1bm1hcCBhZnRlciBWTSBmYXVsdA0K
PiB3aXRoIE1FUw0KPg0KPiBPbiAyMDI0LTA4LTE0IDE5OjI3LCBNdWt1bCBKb3NoaSB3cm90ZToN
Cj4gPiBNRUMgRlcgZXhwZWN0cyBNRVMgdG8gdW5tYXAgYWxsIHF1ZXVlcyB3aGVuIGEgVk0gZmF1
bHQgaXMgb2JzZXJ2ZWQgb24NCj4gPiBhIHF1ZXVlIGFuZCB0aGVuIHJlc3VtZWQgb25jZSB0aGUg
YWZmZWN0ZWQgcHJvY2VzcyBpcyB0ZXJtaW5hdGVkLg0KPiA+IFVzZSB0aGUgTUVTIFN1c3BlbmQg
YW5kIFJlc3VtZSBBUElzIHRvIGFjaGlldmUgdGhpcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IE11a3VsIEpvc2hpIDxtdWt1bC5qb3NoaUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+IHYxLT52MjoN
Cj4gPiAtIEFkZCBNRVMgRlcgdmVyc2lvbiBjaGVjay4NCj4gPiAtIFNlcGFyYXRlIG91dCB0aGUg
a2ZkX2RxbV9ldmljdF9wYXNpZCBpbnRvIGFub3RoZXIgZnVuY3Rpb24uDQo+ID4gLSBVc2UgYW1k
Z3B1X21lc19zdXNwZW5kL2FtZGdwdV9tZXNfcmVzdW1lIHRvIHN1c3BlbmQvcmVzdW1lDQo+IHF1
ZXVlcy4NCj4gPg0KPiA+ICAgLi4uL2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFu
YWdlci5jIHwgNzkNCj4gKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDc3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5j
DQo+ID4gaW5kZXggZjZlMjExMDcwMjk5Li5jYjViODY2ZWVlM2IgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFn
ZXIuYw0KPiA+IEBAIC0zMTksNiArMzE5LDQyIEBAIHN0YXRpYyBpbnQgcmVtb3ZlX2FsbF9xdWV1
ZXNfbWVzKHN0cnVjdA0KPiBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtKQ0KPiA+ICAgICByZXR1
cm4gcmV0dmFsOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgc3VzcGVuZF9hbGxfcXVl
dWVzX21lcyhzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSkgew0KPiA+ICsgICBzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWRxbS0+ZGV2
LQ0KPiA+YWRldjsNCj4gPiArICAgaW50IHIgPSAwOw0KPiA+ICsNCj4gPiArICAgaWYgKGRxbS0+
aXNfaHdzX2hhbmcpDQo+ID4gKyAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+ID4gKw0KPiA+ICsg
ICByID0gYW1kZ3B1X21lc19zdXNwZW5kKGFkZXYpOw0KPiA+ICsgICBpZiAocikgew0KPiA+ICsg
ICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiZmFpbGVkIHRvIHN1c3BlbmQgZ2FuZ3MgZnJv
bSBNRVNcbiIpOw0KPiA+ICsgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiTUVTIG1pZ2h0
IGJlIGluIHVucmVjb3ZlcmFibGUgc3RhdGUsDQo+IGlzc3VlIGEgR1BVIHJlc2V0XG4iKTsNCj4g
PiArICAgICAgICAgICBrZmRfaHdzX2hhbmcoZHFtKTsNCj4gPiArICAgfQ0KPiA+ICsNCj4gPiAr
ICAgcmV0dXJuIHI7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgcmVzdW1lX2FsbF9x
dWV1ZXNfbWVzKHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtKSB7DQo+ID4gKyAgIHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopZHFtLT5k
ZXYtDQo+ID5hZGV2Ow0KPiA+ICsgICBpbnQgciA9IDA7DQo+ID4gKw0KPiA+ICsgICBpZiAoZHFt
LT5pc19od3NfaGFuZykNCj4gPiArICAgICAgICAgICByZXR1cm4gLUVJTzsNCj4gPiArDQo+ID4g
KyAgIHIgPSBhbWRncHVfbWVzX3Jlc3VtZShhZGV2KTsNCj4gPiArICAgaWYgKHIpIHsNCj4gPiAr
ICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgImZhaWxlZCB0byByZXN1bWUgZ2FuZ3MgZnJv
bSBNRVNcbiIpOw0KPiA+ICsgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiTUVTIG1pZ2h0
IGJlIGluIHVucmVjb3ZlcmFibGUgc3RhdGUsDQo+IGlzc3VlIGEgR1BVIHJlc2V0XG4iKTsNCj4g
PiArICAgICAgICAgICBrZmRfaHdzX2hhbmcoZHFtKTsNCj4gPiArICAgfQ0KPiA+ICsNCj4gPiAr
ICAgcmV0dXJuIHI7DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgdm9pZCBpbmNyZW1lbnRf
cXVldWVfY291bnQoc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHFjbV9wcm9jZXNzX2RldmljZSAqcXBkLA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBxdWV1ZSAqcSkNCj4gPiBA
QCAtMjgzNSw2ICsyODcxLDQwIEBAIHZvaWQgZGV2aWNlX3F1ZXVlX21hbmFnZXJfdW5pbml0KHN0
cnVjdA0KPiBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtKQ0KPiA+ICAgICBrZnJlZShkcW0pOw0K
PiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQga2ZkX2RxbV9ldmljdF9wYXNpZF9tZXMoc3Ry
dWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBxY21fcHJvY2Vzc19kZXZpY2UgKnFwZCkgew0KPiA+ICsgICBzdHJ1
Y3QgZGV2aWNlICpkZXYgPSBkcW0tPmRldi0+YWRldi0+ZGV2Ow0KPiA+ICsgICBpbnQgcmV0ID0g
MDsNCj4gPiArDQo+ID4gKyAgIC8qIENoZWNrIGlmIHByb2Nlc3MgaXMgYWxyZWFkeSBldmljdGVk
ICovDQo+ID4gKyAgIGRxbV9sb2NrKGRxbSk7DQo+ID4gKyAgIGlmIChxcGQtPmV2aWN0ZWQpIHsN
Cj4gPiArICAgICAgICAgICBkcW1fdW5sb2NrKGRxbSk7DQo+ID4gKyAgICAgICAgICAgZ290byBv
dXQ7DQo+DQo+IHFwZC0+ZXZpY3RlZCBpcyBhIHJlZmVyZW5jZSBjb3VudC4gV2l0aG91dCB0aGlz
IHNob3J0Y3V0LA0KPiBkcW0tPm9wcy5ldmljdF9wcm9jZXNzX3F1ZXVlcyB3aWxsIGluY3JlbWVu
dCB0aGUgcmVmIGNvdW50LiBZb3UgcHJvYmFibHkNCj4gbmVlZCB0byBpbmNyZW1lbnQgaXQgaGVy
ZSBiZWZvcmUgZHJvcHBpbmcgdGhlIGxvY2suIE90aGVyd2lzZSB0d28gdGhpbmdzIGNhbg0KPiBn
byB3cm9uZzoNCj4NCj4gIDEuIFRoZSBjb3JyZXNwb25kaW5nIGRxbS0+b3BzLnJlc3RvcmVfcHJv
Y2Vzc19xdWV1ZXMgd2lsbCB1bmRlcmZsb3cgdGhlDQo+ICAgICByZWZlcmVuY2UgY291bnQNCj4g
IDIuIEEgcmFjZSBjb25kaXRpb24gd2hlcmUgdGhlIHF1ZXVlcyBnZXQgcmVzdG9yZWQgdG9vIGVh
cmx5DQo+DQoNClRoZSBpbnRlbnQgaGVyZSBpcyB0byBjaGVjayBpZiB0aGUgcHJvY2VzcyBxdWV1
ZXMgYXJlIGFscmVhZHkgZXZpY3RlZCBvciBub3QuIElmIGl0cyBub3QsIHRoZW4gd2Ugd2FudA0K
dG8gc3VzcGVuZCBhbGwgcXVldWVzLCBldmljdCBhbGwgcXVldWVzICh3aGljaCBhbHNvIHVwZGF0
ZXMgdGhlIGV2aWN0ZWQgcmVmY291bnQpIG9mIHRoZSBhZmZlY3RlZCBwcm9jZXNzLA0KYW5kIHJl
c3VtZSBhbGwgcXVldWVzLg0KSWYgSSBpbmNyZW1lbnQgdGhlIHJlZmNvdW50IGhlcmUsIHRoZW4g
ZHFtLT5vcHMuZXZpY3RfcHJvY2Vzc19xdWV1ZXMgd2lsbCBub3QgZXZpY3QgdGhlIHF1ZXVlcyB1
bmxlc3Mgd2UNCmNoYW5nZSB0aGF0IGZ1bmN0aW9uLg0KQW5kIHRoaXMgZnVuY3Rpb24gd291bGQg
YmUgY2FsbGVkIG9ubHkgZm9yIHRoZSBWTSBmYXVsdCBjYXNlLCBzbyB0aGUgcHJvY2VzcyBpcyBn
b2luZyB0byBiZSB0ZXJtaW5hdGVkLiBJcyBpdA0KcG9zc2libGUgdG8gaGF2ZSBkcW0tPm9wcy5y
ZXN0b3JlX3Byb2Nlc3NfcXVldWVzIGNhbGxlZCBvbiBpdD8gRXZlbiBpZiBpdCBjYWxsZWQsIEkg
ZG9uJ3QgdGhpbmsgd2UgY2FuIGhhdmUNCnVuZGVyZmxvdyBvZiB0aGUgcmVmY291bnQgd2l0aCB0
aGUgY3VycmVudCBjb2RlLg0KDQpDYW4geW91IHBsZWFzZSBleHBsYWluIHRoZSBjYXNlIHdoZXJl
IHRoZSBkcW0tPm9wcy5yZXN0b3JlX3Byb2Nlc3NfcXVldWVzIGNhbiBjYXVzZSBhbiB1bmRlcmZs
b3cNCndpdGggdGhlIGN1cnJlbnQgY29kZT8gQW5kIHRoZSBzY2VuYXJpbyBmb3IgdGhlIHJhY2U/
DQoNCg0KUmVnYXJkcywNCk11a3VsDQoNCj4gUmVnYXJkcywNCj4gICAgRmVsaXgNCj4NCj4NCj4g
PiArICAgfQ0KPiA+ICsgICBkcW1fdW5sb2NrKGRxbSk7DQo+ID4gKw0KPiA+ICsgICByZXQgPSBz
dXNwZW5kX2FsbF9xdWV1ZXNfbWVzKGRxbSk7DQo+ID4gKyAgIGlmIChyZXQpIHsNCj4gPiArICAg
ICAgICAgICBkZXZfZXJyKGRldiwgIlN1c3BlbmRpbmcgYWxsIHF1ZXVlcyBmYWlsZWQiKTsNCj4g
PiArICAgICAgICAgICBnb3RvIG91dDsNCj4gPiArICAgfQ0KPiA+ICsNCj4gPiArICAgcmV0ID0g
ZHFtLT5vcHMuZXZpY3RfcHJvY2Vzc19xdWV1ZXMoZHFtLCBxcGQpOw0KPiA+ICsgICBpZiAocmV0
KSB7DQo+ID4gKyAgICAgICAgICAgZGV2X2VycihkZXYsICJFdmljdGluZyBwcm9jZXNzIHF1ZXVl
cyBmYWlsZWQiKTsNCj4gPiArICAgICAgICAgICBnb3RvIG91dDsNCj4gPiArICAgfQ0KPiA+ICsN
Cj4gPiArICAgcmV0ID0gcmVzdW1lX2FsbF9xdWV1ZXNfbWVzKGRxbSk7DQo+ID4gKyAgIGlmIChy
ZXQpDQo+ID4gKyAgICAgICAgICAgZGV2X2VycihkZXYsICJSZXN1bWluZyBhbGwgcXVldWVzIGZh
aWxlZCIpOw0KPiA+ICsNCj4gPiArb3V0Og0KPiA+ICsgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+
ID4gKw0KPiA+ICAgaW50IGtmZF9kcW1fZXZpY3RfcGFzaWQoc3RydWN0IGRldmljZV9xdWV1ZV9t
YW5hZ2VyICpkcW0sIHUzMiBwYXNpZCkNCj4gPiAgIHsNCj4gPiAgICAgc3RydWN0IGtmZF9wcm9j
ZXNzX2RldmljZSAqcGRkOw0KPiA+IEBAIC0yODQ1LDggKzI5MTUsMTMgQEAgaW50IGtmZF9kcW1f
ZXZpY3RfcGFzaWQoc3RydWN0DQo+IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sIHUzMiBwYXNp
ZCkNCj4gPiAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAgICAgV0FSTihkZWJ1Z19l
dmljdGlvbnMsICJFdmljdGluZyBwaWQgJWQiLCBwLT5sZWFkX3RocmVhZC0+cGlkKTsNCj4gPiAg
ICAgcGRkID0ga2ZkX2dldF9wcm9jZXNzX2RldmljZV9kYXRhKGRxbS0+ZGV2LCBwKTsNCj4gPiAt
ICAgaWYgKHBkZCkNCj4gPiAtICAgICAgICAgICByZXQgPSBkcW0tPm9wcy5ldmljdF9wcm9jZXNz
X3F1ZXVlcyhkcW0sICZwZGQtPnFwZCk7DQo+ID4gKyAgIGlmIChwZGQpIHsNCj4gPiArICAgICAg
ICAgICBpZiAoZHFtLT5kZXYtPmtmZC0+c2hhcmVkX3Jlc291cmNlcy5lbmFibGVfbWVzKQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgcmV0ID0ga2ZkX2RxbV9ldmljdF9wYXNpZF9tZXMoZHFtLCAm
cGRkLT5xcGQpOw0KPiA+ICsgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgICAg
IHJldCA9IGRxbS0+b3BzLmV2aWN0X3Byb2Nlc3NfcXVldWVzKGRxbSwgJnBkZC0NCj4gPnFwZCk7
DQo+ID4gKyAgIH0NCj4gPiArDQo+ID4gICAgIGtmZF91bnJlZl9wcm9jZXNzKHApOw0KPiA+DQo+
ID4gICAgIHJldHVybiByZXQ7DQo=
