Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54419E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 09:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB86710E03C;
	Thu,  2 Jan 2025 09:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UVjA3i6l";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A5EF10E03C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 09:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAo+Z7y06uqF4BuyjDC8k9cUiDxKqNSHCLDy3XsyQ+lZ2mVftxrNaDBqL32ZkarvQoy8AqWDOAIPEIPPUquVeWFt59oxzcQrHw4VYsKd0sbNmulzAEqfpT7YoBUf32PZEttuRQy9FvPt1nPLdJoF/KA/jf8gQzaYv9Yk++XV8RRgv+USLNRJC8X/vBflr4RGASRXNgb3qNb8I7KZNx6mlRfUrgbJvsw6VjhmOkFMaqJkqmIcqwFTetspEVUlFslo5Y5u/4WihKN3csJa7+0Tg61+D6Ve2VUyB8rGWNp2lZXZzst/FFmRiNIFvA5D6X9LnGYeyNLjj5RgpUQkWFs63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsFOmhkUOPt5SnK+2tGETXBFsqKZ6dt2P+97uAs0WxE=;
 b=Q+sYqvc9Y65XtW5xa2BUcpuxIcOEMCI4LaujL1Ysee0KmfV4P9I7cavlFQ6zK2VHESefh8HLBvVnK2jHupwyHGzuuUDVG/NljKGWfayZ//rOKOpbR1XNt86YG9KkmvWPB6MPUQXwhgg3lb81YABNrgU1fbdB5Pp9CcLoPHrf9t5HXUxJ1wEUVU4QzL9DQrmh/x65Yt3rwNMciywI4vdTX8UXgAo0pe1P08NhEvcVyxBjJFbkrxSachG9a8sYuPpqNC11aPZqJEdV/7snB7y/S8Yj0eUpA7lUUC/iAkcW8SYjcOJwiN8qGPrReOswXzT+7Lwg7tykkmHAzPs0nAj+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsFOmhkUOPt5SnK+2tGETXBFsqKZ6dt2P+97uAs0WxE=;
 b=UVjA3i6l+2ffiZw9dLAT/T9VdhJvkviX/3ay9t45ZL1uYNn7RPI8OufH6zsy19XCo4toZfAv9vbFGJ2/B0+JQVqNTqBuWG6/GYSEojrg1VCUw6VrwgG0sWCnswrmU+XrwL2Yc1Rwr2JfIY0EiX9hCWtcBBF/uibAyK9xZ31SVmk=
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 09:40:33 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%5]) with mapi id 15.20.8293.000; Thu, 2 Jan 2025
 09:40:32 +0000
From: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: test release process eviction fence before
 signal
Thread-Topic: [PATCH] drm/amdkfd: test release process eviction fence before
 signal
Thread-Index: AQHbXN/0mLhG2YFHlECKMHCb57CD5rMDEbWAgAAObACAABp1UA==
Date: Thu, 2 Jan 2025 09:40:31 +0000
Message-ID: <SN7PR12MB7835724ED1D66C740BE866EB8C142@SN7PR12MB7835.namprd12.prod.outlook.com>
References: <20250102063059.2221560-1-Prike.Liang@amd.com>
 <66d90655-b070-45e7-9222-28e65007e50b@amd.com>
 <DS7PR12MB600585C2E1414074D1B480D9FB142@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB600585C2E1414074D1B480D9FB142@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=14c9a7f0-7f03-44f3-8632-ad03d8607659;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-02T07:42:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7835:EE_|PH7PR12MB5973:EE_
x-ms-office365-filtering-correlation-id: 1778d83f-45ca-481c-a6d2-08dd2b118014
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VzJxQVBWYW91SlBDQlYxTkdzWHZVZ2RsZ2NHQXFuUjZ0S3RqMFpmKzZMUVdF?=
 =?utf-8?B?bHpBWnFCZERtMzRFd2oxNWluelNNSUpnUVRjL0RrOXc3TUZUMUJqMXB1YUxt?=
 =?utf-8?B?ZXl4Z0cvMWZIbzJpVllweEZaYzV6b0pIRmVCNWhGU29HQTBhSmJBSWdCbUtm?=
 =?utf-8?B?K0lLQWdQV0hSUDB6QzhEZmNOd2VTWFR0L2FtYUJ2WVdSTzZ1MWZKTDZSVTJM?=
 =?utf-8?B?Z1lpZFB5RmUyUndtUmt4VmgvVkNjTWs5UDZmb3NBZkhWZnZzYVQxbmlsbFMr?=
 =?utf-8?B?QnZBY0xUSktmYU1aaXYxM1hqRUlZZnRYZEF5czh0dlp1Rm92cGt1bDBRemVW?=
 =?utf-8?B?SE5kb0swTWYvOTRxSTZJWE1LWlF5ZjVYRnRqNFI1TkdUbHorUFJScHJUVFIw?=
 =?utf-8?B?blVKWi9UaGFzenc1M1RhSlJ5SnZuTFdMMWNOWmFnZGZvUitlS3FnbXlRejlS?=
 =?utf-8?B?dVZkRTFqYk8wWmNxWjJ4YWdPRnh3bUFGSm1COFhVMU4rUmpmaW9qRWFQQ3d1?=
 =?utf-8?B?aU0rRU0zNTBPbEJ6UTJUKzdoM1lDSGxud3VkdHkwVllpU1RkRHJWZ2EwT1RE?=
 =?utf-8?B?YnJsUmduakIyK295bVFBZ0szZm1scnY4SXJrTXhPZU1tbnBXRE91UHAzck5Q?=
 =?utf-8?B?MGtKU0Y2N2cyQ2dJUlVqODd6Q0srY1lNN29WdVlPSHhyNTZSNUw0RUU5ZW5l?=
 =?utf-8?B?a255Ymx0ZHNOMmhZVFQzb0JvMFJYUXRvdkRTZVMzNHZ0ODhsN0hDV0d4bGZz?=
 =?utf-8?B?WG5ncXdEVi9uQVFBZy9zWWhlckpVbTBINGZOakhVY05mTSs0M2ZFc2FicTZ3?=
 =?utf-8?B?MWplQkFOZFVDMnJUbTN2UVlzY3hsRjU2ZEtVM0E4R0N1ejRHOXF3blFROHNY?=
 =?utf-8?B?R1lEVTA3bHhLUWREZ2g1dGxzbWhzTTFRTTErZnREUTFoUy9EV3lTdzFxMWFV?=
 =?utf-8?B?RFFvTlY4bDg2eFpaVHd1cWluZGJ1ZWN5T0g4QnhRZ2x5ajQ0QzJ1eWlHOXp6?=
 =?utf-8?B?Z294bU5CTkJ0U1c5Z2VzL0Z0SWxQK1M4eTdmT1pRbFFyeFp6OGRBdkRXV1Rj?=
 =?utf-8?B?Y2Qxd0Ezd05jZWxCdHRDa2Q3cHE0WXdOekVDZ2UyZXpJM3NnRWF3dnpSV2RM?=
 =?utf-8?B?L2JSb2JXemVlTURrT2R5TmhXNWNCa3JiNnkwdm5KMnRwMGJsdFRDb0RKcW5s?=
 =?utf-8?B?eWg4WElVR3ZGRkpXaGRDalZkZ0o2MXA2OVF3bVdKOGRkZHVtTElCQlhNbjNk?=
 =?utf-8?B?U2xZRm5nNkM0NHpETE9FcVIvSWRkZ2FiZmx1VnV1L2tIS1JoV2hNQTN5UXda?=
 =?utf-8?B?RXpML2Fad3plb3pBVngybFdSSmVEVzlLVjUwcTQ1RXEzS0h4UjNsRnAzVXBJ?=
 =?utf-8?B?emlEU1NyWDYyTWRHQTNudHJ4Q0NVZVFPSmt0MUhweEFnN1dHdEdYNUhWK1h0?=
 =?utf-8?B?bEZ2YlhOOWl4OVRINXVEQVVrUHBkdWhIMWlxQU1PSFgybVhrV0hFSWRzdGxL?=
 =?utf-8?B?akpjc3JjNS9Cb1N1TkpKZTNacVE4M2UxZldremViU2l2UnNmYUZoTnJzUk9s?=
 =?utf-8?B?YTRhdWRYMTh4V09GSVdEUkpyQXpuQVRjR3FaYzlOQmtoaHN5U0lVeDZDREY3?=
 =?utf-8?B?NWlnQStyZm5pSVZqZVRUWUpYazk5WitWTGt0a0Y2SUNiemc0ZnducWljeTE5?=
 =?utf-8?B?YUhTUTRJQnVnNFRka3phV0IydEUwenRCcTloemNHZWZJVGNKMWY0TzJuTlNP?=
 =?utf-8?B?Q2J6THJFcWJtL005b2diQ09lMm5VU2tXZXNSVFNoSTIrcU5wejBzclQ1YWd3?=
 =?utf-8?B?WkM4NjRnRWFLMUVHOVZoVXEya3VTNU1yK1g2WW1RLzFkcVlSK0dxNFZFZHZx?=
 =?utf-8?B?eitBU3l3MXdPQnpjRk9LKzIvdnBmYjdYeE5jeDFJMFV4K3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEs3MWlzRGsrMmEyVHM4SmlZUkhwbVJtRERUb1NWa0pHMlY0RHVzYUJLWXNL?=
 =?utf-8?B?djBrOUpWS2ZsMEVzNDlmOGVwdFVSVk1rdEROOW8rMFBEVCtxeW0xR0FBeXNQ?=
 =?utf-8?B?S2p4aXNvZFZwN1dxV0YyYktyZ1licGZaQjZKcnFOZkM0T0lycjlFNmJUYnpu?=
 =?utf-8?B?eWVaSkdkaWVQczV5TGxHTzhBYXhPdnBrcEY0QkpIWnRqQXlmR0hRL2RwTjVJ?=
 =?utf-8?B?NXJpM3ROTUVZSGdOaDBNeDRQWm9MUnpiR3FmV0FlelpYQ1FkRXJ6YXB3Uk9K?=
 =?utf-8?B?K0JTMDFvWkNQTmhVcy9QeWNsbEtpdFRQV3B1Vk9jQlFscUxmVFFGaEw4RDhU?=
 =?utf-8?B?Sy9DL2RHWVU2dDNpMzNRQ3M5TVAyUHdZa3M0K3U0V3ZRT28xQUo2bDdEUE9i?=
 =?utf-8?B?OUg5SUhld3A4Z1dXUXRSWStqSUhmczFOYjdRZ09LWjNDbGpMVWdxMVBCb0Ey?=
 =?utf-8?B?aERtYlZ3MmhyQU5NSXh0Ry9PMjNMSEw4dTYvVmlRbC9UQ1FmTUtjZGJkaFBS?=
 =?utf-8?B?MHcyRlh1NHJnQlVHTGMvL1RrekhzYm8xVDFxbUlEMXJDYjQxbzF0dVBKcjFP?=
 =?utf-8?B?MUlJdno0TlNOWmVLUldmTE0yRVByVG5wQTN4VjJ4L2lVZ25GQ2xiaHpWOFJJ?=
 =?utf-8?B?Umt2aFQyakVNdXlBaS9VcDZISzdHOGU2VzA5UVJaS0FZaTNKb0orY3FyQ2RI?=
 =?utf-8?B?ZERoNDhEUGhBeE9UQWNnWDUvTFNVRnZkTDNYTTZqc05iUEYxVlh1U2s4K2Jw?=
 =?utf-8?B?eHN1U1dKNnZHSXpBRW4zNXRnZEFzeVA1VlJHanFxV01hbGhqb3B2VXVTV3RL?=
 =?utf-8?B?aG8wSjFuOEJaZWlsbEo1Nk4vNnBzQnBWNmpkckU3QlYvVDdKZlVFZ0dwVkM0?=
 =?utf-8?B?dGJ4bUgyMFZUOHUyYTVMZkRYaG1PN3dSejdYclY3VHY0VENkYnVPNFBPd1lS?=
 =?utf-8?B?Q1BSVS9YdW8zbE85eHUraVgyTUZhS1FVQSt2dnRCYTR4WEhvU2JmdkdZYlNF?=
 =?utf-8?B?dGt6YmNZOTBQVDdZSElodUJQY2dUTGhJeFdBald0M3FCbzRmcTRtNGFVRWZP?=
 =?utf-8?B?UDlreVFKbmo1RGRlanlIOEZrVU5nb1FvYUU3dm51V2xnRE95S091NEZadHY2?=
 =?utf-8?B?ZnBERUtlcC9PNE1VRTEzZzFKYXEzdFo0dDV3MDNQZ3I0SkpPSU5QTHpITTBY?=
 =?utf-8?B?d0x4N2N3dFEyTkIvNXRDMXRJOXE5WEVqY3VLTlZ0dW96TmFBeDZmdEl2bGl5?=
 =?utf-8?B?RDE5MG9kV05MYnRBM0VhclYwaEhyV21FOXc5OFZvTk9iQmNRbHhWUFB4U09w?=
 =?utf-8?B?ekNJY0MyVUlaTnVNN1pYRnMxcWVLS2g0QUtQY1NVMUxhRWtGNnNna25JWEdQ?=
 =?utf-8?B?b29yeXk4RWc5MEVwa29oYkpzQ2NKYmJqcktlUmFDVDI1Q1QrZWt4YXhlNW9q?=
 =?utf-8?B?RVlBeGw5cUhjMUs5VFFWcFd1a2RWT2lhOHdrVEtOUnRXSHBDalRMRk9TQk1B?=
 =?utf-8?B?dndXOTIwallrbGx0UWZHbjRaRXZveGtKZ0thODFPeGhVbnpUNXEvMDBwekdr?=
 =?utf-8?B?NmtmYjFoamJFc0dkUVgrTWpHZ3ZQckpPUCtVRXM5NGVaTTZyd2ZzMDBkYmNK?=
 =?utf-8?B?bTlYb1ZRV2pXNDcwU2hIOGpQbDVFTmdyOHlkMDgwNGMwbFQvbDU2R1hLTmNB?=
 =?utf-8?B?VkVpRm0wSStLZVM1d01uK25sV1VzbkhyTm95blp4MjhLZitHRmxXdWdZbjl2?=
 =?utf-8?B?aFZ3ZWFzSUl3c3R3U0k2NzF6cmhMempsVkkxNm5Wb2kwb1pydnlTbDdTUlcz?=
 =?utf-8?B?Q1d1dEhDSkVKai9QYmNYUTFkOWU2eXk0di9xS0RjVWJtY1N2UEVqRlBCRUtr?=
 =?utf-8?B?WVRxOG9ycUViWm9Fd1l0OHo5aEp2Z0lFSGllSTVYZ0hscFgxZGV5QnlkeUhL?=
 =?utf-8?B?YlVTUmdWeSs5OFMvTU9ONGFRTWlQcWVOK0s1OGJwcVc2anZVQTZsclJQZWNm?=
 =?utf-8?B?NFk3UXVUNkZUUHJsaGdHV01nN1RZT1Q1MEVjQ2ZmNlh5TEdrY0NucXJITHhV?=
 =?utf-8?B?RUlKelk5Ymo4WVZvUXJXOXRQeFgrWGc4WVE0dklIc3kyc205aXBDTEtyMTRX?=
 =?utf-8?Q?hfg4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1778d83f-45ca-481c-a6d2-08dd2b118014
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 09:40:31.9667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEGUCtoefZRlrbRcMkhil6zvIvETzdecwpQlyRyAXK6aUKJWwiiMYS2s10zyh1fUvq7rsyHNCsFQ3ddTmh1ceQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973
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
Cg0KVGhlcmUgaXMgY3VycmVudGx5IGEgYnVnIGluIENJIChyZXF1aXJpbmcgSW50ZWwgR3JhcGhp
YyBDYXJkIHdoaWNoIGlzIHRvdGFsbHkgbm9uc2Vuc2UgKSBibG9ja2luZyB0aGlzIG1lcmdlIHJl
cXVlc3QuDQoNClRoYW5rcw0KTGluZ3NoYW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NClNlbnQ6IFRodXJzZGF5
LCBKYW51YXJ5IDIsIDIwMjUgNDowNCBQTQ0KVG86IFpodSwgTGluZ3NoYW4gPExpbmdzaGFuLlpo
dUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5p
Z0BhbWQuY29tPjsgS2FzaXZpc3dhbmF0aGFuLCBIYXJpc2ggPEhhcmlzaC5LYXNpdmlzd2FuYXRo
YW5AYW1kLmNvbT4NClN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IHRlc3QgcmVsZWFz
ZSBwcm9jZXNzIGV2aWN0aW9uIGZlbmNlIGJlZm9yZSBzaWduYWwNCg0KW0FNRCBPZmZpY2lhbCBV
c2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCg0KVGhhbmtzIGZvciB0
aGUgaW5mb3JtYXRpb24uIEkgZHJhZnQgdGhpcyBwYXRjaCB0byByZXNvbHZlIHRoZSBISVAgc3Ry
ZWFtIHRlc3QgdGhhdCBjb21wbGFpbmVkIGFib3V0IHRoZSBLRkQgcHJvY2VzcyBzaWduYWxzIGFu
IGludmFsaWRhdGUgZmVuY2Ugb24gdGhlIGxhdGVzdCBkcm0tbmV4dCBicmFuY2guIEJUVywgaXQg
bG9va3MgbGlrZSB5b3VyIHBhdGNoIHN0aWxsIGhhc24ndCBsYW5kZWQgaW4gdGhlIGRybS1uZXh0
IGJyYW5jaC4NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8TGluZ3NoYW4uWmh1QGFtZC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDIsIDIwMjUgMzoxMyBQTQ0KPiBUbzogTGlhbmcsIFBy
aWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEt1
ZWhsaW5nLCBGZWxpeA0KPiA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0
aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBLYXNpdmlzd2FuYXRoYW4sIEhhcmlz
aA0KPiA8SGFyaXNoLkthc2l2aXN3YW5hdGhhbkBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBkcm0vYW1ka2ZkOiB0ZXN0IHJlbGVhc2UgcHJvY2VzcyBldmljdGlvbiBmZW5jZQ0KPiBi
ZWZvcmUgc2lnbmFsDQo+DQo+IEhlbGxvIFByaWtlDQo+DQo+IFRoaXMgaXNzdWUgaGFzIGFscmVh
ZHkgYmVlbiBmaXhlZCwgcGxlYXNlIHNlZToNCj4gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlz
dHMvYW1kLWdmeC9tc2cxMTcwNzEuaHRtbA0KPg0KPiBUaGFua3MNCj4gTGluZ3NoYW4NCj4gT24g
MS8yLzIwMjUgMjozMCBQTSwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4gSXQgcmVxdWlyZXMgdG8g
dmFsaWRhdGUgdGhlIHJlbGVhc2UgcHJvY2VzcyBldmljdGlvbiBmZW5jZSBiZWZvcmUNCj4gPiBz
aWduYWwgdGhlIGZlbmNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFBy
aWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9wcm9jZXNzLmMgfCAzICsrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiA+IGluZGV4IDA5NzZiNWIwZThlOC4uMDgzZjgzYzk0NTMx
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNz
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+
ID4gQEAgLTExNjAsNyArMTE2MCw4IEBAIHN0YXRpYyB2b2lkIGtmZF9wcm9jZXNzX3dxX3JlbGVh
c2Uoc3RydWN0DQo+ID4gd29ya19zdHJ1Y3QNCj4gKndvcmspDQo+ID4gICAgICAqLw0KPiA+ICAg
ICBzeW5jaHJvbml6ZV9yY3UoKTsNCj4gPiAgICAgZWYgPSByY3VfYWNjZXNzX3BvaW50ZXIocC0+
ZWYpOw0KPiA+IC0gICBkbWFfZmVuY2Vfc2lnbmFsKGVmKTsNCj4gPiArICAgaWYgKGVmKQ0KPiA+
ICsgICAgICAgICAgIGRtYV9mZW5jZV9zaWduYWwoZWYpOw0KPiA+DQo+ID4gICAgIGtmZF9wcm9j
ZXNzX3JlbW92ZV9zeXNmcyhwKTsNCj4gPg0KDQoNCg==
