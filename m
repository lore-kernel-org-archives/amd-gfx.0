Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1F6E68949
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 03:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB0A10E82D;
	Thu, 31 Oct 2024 03:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dYusPa1v";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 902B210E82D
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 03:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLHOLeMDAg1YCEuFrwzzoBb2b9ZEdFi4xf5QR7+4zT7rx+KdjB/c5EYWalBpAfv/9s6yO0O0lD1m7Vy55AyLzcGZTsfwBIryvAyATHKj9TSUUi1RJnoebPyvtDADRaPdykQv+eXNZY42x07QRPH7FNPI+fqtR0KMZ/TVEF+CGDt0D5BPF8tV9vJa1BIYNvlTDzx0gRYvbYiiOaa+NtzLtozC7TNO/JXYGoZZaQPWYDGBAfr28P0/4LsrUtH+GKHYWTwHvOvOkapoUHN6ISNVRvCMGdlOnGApmPjl238YZL5pZXhi1l6spb3XCaiIN9nj3qWV+Z3GlsoTtlG1rdYwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0e5c7QXv74nqdgRFEIW634qCq75synHzx8wUclJTIc=;
 b=SHCRQR9KcLjiFsV+8JxkKm90XrL3eGSfza17LZ1wymTdsDrNLNTOVH6ndCq6JhHmfFeGJe9Jn1FiqhfRzMVvzdG2FJjpZekKfAKTbvaOseEJkJUXWS91uNPvgKI7L1qmVI7hyG2Qz+wH50TZw/KTN3LPmnekmvCmtHCw/RtfmL8V5GD1/PachFQDf3SJWaYk9GHgxJgS8Z9biue6DR5zgZRj7WDzuMemzaf7FiB3MCd3hz7+DRB7PxPYHDg/XTkDZVltbxApFkS9mDhUK2fhf3cuAxUTwHQV7nOrlFFzXBDIITYdlOOiZ1tTobhR3K86KSdiz5Wfql0QTK8YIsB7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0e5c7QXv74nqdgRFEIW634qCq75synHzx8wUclJTIc=;
 b=dYusPa1vSzmRyepZTQ+mICaxwbkykP9wvmXLMQm6EHTa24UaJfkhyjXb5v8/bjkkGjX89kzmq2EI8MP3ChyLRE7IobCxEPnvCv8qoem0pEqmwk1ZmV1Bp1Kg/j61mW0M/4IEfIKMSOkSjNUsggwETzyiOOw2CRk+hXRKZnvLTjM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 03:31:34 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 03:31:33 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: Adjust debugfs register access permissions
Thread-Topic: [PATCH 1/3] drm/amdgpu: Adjust debugfs register access
 permissions
Thread-Index: AQHbJY8a9hiRk1N62ESoyaJyX7V45rKcRDQAgAM68oCAAK1skIAACe8AgAAIs1A=
Date: Thu, 31 Oct 2024 03:31:33 +0000
Message-ID: <PH7PR12MB5997936FC158187C39EC80AE82552@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241023210342.685808-1-alexander.deucher@amd.com>
 <CADnq5_M3ar8qGBFVF5p7YUbVsjZvzCdkDcJ-GM7J+T15vfJOhQ@mail.gmail.com>
 <CADnq5_OAwioJzxgonFEPNCHSWNOvmCowh=_OCQ-jcowP-Bcomw@mail.gmail.com>
 <PH7PR12MB599777B2FBF5C082AF2CC2D282552@PH7PR12MB5997.namprd12.prod.outlook.com>
 <CADnq5_OMxsiJR9LGNJE-2pvE1SoMtMJXJu1BxmYZh1qRf+1Bwg@mail.gmail.com>
In-Reply-To: <CADnq5_OMxsiJR9LGNJE-2pvE1SoMtMJXJu1BxmYZh1qRf+1Bwg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4db79888-df45-40be-a1d5-5470ba56e6a3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-31T03:29:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH3PR12MB8911:EE_
x-ms-office365-filtering-correlation-id: e0de3383-edc3-4260-6acf-08dcf95c84b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UVJNSTI0a1A3WjVzTzlQY2ZXbUNFSjZBZ3pwc0FSRndhTU1BQ2Q0TDVvbWdr?=
 =?utf-8?B?SGtCQ1lJL20vRHJTS0dnVmJQVTJvZ1pEVDBFS3dEbllGa004blZMdm5sd0tP?=
 =?utf-8?B?bTBsKzNPWGVOd1NJVFFKeERwUXhEV1lKSi9HSjhlQXcrMTN5QTVoSEozUmI1?=
 =?utf-8?B?eVlldzdiVmF1TVdObldZU0hSTjVncDM5VXFCZ2YxYk9NRmtlVThkRUM5eVcw?=
 =?utf-8?B?bkorY21DVTBYT3NHbHkzOU9aTCtsc2NBam5hLy9CNmV2VjFEUXVNYnFocUJ6?=
 =?utf-8?B?UmFJYXBBY0xjS0szUnRYTkI4UmYwTWEwMnVyL3VMY1NNdVNJSnFiN3hPN0xk?=
 =?utf-8?B?QktEckEwT0xYbmxUVENMNUUrZ3VhdGY3cEZjMWZoM1h1N01tTnVseHFhOEQ3?=
 =?utf-8?B?NDdjUGN4ai91bHc3aXo3Rk56bmE1VzllZEZZaGVLNVhxZ0daUzJQcy80cnhZ?=
 =?utf-8?B?RE83VzBhWWE5NlVHOGRMeVZ6bTUyOWZZclNHWlVTcTZ5MitoZFZPQUtOWjRJ?=
 =?utf-8?B?NGtnTlNZZFo5MTB6bXprZFlxR201clhQWkF5NjhHcEZqN3E2TVJHLzhtQW44?=
 =?utf-8?B?b2VDWDd5c0E2TVpnS3JFRGYrZVdxbTNmUGw0NHNrM0h5c3J3bFJES0xDQ1p3?=
 =?utf-8?B?QWdia0ZMNCtRQURPSUtWUEczeWRwNm5ZQWxXaWlmQ3k2d0o1YWd3SEErbkV2?=
 =?utf-8?B?YXlQWFZ3OWxPMmtxMTJ4QXBqRzlRVUdwd2tlVXFUN09yYWhIa2xLZTl2OW95?=
 =?utf-8?B?dDhTNDA1dStza0JaQm5IcWZYRnVPZ1JraFB6MG84RWZTaWxzcC9wcE5LeVZq?=
 =?utf-8?B?Qko3UW5jazNWUlZ4YkNXOE90TXBYSXZOM2ZrVkYwTEVTWkp3OTNTeXFxSFl0?=
 =?utf-8?B?RmNoMFNsUFpRdlFiY3pKZnprcWwrZ0o5UWhzSHVtbGJFc1lSZGtsUW1BNkhT?=
 =?utf-8?B?cHZjY2ErdXJmMlEzejJFMVlKaTRaTW01WnlNWE1WOUxCNHoyWlFoUlVZMFRu?=
 =?utf-8?B?cktYa2hhR0NWNzQvNTZSOFdEVW0zVjJYUThRd0F3VVczTmdpWnVnSVIxTm95?=
 =?utf-8?B?UDJYQzdJcU0xV2NQNlpxS056WHM2VEJHTS9Dc3JwbHJwNDQ5SFh2YkpUb3dB?=
 =?utf-8?B?VE1yNnFrQ0Ryb3BpR3VtZmRtM3lMbDA3bnFrMFBaYkc4eXZJaC9uYTlObFlm?=
 =?utf-8?B?S1ZodGNjaEJ4UkF6ZVBrcW5KUENjWGRRVEtJdENPZS9TQjB0am8rZkk5TEtW?=
 =?utf-8?B?RlJmaHFUaUU5MXFhbDBtR3VlNkFJdWg0eURtSk5Md296a0xKZVIralpkdjV1?=
 =?utf-8?B?Y1AzeGYrVFRQcUZITE13ZzdGb08zYjNHY2grS3c2N25XckwxdUZJT1F4aFFm?=
 =?utf-8?B?SDNPU25neEszWG05VGh6ZGgwM2xFelZDRnpGU1lKZmo3Um9HZ00xRnZIYXBv?=
 =?utf-8?B?RlJKbTFxKzA3ZStVRVVyaGVVYXRhVFRWenVlWDRjU1M1Z1JzNWVmd2Q3djd4?=
 =?utf-8?B?QUVjSWRja2wvMHpmSTNuZWFkaXJ5eGYwaC80RWtHejBzU3BsdTlwV1ZaajNS?=
 =?utf-8?B?d09zMHE1YTN6REpOOXFUWXl2QnpnNElYUFVHbmJ6VjhBZ0ZlYlNmV3V1ZHZB?=
 =?utf-8?B?ejNLSEdXa2I1U2ZZSFd6eXUwN2s5SWNsT1kxQmI4SmVablFRTi9VSlFyN0M4?=
 =?utf-8?B?OFltbUgvTDBjSmFXUTFGY0QzdlRPaGtkWlUxQTV5dE5ybThweGJ2QWE4U3I0?=
 =?utf-8?B?MnFYMHdUa2pBY2hGTjY3R3ZiWWVLbE5IWWhiQjdnQk9BYlROQWdNN2FDQisx?=
 =?utf-8?Q?mnti2R8sIXMH8CHe83S8hp5SJubthUlcBZFoc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkVjVVJDQUt2WHBKK0JLemgxMW9kZldybys0ckVud3FERWtWS2ZmRGpHajN1?=
 =?utf-8?B?RDhVVk94NDRXRFd0N2NPRUNpTVZRclZ5Vy91Qi81aVdSVS9BV2RwdmJDVHNr?=
 =?utf-8?B?TUJZUHhKRUxKRUQ5SU53SzFMSUdPa0ZmOUp6NmFDSXBTNDJKOXNGNDZMVkNU?=
 =?utf-8?B?UG44eVVTcmdmdGtLUWtXMS9RWjRRNlIralFHdkxkazNHWjA1VFdDUHBJVTVZ?=
 =?utf-8?B?cEovWHlYbEtLYlpKamU2MGFHRkduN2pVa3N0VVdobVV0Q2pRRWpFYnl0TU5w?=
 =?utf-8?B?R05DUFhpM2hwakxiUGxwbkxOK3lLLzhYRmJrYWZBVlcyeEdCZHZpNzRTWThE?=
 =?utf-8?B?N2tJY0NCN09FNmpkREhLNzd4aE9rc3JNU00veGNTdURPODFnVzZxL2ljZmJk?=
 =?utf-8?B?RzgvZFl2VytRaHZGc1NCcXlNT2xBaGdGWjZsekhEbnc4QlMzT0dtcG0vYnVJ?=
 =?utf-8?B?dUk4TkxLNElKVmFwTlFUcWNEN2tLaWZTVkVMZHNTZXEvUGJXTUdvTlBGc1Zz?=
 =?utf-8?B?YzRTcVpud0pweG5yd25uNWR2THF4dDZaRzQvTzIzTmdxSXBFNk1EQ1VqTFly?=
 =?utf-8?B?eHZjM3pjUlh0SkhOZmt3emJUZk4xdW5wVkl5bEluMzBLTGFFZXcxRUZSWUcv?=
 =?utf-8?B?UGM3SDUrdTk0aHFBeExzbDFEYnNKUWExNmJsUlpoRDVTV1hIMUVQdEU0NVp5?=
 =?utf-8?B?WEFXcHBoLzBCdGxVQ0Q5QWo2ZGhyWHlBa0FENldmLzFBVUdySVJZcllWdzBL?=
 =?utf-8?B?UWhXait1WmlpQ05jWGlYRitrYnZYckwxVFZqZ2hQcTdDNm1ZaTdsK3R0RHZ0?=
 =?utf-8?B?VkVXMEwzRC9jeW4xbVMrWWZ3ZkJrc0dlaFZKRUpYRE4rbGh1b0laOVZyRDcx?=
 =?utf-8?B?YzFBb0V2TXN2cExmazAzWTcxclBxRUlwOTNMWUMyc21sc09yNzlUdDlac3Bh?=
 =?utf-8?B?bzA3UXpTL2JHOEZVNE1DV1hwT2hJd2VLNUMzVnpaWTlQOVhrOWlVUStGV0sy?=
 =?utf-8?B?MUhrcFBRMlU0UTcxaDRFeDVJeUlsT1dvMlBOenh6bXQ5YlFObjVwVVNyY2o1?=
 =?utf-8?B?K05XWmRvSHY4R0gyZGRQb1ZRNzZCNVJHSnhLOWZ5YXRBRy9xditwZGJ1dWk2?=
 =?utf-8?B?cW1KbGVpTzVMTEVjRmVtNHh6M3VUMUd5YUhSSmJ3MitCUWJBT2pHckhlbVVL?=
 =?utf-8?B?WjRFQWNUbnpJMkJ0SnFYa3FCS2dESm1BdHM3TnBZZTBRbVBxRUZiTXlJaE14?=
 =?utf-8?B?bkZIV1Y5TDNwc3VBQ1ZpanZFd0RNR0Rwb2tiNlAyejZlV1J0d1dmZXlYZHor?=
 =?utf-8?B?L0RZdVBzQTR4aXBJdjFSM21wajlyZ1dJRGlPNHUyakkrLzlHQWlXMlFobXMx?=
 =?utf-8?B?Q2NSeWxsVXE5YmR4aXlab1lCMGpPR0Q3T2tHaHdsYWR2UUdwQW1PZEFiSm14?=
 =?utf-8?B?U1k2SGJpUXVOVnZNUE9PVEc2aDVQbUpKNDRTWTRQTFFLOFpWNWdiNWxFNkxJ?=
 =?utf-8?B?NkxjMUpvc0pmb2JveWxQbkxUN1FKcWdOdEVvSi9kWEFGOUszU3A1UTlWTWZ5?=
 =?utf-8?B?V0FFYytmUjZkVDJ4ZXhaQnJhUUhjd1I0ckhoMHE0OG4zTFRWbFY5b0VRVXhS?=
 =?utf-8?B?MisyRlBMVVlac1c1d01QTzR1WGRpcGdFQ1FNWU0zOUV6NGFWejc5cFdHMm5K?=
 =?utf-8?B?RkxhMW1xUGdHRU9udnRHZjFkSElkanBjRlN1ak1HYmgveGZVZ2tsU1dzMGlu?=
 =?utf-8?B?RmJzWTMyWTFpUkN3ODdyZHNTRmtaMkNCcGl0N3FtcWtLajNOanY5ODNxbGI0?=
 =?utf-8?B?OWhiSHgrUTIyM2pDUnQzbUk2ZDMxZzIvYXFQaHJUelpkUGZMKy8rcjdsSUd4?=
 =?utf-8?B?M0ZrbUdxZjU5TExTNVV2blYxemx3T1hKWUExeGQxc2ovaUxBWGszTjN4dUZE?=
 =?utf-8?B?cTZGMzNEQ3NTWS9XOUJpa1M5TWRRYWkwTk5UQWxJN3B5SEk5allsU09Gb1l2?=
 =?utf-8?B?NEprMVAyc0FZODF2by9BTFA2eEFvR25FMUZpRVJlaVZiVllPVW93WForRFNX?=
 =?utf-8?B?bVJEUTRWVXRXSUhQV0h1dkx0dzBpUzdsb0FQMUcvNys5bjBvamh5N2EwQ1BT?=
 =?utf-8?Q?BxYw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0de3383-edc3-4260-6acf-08dcf95c84b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 03:31:33.8182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jo1ryz3MsDofEGVPOEHUTQkBd6F6C6Z5rT0Jf0QHMz0f50gbCoxkVUSroic/jmbc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
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
dWNoZXJAZ21haWwuY29tPg0KU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMzEsIDIwMjQgMTA6NTkg
QU0NClRvOiBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NCkNjOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6
IEFkanVzdCBkZWJ1Z2ZzIHJlZ2lzdGVyIGFjY2VzcyBwZXJtaXNzaW9ucw0KDQpPbiBXZWQsIE9j
dCAzMCwgMjAyNCBhdCAxMDoyM+KAr1BNIFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2Fu
Z0BhbWQuY29tPiB3cm90ZToNCj4NCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRl
cm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4gUmV2aWV3ZWQtYnk6IFlhbmcgV2FuZyA8a2V2
aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KSXMgdGhpcyBmb3IgdGhlIHdob2xlIHNlcmllcyBvciBq
dXN0IHRoZSBmaXJzdCBwYXRjaD8NCg0KVGhhbmtzLA0KDQpBbGV4DQoNCltLZXZpbl06DQoNCnRo
ZSB3aG9sZSBwYXRjaCBzZXQgaXMgbG9va3MgZ29vZCB0byBtZS4NCg0KU2VyaWVzIGlzDQpSZXZp
ZXdlZC1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KDQpCZXN0IFJlZ2Fy
ZHMsDQpLZXZpbg0KDQo+DQo+IEJlc3QgUmVnYXJkcywNCj4gS2V2aW4NCj4NCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+IEFsZXggRGV1Y2hlcg0KPiBTZW50OiBU
aHVyc2RheSwgT2N0b2JlciAzMSwgMjAyNCAxMjowMyBBTQ0KPiBUbzogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGRybS9hbWRncHU6IEFkanVz
dCBkZWJ1Z2ZzIHJlZ2lzdGVyIGFjY2Vzcw0KPiBwZXJtaXNzaW9ucw0KPg0KPiBQaW5nIG9uIHRo
aXMgc2VyaWVzPw0KPg0KPiBBbGV4DQo+DQo+IE9uIE1vbiwgT2N0IDI4LCAyMDI0IGF0IDEwOjQy
4oCvQU0gQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gUGluZyBvbiB0aGlzIHNlcmllcz8NCj4gPg0KPiA+IEFsZXgNCj4gPg0KPiA+IE9uIFdlZCwg
T2N0IDIzLCAyMDI0IGF0IDU6MDTigK9QTSBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IFJlZ3VsYXIgdXNlcnMgc2hvdWxkbid0IGhh
dmUgcmVhZCBhY2Nlc3MuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyB8IDIgKy0NCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPiA+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+ID4gPiBp
bmRleCA2ZTYwOTI5MTZkNGUuLmU0NGE0NDQwNTI2NiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4gPiA+IEBAIC0xNjU0LDcg
KzE2NTQsNyBAQCBpbnQgYW1kZ3B1X2RlYnVnZnNfcmVnc19pbml0KHN0cnVjdA0KPiA+ID4gYW1k
Z3B1X2RldmljZSAqYWRldikNCj4gPiA+DQo+ID4gPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBB
UlJBWV9TSVpFKGRlYnVnZnNfcmVncyk7IGkrKykgew0KPiA+ID4gICAgICAgICAgICAgICAgIGVu
dCA9IGRlYnVnZnNfY3JlYXRlX2ZpbGUoZGVidWdmc19yZWdzX25hbWVzW2ldLA0KPiA+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU19JRlJFRyB8IDA0NDQsIHJv
b3QsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTX0lG
UkVHIHwgMDQwMCwgcm9vdCwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGFkZXYsIGRlYnVnZnNfcmVnc1tpXSk7DQo+ID4gPiAgICAgICAgICAgICAgICAg
aWYgKCFpICYmICFJU19FUlJfT1JfTlVMTChlbnQpKQ0KPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgaV9zaXplX3dyaXRlKGVudC0+ZF9pbm9kZSwNCj4gPiA+IGFkZXYtPnJtbWlvX3NpemUp
Ow0KPiA+ID4gLS0NCj4gPiA+IDIuNDYuMg0KPiA+ID4NCg==
