Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78BCCCFA0D
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 13:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58B6D10E0B1;
	Wed,  5 Nov 2025 13:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="muYqeWRU";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E77A10E0B1
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 13:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyljI1wMz10naq3Q6iVdLIqPmiUEXy+NJPeAdMVtZpVtY8gJ90WQxVg91kNZ4ITEFN5z4UJFK/Mg+fk1LvAWx9rTGm6hDdWVL1W0GJykiubUh7xhJxwtfx0M7MrKUUsoTa7zdCLZENyU4D1YWy7B2vmBtRUhMH5qYfZ6YBpIKMh+MhpFK9yB4dw0uMVpx/TNI5xQrce/nWn+hu/GR1wF1B/YbvRL76offf5yfiCVecEWwmvCUUaYwUkycfcdSxG64Jq5/jnSiQU7GPCNddeHYlOvBrwLk0MWvnLgqSNmH6wpzwTuRVG7B+UNadcWzDsZNYB8iLWHCyTho2chJuf2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42prMuviRLYYwb+FGbIUlhn8Un6Svp3O14D8vHfhpHs=;
 b=Ggq9Y4UM6MP2Rukm3GA1t2y+64H3XsVSicTNpPm+8/pS6l6N9sxFXKQMb9nWIAW9SfjpJLktoTH2YQqsGFngpd7xRxhWaE0KAqj+Db08xRQL8p71cM2XyOCgmI1hNdcvshgbsp7JGVX/cO6EHYGi7/SVZ0bU/2XWLZgP6I/F3ICYZwxcIaMIVmDATlxVb9EHu0SBpRedvk5bRtfSwjAP8rB9MB7AJTVcGJ5eWH73ib1NXMXxmVvLehXwy4/xmRBLk15JBe5RpRFnXL0JO0NLuYdozitRMySy8P8F/xO0NrA4BiziJGGE1C9G7eTNU7/OthbtPwvcyogib8UMhd72IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42prMuviRLYYwb+FGbIUlhn8Un6Svp3O14D8vHfhpHs=;
 b=muYqeWRUZqzfoshYcEmlwcxe8UdMfI4tIQbKhgVLDc7c8psoScH0iiFq5UkG5fwozW1OA3uu2NpibYbByOTSurWBnQELO99woGhDJWMPonnQfd388fMeKGNzR8OtkFBBCp2+DY+28ICJN+lKZaW8unpceKkZ8ejlLBg6RC6gza8=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA0PR12MB7580.namprd12.prod.outlook.com (2603:10b6:208:43b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Wed, 5 Nov 2025 13:38:32 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9275.013; Wed, 5 Nov 2025
 13:38:32 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: attach tlb fence to the PTs update
Thread-Topic: [PATCH] drm/amdgpu: attach tlb fence to the PTs update
Thread-Index: AQHcTk23Fsn5u6MnIkSf2dQxl03JWbTkCMeAgAAGZ3A=
Date: Wed, 5 Nov 2025 13:38:32 +0000
Message-ID: <DS7PR12MB6005EF181DDD22DB86CE49C5FBC5A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251105121403.4154169-1-Prike.Liang@amd.com>
 <83602bd7-cf0b-4b74-8b64-48d16105de42@amd.com>
In-Reply-To: <83602bd7-cf0b-4b74-8b64-48d16105de42@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-05T13:13:00.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA0PR12MB7580:EE_
x-ms-office365-filtering-correlation-id: 28139946-47f4-4952-36b6-08de1c709cd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?V3dVNGxMaTRsb3BuTEEyTDY1U2lqVWF1M3ViakVBaDNvTFFpQjh6am1ZY1JQ?=
 =?utf-8?B?RHRxbWhxZ3NFa0FGQWNCZ3F4TGFIQUhoVDMvbkpFYlhrcHB5b2hsOTI0ZTVX?=
 =?utf-8?B?ajhRV05QckZpajMvczluTHc2azdFaFI5R2RjT3UvVEllUGV4ZXpqQ2IySEpD?=
 =?utf-8?B?TW9LTVRXdWFJdHh4dmxMMEY4QWdGMW5YL0hIZ2NiUlpwazhxQ0RTRDdCZ05j?=
 =?utf-8?B?TUtkKzNLMVBxbkFCWkI4TkZlMUd6NUdNNHN0SEVtWjc4TzI4dEdCbUxVUkly?=
 =?utf-8?B?dUdwQ3oxbVI4UlE1Q3pwYTM2SmdpcWtFSUhER3Iva2hyTkw3cmtwelFMRVdv?=
 =?utf-8?B?YTBpcDlYUVVoYUs2dmxwQlA1U210dzdFaS9SeEhCNXR4bE1RWlBVNzJjT2Fj?=
 =?utf-8?B?SVRuZVhLb1JoQngyMXg4SW5nejBITEU2dHlWRlNSV1lwVzNMZ0tsaGpkcEZI?=
 =?utf-8?B?STNSeXdVcVlaUUtpWHBacWZYRWE1YStRMnk5ZmJUSXlveFZRTVdUenNQSlZo?=
 =?utf-8?B?UFZNd09nTFNhU0dPOGRRZ1QxK212V2pvRTBVWEo4cEMvZm9ZZ2NWZDVPUW9p?=
 =?utf-8?B?SUJQM3dIWGgwclFoQmhaemg2cG11TGZ5N3BRNUZZbXRMZVFKSG9QbnV4SUJl?=
 =?utf-8?B?ZWNYYWQya1lmU0hnQTFrZ3paMENwR0VESmtDSHNvSEw5OGVzT3lGbjF6aDUz?=
 =?utf-8?B?eC90NVVyYXBOMnQyaytNNUlkeXNwU29GMWlMRUFacjFBS21nS0F0ZzlqMnUr?=
 =?utf-8?B?WnJuT2RmcktTeEVpREFldkxBbkExOUZXaHByTEVXcCtQN200YkJJZVhMR1c1?=
 =?utf-8?B?Tm50UUFPUU94RWRkVkJTV2U5SW9xby9tRjJjbTdwZjM1QzdTV1l2aVBjS3lY?=
 =?utf-8?B?OFZHNjRVYlhwQWpxb2JlODRZTEJldk9mRDVoSGRxUUpFZjN2RHIvVTNOSG5H?=
 =?utf-8?B?RjJma3c5UC9SeGk3OXdBQlMzc1pJcW00UE9meVhOMGVrRU95RDJPb1JQdUIw?=
 =?utf-8?B?aWNYejNueUVieXNzNmkxSUc2OWFJU0dKZzlWQm9IUWE5WGlrWkpvcExGMEpC?=
 =?utf-8?B?L1hmRGVTQ0QzNjF2aklEWnFwbjdHWDhiVHpvZXFmRGFsdG1NQUg2bGJiTFJR?=
 =?utf-8?B?NTh5aUVxQlFVVmcwNVRqL0lwSUlFRWtRTHpkMS9uRFhNNG5LQjNiYjgyVGd3?=
 =?utf-8?B?Sy9WUnY2MzQ4VUlzZUN2dzRSOVc5TzI2MGJISzVvaHFqa2MvVElHcFBPNFNx?=
 =?utf-8?B?SEFhNlFyR3VxaWZ1SFFTSnptSUJtTVdFTExrTzNuc2psZG5hYi9HVDgzN3pv?=
 =?utf-8?B?U2duVml4L3RzZGpKOTkzaVBnY3liVHRSTVNnSlNlWEcvcysyZk5rZnhhTUl6?=
 =?utf-8?B?ekE0RDJoZDZhVnNUY2s3b2E0RWdZSjdHbTBrQkU3OEtrMDVRLzlwSGYzZUdP?=
 =?utf-8?B?eXg3c1FiZGV5Z3JhbllwRWo2NU9rUDRzcFJMTHVkYXBVWlNlMU15Q1dRdXQ4?=
 =?utf-8?B?QUl6QVZMby80cXlzZ0pOalk0U09tazFNVTQrU2w5RzdsbUtNRjcvSUV1QkZq?=
 =?utf-8?B?TU1BOGMwQ3BVT05MYW1YRUt6dnZTK0EyTndaMlhyTEI2UlVXcDd6NWdseWVw?=
 =?utf-8?B?VjhDREUyWk12RENWWEhTNlpIa0JaR2dMRHlMRDZZV0JMMmZaVTA0UGtqblBQ?=
 =?utf-8?B?Z0VCai93VDVmbkVwWENKbEVSNWFOZ1oyTm1hNDlMcXBBNGQyN29IRUl5UFc1?=
 =?utf-8?B?aVY2dUd3Rk5ab240UmN6bkZaYVJiVVFYUVR2SDArV3V0SWpEeVA5eWFwTU8y?=
 =?utf-8?B?SlZDVlpSQ3dhcG41MXBOY3dRQWNPR2JKU3ZubzRrZTBLT0ZTeG9ZdENRZFVr?=
 =?utf-8?B?L2dLL3NwQ0Y2aktIQ2Z1TXFsZVpxbzhtaUwwekgrSjZCM1BOdlRtZGtvTG15?=
 =?utf-8?B?TVVIMStqSDBCTkErL0tKWCtndk42MTI0eDNmeG5rclkvOXRQYWVuMCtPUnB6?=
 =?utf-8?B?SDFSNmU4RXhwMG5ZUjR6dE1RcTN1cUo5V2pGZWdsK1FWQzFrajdXWG00NW5x?=
 =?utf-8?Q?vH0qCo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTIwQjdhajZWYjBnenltZncrMWhFUVpaUENsREc1SExjS2dIeXVibzdpQzVC?=
 =?utf-8?B?Y0JxaWVWNWl3T0gyMWxmWUkyVnNHQkM0STB0VnNubkZqREhpeHROTTZKQ25v?=
 =?utf-8?B?cEo2SyswN2U1cEpzZVZ0Mlhhc0VaeFZFT3FFNkx1akU5VVNSV1Z6TmZxQkxp?=
 =?utf-8?B?ZldBK01RaTQrTndhTzcydElKcnl4eXdHV1JFcGJGWXhDek1DaVFuODNmQlZM?=
 =?utf-8?B?S1hBamducVYvcUUvang1T0JHeUQ5TW9yRXpqOGdselVnMXV4MnpVOE1pSkJw?=
 =?utf-8?B?R3NZU0xWRkcxZExyM3dmUitMcUlYQXBJK2dpYm5uTVZKdTBtMUNNUGZKaXJJ?=
 =?utf-8?B?ZDJyWHV5VUlaRUZKY1FsOTdpdU1ONTZDS3l4bXoxTGZ6L0VmYm4vb3NNMm5p?=
 =?utf-8?B?Z2RXNGpxV1ZVYWdsVGxMSnlsZ0FMTDFLVFcvRHI2MjJadU1aNmlaTTlGTXpD?=
 =?utf-8?B?MEc0V1hlbjl1SG9CWDJiaEVjSEt1d3hOVVRpZ1Q2ekg4Z2dGdzRCWU8rZG1T?=
 =?utf-8?B?emRjRThmekZVTVRsV1o1NXRZTFhZWEplajNBYk5CY3hBVmViUVdzdXUxc2FU?=
 =?utf-8?B?WS8rR3VNVmM4UGJwUkxEQ0UzY1BFT2YrbGF5WVJkcFpxc3JrcDUxd090cmNR?=
 =?utf-8?B?Uit0eUpRMkFjWThSV1pWR0NBVzJseWJWaUpjelNWRWJEdi9IZnl0azYvaVZ5?=
 =?utf-8?B?YkNZOUNWcFpaS2tsbWZxWFIxU0ZoQk5ocTlCdVVDSnpnSHdNaXRaOHRwT0VP?=
 =?utf-8?B?eWVnUldNa3JQOXF5K2pNS2g2OVh1WjQ4NzR3Y2tXeGVPNUtyZzhFaU9uU0lC?=
 =?utf-8?B?ejF0SkcvNEFzYmFpUU9KbkxPQ1lOUkFWZU5pZmwycDBwWGFtWktDVG5QTVN0?=
 =?utf-8?B?b01NRm1uL1VQVlJLSFdtQVJhbmdTTFg2VXNzZW8wb1VGeURlQXRiV2EvMVla?=
 =?utf-8?B?UnhnTEN0MDVuYjlxemYrRzE4UGp3alp0RmgzNytscXZySmJ5V0tEanhWYWJ0?=
 =?utf-8?B?UVRBMElid25MZDdTMmM3a0YyMlh2WlZHc0tXK2ozRTRPTFBKdThaTW5id0pr?=
 =?utf-8?B?QUxhRnZqQ2lQS1R4RHd3TTVtWW00eTd0bC9qcHRFYVJ1aEVmcUw0ajBCQ2Fq?=
 =?utf-8?B?UnJYTHNzYnR4NUZCSldrVU5QMFBzcjRJd014UGpOZFJURXQvWWo2b1pDQld1?=
 =?utf-8?B?UWhmMzBmTkRUa2taamhtRHhwZDJ2c2JlR2hXaU9scnpkemxoRlRHYjNZUEJm?=
 =?utf-8?B?QWZTdHZWQWFNdVRUelRYMHR5Z3phSWFuemhKdkdTZkR5VWJNTG12UTdJRXp4?=
 =?utf-8?B?emJSbUx1M1RCS3BFeW1Qcm5DYWxmcm4wVG9UU2x2Rlpuc3FjOEw3ZHpScVV2?=
 =?utf-8?B?K3RNWG9oVDdNSkluOGpaQVpYY09JR1RFOVA2Ni9zWXBGZ1YvSUZRMGFQYkcx?=
 =?utf-8?B?b29LejdjMG5pRHFHS1VNNW9xVXZqSXRrNnc1a2t2WTRtWlZMSDFuUUVXbW1u?=
 =?utf-8?B?dm9mNkY0M3RHREdPQkR1Mjlsa3FmM0JlUGR3ampOMUZWNXIzdkpkTVVLT3hx?=
 =?utf-8?B?MWNydWNkME5SeWtBeVorKys4RVM0ZmJCbXFwaUNCcHNOSUhXUUFSdHVTay9G?=
 =?utf-8?B?SGpoRDR4QURacmtKSWRhbFRvNnU3UDFMSjRIajZLMGJmU0diM21FYzhmcTZB?=
 =?utf-8?B?aXoydC9CWGdFNTljZmJGWU1TS2RQWlhZNlhmWHdQYmFENXlpQ3RRUXJMcVZF?=
 =?utf-8?B?TXBqU3ZjU1ZzS0VKVnVNL1FWOUlvNEFXb3RpYlJVZUw3aFkxdm1oWE16MHhi?=
 =?utf-8?B?Ym5vQm9lZWU3VkZyYXFMZUxiUVFEMkZpaE9nV2pnSUhkaVlhdWZ1OTg4UmxL?=
 =?utf-8?B?ZndKVXJFajdJOTVGQlIzV2t1K3J4U21TQVljM1Vlb2NrVHJ3a0k1OElGSElv?=
 =?utf-8?B?aVlSc2J5eTZpNzFsMEdiRG56cGJTTEdqYkg0MEdNaldPTlB6dVYwWkJhZkh1?=
 =?utf-8?B?aE9BbUE1UUNmYWxJTHdUMEFqMUdsNUY2aEZ1ZjlQNnNEdU5SZW1pb01TTXlM?=
 =?utf-8?B?ZlRUQjVZQ2p4STlvclJ3Z1hqdkVmWk5kRzRRaXhPM2JnbDRSeWdsRzB2dFVP?=
 =?utf-8?Q?7vjs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28139946-47f4-4952-36b6-08de1c709cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 13:38:32.6003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TvpkQ1MD6kwfNyqcQ+Opn4dq8VFjkDV/pTl47U6l9YJjFY9ynMu7rG7vPaTiOs6y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7580
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
LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciA1LCAyMDI1IDg6NTAgUE0NCj4gVG86
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGF0dGFjaCB0bGIgZmVu
Y2UgdG8gdGhlIFBUcyB1cGRhdGUNCj4NCj4NCj4NCj4gT24gMTEvNS8yNSAxMzoxNCwgUHJpa2Ug
TGlhbmcgd3JvdGU6DQo+ID4gRW5zdXJlIHRoZSB1c2VycSBUTEIgZmx1c2ggaXMgZW1pdHRlZCBv
bmx5IGFmdGVyIHRoZSBWTSB1cGRhdGUNCj4gPiBmaW5pc2hlcyBhbmQgdGhlIFBUIEJPcyBoYXZl
IGJlZW4gYW5ub3RhdGVkIHdpdGggYm9va2tlZXBpbmcgZmVuY2VzLg0KPiA+DQo+ID4gU3VnZ2Vz
dGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+DQo+IFJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+
DQo+IENvdWxkIGJlIHRoYXQgcGVvcGxlIHN0YXJ0IHRvIGNvbXBsYWluIHRoYXQgdGhpcyByZXN1
bHRzIGluIGV4dHJhIG92ZXJoZWFkLCBidXQgdGhhdA0KPiBzaG91bGRuJ3QgYmUgbXVjaCBvZiBh
biBpc3N1ZS4NCklmIHdpdGhvdXQgc29ydGluZyB0aGUgdXNlcnEgb3IgS0ZEIGNvbXB1dGUgY29u
dGV4dCwgbWF5YmUgb3ZlcmhlYWQgb24gbGVnYWN5IGtlcm5lbCBxdWV1ZSBjYXNlPw0KDQo+IFJl
Z2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYw0KPiA+IGluZGV4IGRiNjZiNDIzMmRlMC4uNzlkNjg3ZGVlODc3IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiBAQCAt
MTA2Miw3ICsxMDYyLDcgQEAgYW1kZ3B1X3ZtX3RsYl9mbHVzaChzdHJ1Y3QNCj4gYW1kZ3B1X3Zt
X3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywNCj4gPiAgICAgfQ0KPiA+DQo+ID4gICAgIC8qIFByZXBh
cmUgYSBUTEIgZmx1c2ggZmVuY2UgdG8gYmUgYXR0YWNoZWQgdG8gUFRzICovDQo+ID4gLSAgIGlm
ICghcGFyYW1zLT51bmxvY2tlZCAmJiB2bS0+aXNfY29tcHV0ZV9jb250ZXh0KSB7DQo+ID4gKyAg
IGlmICghcGFyYW1zLT51bmxvY2tlZCkgew0KPiA+ICAgICAgICAgICAgIGFtZGdwdV92bV90bGJf
ZmVuY2VfY3JlYXRlKHBhcmFtcy0+YWRldiwgdm0sIGZlbmNlKTsNCj4gPg0KPiA+ICAgICAgICAg
ICAgIC8qIE1ha2VzIHN1cmUgbm8gUEQvUFQgaXMgZnJlZWQgYmVmb3JlIHRoZSBmbHVzaCAqLw0K
DQo=
