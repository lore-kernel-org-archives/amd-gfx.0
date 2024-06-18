Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AB9C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 15:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6503A10E1EC;
	Tue, 18 Jun 2024 15:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oQW0KBJH";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B37310E1EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 15:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEArVGEh21dGzLbgdP1IJJS8uxqD8f7KTTdfBzsDodgoazMG7b1FTdRDxWbNPzasIdwBR6er2jzg5CbVth0BgsA9KUCDC92IzXKAPNj35rxnNvLZ3m38TG3lLIQIGp00fozyxpUDauYEU5dVaUe+UMgEiKxxfk8DQmVTDtmIEOZOz5PJ+IooAxoEtzBHnDNhkAGc09b3erfNORNJYKzWnTmksxu5tlu1MzpctiDTyJuR/gE4loyHd4ds1gs0Q+DxmQQn2uZKqNooVGgEgjqLNlVsixzIr53v3Bq0tzUVPHM7rIYQJG8IQVR67uwvWF8Clbn2TPuYYKZhAeA+LP/ZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsAKd7Bc+eoULwhqhraqeHF3GoZ3PYYK0SsfyKWJaYM=;
 b=Vu2kYPS/7O4OHtGhdVbjT5xylSR+TcsIFER1+JrH+48qj0DawQbrRo/1XJUVROETPVPk/+JIlGDxm4bWPComd/dJF7JZWOYgDWNBUg2efNJuxgloiKrTGGqxGUX+ttLBf0ZE9BGhqm3EGTBMiDW8F1nRJpMS0KhlufV/ti1G3ktU5sWQ8vcBvjlbnuqOUjIdyl31VwSSiZBqdQpVVdbcreVqKlCdQXg8fZdAQuCpK/WoK0QN35pPfA33lEDyk5D1aLA6F7YH8v5kdEg4u33gf8eCd/GWN6cfy72Q0IpnXfvRRFb2QJzej9Oh8+eY+yvP6L0HsgvnTLvTg2MK5dES5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsAKd7Bc+eoULwhqhraqeHF3GoZ3PYYK0SsfyKWJaYM=;
 b=oQW0KBJH50tu01nVDg3Q1ilPzprFEHop1ZmnqL9P19GyhnW67MRsTW/CJsXMq3sTzog2a4cFHkpWTlM5hZVdUJKqYr5UYdkhG3YU29HoPX1QmDNnd3JHKDoxs+eCHK8UlbTTu466jjjwJ4laOJ2Ay2FwVLnIVp6DVmucdWFaUsE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 15:20:03 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:20:03 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Slivka, Danijel" <Danijel.Slivka@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Slivka, Danijel" <Danijel.Slivka@amd.com>, "Chen, JingWen (Wayne)"
 <JingWen.Chen2@amd.com>, "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
Subject: RE: [PATCH] drm/amd/pm: check whether smu is idle in sriov case
Thread-Topic: [PATCH] drm/amd/pm: check whether smu is idle in sriov case
Thread-Index: AQHawY763f28EVkVyke/EEWZn32NX7HNoZ+g
Date: Tue, 18 Jun 2024 15:20:03 +0000
Message-ID: <PH7PR12MB59976AE8297422B6EBB712C282CE2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240618145944.95640-1-danijel.slivka@amd.com>
In-Reply-To: <20240618145944.95640-1-danijel.slivka@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS0PR12MB6535:EE_
x-ms-office365-filtering-correlation-id: 72673c90-179c-47b3-d0d7-08dc8faa206f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?gb2312?B?TUxscUM3VEw3M09GWmtyR2RtT2MxM29ibmMrODkxaVU5UjQwbFg3NVQ4Q3gx?=
 =?gb2312?B?NmlnWFVsNDF6dHNHTlZ5NlRNam9ORS9iV29yZDRMbVptbmQ5VDFQRnFKZklj?=
 =?gb2312?B?bEFPdUFjdllyVllDWkdhNDdlZmk1cDV4SkZtdFJ0dHFITlFqZTlSYjhlSC94?=
 =?gb2312?B?bVRWSzZkVVVFc1hUbzhjNjJFc2swdThUWWRFbWxEeU1VMC9EazBHSnNSb2NK?=
 =?gb2312?B?NmgvYm0xQ0JtaVozVEpHV0FYaGt2K0l6YXZ6VlIxTTFjS0M1Z3RxS1ExWjBP?=
 =?gb2312?B?dnhUc3FMK2tQbnZZN09obEFNU1ViTiszZ3FOcmk3R2VEQVppZVdJUGJONlk3?=
 =?gb2312?B?T2N6RUpIU0VIWEZFTTBVMHJqQTVTTnBTTWNBMzFRZ3dwbFhYOHdNZG92bDFY?=
 =?gb2312?B?VVdVajk3a2l6d1c2WlV3d2VIVDhhblA4Q2gybS9sZzJwbVJtR0hsVDFHZDVK?=
 =?gb2312?B?VUlpc2xTdHczeXZJVlBPdlRYV3pwYnRBR1JkT3YxaXRDaXVHWTAyeUZQRmRJ?=
 =?gb2312?B?Z1BvYjBDNWtidS9jOXBGNHZoZmQzY2Zpa1ZnMUFxWUVxK3VrUUV2TzVkdmFS?=
 =?gb2312?B?UStnUmpEZUxIaU84bm5KcGpPQVBFWDkzdUtrekVLU0FKYytGRWhDY2htT3pB?=
 =?gb2312?B?WFZYdkN5amEyb0F3TTM5RFR0bHE4Y1FXbUR2R3UxRG9iajVWc0NJaHVjMGh1?=
 =?gb2312?B?NHB2eGVycXlLWkxhaWRaNTlrRkdyK1oxOUltM3FJb0UwaGJ4Yzhtd0M0UlJB?=
 =?gb2312?B?czh2bCtTdGN3VnBiK05HL25DbGpXYU5jODdXRmNGbDAvRGVUWTRiK2g5ZVVU?=
 =?gb2312?B?bm5JNklmNGt2UW5reTVNb3BEL1ZnWDhOcW04RzFCUzVZWmxSNi8wYlF3S1Yz?=
 =?gb2312?B?YXE5Z1Ntc0ZnUlpTcUNLaEN6UGtVZXFPRWhkOUdzbnkvSTBkd1d2aENoZjlj?=
 =?gb2312?B?b2dKUVhsdWhLMmxvRkJOSS9sVnNGUUVwdHQ4RmNheDBDNW1RYWlDTGVLTFV3?=
 =?gb2312?B?eEVlSUNULzZzMGd4ZGQ2OWtzMytNZndhQ3Y1SDEySDNnVGlzckNGbndLSFY1?=
 =?gb2312?B?YmZSYlZWQlcvS3piSExtSEVkaWRGQXJGa3F3R2pVaEU0NExucE4xZGEwU3NL?=
 =?gb2312?B?b0wrMElrT0RzTlNiVW8weVdhb3dHVlRMQzAxQ09pSkdZbkNua3MrNVRsRE1B?=
 =?gb2312?B?YVNrNUJEMlZ5TkFQbnBHUU8veEg3SEdoeVh0TDVnelZPQlZJcWVCc3h6QXRW?=
 =?gb2312?B?eGs2NG84VjR6TXVldDNnb3dBWE14RVNrRVdsYVpmVlc1dHExRklnZVZVTkpP?=
 =?gb2312?B?V2tHNzYyTGlZZllYVmlzbFpPWFR0YUpCdnVneWhsOFJsMUsrWlduQTh5SmZR?=
 =?gb2312?B?R3FOTUhJT0hDMEl4MXNaNE4xM1Q0ekRoQjkvVXlaL2dmZ0U2VWovRXRFKzNx?=
 =?gb2312?B?ZnpkbURXRG5VVEdud2sxeUxWM2t1WWNNMjVhTW1jOHdub25JMGtPaktPNnNJ?=
 =?gb2312?B?TzYvUDI5aUZnMlR1ZWxyd1hxNEUydElXUFAyYVpSeXpCRWN6eUhlekFBZWUy?=
 =?gb2312?B?VVNJalNuMUFKNGRjbEI5S0dqNEEyVDlWWGpYblJpRFkrcCs0Zy9kdHNYM1Vs?=
 =?gb2312?B?R1NkUDFZV25uRzJWR3NVUU11Y2FqWWVvcnkzR2lnaDZuZ0VONGlIalpMbEQ3?=
 =?gb2312?B?Ni9rdXpTaXlBOHVlbmtBeGxGeFNaM1p5NEFzakRGRlBHZFRKMzIvajRpMFRI?=
 =?gb2312?B?TEVVOW1ITlRVQ1VtN1NodE1oaW1PUzBUWHFlZk1NRzRGWnIwQzh1Snp1Q2s3?=
 =?gb2312?Q?A115ZljH9/x0Wl0SxTKBbaQwq4kMKg9/+/RZ0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aU5pWWRNckpDVXdXYTNDSXNTT1dMU3ZBY1VaRVEya0d0Lzc3bXdzMmE4QUp4?=
 =?gb2312?B?TFJCSWNqS0FCMlFBRFl3c29hQ1BmaTF4QU4wUjBBd1d6Zmw0N2VPTXZvODhD?=
 =?gb2312?B?YzVNZ3RrRm4xeHQ4QjFway9FcFE1SGV6Y01vSlVWMzFkb0Z0U01ERzA2TU5q?=
 =?gb2312?B?MUR2OStERjloY1Bad1ZXNldjTS81eW56TnRDL2JhUno0dTh2L2F3YUZSSFZS?=
 =?gb2312?B?d0h2aGx6Y2c4am9YakZrdTJXSlRCSUN6azZ5QXJvL1VTN3F6a01QUFVqTkYw?=
 =?gb2312?B?VDM2cDc3RTBJT3FDNjdhcXZvU0xvWDlTckxaR3J2aHFCSEFvcVZlb0M0L1R5?=
 =?gb2312?B?LzRHdCtEbk5kVkFLUGQ5cC9TVGdpTFY3ZFBidWh2WmpxeG5ZQnh1YWpNL0JR?=
 =?gb2312?B?MVFJVjJrLzJhOThvWUlpUXJvYVhQM2JDT3VldGxiMk1BTlE2MnQyd1hCRUx6?=
 =?gb2312?B?MDRyVDhtS29ZSkxKVEdybUh5dWEyOENManM4Rzd3dW5VVFd2aUQ5NTZDbmEz?=
 =?gb2312?B?bGIreTdLakI3bjdFb2xpc2l2c3VrRWRjUE1ONElBMm9RMEdkcC93NVZ4ZWNo?=
 =?gb2312?B?em0zbmd4QzJzQW1zQnY5dVBLMEFoblNTM1ZQYmtDcmdoakRDeEVoUWR0VHV5?=
 =?gb2312?B?Z1d6N2JxTDI2NFFwb1dPaVhRWnJYS2o4TFZXVlhNYkFFRlRVUFh1b1ZqajZl?=
 =?gb2312?B?NzRMbUQ5UXp6VUlMVXEvOWwwTjBoOFZFcmpUa0F2K09yc0dTZnR0enhNeWNV?=
 =?gb2312?B?NkoyL2VtZUdJUEUxMHp4cFdZejZmMHV2MlhWaFhuVHgvT3R2bUc3eFg3MGJE?=
 =?gb2312?B?WGdpUzhPVitUYzhPcWZzUkNDZExDemVRdDkwUUhreHBDcEQ1MWM5UEZCZnVl?=
 =?gb2312?B?MVhZRGVTTndibkU5b2RGWGtDbE9LZU5pUHM2bXRkNGRvKzVkSHVpTVpUUitt?=
 =?gb2312?B?Z0QvM2hGTFlycVYycUtRT1ZVTUVkQUVQM01DQmErd0gremtLUG93WXpWNkNi?=
 =?gb2312?B?N1RFd3BBczhFc2syWm4yb0xJbk45dHltWktWQnNhZ3FyMXlXdkxkKy9aWE1r?=
 =?gb2312?B?L2JkdUt6Z3A4QU1xSjZSR29pQ0N6Sm1xQ0dxVTNKTnZtRUNUWDNmbmhIamRl?=
 =?gb2312?B?VThaaHJtdXlxOUxvR0FNcmxYMVNsNXgwU3pzRkZremUyRm9GaUVkL0pyVlFh?=
 =?gb2312?B?SE5rTEp3VHJ1Y3R0RnRTZGl3RVNQR2tsaG8veEY0ajF0RzJwc2c3VzJqcTBO?=
 =?gb2312?B?dGI4RlFkVlgzR2ptSUQ2dWVUWS9Vall3QWhPTy9QdFdoMnJkbmV6b2lZNkh2?=
 =?gb2312?B?b1Qwdzcxc1BDLzlYWkc5YzBFVEEwSlFUdjRCTTBvbFhObFo5SFZXd3k4cVJi?=
 =?gb2312?B?eHlqSlB1dmJ2aCthSWl3N0tIZHcySDNoK3o3TDduQnU4eDFzdHZneVJyWlRN?=
 =?gb2312?B?Z2RvSFhBM28rOXgzallIdTZlRmdoMmE4OHV3QXdIcXVwZVpnTjBJSEhwMnNx?=
 =?gb2312?B?VW4yYzBEQmpBQnNqcmU2SStpUTFINlN0Q2dodXpnaG9BdUdvY2crc0ZCWEgz?=
 =?gb2312?B?TytSUklFdEdiZUY4d1VBc1R3MS9zcmhwMjF1ZERTTjhiVklkbGNQeVYrNVFV?=
 =?gb2312?B?bExnYzVDTzRYcE9yNWtGZkJPenFxdkY0OGZ4elpUVkh2MGpNaHloL1YrdjRv?=
 =?gb2312?B?a29OS1dIS05BNkYrTEN6S0ZFaVh6TDc5Z3dyQnJGRnN4cXpQM1EvM1NCR3Bp?=
 =?gb2312?B?aE9JaTE1cDUxS3hQOXZjNWlsdlozMlFNQ3AyVUgzR051NVNxd1JVS3VPMmFp?=
 =?gb2312?B?cHNMTHkzQjJjS2ZySmNUOTNLaUxEZGcxcHh6WTdpZGJjTjBtZEJkVUdnVCtl?=
 =?gb2312?B?K2RaNmlEalREdkFUdi9QTGd1aUlLTFU0YjV0UGY0R09HY3R2Wmx5Z2hsNGhr?=
 =?gb2312?B?VGhTMEdDS252OGlXUWFJR1NKNWIrRGM1amIrU0xLNWV5OHJiRmt3SlF1eXgz?=
 =?gb2312?B?ODhvZjJKbjl3NEtIN1NiQmRVTGhXN3VuOXNFcGRkMDZ3Y2ZKNHJlUnBSWmIv?=
 =?gb2312?B?aURncTAvcE5YKzM3bGJtL3V0Q01UYThrRjZkR0lqNEgwVTZJeGp4dnhKeDU0?=
 =?gb2312?Q?tOKg=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72673c90-179c-47b3-d0d7-08dc8faa206f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 15:20:03.0919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4jHJxXXGN7qt8KcAb0FqYQkVuI4DoLqqaXV9tZIaRtyxTQoEq08nCALSJk/1gu2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
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

VGhpcyBsb29rcyBtb3JlIGxpa2UgYSB3b3JrYXJvdW5kLiANCkNhbiB3ZSB3cml0ZSB0aGUgQzJQ
TVNHXzkwIHJlZ2lzdGVyIHRvIDEgb24gdGhlIFBGIHNpZGUgd2hlbiBob3N0IHJlY2VpdmUgR1BV
X1JFU0VUL0dQVV9JTklUIHJlcXVlc3QgY29tbWFuZD8NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBEYW5pamVsIFNsaXZrYQ0K
U2VudDogMjAyNMTqNtTCMTjI1SAyMzowMA0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpDYzogU2xpdmthLCBEYW5pamVsIDxEYW5pamVsLlNsaXZrYUBhbWQuY29tPjsgQ2hlbiwg
SmluZ1dlbiAoV2F5bmUpIDxKaW5nV2VuLkNoZW4yQGFtZC5jb20+OyBaaG91LCBQZW5nIEp1IDxQ
ZW5nSnUuWmhvdUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kL3BtOiBjaGVjayB3
aGV0aGVyIHNtdSBpcyBpZGxlIGluIHNyaW92IGNhc2UNCg0KV2h5Og0KSWYgdGhlIHJlZyBtbU1Q
MV9TTU5fQzJQTVNHXzkwIGlzIGJlaW5nIHdyaXR0ZW4gdG8gYmVmb3JlIG9yIGR1cmluZyBhbWRn
cHUgZHJpdmVyIGxvYWQgb3IgZHJpdmVyIHVubG9hZCBpbiBzcmlvdiBjYXNlLCBzdWJzZXF1ZW50
IGFtZGdwdSBkcml2ZXIgbG9hZCB3aWxsIGZhaWwgYXQgc211IGh3X2luaXQuDQpUaGUgZGVmYXVs
dCBvZiBtbU1QMV9TTU5fQzJQTVNHXzkwIHJlZ2lzdGVyIGF0IGEgY2xlYW4gZW52aXJvbm1lbnQg
aXMgMHgxLCBhbmQgaWYgdmFsdWUgZGlmZmVycyBmcm9tIDB4MSwgYW1kZ3B1IGRyaXZlciBsb2Fk
IHdpbGwgZmFpbC4NCg0KSG93IHRvIGZpeDoNClRoaXMgcGF0Y2ggaXMgdG8gY2hlY2sgd2hldGhl
ciBzbXUgaXMgaWRsZSBieSBzZW5kaW5nIGEgdGVzdCBtZXNzYWdlIHRvIHNtdS4gSWYgc211IGlz
IGlkbGUsIGl0IHdpbGwgcmVzcG9uZC4NClRoaXMgd2lsbCBhdm9pZCBlcnJvcnMgaW4gY2FzZSBt
bU1QMV9TTU5fQzJQTVNHXzkwIGlzIG5vdCAweDEgZXZlbnRob3VnaCBzbXUgaXMgaWRsZS4NCg0K
U2lnbmVkLW9mZi1ieTogRGFuaWplbCBTbGl2a2EgPGRhbmlqZWwuc2xpdmthQGFtZC5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBKaW5nd2VuIENoZW4gPEppbmd3ZW4uQ2hlbjJAYW1kLmNvbT4NClNpZ25l
ZC1vZmYtYnk6IHBlbmd6aG91IDxQZW5nSnUuWmhvdUBhbWQuY29tPg0KLS0tDQogLi4uL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMC5jICAgIHwgMTcgKysrKysrLS0NCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYyAgICAgICAgfCA0MiArKysrKysrKysr
KysrKysrKysrDQogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmggICAgICAg
IHwgIDMgKysNCiAzIGZpbGVzIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3Nt
dV92MTNfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzAu
Yw0KaW5kZXggZTE3NDY2Y2MxOTUyLi5kYWZkOTFiMzUyZWMgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMC5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMC5jDQpAQCAtMjMxLDYgKzIzMSw3IEBA
IGludCBzbXVfdjEzXzBfY2hlY2tfZndfc3RhdHVzKHN0cnVjdCBzbXVfY29udGV4dCAqc211KSAg
ew0KIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHNtdS0+YWRldjsNCiAJdWludDMyX3Qg
bXAxX2Z3X2ZsYWdzOw0KKwlpbnQgcmV0ID0gMDsNCiANCiAJc3dpdGNoIChhbWRncHVfaXBfdmVy
c2lvbihhZGV2LCBNUDFfSFdJUCwgMCkpIHsNCiAJY2FzZSBJUF9WRVJTSU9OKDEzLCAwLCA0KToN
CkBAIC0yNDQsMTEgKzI0NSwxOSBAQCBpbnQgc211X3YxM18wX2NoZWNrX2Z3X3N0YXR1cyhzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSkNCiAJCWJyZWFrOw0KIAl9DQogDQotCWlmICgobXAxX2Z3X2Zs
YWdzICYgTVAxX0ZJUk1XQVJFX0ZMQUdTX19JTlRFUlJVUFRTX0VOQUJMRURfTUFTSykgPj4NCi0J
ICAgIE1QMV9GSVJNV0FSRV9GTEFHU19fSU5URVJSVVBUU19FTkFCTEVEX19TSElGVCkNCi0JCXJl
dHVybiAwOw0KKwlpZiAoISgobXAxX2Z3X2ZsYWdzICYgTVAxX0ZJUk1XQVJFX0ZMQUdTX19JTlRF
UlJVUFRTX0VOQUJMRURfTUFTSykgPj4NCisJICAgIE1QMV9GSVJNV0FSRV9GTEFHU19fSU5URVJS
VVBUU19FTkFCTEVEX19TSElGVCkpDQorCQlyZXR1cm4gLUVJTzsNCisNCisJaWYgKGFtZGdwdV9z
cmlvdl92ZihhZGV2KSkgew0KKwkJcmV0ID0gc211X2Ntbl93YWl0X3NtdV9pZGxlKHNtdSk7DQor
CQlpZiAocmV0KSB7DQorCQkJZGV2X2VycihhZGV2LT5kZXYsICJTTVUgaXMgbm90IGlkbGVcbiIp
Ow0KKwkJCXJldHVybiByZXQ7DQorCQl9DQorCX0NCiANCi0JcmV0dXJuIC1FSU87DQorCXJldHVy
biAwOw0KIH0NCiANCiBpbnQgc211X3YxM18wX2NoZWNrX2Z3X3ZlcnNpb24oc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUpIGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dV9jbW4uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQppbmRleCA1
NTkyZmQ4MjVhYTMuLmRlNDMxYzMxY2E3ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvc211X2Ntbi5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdV9jbW4uYw0KQEAgLTM1OSw2ICszNTksNDggQEAgaW50IHNtdV9jbW5fd2FpdF9mb3JfcmVz
cG9uc2Uoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQogCXJldHVybiByZXM7DQogfQ0KIA0KKy8q
Kg0KKyAqIHNtdV9jbW5fd2FpdF9zbXVfaWRsZSAtLSB3YWl0IGZvciBzbXUgdG8gYmVjb21lIGlk
bGUNCisgKiBAc211OiBwb2ludGVyIHRvIGFuIFNNVSBjb250ZXh0DQorICoNCisgKiBTZW5kIFNN
VV9NU0dfVGVzdE1lc3NhZ2UgdG8gY2hlY2sgd2hldGhlciBTTVUgaXMgaWRsZS4NCisgKiBJZiBT
TVUgaXMgaWRsZSwgaXQgd2lsbCByZXNwb25kLg0KKyAqIFRoZSByZXR1cm5lZCBwYXJhbWV0ZXIg
d2lsbCBiZSB0aGUgcGFyYW0geW91IHBhc3MgKyAxLg0KKyAqDQorICogUmV0dXJuIDAgb24gc3Vj
Y2VzcywgLWVycm5vIG9uIGVycm9yLCBpbmRpY2F0aW5nIHRoZSBleGVjdXRpb24NCisgKiBzdGF0
dXMgYW5kIHJlc3VsdCBvZiB0aGUgbWVzc2FnZSBiZWluZyB3YWl0ZWQgZm9yLiBTZWUNCisgKiBf
X3NtdV9jbW5fcmVnMmVycm5vKCkgZm9yIGRldGFpbHMgb2YgdGhlIC1lcnJuby4NCisgKi8NCitp
bnQgc211X2Ntbl93YWl0X3NtdV9pZGxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211KSB7DQorCXUz
MiByZWc7DQorCXUzMiBwYXJhbSA9IDB4ZmYwMDAxMTsNCisJdWludDMyX3QgcmVhZF9hcmc7DQor
CWludCByZXMsIGluZGV4Ow0KKw0KKwlpbmRleCA9IHNtdV9jbW5fdG9fYXNpY19zcGVjaWZpY19p
bmRleChzbXUsDQorCQkJCQkgICAgICAgQ01OMkFTSUNfTUFQUElOR19NU0csDQorCQkJCQkgICAg
ICAgU01VX01TR19UZXN0TWVzc2FnZSk7DQorDQorCWlmIChpbmRleCA8IDApDQorCQlyZXR1cm4g
aW5kZXggPT0gLUVBQ0NFUyA/IDAgOiBpbmRleDsNCisNCisJX19zbXVfY21uX3NlbmRfbXNnKHNt
dSwgaW5kZXgsIHBhcmFtKTsNCisJcmVnID0gX19zbXVfY21uX3BvbGxfc3RhdChzbXUpOw0KKwly
ZXMgPSBfX3NtdV9jbW5fcmVnMmVycm5vKHNtdSwgcmVnKTsNCisNCisJaWYgKHVubGlrZWx5KHNt
dS0+YWRldi0+cG0uc211X2RlYnVnX21hc2sgJiBTTVVfREVCVUdfSEFMVF9PTl9FUlJPUikgJiYN
CisJICAgIHJlcyAmJiAocmVzICE9IC1FVElNRSkpIHsNCisJCWFtZGdwdV9kZXZpY2VfaGFsdChz
bXUtPmFkZXYpOw0KKwkJV0FSTl9PTigxKTsNCisJfQ0KKw0KKwlzbXVfY21uX3JlYWRfYXJnKHNt
dSwgJnJlYWRfYXJnKTsNCisJaWYgKHJlYWRfYXJnID09IHBhcmFtICsgMSkNCisJCXJldHVybiAw
Ow0KKwlyZXR1cm4gcmVzOw0KK30NCisNCiAvKioNCiAgKiBzbXVfY21uX3NlbmRfc21jX21zZ193
aXRoX3BhcmFtIC0tIHNlbmQgYSBtZXNzYWdlIHdpdGggcGFyYW1ldGVyDQogICogQHNtdTogcG9p
bnRlciB0byBhbiBTTVUgY29udGV4dA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vc3dzbXUvc211X2Ntbi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21u
LmgNCmluZGV4IDFkZTY4NWRlZmU4NS4uNDg2YWNmYzk1NmE1IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmgNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvc211X2Ntbi5oDQpAQCAtNTEsNiArNTEsOSBAQCBzdGF0aWMgaW5saW5lIGlu
dCBwY2llX2dlbl90b19zcGVlZCh1aW50MzJfdCBnZW4pICBpbnQgc211X2Ntbl9zZW5kX21zZ193
aXRob3V0X3dhaXRpbmcoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQogCQkJCSAgICAgdWludDE2
X3QgbXNnX2luZGV4LA0KIAkJCQkgICAgIHVpbnQzMl90IHBhcmFtKTsNCisNCitpbnQgc211X2Nt
bl93YWl0X3NtdV9pZGxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211KTsNCisNCiBpbnQgc211X2Nt
bl9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCiAJCQkJ
ICAgIGVudW0gc211X21lc3NhZ2VfdHlwZSBtc2csDQogCQkJCSAgICB1aW50MzJfdCBwYXJhbSwN
Ci0tDQoyLjM0LjENCg0K
