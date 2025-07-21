Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B36C83F25
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jul 2025 12:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 062EE10E532;
	Mon, 21 Jul 2025 12:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ry7JnrWH";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFE510E52B
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jul 2025 12:11:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAU3R40WIpCzhvGZalNgzk3BKwq6x32pz+A7Npqa48ioofXTmZMkSUEIp1Kqsvls9C0jheVBWG8qAc7TSoxcf/6cbB2049zCEvKa92PAVJAeTgJuQdtDHn6DOWoe1FXEhlHEAlHtahz7p3HSH6SFpnnQsw0FaSesTRBTvXn9bcN332QdXCQzq4X2iHjtjIiPVztFFTi7dFFPQcj/PL31TpZ8FfGjZNlLPKBY7E3Vd6cpgzGfsfhcK9slfQsNXaqZnfxmfcUi1WbFzuBjeI0ckCixVUngCiOfVq6+ilcu+w4FUlGAtvsaurUZE5lXW+3GJJRhhNr1F6VMWE+r4NQqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Jgi5QTvoZTEQDHU7f7g+bYOqWlnbCNZsm2vbQEkixo=;
 b=SUFbVX2bRKDlPP/CvREUhc+2SStk7FQAgigUX/4e/OJQTcy5B4AjZi0+4jGKxyDSdPVmScowStjTh+5fmD+5se9wD4rDqMsr8KFD8ySelLyYB3Q0PWzgnHR3wZrs8P8aeRe/hIDomj+Ksp3QSK5t1uwYdlKAgc8i6larhqFZ9UH1tDUVkvW0I+MTEPPhHeqrBeS5U16eHoCbZe2oQWIL9we/efzeEpyrrRa04NUaWvzmSva64YLri8DZR8hDzCPJnZ662k1HlIY5FuqLRw7a7qsxE/JXoGbjTn0oOMOvxWgdoPotGlOV2VyTpMAOa6gAh9nwR0VIcQZeWNMULq8rrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Jgi5QTvoZTEQDHU7f7g+bYOqWlnbCNZsm2vbQEkixo=;
 b=Ry7JnrWHeNUPgXuv7og30E/4TePqjOfqvsovkxq3FVN9eshphHyWMqo+jxS3RvLDqilGe1gF/yZ3bml+sYHEzSDeXNHHexWNHzX3m7fz91ob6mOBh30GZUNtLNWgFrTQwq0UHh4e2bfjeDW0xVQPakwN7ab2dOPUqFjBTQk8vw8=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 12:11:26 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 12:11:25 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/8] Generic register dump helper functions for VCN
Thread-Topic: [PATCH 0/8] Generic register dump helper functions for VCN
Thread-Index: AQHb9+pP9A9BOgm+gkSNKYTMSXMmrbQ8gTfQ
Date: Mon, 21 Jul 2025 12:11:25 +0000
Message-ID: <DM8PR12MB53996CB71D5361D56A4B4996E55DA@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250718134544.2594829-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250718134544.2594829-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-21T12:11:01.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|CY1PR12MB9604:EE_
x-ms-office365-filtering-correlation-id: ad2d292b-14e4-4400-00a5-08ddc84fb719
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YXplWEtWZGdvZ3BZcHFTTjhSUE04emUvNko1RWg0cm8ya2JaVU1vTCsxSnhD?=
 =?utf-8?B?a1kvMHdBSTZEOE9pdldsd05LS2EzZnF4Qjg1akU4WTVncklJclpoREYxQXVy?=
 =?utf-8?B?UnJNTnd6dVhkK2ZIajYwbkJmU1NZdjlBZ3dTT291dEZrTGpiSlVhY1JZaWhp?=
 =?utf-8?B?bk1pUG5wcVhkMGF1QzhPVWI4ZGdyZlhveGJQd3V4djF6MEpJd0RQWDYwN2xh?=
 =?utf-8?B?eUs4VXlSZTBPa1lhSlk1VStKMGpGUC9iNmVXTjdUUDYrVzNrU1ZFVkpHL25Q?=
 =?utf-8?B?T2I1L1U0R21TUkd3cFByT2ZPZW9mc1hwelNLaTR4MDFUVzEwMTJuTGltTHIw?=
 =?utf-8?B?QThGSEZsVU9nMnVpa0t2aWJwK1JIcjJWdEZKUWZ4OTJraEJYbWl2ekowVkNG?=
 =?utf-8?B?bkM4MEdRNUxMUVR6elhycE9sZSthNzlKWC96ZFNLZmpwL3JzU1NldURuVmRt?=
 =?utf-8?B?VG5EeWh5OHFqSnhoa1krZ0ZhMWEzSnVzYTdIY01MY0dwdHQ5MTJ2U2xzeHBq?=
 =?utf-8?B?QXBCa1NtRUE5NGtkYWxudTMwU0txejJ2aC95Y3RTN1p2dEh2UU5ad1NZTHNQ?=
 =?utf-8?B?UGsyTUVTOTc5MGJTN09uQndsaDRGZmlXSGpDOElvNmR3WC9KaGhTTC9mbWxq?=
 =?utf-8?B?UW9adkVkK3FZNUVSVWkwa295b0xCd3gxd1BzOVZMLzA3amFkeUFQV1N3c2lu?=
 =?utf-8?B?WUFYb0pKK0UwNmVWMG8zWThlQ2xhakh4czVGVGlJUnhsMjR3SGtaYWN6Wmcx?=
 =?utf-8?B?UDc0UDN2S3c4RHk2K2wyNjhHcW9NK0hKTk5SUmZBb09seTAvRTB1aE0wK0VP?=
 =?utf-8?B?Nk0vckJlb3Q1MlJDUUhzdGhCR29zdWJDZFIwZnUvQjVPaUVHVmVsYmpaUDNG?=
 =?utf-8?B?cDN4Qjl6Q2YxY3ZsSVJ1S2k5TUJXdGEwYlhGdk1YcmYrZy9GNm9vY3R3cUlX?=
 =?utf-8?B?OHpmQVZxUVVEc0ZwNUYxUndmU0RpSnNYRHAvZERIRjdtUGdmQi9MM0lFR2VG?=
 =?utf-8?B?dGhEUktDa012ZWQ5eGxJOTFXbWNuRy82NEtiWkpqRGVTNFlGVU9jQlpvYitj?=
 =?utf-8?B?cnFna0hxZCthUVdLbnJqckQ5VVo5SnhPMXN0QmFZaEpURzR3dXprZTJabGtu?=
 =?utf-8?B?QnV6NEdDVHZHOGZtbFhRSEh1U1haRHRCR1pYR21sT3kxcFh3MHd6WEJIMDg2?=
 =?utf-8?B?VG8zeUdWTHdlRENYTWxuanh4L05RTmpOM0dPQ2s5bGFwVUFIQmpkOXNNaWEw?=
 =?utf-8?B?czdUaDlPUWhiTDU1am5DcG5NZnFqdEhKV1lOa25rUzBWdGZUb0VmU1haWTNa?=
 =?utf-8?B?NkhWQTZ0bkpjb2w1MzhFWlJNbml2OVhTVk04dEpPK0R2MDZaQjJxeXVwNkRO?=
 =?utf-8?B?Tm5qVW9LbUVTcUZVUy9xTVFLL0RMVnV2SkJWY2FyK3ZSMzU5NXIvWXRNaGk3?=
 =?utf-8?B?NGNHN01qODl2a1hFQnRSbXA5MEQ2em16WWtFOElRaW5VYlZhMC8rSlZpSVZt?=
 =?utf-8?B?VWlXUHRqdkJjUlVldDJjcjVTNFFWV2Npem1sd2J1Q3drZW1CQ3VGVFFwQWtw?=
 =?utf-8?B?SnJpTUsrUTdUSnNweHJXSzlpcysyc09qS2Q3MW1kZ2ZiUnpZb1JkclRoNWwz?=
 =?utf-8?B?NVhjOVk2bkpOdjdFd3dGOXBvYSswcHNOdkJNS0kyQjlPR1pQbDBvNnhyZnFj?=
 =?utf-8?B?U204bnpDenRLeWVTK1BEdURESjRVTS9WS2lxMDY5SUVzLzVFUVR2L3FxS0lB?=
 =?utf-8?B?Y0poTHJrYVY4QnNtNnROTmcxaEJENndsUWtyZDVzdFo3Nk9Kc3FQcWtmRERv?=
 =?utf-8?B?OHdLUjhOcnVBY0FZU3h1ZjZXSk80aVU5czM5Uzh0Yy9YcFhQQnJxM1N1aVc4?=
 =?utf-8?B?UFNkaUZSMHpqaktRNjVjWTBuN2Y4MXFTZDFpOXZNUXFQVnFONFZleHQwUjE5?=
 =?utf-8?B?Nm9Pbk4vc3lyRTU0NUxKMTd5czUzYjEyTVExM0xJMEJpRTJ5aVNONGpIQ2pN?=
 =?utf-8?B?MGFrcjZrS1J3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(376014)(366016)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW9NT2U3cFZHK2k2YUp6aTFvUVNUQVpnWTNZcTBIZ1NxVnJPaFdlNUtVK09C?=
 =?utf-8?B?eXBOMnliU1Q3WXA1cjFlQ01WVVZQS2VrQmZSZjN3Q1FGTG9CQ1BVaWRQOG9P?=
 =?utf-8?B?ZHYrZDF3R3F6WExHRHJuOTkvSHlMdzREbGtZVkdOb1IrNGJncjhMQWVjL1Bx?=
 =?utf-8?B?RWNoSE8xcDdxdFFsLzk0WGVabTJ6QVJKd2dzQWxkSUxWNXZ5UGZISWtHY1Zv?=
 =?utf-8?B?c0tpRUhKT2VGOGFnNERLMSs4d2JWdTJ6NUcwa1lXeWMzYjBUSmlEWHhkNDlP?=
 =?utf-8?B?TjgrZW8ybVIzQXYxbHV1emE5QmR0ZVZQTnRqRUg2aUo1a3Uvd2ZkcmY3eFl1?=
 =?utf-8?B?VEp2SWZESFBUcnNXVmR4eWM4L2duMWRqTzBpalR3RFlQUTlLQndYZkZ2b0lM?=
 =?utf-8?B?REtkVVNORXJMeXZ5NGdZVWN3SCtjbFlkNU5GYlpVckxlMVFET3FkTGllMVNo?=
 =?utf-8?B?UXc1eHRZZDBiYUVSOTdwOGJHbUgzTDArSzBKVzFWNlYrZ1FEWUM4Q2YrQWF3?=
 =?utf-8?B?NS9XaU1xRzFZb1JlZXdYTE5oMUpNQW1YWXJ0bThCVjUrZUg4UWZGSW95T3By?=
 =?utf-8?B?WTFqZ1BqVUNuME8zaW5lMG1yR2h4QWdvOTdqdXovSWhMZkpjWnZSUXNPVWRY?=
 =?utf-8?B?Rit2bHBHMEN4ejhWVU9vVEZXalEyYWhneGs4a3k5Q2hEWVZSR2F6WnhicVdB?=
 =?utf-8?B?MlFDRm1tT1hvbmt1ZXRIbTRJb0ZzNGQxM21VWGdpWHFTbkh2Z0FsWWV3QW1u?=
 =?utf-8?B?aWVKMkU0TkNuOWFVM3MveEFiUUxCZVA0RW5UUXYrS09seHFoUnRRR2VXRTVR?=
 =?utf-8?B?OWNzZCtYeGRFSmsyV2pPWDJBemQ0d0RxalJwQTh3WDkxRjl4aDFWNENOTzFM?=
 =?utf-8?B?K1JNV2ljcFBtdVZLL3Z5WWxRNHhXNnluYUE2NnZsL0lIK3pHOXNFL0ZSa1Rx?=
 =?utf-8?B?REFNQVNCWFh5N0hjRGVOWkpWZEhINFRvemxscUZleDhPUGRSYXJEWWZ0M21Q?=
 =?utf-8?B?RS9OL1FtYTY0cmI0cWdtQWhVMzU0a0hSSURnRVhXaEFkUUw4SXljWUsyNStl?=
 =?utf-8?B?UGxLWmJxOXZOUUkvd1VGRkIzajUwclQ3RkduUHhHS21kd2xtMFhHdnpsTVpi?=
 =?utf-8?B?QzZ3Wll6Q251WkcweWpzdWNyMUxKd0lRSHNXQzZvNkxOMmU0V1duT0Z6TDR2?=
 =?utf-8?B?SFlRbDlKWnFZTEVsR3Nkd2Zoa1VRWFB4dDY0U3lLNStvTURFSXZ2cjhLOHVU?=
 =?utf-8?B?YlYwS0I4TGJBY1NpT2tScytld3M2S2c5K0R1ZWZaYmtkREROenVxY2JnZnlj?=
 =?utf-8?B?Y1o5MU85b3hrSTNKb0J0dEk5enhaeFNMRWFDQ1pnWm4vbE5Ea2E2VWtNZHpB?=
 =?utf-8?B?ajB6bzJoUGdIazVtTTJ6RkwvWVgyaGRWN0lYc2MwYWU3NGZZUjRNQWk0NU5X?=
 =?utf-8?B?UzEzMkJ4R0Y3cEdXTE53ZU42c3JXNG1rc1VuUFhYd0xmRlptZWh1OWNXeGY0?=
 =?utf-8?B?WDl0SCtYWUdmS2NsSWVWTjQwS1RZVkQ0cGRwYU1XWXJxdFJxaTNxOWE1N2ll?=
 =?utf-8?B?dHFja3BLQ21tcldyblFmd0srUVJXa0hHVHlZYUw3MktFSHFDYkphTGg1NmN2?=
 =?utf-8?B?MzFFRTAybkNQRVVuMGNrNCtMWm4xQjFBSFpCRGN1RzZMRXNWdWRxZHFpYzAr?=
 =?utf-8?B?bUNJcXVSbUhiRWd2OHNRTTdqYUtON0cvMXJrYW5pc0lsTHV0c2dmblR6RkJU?=
 =?utf-8?B?cTA3U0czOGNqNXkzZkVOWHZQdmt3T0tOUTl4a1pDSWgrdnJTK0orOEg1MkV2?=
 =?utf-8?B?UUtFL25pVGZqcklPNzZsWURxOGV4cC9mdjhaR3FEdnY0NHRwa0RKc3JlWHk3?=
 =?utf-8?B?aGtMUFQzeG1tM1d2UFZOQzc5amRWaEJXYUsvUFpkNVl0cnBHcXVON3BVK3BF?=
 =?utf-8?B?ekcwSVJ5VzA2Z1cvUGtMK2pSc1k3K200VmVMUmIydGlTWEZPQVJKblkvUEVE?=
 =?utf-8?B?NnRyNmtSTkQ3Ky92bVZkTjQ5bklrRFlWM1FYMERPb1NiTkJ1OC9NZE8vbnlr?=
 =?utf-8?B?K2xtQTlHNmRCaHQvZFYveVFEWUdIaWFaZHgwWXZPOFlpdXVKanBScEtKM1RT?=
 =?utf-8?Q?fX4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2d292b-14e4-4400-00a5-08ddc84fb719
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 12:11:25.6279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1KUn+SfEGZJ48mXz8OP2fVzHxudGv4m/oCdgwzbU7EruNCXowQx1E9LGf33voQh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604
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
Cg0KVGhlIHNlcmllcyBpczoNCkFja2VkLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+DQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VuZGFyYXJhanUsIFNhdGhp
c2hrdW1hciA8U2F0aGlzaGt1bWFyLlN1bmRhcmFyYWp1QGFtZC5jb20+DQo+IFNlbnQ6IEp1bHkg
MTgsIDIwMjUgOTo0NiBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
Q2M6IExpdSwgTGVvIDxMZW8uTGl1QGFtZC5jb20+OyBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1bWFy
DQo+IDxTYXRoaXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
IDAvOF0gR2VuZXJpYyByZWdpc3RlciBkdW1wIGhlbHBlciBmdW5jdGlvbnMgZm9yIFZDTg0KPg0K
PiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIGdlbmVyaWMgdmNuIHJlZ2lzdGVyIGR1bXAgaGVscGVy
IGZ1bmN0aW9ucyBhbmQgcmV1c2VzDQo+IGl0IGluIGFsbCB2Y24gdmVyc2lvbnMgaW5zdGVhZCBv
ZiByZWRlZmluaW5nIHRoZSBzYW1lIGluIGV2ZXJ5IHZjbiB2ZXJzaW9uLg0KPg0KPiBTYXRoaXNo
a3VtYXIgUyAoOCk6DQo+ICAgZHJtL2FtZGdwdS92Y246IEFkZCByZWdkdW1wIGhlbHBlciBmdW5j
dGlvbnMNCj4gICBkcm0vYW1kZ3B1L3ZjbjogUmVnaXN0ZXIgZHVtcCBjbGVhbnVwIGluIFZDTjUN
Cj4gICBkcm0vYW1kZ3B1L3ZjbjogUmVnaXN0ZXIgZHVtcCBjbGVhbnVwIGluIFZDTjRfMF8wDQo+
ICAgZHJtL2FtZGdwdS92Y246IFJlZ2lzdGVyIGR1bXAgY2xlYW51cCBpbiBWQ040XzBfNQ0KPiAg
IGRybS9hbWRncHUvdmNuOiBSZWdpc3RlciBkdW1wIGNsZWFudXAgaW4gVkNONF8wXzMNCj4gICBk
cm0vYW1kZ3B1L3ZjbjogUmVnaXN0ZXIgZHVtcCBjbGVhbnVwIGluIFZDTjNfMA0KPiAgIGRybS9h
bWRncHUvdmNuOiBSZWdpc3RlciBkdW1wIGNsZWFudXAgaW4gVkNOMl8wXzANCj4gICBkcm0vYW1k
Z3B1L3ZjbjogUmVnaXN0ZXIgZHVtcCBjbGVhbnVwIGluIFZDTjJfNQ0KPg0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIHwgODYNCj4gKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmggfCAgOCAr
KysNCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMgICB8IDc4ICsrLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81
LmMgICB8IDgyICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y25fdjNfMC5jICAgfCA3NyArKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRfMC5jICAgfCA3OSArKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzBfMy5jIHwgNzgg
KystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25f
djRfMF81LmMgfCA3OCArKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3Zjbl92NV8wXzAuYyB8IDg2ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y1XzBfMC5oIHwgIDUgLS0NCj4gZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y1XzBfMS5jIHwgNDQgKysrKysrKysrKystLQ0KPiAg
MTEgZmlsZXMgY2hhbmdlZCwgMTcwIGluc2VydGlvbnMoKyksIDUzMSBkZWxldGlvbnMoLSkNCj4N
Cj4gLS0NCj4gMi40OC4xDQoNCg==
