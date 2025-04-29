Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107F7C369CB
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 03:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9F710E237;
	Tue, 29 Apr 2025 03:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D8nay+KI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5BC610E235
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 03:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYgJcHSN2WEVuaSxLQAbCPCQ7clh3StkCMzt8gUG2XVxz9DfVu5WckdJ5h7OrIucbLFCVN1gorMkmLRVg9P5paeAhYzOhTpbu6F2N7RC0MqaruAs+g5Q6QiAqhpLbLBSws32tfItrOO9iak/m83KSJKYRuDscBmzPUbjzfREeCjhj5H77HpWsGtuarCoZibra7WUPty6V9OLZxQGIcX0LjgqFw/CcquTsJ7IPtWgDGFI9S+hHNoAN0Su+BhUWXYXdrTvvm9lq72ofkwHWyMBIASFftNAVIFyw4cu4Dx9m50TSc2HagQt8HzVH9CYYDh03S4XOWRGRzgrZBEOVVaQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRKwCYa2+5Us/R+Ty/erqKN0OrAUl4a1+csUkY7kwyM=;
 b=yDVY0X3wfSXks4y96/PmRgvV7WUYuw7Tyf+PuSGfmznHif0SjwQZZ3Q/vWjfe9Whf4rlirs4XEljJYeldX/63el/97mHGomS/wQqM6SQVOIy75CWFksUtODFPOIpzzV83L42isa9OdPK4xanhyKpM8vF2+txy6ZeR3QQPJuIv6bYhUtncVYJpGe/O2Ru8v9lag2MmlnDoSAiZSkxAqhiK2sWro8IhMiTXV5dD65VcOjWxRmoHoeg+I423a5ty/H0OvE3dcJSoXFuhTSk33N9c8NhEM61AI5baHQZlkYXs6uk+OW7I/R6MX7fy5rrW4DYmE6wDy9aWwDovzlgy9YW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRKwCYa2+5Us/R+Ty/erqKN0OrAUl4a1+csUkY7kwyM=;
 b=D8nay+KIawQnUbiy0gSGROFDQ0j81jo7WF7m18AbwkQt6qA3IRbiMWk5wvEL8NiENNmxHpLe9bJu3jHEIwZBnxUDLD1W3Rx7bTt7t9BbLt9efJsn6VymqW+UkOIdJXDkk4YGUTguTXBwYf7F3cc+3kzs6HaPq72mqLbVx/9VVa4=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Tue, 29 Apr
 2025 03:54:19 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 03:54:18 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Use macro to initialize metrics table
Thread-Topic: [PATCH] drm/amd/pm: Use macro to initialize metrics table
Thread-Index: AQHbuLT4pAit+1UvPk66cYgr1e0aSbO6AVYAgAAA5Xw=
Date: Tue, 29 Apr 2025 03:54:18 +0000
Message-ID: <PH7PR12MB5997A8077DF741BA9F320D2582802@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250429031512.974183-1-lijo.lazar@amd.com>
 <BN9PR12MB5257D924F233D284649FCEE0FC802@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257D924F233D284649FCEE0FC802@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T03:46:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ0PR12MB8168:EE_
x-ms-office365-filtering-correlation-id: 218d4934-f706-43c4-7457-08dd86d184ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|38070700018|8096899003|7053199007;
x-microsoft-antispam-message-info: =?gb2312?B?SDFodlBUKzZLSE1MdU43QWgveG1ycHp4YnV4ekd0NjAzdkFHYitCYWl4czBI?=
 =?gb2312?B?dnZMbnJMdTRkM05sRjgrYzhvM28yWmx1ZDVXTkFFR1B3ZlBWSXMzNUdJcVBv?=
 =?gb2312?B?eDUzc0FhYXVKL0tKNXVXK1dMYWpqNmtJSEdIbGN0QlBXek1oQ1hjem9ZT3Vn?=
 =?gb2312?B?YmNuN0hPV1NqdnhjN3B0V0p1YlRsdlBvSS9DZnMxM2k2VlgxL0FnamNhVk9t?=
 =?gb2312?B?UVRYd2JNM0JuVWVic1BETGxuQ0VoOW1HOFkxTVpDbDBtYTlicHJTNEwyd0ht?=
 =?gb2312?B?S09xbzd6Qk54WXE5cDVSZlRMcUp1MUw1MnFMYXQxelRKSjhzLzk4eDN4NzVq?=
 =?gb2312?B?TmZkbVVVY204a3hXbGNtbDViOVJOQlBFU0p1dlZ1dG1DRGp1SGFSeVlkYXB5?=
 =?gb2312?B?cjNyMnZOQTM0MUZMdkkvME02cE5HK3hNMG51Nm4rcW1pdmZhaWFWKy9qYnhW?=
 =?gb2312?B?ZGNlRHpITmRLN25weVJ6ZkdSRHoxcHlRSzFLVHV0eTZIVzMyTm5ycEUwWkc1?=
 =?gb2312?B?OC9Zdi9BQmdDUW9TK2s0ZEZVZ05iRVgzQ2EwVndwOG9ySE00OXdmZm01ODRW?=
 =?gb2312?B?NVBhZ0VETlpteHN5b1VVQndkaGd0eWZUNWZNWm5UckJvdkZjTm1nMVIrbTdC?=
 =?gb2312?B?ZmVYLzhFYW5MUkNjWktqUVE3TGxwcVpQcURabmIrT0V5NDErTm52ZUkzK1Iv?=
 =?gb2312?B?ZkdJRVlTVllLOFhQTjZWTFlPclRVaWxWS29NeitQeTBBNzRJalhIbDR0TmhG?=
 =?gb2312?B?T3NkZHM2MXNtenJCR2JCS2RySkxpelNKQmJrZk5GaHhiNSswYS9iU3BRcjRq?=
 =?gb2312?B?UFBTSDRqU3J5MnYyY2Z1bnRLQ0d2YWwvVzJFUDhVR3J5bUN2TTJrU0xsd2hP?=
 =?gb2312?B?YW4yTGlPVXg2dUw0OUpVbjZTbzdPR2lvWjRTQXRNOHdnNWlhb21NLzlHdUwz?=
 =?gb2312?B?OG04K2NRQTRXWjl6QzJMbVVGSGlRTTBzYWhyRVN0VGo0MTM4ZUU2aHM5ajZC?=
 =?gb2312?B?Q1JrdS9BMFVBcGRhYmpraUZUQTRWbndsdzZseWV5R1JWZmN5d2ZhUmJ0Sy9s?=
 =?gb2312?B?Tm9xVG1CbmdKVDdMRjBPTEZkTS94OCtIQldDWlE2dXFIWkRiMWJTWkxQOTUz?=
 =?gb2312?B?Z2laTWI2TFdQalZCN2lscmZYVHhuNmRsMzBkQVNjejhrZWF1RGdkRlRKUlFh?=
 =?gb2312?B?OGhGWjhuOVlJZDBMNGVkbWtyUTVpVkoyZmRDVEh3MGhJMUlJVmViazMzUFZQ?=
 =?gb2312?B?OXptUGVvcmt3cGtUNTFjV3h2cU16bHBvM2lvWjRkNVJFV3NOMnZFN1lUZTZN?=
 =?gb2312?B?ZlJpZTMvOFZPRGtiWUR6UmtyQWx3N0NRM2NCMGFYcUtOZDhJSGF1Y2NZQ1NE?=
 =?gb2312?B?M1VmYS90RzRUL2k0aU1YN3JxQWNIMUxBbG1EWGQwa250QnVHR0F1SVhIcVZY?=
 =?gb2312?B?OFJZODlKWHZFS0FRKytyalJmVjNRVDFJcUhsQjMyYTkveVlzVWczQTFlY1Q0?=
 =?gb2312?B?RndyWXV1NmxUMDVVNXJMMDQ1THdhYnhITDI0WXBneWp4RE5PTlVxSFdaaDJU?=
 =?gb2312?B?VzRjZUhmTHg4SkN3QUp4a2YyMjIxZDNROUV6OEFsYSthdXhwS0oyZlRtdllU?=
 =?gb2312?B?bHNjSk1HME9nVjJtRzZ2T0tPR3BONi9DZDA1TEw5ck5wc3NRUXFJcHFIUDRF?=
 =?gb2312?B?SVRzZm9xUmwyUGQrbDkzNk9Ga29NeHBCNEJIWU1UZmhOUGU5bjhUeTZ1cEc1?=
 =?gb2312?B?Wk9maEpPcmI3MTZLRWg0RXdraUluMU5vL096SmIxYXAyV3k0bHhyT2hDajUz?=
 =?gb2312?B?Q3ZWcDRnVmVkckxnbTNrL0t2dXlZMk9raDlYaGNrbTdIbDNYOWp2c25RV2ha?=
 =?gb2312?B?am0wd3FpazFGRnVHYnlVQ2NKWW5QNVphYk5qbG9FU204RXBNeXc0OS9LK2pi?=
 =?gb2312?B?R3gya0pYZjR1WWFSM003Z2ZYcVl6RUtlMTdnSkg0Y0greGNkNG1HUUl1ZENR?=
 =?gb2312?B?b0ZSVGJ2YUx3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TlpEUWFSWFFKdHlpVStrSWdPRkwyMXlOMmF4Mlp4VWlJb3FGMFlZTEdSWTlT?=
 =?gb2312?B?MVF4T1A4MGkyamoyUU5UanAzVDBGNXlHNEFkWlRzN3JnTW01QkRUZnJYOVlo?=
 =?gb2312?B?akRVMDk1dkxkVU1hTnMxMjhLUXljc3pPOTh0bTIyS2JlTHlhd0JVY0tHWWc0?=
 =?gb2312?B?UHNJdmVXYWNNYmlDSFowUGZsaFdPV3NRaU5objB1bVBmaWhpR2lBeE1nMFFE?=
 =?gb2312?B?S21IRnRoODNmZmVvb01EdjBaV2ZQaUI4TExWbkorbG9OakhNd0xVU3htbU1O?=
 =?gb2312?B?UHFZbU53SWljMzhBdmxjUUpJSzdZU3J2WmFybDRybCtaTHZmcGp5S21Bd0U4?=
 =?gb2312?B?YkN0Q2FHcnV4a3VhMVNiLzRzUFBCaXBzaG1pRnBqQW0wN1J2K2J0MXA1dlll?=
 =?gb2312?B?UHE5OGYyWFFxWEsxWFFjbzMvQ3NxV0JTMjkydVdBWHkyV1hWZGtIWTQ0MDU4?=
 =?gb2312?B?WFBUM1JVQ3ZOY1Q5elEreHBPT3oxR2RMN3h6WmluNEM3UEk0SDRTb3ArRHNQ?=
 =?gb2312?B?b2MyOHJxMGFHTTQwTnlydlBHY29yRUVpRDVoNUQ1YmV6WXVSUkVtWnJudWpu?=
 =?gb2312?B?Y29RVEQreXM4UWFJTlp6WkFiUjdKM3E2OE5lYm1TNTFpUnNvcXpOTVRCb1dZ?=
 =?gb2312?B?MUlDUHFFeFBIUnlUSWM2Z0o2MkYyWEhFTmJMdHhQa2N5UlJQQ3cvNk1acW9E?=
 =?gb2312?B?a3Y2YWFQK3dlNmlLSEZYVXNkaWNNRmVKWFRDc241d0plY3dLWXdBYlB3bXJa?=
 =?gb2312?B?L0ZHNjVwREtxeitSOElhL1AxNmNYUUJ5Qi9oRTVmZThESjJaODZxTlpUVWJV?=
 =?gb2312?B?ZzNiRDBac2UwbWlRYVJpNkVuTEF3d0dtcC9OWXV4WFl3cGlYcnlTNFg3ZXFD?=
 =?gb2312?B?MGlwT2VNSHNmUnVRSEErWXp5V0ZXblBKRlczbDFVWTk0Q3RaZTlPaHJ3bXo2?=
 =?gb2312?B?Ti95U3VXR0pZR2hWRGw3UDFNRElyNlZVNnZvQ2s1US85eTYyenZqU3pZN1Rt?=
 =?gb2312?B?L256bzNEVEdsWDQ2RFhVSWpUaEJza1BkV2JPeFVSZkhFUUZzaVlFMnFuVEc5?=
 =?gb2312?B?SWF3RUgwR2x4OG5Pd3gwZmhUQ3A3RjZwbTNYZW1Rd201MDZEcm5hdUI3U2ZL?=
 =?gb2312?B?cm1lRGRmcWRsWmpIbzduTURTdWxyTStSa3BJMWEwbjh1OUdDRFJtVklqZWdW?=
 =?gb2312?B?d2Y4Q3dKUjA2QVIyY0FLU2dQelhXTUVwOG0rc20xK3dBb1BHUS9meE10VFFr?=
 =?gb2312?B?QW5VeXlGZlZJOC9YT2tycUx5Nm9ER1phL1VMU1FSZmlxdFJrS3RWL0NNZHdP?=
 =?gb2312?B?ZkFHdkRXM3cza1BTdkJ4Y3c5U09XSU5xd1prcTBURkZTUUE0dUd0Q0ZZQmlz?=
 =?gb2312?B?MmZCS0M5WGUyR053RitWaC9CUHFCeTZDN2VDc0tmR0cvWVJjV1FhcFhUR0tG?=
 =?gb2312?B?OWpsMVUwY2pLdC9oazJiTnNCLzJjQTYvblNlVmErUXozeDZEU3NRajZHUDYw?=
 =?gb2312?B?Rk5WWWp6aDRaMnpSMEtwa21MWkc5UitUOXpqMTVWYjRPUlhRbXhNVDdwMmow?=
 =?gb2312?B?dVZFRk1qdU93b2xFcnZldFg2OE55K2daNmJ2akR4NC96UCswUi9NRy9hNXU2?=
 =?gb2312?B?a0MvZlRLeXFXcFo4L0VTSWhzcEVudksyRVd0NWFYMHVKbXQ1SG1pRDRRR1Jl?=
 =?gb2312?B?WDBZOGQ4bFdyNnE2OThjNWc3NGptTnZHVVN4RWxJK2hnNFZGVEFpby8yRjBI?=
 =?gb2312?B?bno1cGcvQUVla28rdmd0b0tMV0tmd1dQQXNmVHJWZG9uSVEvbjI3V2Y3cE1l?=
 =?gb2312?B?R2lLNkpMS2E0QkFlenV4cC9xWHB6dVp5ZEJTUlpOYzhOUlVFanFZOXhQZFM1?=
 =?gb2312?B?a3g0cjNIWlJZSFJ5T1lyTFdpYk9Nd3ZrSy9MU0FwWDYyczlhZWRzQjRGK2M3?=
 =?gb2312?B?NjJBNURyMHZuQ3pmWUhoZ2RUYWRNbEpjNk93enRpOGtkY3hTMDRiMStyb21O?=
 =?gb2312?B?cU5ONUIycUt3WnVsVWg1ZHQ5SHNGODNTdmVzdkdLdGNRT1ZFdkhKYUozK29Z?=
 =?gb2312?B?WStHcTZHOTlUUFlUTFlRelpqZU5HWVYzTzByR3djTzdsS3kwYXNub0dlYWxm?=
 =?gb2312?B?K1pCeGtqaExpUjZsTTJsMmdDL2l3c3htTEV2UjFJd1dXMVk5VytFV0tVaHQx?=
 =?gb2312?Q?5avDA5ioJJfKiWqXBiDG+nSiq6J7qFEz9Vdp+0PbrCgb?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB5997A8077DF741BA9F320D2582802PH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218d4934-f706-43c4-7457-08dd86d184ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 03:54:18.8350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofdwuAb+SBRxl6YayDKKxcSn7PV0rKDtQI3ACoLjCEu3p28NFv4S/QeomoWJttAX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168
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

--_000_PH7PR12MB5997A8077DF741BA9F320D2582802PH7PR12MB5997namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KI2RlZmluZSBzbXVfY21uX2luaXRfc29mdF9ncHVfbWV0cmljcyhwdHIsIGEsIGIpDQoNCml0
IGlzIGJldHRlciB0byB1c2UgZnJldi9jcmV2IHRvIGluc3RlYWQgb2YgYSxiIC4NCg0KYXBhcnQg
aXMgb2sgZm9yIG1lLg0KDQpSZXZpZXdlZC1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0Bh
bWQuY29tPg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCreivP7IyzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4N
Creiy83KsbzkOiDQx8batv4sIMvE1MIgMjksIDIwMjUgMTE6NDcgyc/O5w0KytW8/sjLOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0Ks63LzTogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS2FtYWwsIEFzYWQgPEFzYWQuS2FtYWxA
YW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0K1vfM
4jogUkU6IFtQQVRDSF0gZHJtL2FtZC9wbTogVXNlIG1hY3JvIHRvIGluaXRpYWxpemUgbWV0cmlj
cyB0YWJsZQ0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1
dGlvbiBPbmx5XQ0KDQpSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0Bh
bWQuY29tPg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiBUdWVzZGF5LCBB
cHJpbCAyOSwgMjAyNSAxMToxNQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpD
YzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEthbWFsLCBBc2FkIDxBc2FkLkthbWFs
QGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NClN1
YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9wbTogVXNlIG1hY3JvIHRvIGluaXRpYWxpemUgbWV0cmlj
cyB0YWJsZQ0KDQpIZWxwcyB0byBrZWVwIGEgYnVpbGQgdGltZSBjaGVjayBhYm91dCB1c2FnZSBv
ZiByaWdodCBkYXRhdHlwZSBhbmQgYXZvaWRzIG1haW50YWluZW5jZSBhcyBuZXcgdmVyc2lvbnMg
Z2V0IGFkZGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5j
b20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYyB8IDY3IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dV9jbW4uaCB8IDEzICsrKystDQogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA2
OSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211X2Ntbi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCmlu
ZGV4IDgwZWIxYTAzYjNjYS4uN2VhZjU4ZmQ3ZjlhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211X2Ntbi5jDQpAQCAtMTA1MSw3MyArMTA1MSw2IEBAIGludCBzbXVfY21uX2dldF9j
b21ib19wcHRhYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211KQ0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZmFsc2UpOw0KIH0NCg0KLXZvaWQgc211X2Ntbl9pbml0X3NvZnRf
Z3B1X21ldHJpY3Modm9pZCAqdGFibGUsIHVpbnQ4X3QgZnJldiwgdWludDhfdCBjcmV2KSAtew0K
LSAgICAgICBzdHJ1Y3QgbWV0cmljc190YWJsZV9oZWFkZXIgKmhlYWRlciA9IChzdHJ1Y3QgbWV0
cmljc190YWJsZV9oZWFkZXIgKil0YWJsZTsNCi0gICAgICAgdWludDE2X3Qgc3RydWN0dXJlX3Np
emU7DQotDQotI2RlZmluZSBNRVRSSUNTX1ZFUlNJT04oYSwgYikgICgoYSA8PCAxNikgfCBiKQ0K
LQ0KLSAgICAgICBzd2l0Y2ggKE1FVFJJQ1NfVkVSU0lPTihmcmV2LCBjcmV2KSkgew0KLSAgICAg
ICBjYXNlIE1FVFJJQ1NfVkVSU0lPTigxLCAwKToNCi0gICAgICAgICAgICAgICBzdHJ1Y3R1cmVf
c2l6ZSA9IHNpemVvZihzdHJ1Y3QgZ3B1X21ldHJpY3NfdjFfMCk7DQotICAgICAgICAgICAgICAg
YnJlYWs7DQotICAgICAgIGNhc2UgTUVUUklDU19WRVJTSU9OKDEsIDEpOg0KLSAgICAgICAgICAg
ICAgIHN0cnVjdHVyZV9zaXplID0gc2l6ZW9mKHN0cnVjdCBncHVfbWV0cmljc192MV8xKTsNCi0g
ICAgICAgICAgICAgICBicmVhazsNCi0gICAgICAgY2FzZSBNRVRSSUNTX1ZFUlNJT04oMSwgMik6
DQotICAgICAgICAgICAgICAgc3RydWN0dXJlX3NpemUgPSBzaXplb2Yoc3RydWN0IGdwdV9tZXRy
aWNzX3YxXzIpOw0KLSAgICAgICAgICAgICAgIGJyZWFrOw0KLSAgICAgICBjYXNlIE1FVFJJQ1Nf
VkVSU0lPTigxLCAzKToNCi0gICAgICAgICAgICAgICBzdHJ1Y3R1cmVfc2l6ZSA9IHNpemVvZihz
dHJ1Y3QgZ3B1X21ldHJpY3NfdjFfMyk7DQotICAgICAgICAgICAgICAgYnJlYWs7DQotICAgICAg
IGNhc2UgTUVUUklDU19WRVJTSU9OKDEsIDQpOg0KLSAgICAgICAgICAgICAgIHN0cnVjdHVyZV9z
aXplID0gc2l6ZW9mKHN0cnVjdCBncHVfbWV0cmljc192MV80KTsNCi0gICAgICAgICAgICAgICBi
cmVhazsNCi0gICAgICAgY2FzZSBNRVRSSUNTX1ZFUlNJT04oMSwgNSk6DQotICAgICAgICAgICAg
ICAgc3RydWN0dXJlX3NpemUgPSBzaXplb2Yoc3RydWN0IGdwdV9tZXRyaWNzX3YxXzUpOw0KLSAg
ICAgICAgICAgICAgIGJyZWFrOw0KLSAgICAgICBjYXNlIE1FVFJJQ1NfVkVSU0lPTigxLCA2KToN
Ci0gICAgICAgICAgICAgICBzdHJ1Y3R1cmVfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgZ3B1X21ldHJp
Y3NfdjFfNik7DQotICAgICAgICAgICAgICAgYnJlYWs7DQotICAgICAgIGNhc2UgTUVUUklDU19W
RVJTSU9OKDEsIDcpOg0KLSAgICAgICAgICAgICAgIHN0cnVjdHVyZV9zaXplID0gc2l6ZW9mKHN0
cnVjdCBncHVfbWV0cmljc192MV83KTsNCi0gICAgICAgICAgICAgICBicmVhazsNCi0gICAgICAg
Y2FzZSBNRVRSSUNTX1ZFUlNJT04oMSwgOCk6DQotICAgICAgICAgICAgICAgc3RydWN0dXJlX3Np
emUgPSBzaXplb2Yoc3RydWN0IGdwdV9tZXRyaWNzX3YxXzgpOw0KLSAgICAgICAgICAgICAgIGJy
ZWFrOw0KLSAgICAgICBjYXNlIE1FVFJJQ1NfVkVSU0lPTigyLCAwKToNCi0gICAgICAgICAgICAg
ICBzdHJ1Y3R1cmVfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgZ3B1X21ldHJpY3NfdjJfMCk7DQotICAg
ICAgICAgICAgICAgYnJlYWs7DQotICAgICAgIGNhc2UgTUVUUklDU19WRVJTSU9OKDIsIDEpOg0K
LSAgICAgICAgICAgICAgIHN0cnVjdHVyZV9zaXplID0gc2l6ZW9mKHN0cnVjdCBncHVfbWV0cmlj
c192Ml8xKTsNCi0gICAgICAgICAgICAgICBicmVhazsNCi0gICAgICAgY2FzZSBNRVRSSUNTX1ZF
UlNJT04oMiwgMik6DQotICAgICAgICAgICAgICAgc3RydWN0dXJlX3NpemUgPSBzaXplb2Yoc3Ry
dWN0IGdwdV9tZXRyaWNzX3YyXzIpOw0KLSAgICAgICAgICAgICAgIGJyZWFrOw0KLSAgICAgICBj
YXNlIE1FVFJJQ1NfVkVSU0lPTigyLCAzKToNCi0gICAgICAgICAgICAgICBzdHJ1Y3R1cmVfc2l6
ZSA9IHNpemVvZihzdHJ1Y3QgZ3B1X21ldHJpY3NfdjJfMyk7DQotICAgICAgICAgICAgICAgYnJl
YWs7DQotICAgICAgIGNhc2UgTUVUUklDU19WRVJTSU9OKDIsIDQpOg0KLSAgICAgICAgICAgICAg
IHN0cnVjdHVyZV9zaXplID0gc2l6ZW9mKHN0cnVjdCBncHVfbWV0cmljc192Ml80KTsNCi0gICAg
ICAgICAgICAgICBicmVhazsNCi0gICAgICAgY2FzZSBNRVRSSUNTX1ZFUlNJT04oMywgMCk6DQot
ICAgICAgICAgICAgICAgc3RydWN0dXJlX3NpemUgPSBzaXplb2Yoc3RydWN0IGdwdV9tZXRyaWNz
X3YzXzApOw0KLSAgICAgICAgICAgICAgIGJyZWFrOw0KLSAgICAgICBkZWZhdWx0Og0KLSAgICAg
ICAgICAgICAgIHJldHVybjsNCi0gICAgICAgfQ0KLQ0KLSN1bmRlZiBNRVRSSUNTX1ZFUlNJT04N
Ci0NCi0gICAgICAgbWVtc2V0KGhlYWRlciwgMHhGRiwgc3RydWN0dXJlX3NpemUpOw0KLQ0KLSAg
ICAgICBoZWFkZXItPmZvcm1hdF9yZXZpc2lvbiA9IGZyZXY7DQotICAgICAgIGhlYWRlci0+Y29u
dGVudF9yZXZpc2lvbiA9IGNyZXY7DQotICAgICAgIGhlYWRlci0+c3RydWN0dXJlX3NpemUgPSBz
dHJ1Y3R1cmVfc2l6ZTsNCi0NCi19DQotDQogaW50IHNtdV9jbW5fc2V0X21wMV9zdGF0ZShzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgZW51bSBwcF9t
cDFfc3RhdGUgbXAxX3N0YXRlKQ0KIHsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdV9jbW4uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Nt
bi5oDQppbmRleCBhMDIwMjc3ZGVjM2UuLmNkNzVmZGZkNmI0YSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L3NtdV9jbW4uaA0KQEAgLTQwLDYgKzQwLDE3IEBADQogI2RlZmluZSBTTVVf
SUhfSU5URVJSVVBUX0NPTlRFWFRfSURfRkFOX0FCTk9STUFMICAgICAgICAweDgNCiAjZGVmaW5l
IFNNVV9JSF9JTlRFUlJVUFRfQ09OVEVYVF9JRF9GQU5fUkVDT1ZFUlkgICAgICAgIDB4OQ0KDQor
I2RlZmluZSBzbXVfY21uX2luaXRfc29mdF9ncHVfbWV0cmljcyhwdHIsIGEsIGIpICAgICAgICAg
ICAgICAgICAgICAgICAgICBcDQorICAgICAgIGRvIHsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCisgICAgICAgICAgICAgICB0
eXBlY2hlY2soc3RydWN0IGdwdV9tZXRyaWNzX3YjI2EjI18jI2IsIHR5cGVvZigqKHB0cikpKTsg
XA0KKyAgICAgICAgICAgICAgIHN0cnVjdCBtZXRyaWNzX3RhYmxlX2hlYWRlciAqaGVhZGVyID0g
ICAgICAgICAgICAgICAgICAgICBcDQorICAgICAgICAgICAgICAgICAgICAgICAoc3RydWN0IG1l
dHJpY3NfdGFibGVfaGVhZGVyICopdGFibGU7ICAgICAgICAgICAgIFwNCisgICAgICAgICAgICAg
ICBtZW1zZXQoaGVhZGVyLCAweEZGLCBzaXplb2YoKihwdHIpKSk7ICAgICAgICAgICAgICAgICAg
ICAgXA0KKyAgICAgICAgICAgICAgIGhlYWRlci0+Zm9ybWF0X3JldmlzaW9uID0gYTsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQorICAgICAgICAgICAgICAgaGVhZGVyLT5jb250ZW50
X3JldmlzaW9uID0gYjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCisgICAgICAgICAg
ICAgICBoZWFkZXItPnN0cnVjdHVyZV9zaXplID0gc2l6ZW9mKCoocHRyKSk7ICAgICAgICAgICAg
ICAgICAgXA0KKyAgICAgICB9IHdoaWxlICgwKQ0KKw0KIGV4dGVybiBjb25zdCBpbnQgbGlua19z
cGVlZFtdOw0KDQogLyogSGVscGVyIHRvIENvbnZlcnQgZnJvbSBQQ0lFIEdlbiAxLzIvMy80LzUv
NiB0byAwLjEgR1QvcyBzcGVlZCB1bml0cyAqLyBAQCAtMTI1LDggKzEzNiw2IEBAIGludCBzbXVf
Y21uX2dldF9tZXRyaWNzX3RhYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KDQogaW50IHNt
dV9jbW5fZ2V0X2NvbWJvX3BwdGFibGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpOw0KDQotdm9p
ZCBzbXVfY21uX2luaXRfc29mdF9ncHVfbWV0cmljcyh2b2lkICp0YWJsZSwgdWludDhfdCBmcmV2
LCB1aW50OF90IGNyZXYpOw0KLQ0KIGludCBzbXVfY21uX3NldF9tcDFfc3RhdGUoc3RydWN0IHNt
dV9jb250ZXh0ICpzbXUsDQogICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gcHBfbXAxX3N0
YXRlIG1wMV9zdGF0ZSk7DQoNCi0tDQoyLjI1LjENCg0K

--_000_PH7PR12MB5997A8077DF741BA9F320D2582802PH7PR12MB5997namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"ltr" style=3D"font-family: &quot;Times New Roman&quot;; font-si=
ze: 14.666667px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">#define smu_cmn_init_=
soft_gpu_metrics(ptr, a, b)&nbsp;</span></div>
<div dir=3D"ltr" style=3D"font-family: &quot;Times New Roman&quot;; font-si=
ze: 14.666667px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div dir=3D"ltr" style=3D"font-family: &quot;Times New Roman&quot;; font-si=
ze: 14.666667px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">it is better to use f=
rev/crev to instead of a,b .</span></div>
<div dir=3D"ltr" style=3D"font-family: &quot;Times New Roman&quot;; font-si=
ze: 14.666667px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div dir=3D"ltr" style=3D"font-family: &quot;Times New Roman&quot;; font-si=
ze: 14.666667px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">apart is ok for me.</=
span></div>
<div dir=3D"ltr" style=3D"font-family: &quot;Times New Roman&quot;; font-si=
ze: 14.666667px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div dir=3D"ltr" style=3D"font-family: &quot;Times New Roman&quot;; font-si=
ze: 14.666667px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Reviewed-by: Yang Wan=
g &lt;kevinyang.wang@amd.com&gt;</span></div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"ltr"><br>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div dir=3D"ltr">Best Regards,</div>
<div dir=3D"ltr">Kevin</div>
</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<div id=3D"mail-editor-reference-message-container">
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif;"><b>=B7=A2=BC=FE=C8=CB:</b>&nbsp;Zhang, Hawking &lt;Hawking.Zha=
ng@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b>&nbsp;=D0=C7=C6=DA=B6=FE, =CB=C4=D4=C2 29, =
2025 11:47 =C9=CF=CE=E7<br>
<b>=CA=D5=BC=FE=C8=CB:</b>&nbsp;Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd=
-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b>&nbsp;Deucher, Alexander &lt;Alexander.Deucher@amd.com&=
gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYan=
g.Wang@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b>&nbsp;RE: [PATCH] drm/amd/pm: Use macro to initialize m=
etrics table</span>
<div style=3D"font-family: Calibri, sans-serif;">&nbsp;</div>
</div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<span style=3D"font-family: &quot;Times New Roman&quot;; font-size: 12pt;">=
</span>
<div style=3D"font-family: &quot;Times New Roman&quot;; font-size: 11pt;">[=
AMD Official Use Only - AMD Internal Distribution Only]<br>
<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
Sent: Tuesday, April 29, 2025 11:15<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander &lt;Al=
exander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;; Wang, =
Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
Subject: [PATCH] drm/amd/pm: Use macro to initialize metrics table<br>
<br>
Helps to keep a build time check about usage of right datatype and avoids m=
aintainence as new versions get added.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 67 -------------------------=
-&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 13 ++++-<br>
&nbsp;2 files changed, 11 insertions(+), 69 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c<br>
index 80eb1a03b3ca..7eaf58fd7f9a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
@@ -1051,73 +1051,6 @@ int smu_cmn_get_combo_pptable(struct smu_context *sm=
u)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false);<br>
&nbsp;}<br>
<br>
-void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev=
) -{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct metrics_table_header *header =
=3D (struct metrics_table_header *)table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t structure_size;<br>
-<br>
-#define METRICS_VERSION(a, b)&nbsp; ((a &lt;&lt; 16) | b)<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (METRICS_VERSION(frev, crev)) =
{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(1, 0):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v1_0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(1, 1):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v1_1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(1, 2):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v1_2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(1, 3):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v1_3);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(1, 4):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v1_4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(1, 5):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v1_5);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(1, 6):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v1_6);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(1, 7):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v1_7);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(1, 8):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v1_8);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(2, 0):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v2_0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(2, 1):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v2_1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(2, 2):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v2_2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(2, 3):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v2_3);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(2, 4):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v2_4);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_VERSION(3, 0):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; structure_size =3D sizeof(struct gpu_metrics_v3_0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-#undef METRICS_VERSION<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(header, 0xFF, structure_size);=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; header-&gt;format_revision =3D frev;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; header-&gt;content_revision =3D crev;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; header-&gt;structure_size =3D structu=
re_size;<br>
-<br>
-}<br>
-<br>
&nbsp;int smu_cmn_set_mp1_state(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 enum pp_mp1_state mp1_state)<br>
&nbsp;{<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h<br>
index a020277dec3e..cd75fdfd6b4a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h<br>
@@ -40,6 +40,17 @@<br>
&nbsp;#define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0x8<br>
&nbsp;#define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0x9<br>
<br>
+#define smu_cmn_init_soft_gpu_metrics(ptr, a, b)&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; typecheck(struct gpu_metrics_v##a##_##b, typeof(*(ptr))); \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct metrics_table_header *header =3D&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct metrics_=
table_header *)table;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memset(header, 0xFF, sizeof(*(ptr)));&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; header-&gt;format_revision =3D a;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; header-&gt;content_revision =3D b;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; header-&gt;structure_size =3D sizeof(*(ptr));&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (0)<br>
+<br>
&nbsp;extern const int link_speed[];<br>
<br>
&nbsp;/* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed unit=
s */ @@ -125,8 +136,6 @@ int smu_cmn_get_metrics_table(struct smu_context *=
smu,<br>
<br>
&nbsp;int smu_cmn_get_combo_pptable(struct smu_context *smu);<br>
<br>
-void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev=
);<br>
-<br>
&nbsp;int smu_cmn_set_mp1_state(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 enum pp_mp1_state mp1_state);<br>
<br>
--<br>
2.25.1<br>
<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR12MB5997A8077DF741BA9F320D2582802PH7PR12MB5997namp_--
