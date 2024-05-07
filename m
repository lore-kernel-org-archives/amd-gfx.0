Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74C1C25B10
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 01:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 539EC10FAC4;
	Tue,  7 May 2024 01:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V8iJVejU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C440910FAC4
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 01:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0aTlZsgu+LDxKv4JXnPUKOnojcSe/AUyZjJRQt+w35jqJR1vMFzj17hpPweTHrIYK5kAB2P1UKlTCkeUuJZWKL8A+k862iNq/WDBzJAof1fhc90aSNL36d5vOp1TMQXJBHXKqU77fP8u72UDMBzN0kN7TIeX8nxSHoD7f3rLCLyq8OHrD6HEYWv6EdFyJ2Qaduf+zG+/bK1pFZE9CtzbHtP2Xk8p+07PICcUYGZzChJNH/aF7oLmZ4agpK0+Rbz9kyto1FAh8jfLVfrL14h33lONjdLWCHMfGoQ3z99lACIwa8uId7MSuRBQZB+GQ8K7W8VmiEsKj1PNJibU0pCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVePrIcxfNNHu3/mihhMW/L+eYUFDoaKCL/yQU1jwTI=;
 b=M9jkXIWo0xWATdscXvNtiHmEvJNvG5ZZ4+ZMD+LrUrraIR6WM8LmKy5cGPe7B5o2Oatx9QWEV+TmJ9nd3sWiIS9CZDkIBz8UXTSq9KxcE+svAzc2EwWnNR13Nht0icPwd86+XgL8sX0NR5rhAm3JKds93RjmkhyGXistqCI6F3Hp8p7W2f4tJ8Hpx0PuJnbZ5uIOGoZUgKMJM5mmM/tMEl+IynArdbgGXIjTlhaoLi3Tpnw76rkrMISDR2H98IKQavX7+y2KqkUXy6faAlSwRvZca3yrtV2veqrCEtTY+vVHWS7HEYsp2GsdTvO1y2yFNyge9IGmVQbVMmwFsJVb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVePrIcxfNNHu3/mihhMW/L+eYUFDoaKCL/yQU1jwTI=;
 b=V8iJVejUizs/5mAubY49PtiHvZx9pEsxcjKVqgHb9B9iqlfvB3Y62SMGKN6EtP9SHv5TWSFz2qFLytjnM5De+hqRuFX5KubgMEAihkUzACAK+CWsH6OBlJfMQGRqtBPKEHddVvGAP3POVtwvVfkt2urLAQ7S2rTrpYKtVXer/dA=
Received: from DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) by
 MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 01:36:15 +0000
Received: from DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c]) by DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 01:36:15 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Zhou, Hao (Claire)"
 <Hao.Zhou@amd.com>
Subject: RE: [PATCH] drm/amdgpu: ignoring unsupported ras blocks when MCA bank
 dispatches
Thread-Topic: [PATCH] drm/amdgpu: ignoring unsupported ras blocks when MCA
 bank dispatches
Thread-Index: AQHan4FPKexGlaJg/Ue4F9VG4u5agbGK/sWg
Date: Tue, 7 May 2024 01:36:15 +0000
Message-ID: <DM4PR12MB6012E9C995CC8F7B7F3CC93682E42@DM4PR12MB6012.namprd12.prod.outlook.com>
References: <20240506064723.996050-1-kevinyang.wang@amd.com>
In-Reply-To: <20240506064723.996050-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_|MN6PR12MB8589:EE_
x-ms-office365-filtering-correlation-id: 77e98916-2a3a-42bb-0017-08dc6e3615f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?gb2312?B?VlJCdnV0dmQzTDh2MG1IWm1xTlRuOC95bVdsS1Y5SnM1emFDeGl5QzJyNXNl?=
 =?gb2312?B?aGE1RGpGTFZGU1ZxVUh2SS9GUnhUR2hUdnN1KzAwd2pVQ2owR20wNGM0WXBu?=
 =?gb2312?B?UkRLaDVNYjdjSGd5YWFvb0ZJQUtZeE4wYkdHdUh2M2FBZDhCeXlRT1pKVEo1?=
 =?gb2312?B?OUlXcjI0QVBkWWJXdk9MWTM3R01PYTJDVWYzcmpNeXdJM2lnN1I1ZE9uSnJ1?=
 =?gb2312?B?dEhHSHA1SjA2dFJFTkIzT0VydHIyckRZSlZYVEpLeFQwWEEycjlNRnpSMmJB?=
 =?gb2312?B?Zllzd3pvYUlvQmozV2RvenNGOHNMd2t4Ri85QmJ3eEF1SWJsZUs4bis1bjVU?=
 =?gb2312?B?djZkSlVsMGVNeHhzNzZ1eU52T1NGa3c0TkJXYTdINGIyTWhZbkt0V2o5Nk1Y?=
 =?gb2312?B?WjQ5TUVBM2JwTCszemtxaWxIcHpCTThtdHAxRXZHTit1YjJJdEVHU2VHemlC?=
 =?gb2312?B?enc4SEUvMVRtTjJ5cGRFZitod0Fnb3ZGUjE5bTlUMTc1UDRCOXUzOFp1OUs5?=
 =?gb2312?B?cEJvVUQ5Njc1WFZpY1pVbHJSa29PNVY5cUtTZFdXV3FtSXplekY1cktrNVdm?=
 =?gb2312?B?WElqZ0t5MDlwY3lQZzFrWFFTM1ZtU2NuSnR6OTd3ZDh4dzdza3I5eDdCSUpQ?=
 =?gb2312?B?OUpGSTlIdFMyWUh1cElNNnA3YmJERXVzOVlEdUkyK29hRUZJT3BiUTJLQU5U?=
 =?gb2312?B?OUFCOC9oU3ZHdSt0dXU1Q0NCQWlhZUUwbjhyeUh6WEt6cHRzWU5lVzhDOEtS?=
 =?gb2312?B?cUMvWVRBb2FFeklwdlN6YmZZN0xjRDJjMmZoTjhyYkNMaUgvTUdZTkEwajFF?=
 =?gb2312?B?ODdDNWVsTTNYYWpLSEVncVBBQngvSGNhaCsxUmwyM0pnWDFZeWtMejNPbmVP?=
 =?gb2312?B?azVYUlJlTC9yUS9YZHFRWWxITFkzVHgrYm1tS3dpNnJXb2Y2WENxTk1xU1Bi?=
 =?gb2312?B?SFEvd3U0bzNsVVVLZ2JBV3c5ckp2OWlOSjVVUjBnL0R3NUlidEY4a2UzclZ4?=
 =?gb2312?B?OU4vekloUHp3ZHozT1c1UkkyOTBlaXpsM1Ivb1lPQXFNSlErWUpONjl3QXkr?=
 =?gb2312?B?RmNoNDU0N05Sc25sQ1BKWU9HOW05clR5djFkQkk4dHZNUmVmRU5oa0RDaFZE?=
 =?gb2312?B?RW4yUmpheUZ1bFpsaGEyMlVxMHBPNk9BTFovN2YrT3gyOWdFMVZtbXBJYnNJ?=
 =?gb2312?B?enJZZ0s4bmlmVUp1Um5GM0EvVDBiTGlwRjQ3S2dhTS9QbXFsKzlKc1ZJaVlR?=
 =?gb2312?B?K2RUWDNWTzFKVTJzWUZtK2pGOGFuRWFydkZuNVpDM25hekd1QnhpVG5sZjVX?=
 =?gb2312?B?bUc3S1QwVGk1K0tudTNnL0tFd1VMdVVFQmxER2NXVlhyWXJpZUtvaTJnVzVv?=
 =?gb2312?B?STFud3BIZjltdzhycUdVc2pZY2l3VlA4TkVMVDNqUjRiaFJNVHlVaEc0U1Ix?=
 =?gb2312?B?TGtmVEVYeElqenRNaU1aNkdxUjI1V3RuaFB0azBUcGlhVjRQQ2p1TURONnZ2?=
 =?gb2312?B?Nm1QQnBjSldHeVN2TTV1UG43TnBFYUZEMmxCYkFzbXFsSFJwYWtUTFd3NDNW?=
 =?gb2312?B?NmxYVGZGWmo1SW5EVTIyRC8weWFsZWJtaTRvRml3TkQxQWNBaDh1Y3JubXBT?=
 =?gb2312?B?N0UxNEpSTlRvQ0hmUmMyemlqcnpmSXNib1I4NUdxN3NqbEFad21PZTVZci9n?=
 =?gb2312?B?Nm5WQVE4aTVWZGg2YzFNUUVTSUNxdE5zS2NpOXRxT2pOYmZDcVFvL2Fsbk9w?=
 =?gb2312?B?MHFMODU1WEVZTEY5eG9tRElJaGlWbDdiMG8ydHFaUFNtS1NmcVN4YVkxbWVT?=
 =?gb2312?B?ZUxKdjRYYWhQUEtLOTEyZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DM4PR12MB6012.namprd12.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?S3cvOGVpQ3dHWkhaNDZVaWZaMkJ1WTV4dGpNcEJ2dFFIaE9OZVVUaktGV29v?=
 =?gb2312?B?T1FnQlNRSS9oSXYvSWxPYS9GSGp6eHZGVlJKc1JEaVNFaDRMR2wvTkVac3ZU?=
 =?gb2312?B?YnU2QldqNjZVLzNSM1JMaWlRU1ZIbkYwRFFrcWZDMnQwL1E0SHpDcmZoTlZE?=
 =?gb2312?B?WkJIUGhmdWRiQ1l4RFlXWkJqaFpoRlRFdjA4TlZtM0d5cEZnWDlnZndsUFlk?=
 =?gb2312?B?V01GbDErVjB3bE5xaGd6di9BOGZMaCs0bkFsdEZjNEFXNVZ4QVJBOXJ5Mlp4?=
 =?gb2312?B?N1VJajROTitaMHJPR0x2eU5SN0VHdUdZVUdaTmpUelQvMTUxelBLSG9aN0wv?=
 =?gb2312?B?RFZFdTNkQmh2TFd3NGxwa2tncytYd0hVTjVRTVgwU1NlclNjZlVDLzFyckJ1?=
 =?gb2312?B?dGF5YzE5MjJ2eTA3SmtCYnc5b0hFWnNTZXhPZ1JjUmpENm02ZElrdDhNaExW?=
 =?gb2312?B?M1FveWxEeUtxTzBUNHR3UUd5YTF6UHZXQ29FM2FDYXVpTlozNDdxREZlMStK?=
 =?gb2312?B?UGVhS0tzSGRXL012NFQ1TDB3Y1dPUUpLUERvS1hpZFRRellSS3I3ai84M3lR?=
 =?gb2312?B?L0RFWVFLdHRUOW4vbEhCZU9sRDBwWEFtYTFidDgyc0JFclVvNXBBWjF4RjFO?=
 =?gb2312?B?N0dnYUwweXZnNFpNSmxvTUdqNEo5MDZMcDhlUkM4aWVMSW1mRDdVOGY0MTlh?=
 =?gb2312?B?cGN1Z1FiMGFlNEI5ZlowcFE0dUcreWpuK2U4cVY0MGZ5RmRQM3ZjM0dyT1da?=
 =?gb2312?B?aThsNGRKUWl3bWI5ZVYzZUxMTjA4dXFaQ1BkRkxEbGRaZVNMazkxaXRKc2N6?=
 =?gb2312?B?c0xCWnVnMWRVV3JuZklzaUxJY3hnSEg4dVA1ZitYakpVOFNTbU1IczJhcDRt?=
 =?gb2312?B?WTAwczhNZ0RRQjM0OTI4WFJ2WUJ2ejdWWno0UmFyOCtMcEpBRUhBdlFHK3ZW?=
 =?gb2312?B?SnhReURRbGEyMnhVNGNleWM4OWZ4ZkE0QlRZaWxtL29uYmp1d3NWdjY5eUJk?=
 =?gb2312?B?M0dBWFQ1cXFBcGxBY1duTWZzTmtZSTYzbDdNRi92am5aUW5YSEFhVTMwNm0y?=
 =?gb2312?B?cG9HMWY2Z2VabjlJbks4VlhJTlNzQnR4eFRCUGtvNERVRnZFSW1sbnVFa3FS?=
 =?gb2312?B?ZVdjRmJjV0J3T2tOWXBzRnJrRDJZSkFLQzY5Wi8yMHNJWkl5TmV6eGEyYnJz?=
 =?gb2312?B?dm5FWlhUQnhGaGduSnZlY3dBSHhtTTNDeFJ1ZmpaWjBTaUR1dkVyVHU5Qkk2?=
 =?gb2312?B?cUFUOVp5TU0xNEJEY3lJZGZKckNPci9ISVYxOU5HY0EzRlJVNFdSRm5LTEp6?=
 =?gb2312?B?dGlKT0dkUFJnL29sdTl0RkpqeVd5bStYRDk5aGdFYUxEQTlQQVhDMnZKT2Zh?=
 =?gb2312?B?S1ovYTFDZDlmekZJZXZMNHAwVjEzOE5KT2g5UTIzd25ycXQ0N2dVaUR4YnRZ?=
 =?gb2312?B?VEZ5Q2d3QWpvOGF4TGVmQ25UZGdXTGhIS3V0TnMrbWtPZ2ZZRlVKdU9SVjlX?=
 =?gb2312?B?YStPSDNpZHdrMzJHa2pWZGNscjFUdktkZDFvaWFuMDk2YUMxNUdoa2ZhR2pa?=
 =?gb2312?B?NHFSQnlhR3dNdXZWeHdaTW5wVU42a1pFYWtnTTlYOTlPbkN3VEovS2h3NG1D?=
 =?gb2312?B?bnJ0WjBjV2lYcXVFWC94Mm1yY2hRaXVtU1c1bThGb0xFVXg5ZlM1MTl1ZStC?=
 =?gb2312?B?QVpOWWJpV3p3TjVqOHA5Q3FHak0wK2tJazZXZk9OdTNqTWM1TElyNVJTMU1s?=
 =?gb2312?B?ZC9hblN0VGUrYVViSit0Y2k3VW5oVEJFaHQzdUcxaVpUWDkxd1NGN1RGL0hq?=
 =?gb2312?B?SHZ6MkdrUnBJT1lqbzFyY1hoUmxGUVVCQ0lleUlJbzllN1JRUzhWOXNsblNz?=
 =?gb2312?B?SFVNLzlUVGFFM201UHJ4R2laaWNablVMWis4ZEJuaU5selBaMzJLVkl6Q1NV?=
 =?gb2312?B?dTFQVlVscUxLbGMrL3E5MHhVL1o0NzRkWk9WMEFhbjhoT0VWQWUyQjFZUEtW?=
 =?gb2312?B?Z3JicDlaZFpHbHdSNFhtb0dFczAyVTdLSEFJMy93NUhud2NDa21tTkZ6MFAv?=
 =?gb2312?B?NjZmR09KeWVXWndzUGtRVDlaZS9hWUE2S3dvWS9KMTJ4bTRwOElERVhaNldE?=
 =?gb2312?Q?8UWM=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e98916-2a3a-42bb-0017-08dc6e3615f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 01:36:15.5126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0E7QHBVIvfK7kveSVhGQViM+1t6OcGekhX22t4hWqtbianI8kTGVE17STtnlt3j/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589
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

UGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zz4gT24gQmVoYWxmIE9mIFlhbmcgV2FuZw0KU2VudDogMjAyNMTqNdTCNsjVIDE0OjQ3DQpUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBMaSwgQ2Fu
ZGljZSA8Q2FuZGljZS5MaUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBp
Z25vcmluZyB1bnN1cHBvcnRlZCByYXMgYmxvY2tzIHdoZW4gTUNBIGJhbmsgZGlzcGF0Y2hlcw0K
DQpUaGlzIHBhdGNoIGlzIHVzZWQgdG8gc29sdmUgdGhlIHByb2JsZW0gb2YgaW5jb3JyZWN0IHBh
cnNpbmcgb2YgZXJyb3IgY291bnRzLg0KV2hlbiB0aGUgVUUgdHJpZ2dlciBncHUgaXMgcmVzZXQs
IHRoZSBkcml2ZXIgd2lsbCBhdHRlbXB0IHRvIHBhcnNlIGFsbCBwb3NzaWJsZSByYXMgYmxvY2tz
Lg0KRm9yIHJhcyBibG9ja3MgdGhhdCBhcmUgbm90IHN1cHBvcnRlZCBieSB0aGUgY3VycmVudCBB
U0lDLCB0aGUgZHJpdmVyIHNob3VsZCBpZ25vcmUgdGhpcyBlcnJvci4NCg0KU2lnbmVkLW9mZi1i
eTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21jYS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X21jYS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X21jYS5jDQppbmRleCBhNzczNmFhNThiYTkuLjBjOWEyNzFjNTAyOCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tY2EuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21jYS5jDQpAQCAtNDE1LDcgKzQxNSw3IEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X21jYV9kaXNwYXRjaF9tY2Ffc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LCBlbnVtIGFtZGdwdV9yDQogDQogCQljb3VudCA9IDA7DQogCQlyZXQgPSBhbWRncHVfbWNh
X3NtdV9wYXJzZV9tY2FfZXJyb3JfY291bnQoYWRldiwgYmxrLCB0eXBlLCBlbnRyeSwgJmNvdW50
KTsNCi0JCWlmIChyZXQpDQorCQlpZiAocmV0ICYmIHJldCAhPSAtRU9QTk9UU1VQUCkNCiAJCQly
ZXR1cm4gcmV0Ow0KIA0KIAkJaWYgKCFjb3VudCkNCi0tIA0KMi4zNC4xDQoNCg==
