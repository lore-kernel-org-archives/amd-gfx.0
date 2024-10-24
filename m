Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779C2D1038E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 23:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACA210E06A;
	Thu, 24 Oct 2024 23:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RM20pzE9";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325F110E06A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 23:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/nxvdykSNZuKMYBoYE2TUzhOvpbUti/3b1iJUwxlIzjxeDgkfiyYLa4p8rsX+Kn6hR03/bQjkvlbKTE98oa54EDj5A2t9d4ozXxDRBeGlLk4Ii7ftoGpj2yDIW82r9S992DXney9paOx9eFkZTEKRNqnqo0rEo6hc0zDpBGJ+daCTSfT/dUqAOryahsDJeDkl0fPscF8VJ6lYhcLFVR33mgjOe/k50WVGkm3q3ZSH6ewsuvA2omUIPfia4dFnZlG4ejDDLUeW6RvAI77smBoNCcoF4Pftqu6H7dqY49Iyo9526/5Az4otd5N1uh5Z3lA11/1u/oPYCcv89SY7xEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7lr6D0wMdXPG+OO5ugi+kHQE4bRwaMh0LIjIGY/BKU=;
 b=emi2SAI0GCj6pj2qh0iXlV6NNMaxUkQsb03GUHwkhSsJlM+IDtPelWXRFLlLkHON/Xf68L0F69o21VSzMDgrUZwsH6Qu9ikU/OtJFfPDtai/q3NVxkUS8Gb8CuYdA+69OWDRCW1/DpHl+J0DdcZvHcVaIfTtlfaRx2Boj4K8ePojKtmbdFURtzqh+6WneDswvDbte3XwgLinAmesVlAADMaHwxGpOZBmXCLi99mhd63iyyhzOycZyJn0V+ERlNO36yaeS0p/fu/CKpkVr9Zj72LRM51xJNO4mI+DHUHLHRNs8Ic3WTyeB22yr4HTJDa+/7x1GTW2tD6LAluf02+rTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7lr6D0wMdXPG+OO5ugi+kHQE4bRwaMh0LIjIGY/BKU=;
 b=RM20pzE9WqbT28CYMnGIdaq+hhQyPq2fVOpxKKSTWUzvG6LnaurnOMhiK3AM/GZFdidIJVHhpzvMpID2RDa9vjCYkaX2C33SAfGqjcUeTQHRlst1NL/JbzJZYjqE6Jrr6nU6B13YoUubzxqkyKgEQYBAkgPfxQys4NnfJHUFv4s=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 23:54:42 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 23:54:42 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/smu13: fix profile reporting
Thread-Topic: [PATCH] drm/amdgpu/smu13: fix profile reporting
Thread-Index: AQHbJU6/SsipUQmD4kigSCOxQ1eMYrKWeGGAgAAcv1A=
Date: Thu, 24 Oct 2024 23:54:41 +0000
Message-ID: <DM4PR12MB516534C810A8231A2B6C72B58E4E2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20241023132254.329135-1-alexander.deucher@amd.com>
 <CADnq5_NmwEVFSXWF-ugssj7fO1RqWXt3CbngOsiqPQpgfOZpLQ@mail.gmail.com>
In-Reply-To: <CADnq5_NmwEVFSXWF-ugssj7fO1RqWXt3CbngOsiqPQpgfOZpLQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=385ee6bb-f65d-4778-b12a-42bc1f263e88;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-24T23:53:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|IA1PR12MB7759:EE_
x-ms-office365-filtering-correlation-id: 9137e9cd-c373-42ec-9ebe-08dcf4873a9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?KzlORk9NK0Z3eFRkM2xaMTk0UlVHTFlvNHBKV0J4QmN5cU1tQzhEN21XcTdF?=
 =?utf-8?B?VWV4MnZwdTFzeHdyZjdJQzZNVW9sOTBRM0JkMk9Yd0Q5SDgvK1Q0TEdJNXNY?=
 =?utf-8?B?R2pjWVpOTWVveExLcWFDdWpONUlhWHZGMGxCWkY3MWd4WHNxUWl0RGZwQU1L?=
 =?utf-8?B?UHBTVmVVNUhWOFFBbU1HVUtxNUc1akZMNEsrd0h4RXQxVnlRb3g5dUpmM1lR?=
 =?utf-8?B?cERyc3FRNThKb3lraTYyWTlzRDk2aDVIeGpxWEdBWlYraG52UTU1cFgxR3pH?=
 =?utf-8?B?ckdHc2NUd0g2bVFTTmNzU0JhU2RMSm15MFl2V0M2YzEwanNabml2M2pEQVZz?=
 =?utf-8?B?UWt1eEQ2cm9YaDlTMisvUFpkVUhnQWV3azhmM1NHaDF6T1I0cW9GL2ZLV0ZV?=
 =?utf-8?B?S2wvNWl4QzhmSU5xWlFUQ2E4alhZUktKSk1zSW9TV1pMcmpNV1dHN2tTbTYx?=
 =?utf-8?B?ZnUzNDEycC83TUwyclBQZGM0aVozUGtuSmR4RVExd2wxY0VjNHZUYkE3cTZk?=
 =?utf-8?B?ZlFIUEZXQVdNdkZkdTQxWkdPR3VKQWVhWjlVcWtEbWNDVE5sTnMvZERhTnhJ?=
 =?utf-8?B?WDl2eTZYeVJnK1hLRHptY2VqZHJLbnVWR2dkbm1ob0RrL3JvTlpKWmNBc1hK?=
 =?utf-8?B?UVc1UE1KWE1VNlVmTFliSEJZVEFDcXEyWmNvWDlpcit6OUQrNjJiY3lhRkpl?=
 =?utf-8?B?UDVyeHVoT0lEYjU3K1RtVDFveVJUYktoRjdPVmdPeFNQTHN0cVFRcHNEaUsr?=
 =?utf-8?B?K0JKTDRXaGpKNi9ETVFjMXY5UDl3LzBsaHl3a3JaR2VlT2xzTnZCWUViWmdw?=
 =?utf-8?B?TnNYTUpiRkJpcU81bmxXaDhMYVYxZG1hOHBGMURLcU5rNU9NblYxV25tbHVy?=
 =?utf-8?B?KzhnVTZZY0NrM1dERGI2ZlFKOHFYY0xrb1RYaW5KUVovU21tclNGTUttb0xE?=
 =?utf-8?B?TFpTeXRYRXRiNk1kK08zcXRxanNKamsrejRmZHJLU2hrdG1sekRzWXR5ZU41?=
 =?utf-8?B?VVpCLzExcmpGUTlvWWpaZFdZUy92WGl1VU9rVElyTTlPWWZ4cU1Zd0dudk1U?=
 =?utf-8?B?YlpHQ0swd1llUzc5V3FmdWhjQ2tSK0s2TE9HeTVGRUxmQkMwL24vN05IMHg4?=
 =?utf-8?B?TlRuNnh5Z0s4V0NET3htc3luMDhmazZQS1liTjVHcHdqNzk1UUhmT1JVcFNH?=
 =?utf-8?B?M0VySDl3SXlDeXY4SEpiMjVzU29kSFpNOTVXZnpVL1RUajJnMkRYVHhzQ3N5?=
 =?utf-8?B?K0ZPQ2dKOStRNE15UkEvZ2JxRUhnQXp6OHVobXhIUExvd0R5Wm0xQWJ4ZjZ0?=
 =?utf-8?B?VEg3SzJkRlp4aFR5VWhNVTFJYnVpUTBmM05lYWtNYUoyaGM4eUFQTFNveHhp?=
 =?utf-8?B?MnMwaFFIa3MyM2UzYW5WdnNJMXFGNVJYaWF5ZTcxRElsNVlWM3ZRNTYrY3Fm?=
 =?utf-8?B?eHdSRGZNbXJoaFVuREZoWHcybW1KVTVxQmdJQ3VRZzhOYS9qM2UzS2lkNmNN?=
 =?utf-8?B?WmhyMWxTanlxeU81NkRQS3UrTFk4ZFZWR28vY0sxaUx6ZzVsazhvZW9pcHBN?=
 =?utf-8?B?bTFETTlBa3Npb0dkMjd4QllxQ21BbVBXeWwxKzdzSThMK1V2WDZGc252MVRu?=
 =?utf-8?B?QWNrd1JlTEhwc0hqeEhmYTNncWxoaDZNTzVkSGFydkxocW5MSFhJSDhRZVNH?=
 =?utf-8?B?S1k4VVNYWlNxam1BVXE2MUl0YzJYQ3RQZ3dTbzZjbVMyOWtyaVliNEg3NnBU?=
 =?utf-8?B?NFFha2VjVG4ydVFGVUNvdmp6VGt5a0wyU21WVUpFN2xTWnRQWXViNmtCSkUy?=
 =?utf-8?Q?jffNShnMlZK7M2330jKRLMMX0HU0MtWwSWpmU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTRXRS8vbnZjR0tMTkZBc3h5UzloQzg4TmVqZHBVU1dKd2hCbld6TFk1TXhN?=
 =?utf-8?B?V1hKVGhBL3Y5aDY5V3cxTEFhRmtRbzJGYXJER2tVOVczTGREUjhLdzE5eGV6?=
 =?utf-8?B?L1VBQmJtd0tHcWFwK2hJR0V1QWR6Nmw5Z2pWNHp3dmFnQVE3MWhDRytLUGxN?=
 =?utf-8?B?citLMWZwOXJIMUVySCtXYWQyam9vbjE0OEVPN0ZYQktCL2FFOEkyZUZsTjM5?=
 =?utf-8?B?bWZGM0FVNUYvdzN3L0lZakRDbWRxOXphY29mNDlHUXFnbk5zTDNoQThGZEhy?=
 =?utf-8?B?bHJVYUx1OFhtWTZpd1R0SlNpc0ZZUHkyRVF4Mjk3LzlOSFZ4Yyt0MktZWkNF?=
 =?utf-8?B?ZmpjUE1OR0VIS2E3TFRidWRMc3ZIZG9uTnM1dVR5NFlHeXIwbnBMMTZzOTJj?=
 =?utf-8?B?SEJFV05FV1FrMWxSZ0duQjIySWtKZTN1UjZCZHlVd09sM2lldkkwYlVYaVd5?=
 =?utf-8?B?dlpJNFJ0VGdScGFmUzJVMVc4MytXbVZCRE9jTUZKVHdyUW9HMHkzdnRHaUto?=
 =?utf-8?B?NXVWZGJKNGVIUEVONUNHanlFK0ZaajdFai9YejQ5dGkxS2tGeVp5ZjY3U1pC?=
 =?utf-8?B?MWgwbEJ5a2FCQnh3OEZCOHBEd3JWTEFPNjh1RzViRTI2aklZWS9XV3dKSUpG?=
 =?utf-8?B?UklDNDhQWktLK1ZvTnBhQUE0MmtEWDNJQkVDKzZ2b2hiVDMwRjU0bGZVUFdO?=
 =?utf-8?B?b1JPKzI5ekVUM243bVFRcm9UcWtaV1FIcnNkQ25yWnVaV2xHc0RvVVlGaUtm?=
 =?utf-8?B?KzVxR3lzYndhRklicEh1UE55RWVwalRySkpPbHVCSVBDcUd4d2dwdWw5SGx2?=
 =?utf-8?B?Z0dobXZxc05YS3pPQ3RxZzVvS0IyTmd4N2RWbWpHSFcyOUN2ZnBUU0NVSXlT?=
 =?utf-8?B?b2F0b0NwWGlLQW5zQWd6RXBXL0pueEdsME5jYy9INE9lM01EU01rYkZOQ05S?=
 =?utf-8?B?ekxXM255TUU2UFJwa2FjVUhlNW80LzZOM1RWT24vV3gvanZuQnVicFpUaXVu?=
 =?utf-8?B?TTViYXNCNEgzZzIxcm5IL3dmTlVKWU9aaXdkb2h0T21sbVdFclZpUmlFcE43?=
 =?utf-8?B?WU9LUDdaRmRxaHAzT2pRakVRaExodjZhTU9SeDVuN0txNHlQaHA1eTFJMzNP?=
 =?utf-8?B?OUxITzJzRjhPYlVzc2RjYml3b09HYTlWa3FvZ2UzYzJwVEwySEVxVzdHTVZn?=
 =?utf-8?B?NE9kOGpDb3UwSjg0eXcwS3BxczB5d0t1M1FWK2lqNHNXSmQ5VEJRS0hJYVJ6?=
 =?utf-8?B?dFdwZ2hQQTVrTk45VzFsWUM4bjJ1aXdMeUx5YWVuWnU2Yk1JL3h6NW5hTEdN?=
 =?utf-8?B?SE1CR2ZvbkNPSVdkMGxNM0JxQlBkT0hqbEFudlNQTnJNNkpoTlhwVkRNd0Nw?=
 =?utf-8?B?NFcwTkdyWkIwTDl1Tk5oT2JRQitQdHpWVjdLUEJiQjRYcHdKbGV3UXhCYUpP?=
 =?utf-8?B?dW9oZFpySVkxV0kyV0ZVaEsrSDZheWh2d29xWHVaSFZLUEZHS2dhc3pvWjRp?=
 =?utf-8?B?cmFaT0FTVnJCQjBIOUdjeUJyQi9WS2tWTFVhVjU1ZGV2Yy8wUEN6NjdiZklk?=
 =?utf-8?B?Q3NtdW9JdS9MRjZqQ2pZNlR6VkExWkc2QXZLVGpRSTZHNXNxbDR2STNqTGZ6?=
 =?utf-8?B?SEZzQWtDMFhlaThzQjJyRDJNTmlBbUlVTGNjb0FNTVdMdnBXcW1RalB5N2RW?=
 =?utf-8?B?S2p5eDVlenJldndJN21pOTFyWE1zQm1vSlJ3TkVVYjRmbDN5ZlAycklMK1JN?=
 =?utf-8?B?Z3NHbFU0Y3A0QVNPZEVPQkJ4dXVHTWF0M2FSMndyT3pCbW9xRzRzdHdxemNk?=
 =?utf-8?B?Wk5IQXJtVGc2SmY5NHIvYVF3Zm5KUkJiQ2ZmZFd4eUFoKzJVdTNMZWZMRlVN?=
 =?utf-8?B?eVBQVW4yQ2gveFQvUVlIRDRUdE1TOWJtLzUrbVFrcUZTUW4xd0RtVmhEZUdV?=
 =?utf-8?B?V2hSYUgyQnY3UXZsdGE3RWN2SWR5ejEyVDBUbjVLNUdlMFpBREJKSitRblpl?=
 =?utf-8?B?ZVdWZE9CdVZpUlRnamFKWnBCZFhIRHdnN0ZjZlp1aGsrb1cySjhBU1pMUkFG?=
 =?utf-8?B?UDduYlBuWVg5Mk1CUGthekhaUi96bloxRHVNbTNEN2czUDEyVjg1MDA2c0hB?=
 =?utf-8?Q?lu4E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9137e9cd-c373-42ec-9ebe-08dcf4873a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 23:54:42.0198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZV90nget5V8t6yPyiEgWKA8Srid8r8YchZUokEa+JFA2k95dly180QQIL/uh8t/u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
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
Cg0KUmV2aWV3ZWQtYnk6IEtlbm5ldGggRmVuZyBrZW5uZXRoLmZlbmdAYW1kLmNvbQ0KDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBEZXVjaGVyDQpTZW50OiBG
cmlkYXksIE9jdG9iZXIgMjUsIDIwMjQgNjoxMCBBTQ0KVG86IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS9zbXUxMzogZml4IHByb2ZpbGUg
cmVwb3J0aW5nDQoNCkNhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0
ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRz
LCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCg0KDQpQaW5nPw0KDQpPbiBXZWQsIE9j
dCAyMywgMjAyNCBhdCA5OjIz4oCvQU0gQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPiB3cm90ZToNCj4NCj4gVGhlIGZvbGxvd2luZyAzIGNvbW1pdHMgbGFuZGVkIGluIHBh
cmFsbGVsOg0KPiBjb21taXQgZDdkMjY4OGJmNGVhICgiZHJtL2FtZC9wbTogdXBkYXRlIHdvcmts
b2FkIG1hc2sgYWZ0ZXIgdGhlDQo+IHNldHRpbmciKSBjb21taXQgN2ExNjEzZTQ3ZTY1ICgiZHJt
L2FtZGdwdS9zbXUxMzogYWx3YXlzIGFwcGx5IHRoZQ0KPiBwb3dlcnNhdmUgb3B0aW1pemF0aW9u
IikgY29tbWl0IDdjMjEwY2E1YTJkNyAoImRybS9hbWRncHU6IGhhbmRsZQ0KPiBkZWZhdWx0IHBy
b2ZpbGUgb24gb24gZGV2aWNlcyB3aXRob3V0IGZ1bGxzY3JlZW4gM0QiKSBXaGlsZSBldmVyeXRo
aW5nDQo+IGlzIHNldCBjb3JyZWN0bHksIHRoaXMgY2F1c2VkIHRoZSBwcm9maWxlIHRvIGJlIHJl
cG9ydGVkIGluY29ycmVjdGx5DQo+IGJlY2F1c2UgYm90aCB0aGUgcG93ZXJzYXZlIGFuZCBmdWxs
c2NyZWVuM2QgYml0cyB3ZXJlIHNldCBpbiB0aGUgbWFzaw0KPiBhbmQgd2hlbiB0aGUgZHJpdmVy
IHByaW50cyB0aGUgcHJvZmlsZSwgaXQgbG9va3MgZm9yIHRoZSBmaXJzdCBiaXQgc2V0Lg0KPg0K
PiBGaXhlczogZDdkMjY4OGJmNGVhICgiZHJtL2FtZC9wbTogdXBkYXRlIHdvcmtsb2FkIG1hc2sg
YWZ0ZXIgdGhlDQo+IHNldHRpbmciKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzBfcHB0LmMNCj4g
aW5kZXggY2I5MjNlMzNmZDZmLi5kNTNlMTYyZGNkOGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzBfcHB0LmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYw0KPiBAQCAt
MjQ4NSw3ICsyNDg1LDcgQEAgc3RhdGljIGludCBzbXVfdjEzXzBfMF9zZXRfcG93ZXJfcHJvZmls
ZV9tb2RlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KPiAgICAgICAgIERwbUFjdGl2aXR5TW9u
aXRvckNvZWZmSW50X3QgKmFjdGl2aXR5X21vbml0b3IgPQ0KPiAgICAgICAgICAgICAgICAgJihh
Y3Rpdml0eV9tb25pdG9yX2V4dGVybmFsLkRwbUFjdGl2aXR5TW9uaXRvckNvZWZmSW50KTsNCj4g
ICAgICAgICBpbnQgd29ya2xvYWRfdHlwZSwgcmV0ID0gMDsNCj4gLSAgICAgICB1MzIgd29ya2xv
YWRfbWFzazsNCj4gKyAgICAgICB1MzIgd29ya2xvYWRfbWFzaywgc2VsZWN0ZWRfd29ya2xvYWRf
bWFzazsNCj4NCj4gICAgICAgICBzbXUtPnBvd2VyX3Byb2ZpbGVfbW9kZSA9IGlucHV0W3NpemVd
Ow0KPg0KPiBAQCAtMjU1Miw3ICsyNTUyLDcgQEAgc3RhdGljIGludCBzbXVfdjEzXzBfMF9zZXRf
cG93ZXJfcHJvZmlsZV9tb2RlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KPiAgICAgICAgIGlm
ICh3b3JrbG9hZF90eXBlIDwgMCkNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
Pg0KPiAtICAgICAgIHdvcmtsb2FkX21hc2sgPSAxIDw8IHdvcmtsb2FkX3R5cGU7DQo+ICsgICAg
ICAgc2VsZWN0ZWRfd29ya2xvYWRfbWFzayA9IHdvcmtsb2FkX21hc2sgPSAxIDw8IHdvcmtsb2Fk
X3R5cGU7DQo+DQo+ICAgICAgICAgLyogQWRkIG9wdGltaXphdGlvbnMgZm9yIFNNVTEzLjAuMC8x
MC4gIFJldXNlIHRoZSBwb3dlciBzYXZpbmcgcHJvZmlsZSAqLw0KPiAgICAgICAgIGlmICgoYW1k
Z3B1X2lwX3ZlcnNpb24oc211LT5hZGV2LCBNUDFfSFdJUCwgMCkgPT0NCj4gSVBfVkVSU0lPTigx
MywgMCwgMCkgJiYgQEAgLTI1NzIsNyArMjU3Miw3IEBAIHN0YXRpYyBpbnQgc211X3YxM18wXzBf
c2V0X3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3b3JrbG9hZF9tYXNrLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpOw0K
PiAgICAgICAgIGlmICghcmV0KQ0KPiAtICAgICAgICAgICAgICAgc211LT53b3JrbG9hZF9tYXNr
ID0gd29ya2xvYWRfbWFzazsNCj4gKyAgICAgICAgICAgICAgIHNtdS0+d29ya2xvYWRfbWFzayA9
IHNlbGVjdGVkX3dvcmtsb2FkX21hc2s7DQo+DQo+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gIH0N
Cj4gLS0NCj4gMi40Ni4yDQo+DQo=
