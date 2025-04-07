Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5BAC36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 15:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D0B910E3DE;
	Mon,  7 Apr 2025 15:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ApYbNjW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF78D10E3DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 15:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZMr+sPnv1w05JmjePWjk0fUpVVijQLSSbK9NDJ5laSWR1RZE5ZTlX1CDRDP/ZOH01nw9DUUDDMZmTrIHuzzxfoYE4P8VfH9awzk7cfGMBxtXiRrErawuYokwnVYv4Ikx2r+I7oC3x48wXFSWnTe8GHtxy8vKIq61ATraH76hxIZiuicWbK8ljj7qCC0NFFFsG6Fe8jn2lvaT3GtGHcf+EqxQTP2L5CdZP64CFBbX9jzv7y426sEpbXeGkKI0acK6EW5CGqzqAKBDwCpc2ubSB85EBg0AZGepAoQ/opZrfiwuJpZBSWRR2ebVYHA+4YOortYVnXmi6Gv5wE9f1n9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALdSEsOt+QIRpTtuHEOsEtHDB9x1CSEzzLQIPGxHJlA=;
 b=JQ6RI9QhwQVg1Oz9xVjeIiLWfWgPgAnBA5AYaNo+yb/VSM4TPdgpXly6aeX7h3NBBft/APZ8MSqmWBCX9F3ThXLZA3zqhOM2KAaVeMviz2vw6sASkD1Ws2Kbv0PQycrxatV1OeM9uYYjd3QLjj7wdMytk4y/8XLlb9jH/ZOl+L+6VvE90dXeKcKNECHezK7Iducx2ICVLcvlqLEsCoNwGXrSpKHNFHsceFCqe6ZhBZKWVmFyffOqYmUJH9fmaBA1Cfg/0eMAcjOppzfl0NHjnxNU5yGmyyBUlYhv3LIvd2LhnYqmk2gubHwv1P3UaBEToNJPjqn9Jqwotg+wZPXZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALdSEsOt+QIRpTtuHEOsEtHDB9x1CSEzzLQIPGxHJlA=;
 b=5ApYbNjWagzUal/IVgTKuVi+b5KLse32ryiW4pIYzzAURrZqwxP2aZ4HO448nI8wZTzDPJgTcacBwhJEhTygTxYWnKQ5yQicNMHrn571AKJm2aLhgXY4rO2Mc0+ir8HT/BYCHJr0CmQasWIo7U4NfYToHgTEJlPEEK4M4lra0Uo=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 15:14:07 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 15:14:06 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] Documentation: update KIQ documentation
Thread-Topic: [PATCH 1/2] Documentation: update KIQ documentation
Thread-Index: AQHbnne/qjxRvdOvt0O1pxJ0YX5JF7OYUtaAgAAPbbA=
Date: Mon, 7 Apr 2025 15:14:06 +0000
Message-ID: <CH0PR12MB53725AF00D212EB5F6445F54F4AA2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250326175122.1209403-1-alexander.deucher@amd.com>
 <CADnq5_MsT6FD0g00H=DxuNj6B83nW8D47Y0k73b9Wavf0JXJkQ@mail.gmail.com>
In-Reply-To: <CADnq5_MsT6FD0g00H=DxuNj6B83nW8D47Y0k73b9Wavf0JXJkQ@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bb2db316-15be-4228-913c-9215f4d930ef;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-07T15:13:20Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SN7PR12MB7978:EE_
x-ms-office365-filtering-correlation-id: fd469b9c-1562-46fc-0b8f-08dd75e6d727
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MWJWWHIxNkttNjFVMWY4U2luWVdXQ2laRXBUV20wdDYyNTl5Q2NVR1lJUzF4?=
 =?utf-8?B?dml0NWdVazQyS0hUbnhoUXVVVThUZ2pHT2dHL2FVanBhN2JVWm93NndPQ0RT?=
 =?utf-8?B?TDNXWTRENkl1dXFmWUNwdVl5QS9NdUpDNjBUMnFJUG1RRnVNaUtCNnFwMEFN?=
 =?utf-8?B?dzN2NERPajY3ajFiYjVKS1h6WkZ3ZHYyWmpLVFpoV3pHTWVVNUlyTTRaSjFC?=
 =?utf-8?B?VkQzejNjZXJRY3BadVgxU0JmV1ZQd1RNVWFrMXhFcVBrVzJGVU44U3ZnZmpP?=
 =?utf-8?B?ZDFiSmI4NC9LcTVuZWx6b0xJVDZoaVVMaEJ0QmFFSXk5RGcxT3BVVE1pS3lO?=
 =?utf-8?B?em5GSVNPOE5temgrTk5TYlphZFFTRHZVdG5RYmpnZ0xMV0NQR1FFVTczdm80?=
 =?utf-8?B?dDZ6SXdwamJFWHArcWc4QXE1Ly90TzcxTzBodGMvOTM0bWxmRmswMFlZbU94?=
 =?utf-8?B?alJ2c214ZTRUelRjcFBsUFNzRmhXNWE4cmhjREtuaHU1ZUY2eDhvYWJYT0ZL?=
 =?utf-8?B?UUozWEd0Wm1FMnhoUHhzdmVCbU9xb1A2UEZTQU9IY0RJSEduZlRpc2JFYjZp?=
 =?utf-8?B?QkVhQm81a3VTNEFFQW1nK3pIQXFiRXdSa3dGQ3dvMjdaSUhaT1l1YWt2ejZG?=
 =?utf-8?B?cVNQYkZuck5hVVpwcU8rbnd2b3JqZFl2ZEY3aFpEcXFZTEdaZ1J3RFA0NjJv?=
 =?utf-8?B?WWNVbXE2ZzZ3NXA3RlZhbThmbExPT0VROFI5Q25XVmkrMEsyTk1oaDlyNE1j?=
 =?utf-8?B?MWJFb2JmeXVmRnBXRWN0Y0ZhcThxUkhoZ2dKVVpZazdqUE94SmF3Wk5WczRV?=
 =?utf-8?B?N2xuUkVJSmxwTkdDWEJ3OTNuMTdLMUpJODNNenc5bjN0M0VJSE5mY1o2bUZB?=
 =?utf-8?B?b1E1em9Zam1oRmlhU2FZU2hiMHdzeGMrK0RER3ZwY0JqZkIvZ3FIRHZnNi9q?=
 =?utf-8?B?dVdQamNhYlMwUVZEaHFueVMwclljeEVkVGNoZ2hHeTJiL2wwL1RacXh5aHpX?=
 =?utf-8?B?K1lVUmdXQUNuMVczS0kzcjZjS2FSWnhKR1VTb016NTgwUmpneDFyZ0dvSWlX?=
 =?utf-8?B?Ky9wbTJNTWd0MzRCaTh2WWpNNHBoblpINjFYaUlrL05qelVoMlVLNTJZeVNz?=
 =?utf-8?B?bmtLRXlPdldFam0zNDhvelJFOUlMb2VlV1ZnbUhKOGpJL2ZlMFB0NUtsRkVi?=
 =?utf-8?B?aUk4YWdSdGRnV0wyR3VDbVpRSlVKb3JJZnpYa3d0ZThWM1R3V21pTG5UWXow?=
 =?utf-8?B?K0l6RjJoUU95Q1hNckpLQTYxSGppUkxxU1N1U3FtTDc1TTBxazVwRnRKbXRw?=
 =?utf-8?B?WERTSzlKSS84M0Q3NjFEWlJwSEpRMGQxUkN2Zzg1cnZGaGdvQUVkSnZNUU9H?=
 =?utf-8?B?S29BSHYxMlVkTFBRbXA1YlVLRUpmMUpsR1ZzUjVhMS92WjJLSVB5MFF4aGEw?=
 =?utf-8?B?M1ZVNDVPVXV4VGl2dlplZENQa1dpUVV0S0EralFKTnJpa3cxV3pEanJZeXBq?=
 =?utf-8?B?WllwZmN1ZGJaRGw4WmhmZDdyMlVxcjdncmFpWVBNQUhpTElMQXdNTVVGeU1s?=
 =?utf-8?B?Ni9kZVV5YjFjUTZ5c1BtSG9KcGlnNFhJWGRhalp0K21aNWdKSnVUMWE3a3Ry?=
 =?utf-8?B?cmE0WE9BcjlrVkNiZW55Q2grZC9vUytWTTZjTXduYUVBUTNvdG5RWUxpMTJt?=
 =?utf-8?B?aEZkR05HMG1OUW5NSWszZDdCRGFCdk9RMkVOc0dTOSsxdklQZFV1VVUxd1Er?=
 =?utf-8?B?eXdjSEVkNjAwRVovWkx5WnF2ME55bnVxRHpaZjcrQjRnNlgySVpzTG8ycEs1?=
 =?utf-8?B?MDNwMDB5VEFhbXFLTlg5U05ZY2xoYk9IcnM0NUJ0dkZlT2FONUErc0lHWWJI?=
 =?utf-8?B?Z2E0YXJKOE80RXB5UXAvY3YyWU5JRitZVTJzdWtGc0RJNHN0UUNFTkl1T1VK?=
 =?utf-8?Q?ti3K2FwHbdc6akz9r/4ckc/AZz91JVYa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGpGR2dYTlM3NUt5ekxFSVJvNkN6WExEYmpkR1UwdUdsOUdMbVdmTFZwVjQ4?=
 =?utf-8?B?R1ZGU1NMYUxxUWNzQXhZYmlhdzAzRzJ1WHVTa2tCSllaV2NsTzFTekJZak94?=
 =?utf-8?B?dkVETDgrbUpEZEVwNG5Mb0hwNjdTYWRwMmMzV0dZKzdmZ0ZVdVJNREhZc1Nx?=
 =?utf-8?B?aFpiS2VoMWVPVWtrN3pmQzlGZGt0ZnVtWGFuY3hNK2ZTVnU0WG8wRmlMQ3Bv?=
 =?utf-8?B?Mll5T09sR0Q3SEZsdGczMjR6eEdLQTYzVHRSb3Bza0lDbUhtZ3dVVVFhLzcr?=
 =?utf-8?B?blRzMHpCRjBaMHUwMStHcEwrN3E5cEdFcnJscFI1MjFudFJ4TlRCQ2s1QU4x?=
 =?utf-8?B?cWwxZkQvVDNCWlVBN2YxYnFoRkx6Q2NKR1ZjSVBobCtPYWlpQXpza3dWTTRB?=
 =?utf-8?B?dzd6bGRWMjFNY09ML3ZqZFc5dkVtZVhGWDJZd2llV2VrYTZUM2FHSDIyNlN5?=
 =?utf-8?B?VWNmUzRQTm0yV1pFS0R1MFJyK2x2Y1IvRUxWYU1VSFBEWTE4eHlMWUJXREJs?=
 =?utf-8?B?NHhyeXRKdklVbmxrTXRtT0cwOUVIZUJkWHBxdHd1Nyt2UXFNSlBjRC9QcGFr?=
 =?utf-8?B?QUxsNW9qektReGVhSlNDbVdJREVaTXpwQ3lWNjFpYmNoc3FLNnlsRk5NRFFq?=
 =?utf-8?B?MzM4WFZPdUx1ZjFBenp6TEdGaE00NTIyblZrT2lCVVdoVEdDbEQzVjBwTGlh?=
 =?utf-8?B?V2l3OVpUYVZTNHYrRUNLZjU0ck1RRnlrMHFCWUNTdHhjWGMvK3lHT081SG9r?=
 =?utf-8?B?T1I5aHJHcHRQK0o1YTduMVZYb3NNL1M5dTBMRHZ1QTBkREJUSi9Gd3VsckRV?=
 =?utf-8?B?cVBWM3Rsa0FHdHY5RnBNNlNlVjRiU3BYblB2Vlc2WkhvbDNSSWQ5T3B3ZW93?=
 =?utf-8?B?TDhOT0JVUHJOaHRIYzR1TUJ3dGxabmRPTUpNWkVPTnE5QXBidjFxNVRTZndX?=
 =?utf-8?B?MjNTSDVZTVdiSDRWSGN2NDcvaTJLd3d5b0FFaHY1ano3N1Z1ZmJtY3V1Zmpi?=
 =?utf-8?B?L1ptNlkvNWV5ZFVvMkQ5S3VuR3BvaUJIUUxYaERSLzZ1bUZPV2hCMER3Ni81?=
 =?utf-8?B?bEJyR3NYL0JwSm1CWFhGcGpFNXhsaXhmSllPbEc5L1d2RjF3SnZheTVmVFgx?=
 =?utf-8?B?T3JXRDg4RXNNMnpoV1NuQitlUndPRDlyZ3FYZG1FSXBhNSs5cEtJbXRQSTlv?=
 =?utf-8?B?ek1ycS94UXpmQ00wVjJ5ZnFBSFZYMFY5eFFGRVBiK0Q0N1ZENmNuTXgxRmxl?=
 =?utf-8?B?ZWx3aURGSThkRmdXeU5vbXFveWd4L2VLWmlOdnRhR1Zrb3NaL3B6eWFFSnlB?=
 =?utf-8?B?RkhVai9lM1pheStTaU9hUVZITzVFUjhQN0xsY3pWQVp0SnpYblFjSmY4cGY2?=
 =?utf-8?B?ZmtiK1A1RExyS2lmZWFoeWZXVHBMd0E5d3ovWlNoaUtDODJ5elhmY2lhZ0Z0?=
 =?utf-8?B?NHQ0STBLWk5JQnJUR0VOM0dzK2Q3Q25xblNoS0RjM2g0Y3dUaWVPVXBzMWRC?=
 =?utf-8?B?a2pCbzFReEc5dWxSdU5mTkNYN1VEWGFaSzN4a1gwaURoVnJabS9HZ2FUcmRZ?=
 =?utf-8?B?a3lBRmJWWEduTEV6bmRlWkRqOERWZGk1d3NOcmtUaW50TWZid3pNSFJZUkJy?=
 =?utf-8?B?bEoyMllTdC9RaHZ4UWZkSGgwVjFoK3pDcEx0SXYwaGR1K2dsaW5oRWhHR0pu?=
 =?utf-8?B?clJlb293N3NUcERLaTJWcVA1cjdQWFBtYytGTVlSZUpBNG9RUUdYbWVOaE5E?=
 =?utf-8?B?S3FBbVVETVIvWmFaMDJvdUYxSWQ0NDh1MU5sN3hrRFpUaVZwL3FlRUIxaFo2?=
 =?utf-8?B?NGJKbEMwT0Yva2YyeXNYaVltT0doRlA2RXovakZLQlFBUElQZUcxMjJrSmgy?=
 =?utf-8?B?bWI4cFpFeWlYZVRkZUV5Wm9ldDRtTGVLdzk0V2RvbEhFbWIxQ0JPSEhaUWJ3?=
 =?utf-8?B?TXMrN3JFdE9saE9nZ0Y2Vnhmc0R1bDVyR25nQ2Zldkp2d01LVDZ1VGFIOTJo?=
 =?utf-8?B?MXp3QThRM1o1bVgrSEd5bUczR3hHS0NFNDFwRG5XNjBoKzlwN1VBYThicU1z?=
 =?utf-8?B?R0FudG0vR05CeXZPVlNuRXlqa0ZEcy9tWmhFaFk2UFZVS2dzWVhoZzlHVmFl?=
 =?utf-8?Q?odv8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd469b9c-1562-46fc-0b8f-08dd75e6d727
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 15:14:06.8827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKMcEeQn06cdPaJQ/EHpiFYq5umbxlhbFucLJs0qHklRXdNZcYzbFIYZGrrdPwGGuzaRpkiYx/oxqNzXFFwpag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
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
Cg0KUmV2aWV3ZWQtYnkgOiBzaGFveXVuLmxpdSA8U2hhb3l1bi5saXVAYW1kLmNvbT4NCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4IERldWNoZXINClNlbnQ6IE1v
bmRheSwgQXByaWwgNywgMjAyNSAxMDoxOCBBTQ0KVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIERvY3VtZW50YXRpb246IHVwZGF0ZSBLSVEgZG9j
dW1lbnRhdGlvbg0KDQpQaW5nIG9uIHRoaXMgc2VyaWVzPw0KDQoNCkFsZXgNCg0KT24gV2VkLCBN
YXIgMjYsIDIwMjUgYXQgMTo1MuKAr1BNIEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4gd3JvdGU6DQo+DQo+IEtJUSBpcyByZXBsYWNlZCB3aXRoIE1FUyBvbiBHRlggMTEg
YW5kIG5ld2VyLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9ncHUvYW1kZ3B1L2RyaXZl
ci1jb3JlLnJzdCB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2dwdS9hbWRncHUv
ZHJpdmVyLWNvcmUucnN0IGIvRG9jdW1lbnRhdGlvbi9ncHUvYW1kZ3B1L2RyaXZlci1jb3JlLnJz
dA0KPiBpbmRleCA3ZTNmNWQxZTlhYWY0Li44MTI1NjMxOGU5M2NmIDEwMDY0NA0KPiAtLS0gYS9E
b2N1bWVudGF0aW9uL2dwdS9hbWRncHUvZHJpdmVyLWNvcmUucnN0DQo+ICsrKyBiL0RvY3VtZW50
YXRpb24vZ3B1L2FtZGdwdS9kcml2ZXItY29yZS5yc3QNCj4gQEAgLTE0MCw3ICsxNDAsOCBAQCBT
b21lIHVzZWZ1bCBjb25zdHJ1Y3RzOg0KPiAgS0lRIChLZXJuZWwgSW50ZXJmYWNlIFF1ZXVlKQ0K
PiAgICAgIFRoaXMgaXMgYSBjb250cm9sIHF1ZXVlIHVzZWQgYnkgdGhlIGtlcm5lbCBkcml2ZXIg
dG8gbWFuYWdlIG90aGVyIGdmeA0KPiAgICAgIGFuZCBjb21wdXRlIHF1ZXVlcyBvbiB0aGUgR0ZY
L2NvbXB1dGUgZW5naW5lLiAgWW91IGNhbiB1c2UgaXQgdG8NCj4gLSAgICBtYXAvdW5tYXAgYWRk
aXRpb25hbCBxdWV1ZXMsIGV0Yy4NCj4gKyAgICBtYXAvdW5tYXAgYWRkaXRpb25hbCBxdWV1ZXMs
IGV0Yy4gIFRoaXMgaXMgcmVwbGFjZWQgYnkgTUVTIG9uDQo+ICsgICAgR0ZYIDExIGFuZCBuZXdl
ciBoYXJkd2FyZS4NCj4NCj4gIElCIChJbmRpcmVjdCBCdWZmZXIpDQo+ICAgICAgQSBjb21tYW5k
IGJ1ZmZlciBmb3IgYSBwYXJ0aWN1bGFyIGVuZ2luZS4gIFJhdGhlciB0aGFuIHdyaXRpbmcNCj4g
LS0NCj4gMi40OS4wDQo+DQo=
