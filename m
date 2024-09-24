Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E573CF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 14:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DBF10E8C6;
	Tue, 24 Sep 2024 14:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nilEi1Xm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7006D10E8C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 14:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wi6vkgtBwPF8f8zPwQcEUYW4F7bK35yy9eqUcBSyAvTOBQi0p75W3mq+vlDaOenrdBs+abV21XREA31jX+js2KQxIlgfb5Y1gqYugcfFuV922N+1l0drrNoY2MtLgPETiez3T0Wuq6yBr3Du+ru94/AfvgDIKZCejlhceef6MC/Gn5K8QzV4vWFXH8rmmUZ0Cq/wej2ItwgL1U8urUhhAF6Q1fBgKSOGTqNYv1OC6dSQwcHzXAmAuptyzBqWU7OnVxFf5vQjR1UDBHYiWmQ49zphN/OXFJZIxOUEMRRyyNAEHS10tgzqNP48IXRYw3U6M8CuVRQBHGj8fg5oxQPISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIU1LXEHRqM2LIWAdkoQJhRe/NQkfl4IdLjCB7NLA1g=;
 b=YHxxey0C7tLshqki0ZYfp4V2i8T7XnJakdzeb83oniwPwx4HRsvb2V07/opwhiKXgNS7sTRQbW+206Ca4ECUKDL0U8MSutGsgdEkIQJMhxVXOWvo3IBiI9E0ZVAV3ESgc4le3aC4U2EcS8JNVAQ/CE8uNXGQGm/fPV47fYfCXFs4mhRchpT8TqJ3XNGCk0MfEBRbsgd2tK0AQMVFxEyEmeQcoTnQTuiTvqivqIEcEQE10gGaaTYBtiDux+/F6LI6e9P/Bs/Ri1Hqu2YSqPYqbsiqv2wDTHblXHxKSFHZpUgibEYNXaaob3XW4+rKDSW4w6KxnZYB9fB6k+KLUTsYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIU1LXEHRqM2LIWAdkoQJhRe/NQkfl4IdLjCB7NLA1g=;
 b=nilEi1XmrhA9uKg97Tdk6SKbdo7yNeGn5KqHAGKmXHsSY6JWNRMKLTcdHv1aJ7Y2hPSXPFU9NesmbYcpbyM5iEuyvKq0CopBRjfXltGDkNb4UXX9Wnr0IdjZeiMSoqSgYBczbVLdvQOSVmDkU1Zij5FKtpO9v61V1Db90B3Qvko=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 24 Sep
 2024 14:22:46 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 14:22:46 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdgpu: simplify vram alloc logic since 2GB
 limitation removed
Thread-Topic: [PATCH] drm/amdgpu: simplify vram alloc logic since 2GB
 limitation removed
Thread-Index: AQHbDZFirJ5o1iio80Sn3Qa6nnB8IbJm+tCAgAACY/A=
Date: Tue, 24 Sep 2024 14:22:46 +0000
Message-ID: <CY5PR12MB63693340F3FFE996395FFA97C1682@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240923081931.2126969-1-yifan1.zhang@amd.com>
 <CADnq5_Nm_OdBNbDR+J_w4v2yK4_yH5GxVdRwinJsgZBys69Lgg@mail.gmail.com>
In-Reply-To: <CADnq5_Nm_OdBNbDR+J_w4v2yK4_yH5GxVdRwinJsgZBys69Lgg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4c5a5c8b-a2fa-425a-b80c-3c20660808c9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-24T14:15:12Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DM4PR12MB5940:EE_
x-ms-office365-filtering-correlation-id: 3cfc2301-398e-4202-003c-08dcdca45ca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bkQydmRtR21TeE0yLzN6bTlDV3VmOTdBTlFNd3JKRnJxRFRYY2ZnWkJIVC9s?=
 =?utf-8?B?SjBKRmt5QVYvK1U1MkxQOHpxSkRjMWRYVXN5MXo0ZkRVZ2FqeHJtc3pvWSts?=
 =?utf-8?B?UDFJMXUvWDNrT1lJamEvelNaWGQ4bG5kMG9oMlpQYXBjMDBhYi82aFhVTnI1?=
 =?utf-8?B?YjJxYVFlZEQzdzdVangxWkpNZXFQSUFTS29nZzRNVEdRa2NsUnNsOVpmYjU0?=
 =?utf-8?B?WWpEQzlwZWh2S3B0RU5pOVZRbDNKM1hqZlBsK05lbkE4a1cyWHlqR3l5bTRZ?=
 =?utf-8?B?elNnOHhiejlmTTMrb3dXN2Q3U1RlNk5qajd6SFltNUdWTTdaTU9CRlpRVjg4?=
 =?utf-8?B?VXFJTThIQ0h6U3Vmbmxtdi9jcng4VFhBK21aVUQwUThqUlFXODRyMk1qVGFL?=
 =?utf-8?B?UXpwWmZNUHlEUEh6SlZTRjNCV29PRTJQNFRIWVJnS2hPeDFwZ2JKOWZ5R1RV?=
 =?utf-8?B?UzBnTWxuNG1UVk5RSnhXd0g2UjA2QXQvOFZFSEQ4VngwYXJtUjNIWjlEZmNr?=
 =?utf-8?B?VURtSjdYb0Nsc0tUQnVSSld0L2toV045dFB3eWpUckhMNTJXbjRaTVlHcHdX?=
 =?utf-8?B?QUJ4RXBkbVJRTEV5SWgvRmNsdi9uSVFoWDRnSG0vZUVmc3A4b0ltMkppSDgz?=
 =?utf-8?B?ZStKLy9tb002cWFJLytLYUhpVWx4NStKVVpPOXF3ZnZ5czRQTUxyZVZoVXhm?=
 =?utf-8?B?Zk5lTi9sQ3d0aW5IV0xxQ012V2xoQlJTZlZJRGFicjhQQkJnZTZRYjd0aFJB?=
 =?utf-8?B?TlBvdjhjZEZMK0JUMEtjN1VLdzFCVktNODJNYnFYbHF2SlBBRnEwdFJ0eW82?=
 =?utf-8?B?NGVIMkt6b0lTVy9TRlJaT213STQ1K2V4NGpVaEY5VEtqVlcwNkZQQlpwL3R0?=
 =?utf-8?B?NEtNcFI0RDRIWW0wVmZGZ3EyWERNTFhYTDJHemRxcmhwbmNEakNsdXBYVTZj?=
 =?utf-8?B?YnM3dkpDeWlQa1FUZG80ZFJaVnlqTVh3RndJMnFxU3prdzNnY3ZBbVo2VzZG?=
 =?utf-8?B?bGhUVHk3K1YxaysxemlPUEFIR3FtN0E5L1FFNFh1THA4eENuYXJnVk1HZU42?=
 =?utf-8?B?Y2dHWnNRaEJYUVdNMTJkU2dxWjN1R1MyMjg5VkRNR1QvL01za2RFU0VzbXpi?=
 =?utf-8?B?ODQ3WlBpSlY5ajg3ek1xOFY0NnRjTDg1MGFxaTBqTnRpNzhKRnR2RkFFa1Ez?=
 =?utf-8?B?T3AvQW9wUGN5ODhiVTJKZXM4bmk1YVo0clduTE01TWVQSnI0Z1FzcGhrRjlY?=
 =?utf-8?B?cDh2Q1BzbmFZVmFwbVYwWVc5d0V6NEQrNDlBay9sM1pMOU1NTGlvaVNiZVo1?=
 =?utf-8?B?UEJxL1RqSmZBR2o0ZWFxc0hwelJQcW81bTV5VGYxLzNsbk1NRTJ4eU9YSW5S?=
 =?utf-8?B?WmxYaFZSenBJSkE0MUQ3bkN5d1dGTVlNYnUvd0tRcnZTalNJckVGT1lGS0dp?=
 =?utf-8?B?eUpteXFVdWl2OUhucjFuWCsxK21BNlJoV09FN3k3TTZ4ZXd0RDRGajhRRHUv?=
 =?utf-8?B?SUFYWmJFT1J5Q3RqdHlyYVFubEFCWGJ5UDVRR29TcThFb2NLdHFuazJuUWYr?=
 =?utf-8?B?Qnp5dzBnUU5sWEFXTjErVVVEM1hjVDd5Q01NcXdzUzV3TEhwWnNQNmp4b1My?=
 =?utf-8?B?NWNKSlNwdmU2cUZhOThRL3pOT2VyamRXcmZVb1laWTVoaWFvdElPUUhQc1Ns?=
 =?utf-8?B?MGFzOGllZGlBTkM3YUE1QXZ6V0dzQ2tyWHd4Y3lpYlZZd1ZsQk9QR0JHNzF0?=
 =?utf-8?B?SDlWU1RDU1gvTkF4eEtja3hMMkpBZTNFZXNweUFNb1Y4dnBINEc3VCtTbnNm?=
 =?utf-8?B?Z1JGZnpLSHFRcjVJYzA3RlpkNUowclg5OTFOOXFKU09aNmtZZFhrS015a1Jo?=
 =?utf-8?B?UUU4VmRaTHlhaE9WZ1pHWXRRVDFUdTRQdUFlQVNGYzhZVWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cy9Eck5LUGtxNmNMdDJoaHFUSkM5OFNNWnhmNzJ0S3RMRXJUQjh5TFVWNDZv?=
 =?utf-8?B?bytmKzR6RzFFRnFMcVUyL0swbVFmWkhKdkZVZW5WcjMrRWFMeDNvWUd2aG0r?=
 =?utf-8?B?Y01FRHQ1SjNOdnFtZS9xV0ZmZ2l5N3lGcSs4eDdRajNkWFo0WW01V2NSdWZ2?=
 =?utf-8?B?d1hWQ1JFT3g1SzdMQUU0bGUyRTFkUnIvMkZhWElEYjlBN0R3YXB6RG9aSFFO?=
 =?utf-8?B?d1BiSDdjUmxtajFQNUlZV3RoT1NZVGFkdDltaWNoeS9iQS9Ma3Z1YjlJZ0RE?=
 =?utf-8?B?OG9KbGIwQkJ5ZGxzdStxWVdmd2c4UStvTFJJOENrNk05YWI4UnpuamI3RE9I?=
 =?utf-8?B?bm1iTFpDa0hOS3RWakJSaHFxMk1mRndXRVBLSmRQZVZHdVQ1clhhVXhCQUdy?=
 =?utf-8?B?NUxhcmxMQlZXc21WL0xZaFFZYzFrU1lHSG9EajZlU2FydTB6cnlGUUF1VXpY?=
 =?utf-8?B?SzdWdkllMVM0MVR5bHBvQ2ZJZUhGaWZGQ1VYYy9Mall0VWgvS1lQZjJ2ZHM2?=
 =?utf-8?B?YUptUlZrT0MwSG0vN0hUM1VmUHJoV0U1ODBQaGlsODRrY0dMdmlQSkhxcDgr?=
 =?utf-8?B?czNzR21qYVZKWm5uRysrdUFVemlqem9YdkRLcXFYWWNjWjk4czF2bG9tVitJ?=
 =?utf-8?B?ZHB1bFI1cjY3UWlldTFzQVFRZnZPTjZKV2dqNGF1emRXekNLSHdVaU91Q0tN?=
 =?utf-8?B?eGh6Z20zOVEzRVlyaklGVC9TQ3VOWm90QmNWUk1ZT1kxenAvTUUrbXU4Y2Jy?=
 =?utf-8?B?VUw1bFBBWDNjc01WSHJkcjRMWnJMYWYvcU1FZXlaWHJlYzdNU1hMN3pWVDR4?=
 =?utf-8?B?TnJ0VU1LUUhTMTNIODU5QUVBZDRzMmZWR3hIUjBQT2lEeCtJdGV0V1JFZFBr?=
 =?utf-8?B?a0xubnZpNGo1Y09xU0t4ZVN4UWN3WGtkSDFMbnNKZ0R2T2I0Nk9Xa1o0RE9s?=
 =?utf-8?B?MSsrRG4zRWo4NDFwZGgvMHZpZ3ZHL1VsK05VUFkyZFZ0UEpMa2haQzhMZFlN?=
 =?utf-8?B?RmcwTExhQjhMMUxRaWhZMTk2V1JseEJpOVlVL0NaN3REQzMyWEJWUFJsODJm?=
 =?utf-8?B?dnVrOXQyT1VBNnRWZTRhUWRjbVlOOWp6c2gvajRSMWMzZEd6MHF2SXN5QXp5?=
 =?utf-8?B?d0pBN3Z4QnJMclZSLy9PVVFjQTFGdDlMWkRmd0RoMExLSTJ2U3Q2ZThOMEV0?=
 =?utf-8?B?SnBLWXU0bmVEUzRIK0Joa3pPOTcrOHVmempMZ2FEYzhPb0dsdkltNFBmT2pG?=
 =?utf-8?B?enA5RUExMGo2YWJzZkU2bGRZYXZxN1MvQm9zYjQ0eGY1VzBBZXg4MUkzYWoy?=
 =?utf-8?B?eW9tMTRnSUlZZm9vY0FVcU9mMGNmczIrd3NuY3pKTklZeDd2WktJWnlNeVQ5?=
 =?utf-8?B?cUdhYnFXT01Ld2JsTTNORzUwUjZUYXlkeE9LaE85SmdJaU1XdU5LREU2YmFz?=
 =?utf-8?B?ckVQQ1JtTkVhdkRVVWV0VmtTV1pMY2M3U3pUSDc0NlBQbkNWSHg0bElJdVdH?=
 =?utf-8?B?U0NURXgvSTJNTEpTdldxYUsvejQ0K0lpOHdvbk9neHVaZTZIYUx3dzJMVnF1?=
 =?utf-8?B?WE9aNG9QUnN6dkRrbnQ2NW5jVHRzcXg2bVliZ09CY3d4YzRSMU9RaWtlb2JU?=
 =?utf-8?B?SkdmS3JrQjVXY3lYOHc3amlQS3ptK0RrNnJJTWgxbTZaa2pYN20zclJIa2lo?=
 =?utf-8?B?T3JCM1BYL1B2MUNNZmhwT3FFNGFHZlFnQUt2RERKbTlyUmlHTTgzdDVFeUNT?=
 =?utf-8?B?TzZOZHJHcVRnZUFkQ2NFa0t6UWw3QnRpR1BvU2ZnS2p4M2J3Y0loaTltMjZU?=
 =?utf-8?B?SThEczB3NkFJRXkyS3FWZmRSOXFaRmVweVd2a01yVEluanpnSU9IalgvUWVk?=
 =?utf-8?B?RTNNb0MrbGIvaWY2MFh5enlSb1RlMHNxU3J1b3pyUi9uUkZsaDFPQkdtQlFz?=
 =?utf-8?B?aDNsbFk3NUVkbXZoL1hnQlR2eEhRa1ppOFl5UDhQZzgraHhSTVpRakhSQTZN?=
 =?utf-8?B?YmYzcCt3bjlsR2pmclZSTEdod0JjeEZCRzRjVFFrdmVuL2Z6V2dUNTBkdUM3?=
 =?utf-8?B?K1J5WnRpM1czbEpLOGxBSWRXa1JZZkticGNUSDNIb2ZFU0FyRGEvenNPdHVE?=
 =?utf-8?Q?u8wI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfc2301-398e-4202-003c-08dcdca45ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 14:22:46.6060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0px1uWLEGTQoMFOKmsjzQWS8wmOXfyIybdVpdQDnbehbw5rb5IHNo17QMRFIoBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
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
Cg0KMkdCIGxpbWl0YXRpb24gaW4gVlJBTSBhbGxvY2F0aW9uIGlzIHJlbW92ZWQgaW4gYmVsb3cg
cGF0Y2guIE15IHBhdGNoIGlzIGEgZm9sbG93IHVwIHJlZmluZSBmb3IgdGhpcy4gVGhlIHJlbWFp
bmdfc2l6ZSBjYWxjdWxhdGlvbiB3YXMgdG8gYWRkcmVzcyB0aGUgMkdCIGxpbWl0YXRpb24gaW4g
Y29udGlndW91cyBWUkFNIGFsbG9jYXRpb24sIGFuZCBubyBsb25nZXIgbmVlZGVkIGFmdGVyIHRo
ZSBsaW1pdGF0aW9uIGlzIHJlbW92ZWQuDQoNCmNvbW1pdCBiMmRiYTA2NGM5YmRkMThjN2RkMzkw
NjZkMjU0NTNhZjI4NDUxZGJmDQpBdXRob3I6IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQu
Y29tPg0KRGF0ZTogICBGcmkgQXByIDE5IDE2OjI3OjAwIDIwMjQgLTA0MDANCg0KICAgIGRybS9h
bWRncHU6IEhhbmRsZSBzZyBzaXplIGxpbWl0IGZvciBjb250aWd1b3VzIGFsbG9jYXRpb24NCg0K
ICAgIERlZmluZSBtYWNybyBBTURHUFVfTUFYX1NHX1NFR01FTlRfU0laRSAyR0IsIGJlY2F1c2Ug
c3RydWN0IHNjYXR0ZXJsaXN0DQogICAgbGVuZ3RoIGlzIHVuc2lnbmVkIGludCwgYW5kIHNvbWUg
dXNlcnMgb2YgaXQgY2FzdCB0byBhIHNpZ25lZCBpbnQsIHNvDQogICAgZXZlcnkgc2VnbWVudCBv
ZiBzZyB0YWJsZSBpcyBsaW1pdGVkIHRvIHNpemUgMkdCIG1heGltdW0uDQoNCiAgICBGb3IgY29u
dGlndW91cyBWUkFNIGFsbG9jYXRpb24sIGRvbid0IGxpbWl0IHRoZSBtYXggYnVkZHkgYmxvY2sg
c2l6ZSBpbg0KICAgIG9yZGVyIHRvIGdldCBjb250aWd1b3VzIFZSQU0gbWVtb3J5LiBUbyB3b3Jr
YXJvdW5kIHRoZSBzZyB0YWJsZSBzZWdtZW50DQogICAgc2l6ZSBsaW1pdCwgYWxsb2NhdGUgbXVs
dGlwbGUgc2VnbWVudHMgaWYgY29udGlndW91cyBzaXplIGlzIGJpZ2dlciB0aGFuDQogICAgQU1E
R1BVX01BWF9TR19TRUdNRU5UX1NJWkUuDQoNCiAgICBTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgWWFu
ZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4NCiAgICBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KICAgIFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNl
bnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyNCwgMjAyNCAxMDowNyBQTQ0KVG86IFpoYW5nLCBZaWZh
biA8WWlmYW4xLlpoYW5nQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT47IEt1ZWhsaW5nLCBGZWxpeCA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6
IHNpbXBsaWZ5IHZyYW0gYWxsb2MgbG9naWMgc2luY2UgMkdCIGxpbWl0YXRpb24gcmVtb3ZlZA0K
DQpPbiBNb24sIFNlcCAyMywgMjAyNCBhdCA0OjI44oCvQU0gWWlmYW4gWmhhbmcgPHlpZmFuMS56
aGFuZ0BhbWQuY29tPiB3cm90ZToNCj4NCj4gTWFrZSB2cmFtIGFsbG9jIGxvb3Agc2ltcGxlciBh
ZnRlciAyR0IgbGltaXRhdGlvbiByZW1vdmVkLg0KDQpDYW4geW91IHByb3ZpZGUgbW9yZSBjb250
ZXh0PyAgV2hhdCAyR0IgbGltaXRhdGlvbiBhcmUgeW91IHJlZmVycmluZyB0bz8NCg0KQWxleA0K
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlpZmFuIFpoYW5nIDx5aWZhbjEuemhhbmdAYW1kLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYyB8
IDE1ICsrKysrLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
MTAgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdnJhbV9tZ3IuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92cmFtX21nci5jDQo+IGluZGV4IDdkMjZhOTYyZjgxMS4uM2QxMjlmZDYxZmE3IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYw0KPiBA
QCAtNDU1LDcgKzQ1NSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3Qg
dHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwNCj4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICpi
byA9IHR0bV90b19hbWRncHVfYm8odGJvKTsNCj4gICAgICAgICB1NjQgdmlzX3VzYWdlID0gMCwg
bWF4X2J5dGVzLCBtaW5fYmxvY2tfc2l6ZTsNCj4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3ZyYW1f
bWdyX3Jlc291cmNlICp2cmVzOw0KPiAtICAgICAgIHU2NCBzaXplLCByZW1haW5pbmdfc2l6ZSwg
bHBmbiwgZnBmbjsNCj4gKyAgICAgICB1NjQgc2l6ZSwgbHBmbiwgZnBmbjsNCj4gICAgICAgICB1
bnNpZ25lZCBpbnQgYWRqdXN0X2RjY19zaXplID0gMDsNCj4gICAgICAgICBzdHJ1Y3QgZHJtX2J1
ZGR5ICptbSA9ICZtZ3ItPm1tOw0KPiAgICAgICAgIHN0cnVjdCBkcm1fYnVkZHlfYmxvY2sgKmJs
b2NrOyBAQCAtNTE2LDI1ICs1MTYsMjMgQEAgc3RhdGljDQo+IGludCBhbWRncHVfdnJhbV9tZ3Jf
bmV3KHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFuLA0KPiAgICAgICAgICAgICBhZGV2
LT5nbWMuZ21jX2Z1bmNzLT5nZXRfZGNjX2FsaWdubWVudCkNCj4gICAgICAgICAgICAgICAgIGFk
anVzdF9kY2Nfc2l6ZSA9IGFtZGdwdV9nbWNfZ2V0X2RjY19hbGlnbm1lbnQoYWRldik7DQo+DQo+
IC0gICAgICAgcmVtYWluaW5nX3NpemUgPSAodTY0KXZyZXMtPmJhc2Uuc2l6ZTsNCj4gKyAgICAg
ICBzaXplID0gKHU2NCl2cmVzLT5iYXNlLnNpemU7DQo+ICAgICAgICAgaWYgKGJvLT5mbGFncyAm
IEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fQ09OVElHVU9VUyAmJiBhZGp1c3RfZGNjX3NpemUpIHsN
Cj4gICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBkY2Nfc2l6ZTsNCj4NCj4gICAgICAgICAg
ICAgICAgIGRjY19zaXplID0gcm91bmR1cF9wb3dfb2ZfdHdvKHZyZXMtPmJhc2Uuc2l6ZSArIGFk
anVzdF9kY2Nfc2l6ZSk7DQo+IC0gICAgICAgICAgICAgICByZW1haW5pbmdfc2l6ZSA9ICh1NjQp
ZGNjX3NpemU7DQo+ICsgICAgICAgICAgICAgICBzaXplID0gKHU2NClkY2Nfc2l6ZTsNCj4NCj4g
ICAgICAgICAgICAgICAgIHZyZXMtPmZsYWdzIHw9IERSTV9CVUREWV9UUklNX0RJU0FCTEU7DQo+
ICAgICAgICAgfQ0KPg0KPiAgICAgICAgIG11dGV4X2xvY2soJm1nci0+bG9jayk7DQo+IC0gICAg
ICAgd2hpbGUgKHJlbWFpbmluZ19zaXplKSB7DQo+ICsgICAgICAgd2hpbGUgKHRydWUpIHsNCj4g
ICAgICAgICAgICAgICAgIGlmICh0Ym8tPnBhZ2VfYWxpZ25tZW50KQ0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBtaW5fYmxvY2tfc2l6ZSA9ICh1NjQpdGJvLT5wYWdlX2FsaWdubWVudCA8PCBQ
QUdFX1NISUZUOw0KPiAgICAgICAgICAgICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICBtaW5fYmxvY2tfc2l6ZSA9IG1nci0+ZGVmYXVsdF9wYWdlX3NpemU7DQo+DQo+IC0gICAg
ICAgICAgICAgICBzaXplID0gcmVtYWluaW5nX3NpemU7DQo+IC0NCj4gICAgICAgICAgICAgICAg
IGlmIChiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMgJiYgYWRq
dXN0X2RjY19zaXplKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBtaW5fYmxvY2tfc2l6ZSA9
IHNpemU7DQo+ICAgICAgICAgICAgICAgICBlbHNlIGlmICgoc2l6ZSA+PSAodTY0KXBhZ2VzX3Bl
cl9ibG9jayA8PCBQQUdFX1NISUZUKQ0KPiAmJiBAQCAtNTYyLDEwICs1NjAsNyBAQCBzdGF0aWMg
aW50IGFtZGdwdV92cmFtX21ncl9uZXcoc3RydWN0IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4s
DQo+ICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkocikpDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gZXJyb3JfZnJlZV9ibG9ja3M7DQo+DQo+IC0gICAgICAgICAgICAgICBpZiAo
c2l6ZSA+IHJlbWFpbmluZ19zaXplKQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICByZW1haW5p
bmdfc2l6ZSA9IDA7DQo+IC0gICAgICAgICAgICAgICBlbHNlDQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgIHJlbWFpbmluZ19zaXplIC09IHNpemU7DQo+ICsgICAgICAgICAgICAgICBicmVhazsN
Cj4gICAgICAgICB9DQo+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZtZ3ItPmxvY2spOw0KPg0KPiAt
LQ0KPiAyLjQzLjANCj4NCg==
