Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C655C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 06:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91BE111A1E5;
	Thu, 25 Apr 2024 06:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zh0b0qTv";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EFC11A1E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 06:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5bUaMKv8ZZmLgp77HfB9Sl7SgMCWIROpFmdXEnMSHt7GBPU+2EJzwrXXMmpJgQuT6kTppp0fRBj8+UWpqHo27p/IsKe6ckbiDVeEjCxgCbPBjGQ+xJ3TWI3Noi3yB7DLTldo9SwhHTwk6bXPlvYavWPC+Y/kSFQ69hk2lbw9/KGxoS/FX/apF0wuLq0sUur9IZFHmA/aMBUe5vxm6VWmOMKzZUHZ5duyuu0I92gUd9lYL+zlw7/1ZHy2T8OPIBi7FlgEIXLosOMIypnIsS1xaaThx7Oh8Ng4uHxNwHiam5CEill3B8zgJAbbudS65xuaEXPof1hZqf16N1esPJJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFZi8FJatXw2LUPMvLYTUG3+6g1+GUnXq5HlPs9xSXI=;
 b=OFuwJ1Sqr4DZGmms4gY1bKASVNj6YiJEQTqngbIV9jjCkpNKkky7PHSsKTbTvQBC0HK8Pb75tRoFazbvcQNka/puCi2cFGT41pOcUqCuCoyQBSOF5fUUDUDJCAGXj8xwuXRfHfhHZk5DrQshIN4kh45WFjz6r3llln7/CfBGg4cLYsmyE01lV6C8DifKJ8FapI8gg/B3w1nJ4R8POqCvRcZgU5ldoWvqXpmKtPhoOtUMOvFyDldQtJziCB2OGT0M7wNGtctULJV0HaKjbWiwnDnZf9DFvtnqCU5EL5q6qKhSVn4SS/z7X0baox/qknKwf91szc731W9F18fhZHxH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFZi8FJatXw2LUPMvLYTUG3+6g1+GUnXq5HlPs9xSXI=;
 b=zh0b0qTvUZ+yQCsGDYMEweMwQhBrWVeNyr+ePmFK+i2K8viZomjtWVvqbxA7PEPruan/XLzpRu3f2v07sZ/VuB3eIFUz9bM7F40/CaV0yaoCRiKHgUimccLpuO5ThJfxMSHT0TUWsAPRy2uabvtUru+mseLwuj1Xp3wPbiIuFO4=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 06:56:25 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%6]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 06:56:25 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix overflowed array index read warning
Thread-Topic: [PATCH] drm/amdgpu: fix overflowed array index read warning
Thread-Index: AQHaltFavtK9J5ycHEuOsL2Wv5flX7F4iomAgAACIBA=
Date: Thu, 25 Apr 2024 06:56:24 +0000
Message-ID: <CH3PR12MB8074160BE54E05E68F63DA6FF6172@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240425052736.1312063-1-tim.huang@amd.com>
 <10bb6ddd-d5c5-4907-a2fc-315d81857b4a@amd.com>
In-Reply-To: <10bb6ddd-d5c5-4907-a2fc-315d81857b4a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3eaf08c3-9f39-4558-9476-90ab287026e1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T06:52:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|BY5PR12MB4068:EE_
x-ms-office365-filtering-correlation-id: c325123b-2d24-4437-1397-08dc64f4d2c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NU1OQkM5Q0wxeHM5WUFvQm9RTi9JS2Z2UXpBdk9xbG9nemZiYnU0MTF1anND?=
 =?utf-8?B?MHROSkx2VXdyNTJxd1ZoT0FTM0h1RGNROEtsR1d4YW5KeDJuRUIvRXdDREZ0?=
 =?utf-8?B?ZDBtcXcxdDMzeHpwbTZjeG84RzhYZ0JVdHYwRkRVb0RNUFo5eG55RDYxbjV2?=
 =?utf-8?B?S0FtN1hUblpYOE5JcEpMNTVjdUJiNm95WFNvalF0R3k5eU5NYUtieG1wWkQv?=
 =?utf-8?B?WTFnRFVPQVF6bFBCTGFkaXVpeStIYmRBdVFFZlJ6RjFRRDhpaUxjWVJmVWI2?=
 =?utf-8?B?SWFwVUhTZDMzTTBaNFMzSEJrdnJ6MlJJeWtCb1BSYksyQXFMUldMaHFnR3ZZ?=
 =?utf-8?B?aFZzN0hLdG9pNjU4eGtiajh6a0piQTFMbzJKdnNFeWR1ZTU5VS9rZW1ZSXFm?=
 =?utf-8?B?WGN2Q09Nc0pqODFtYnhoTGxLdjRpZVpEM1lSTHRua2JFQXhQbXFNaVVsWmNI?=
 =?utf-8?B?cDR0VUFkT0Y1R3I4cjRSZHFKSEJ5NkVBWTlMYlhlNWNFYVU0QU5pNVl6VkFM?=
 =?utf-8?B?bXR2QU0xWTlxOUpITmVMc0ZSbENYRHUzZHQvVmkrYjNyMFczSXkrZjJhWDdm?=
 =?utf-8?B?em1uK0ZLWjFiSUpGMXg0blNMRjlPNHIwWEFEaGJoc21ydy9hYzJmSEVJRU9Y?=
 =?utf-8?B?V2ZTU21ITlNPeEIrYndLRU1mV3JpdFZ0WlpJRFFkT21tcDNLbU04b2RRdWl3?=
 =?utf-8?B?Z1Q2Y1BnWmJWV3hDS2pnVzBncStxVDhsTWszSnRiNHk2bGkrQ3NFczd5MjZz?=
 =?utf-8?B?Z1lKTGlMalRKcmEzNktVaDQ1V3NOU1A3SHRmSDhaZjN3Mzh0MU9Ka0dacnds?=
 =?utf-8?B?MUVRWWE0WHRyc2luRmwxL1NqR0VlMlh3WHhvajdSRlhJZm5Vell5aFZVVXpO?=
 =?utf-8?B?UW0wSGt2aDNxNnErbkNVV1lsNitSVDlCSG9XakRob3BBRjNsM3FxV0NpdTJ3?=
 =?utf-8?B?cExOWmpNNlpwd0NDc0g3VTFTT0g3d0I3R3pUcndoMzUrTityVGwrMnBNWUt1?=
 =?utf-8?B?N1htbkpka090NHp0WDlibDY3STZiaGU4eEdpb1JPemUwMmRUV3JVaFkxNm94?=
 =?utf-8?B?NU5SNmVvWlEzc2JjcFhzcnJPakNBS0VUN1VYWStMbm9jOXVGNGV0TFA5WFpH?=
 =?utf-8?B?TUNsRWNFOHdOQWZiMFR1NlhnUzkrUk5CSktzUnNjbkcwVEFBSjA5Y0R3a0pG?=
 =?utf-8?B?KzZ2UUc2bEMxalB0YXJTOTBMS1ZwOU9UQnl5VDFmQWpaaG5GQTZsQ2Z5M1I0?=
 =?utf-8?B?Tm1wSHVEeTVDRFp6dTlUQXhvbWlOa0duZFlLWkdhVDFkMFR6VFZ5a3dhNkJa?=
 =?utf-8?B?ZXptOFdaUk5qbGpoN0kzK2c5SUN3cnU2emNyY0MzbDIrd1F3Tk1LWGMxQkNl?=
 =?utf-8?B?OG9FTzlrSXJWYmhnbXFiMWFEdVpERDUyZ3d6SGpvWmpCdG90U2xad3UvNEhL?=
 =?utf-8?B?MTVGb2VqSG5vSmtrcWx3V2xmeHMyZXJibi9Sb0RzcUtGanBEUFV6UXVrNTla?=
 =?utf-8?B?dmxLdHpWQUxIamxwOTY2MnVoY3lFYUIxa29kSjJxTlZQRWFkVnV0N0dYWW5D?=
 =?utf-8?B?OEhJa1hYRDFHOUxLbTloOFAxa25BM0ZjUW9yRU11SHlRa0JVb2lJc0JqLzJz?=
 =?utf-8?B?Tkl5YktQVlRrR3lwTmQyKzYvbzZGdENuQ0JqVVFpTHZCdnFKTzh0dW5PZXF6?=
 =?utf-8?B?MGdiYU02RXE1eFR0bkVNSXlhUHJBVmg5UU40L0I4RkhTRk9rUTRVd21SU3RR?=
 =?utf-8?B?Si9RWmlQUEZobDFER2FsdGYvZ1dVUzI0UEtGV01JZWdOczFyM2VEVmszK3hj?=
 =?utf-8?B?WEIyaDREYU90LzZmU29zZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTgwTXZzUmJYN3UzeGIvZE9ja3BramwrS3FnTmtGOGVLNldCbXlOZFhxeFh2?=
 =?utf-8?B?VUVaV1g1RFNMeDRobkx6R1V6R3pkdS9LQ0M3YWRYdktld3A2UEV3ejJOdzU1?=
 =?utf-8?B?VVp1eDlkQXlSdjdqQ1FMOGNFOVI4bU1ONWVEczNhend3dGF3K3IzNU1ibDhv?=
 =?utf-8?B?TEhaem5IK1V5NVMvZVhPcE9GZ2sycSthRjI2UnhEYysvVmlrSDM2Y3ZPZ01X?=
 =?utf-8?B?N2VIVjJMQk9sQ3lDNjBTbWtOeUM3RXlrVUZqNGdaSTlyRU80RjhwQnQ3dlpy?=
 =?utf-8?B?dEtKUXFvV09FOHU0ZVNoclRpNkMyMHpKY000SVFxZTI4ZnQzWG5Uck9ML2Fo?=
 =?utf-8?B?Nks3YlA0YmFRblowcUUwNzJHVkYvTklpQ0lCc3BQVU1lZkZmQnpkNVpQQ3BU?=
 =?utf-8?B?cFV0ZURBb1NjVFhReng0TGVUdWdPSGJGbDB4TU52WGxGVUJydm9KbkVvR3do?=
 =?utf-8?B?N3kwcFRXV2w0V1FwRmM1S1NLYWt2Y3A5b2ZpRStBVXRlbHlPZ3o3SzdyV1VC?=
 =?utf-8?B?QVFJMW1RWmZyNWwrU3QyTmZzb3B3d0RSd0ZpekF2cmNXR3pHR1JjanhKcE9a?=
 =?utf-8?B?MGN6QVdGTFRndXlyUEpqeHd2WnBVMm9ZM1RUOWRMZndYb21KMEVhNlFHWHRB?=
 =?utf-8?B?RE1xU2UvSzhjaGdFKzV1blcySENWc2RJVnBzZGE3cnhIYklRanV5bWRRZnh3?=
 =?utf-8?B?dVpCMkFYaXEyallDY0t2YzlRNngzbVVxSEJ2YkYyZmNQTjV4eTFmaG9COHFK?=
 =?utf-8?B?NUg4OTNwMkIvUTFBZDlEVEFOM1JJNXRTWkhtVGZwek1YTWlKMTU0QnhxbTZt?=
 =?utf-8?B?aG42SzlicGVBblM4NExoMzN3SnBuSm1jSm5GbW9lSUtZcGJDUGdNLzFHQ04x?=
 =?utf-8?B?dS91d3BPQUJiclJIS3lIRUs4dzBoUlpBdnJ1WW1JQmNzdlMvVGgzRUw3ak1z?=
 =?utf-8?B?RG9DeVBIOGJKNk0wTVdCWHZPTWFieGZHbTEveGpkRkZ4OUlVOVBsTlViSzAz?=
 =?utf-8?B?c01PME5XdGs4M1ZHbXhBN0lkOW8rYmdNeDdOMDY3cUl5ckdyRHdpLzJyOWlm?=
 =?utf-8?B?WElCMzZ2cklXcDNQZ0t4Vml0L2JEajJvczFTVG4vcTVReTl1SU1MeUNHS0dK?=
 =?utf-8?B?NEYyeU1WWWN6cXB5ZnhwY3pOQ05aL2FYZ1BNRmlCd1hOd0o4djhlZ3dpVE55?=
 =?utf-8?B?NDVtdW5OcW1QZVJaQ1lZdzhPN3hwUWtiQnlLRWZWbFZYUFIzTUVMRWVWb0Ir?=
 =?utf-8?B?V2xIekxDcHFuRmZUYURPMmZLSlBvdFlpS2tXZTVXR0tCeEpKeTlIcnArVUdq?=
 =?utf-8?B?aGdPWjlSOHk2MXprVkVqMGRQRmYvR2pxWUJ4UWJMeVZKaFdLdWdndXhkZnd3?=
 =?utf-8?B?Y3cvVU4wbU84Q01MUWZ3VFBLclNzaldvc3hWNDB0TEg4U1d0cUpVajZ1SlYz?=
 =?utf-8?B?S0xLdVpoOGtGRlhRTnpIZ2YwOE9JRDNtTXhKNUUrVld0QjQ3NFRoaWthakx0?=
 =?utf-8?B?Z0x0K3FtSlBBb3VVOVFhVEhxam9SeER3RXVXOU9OSHFpUkVrbmRQS1ZvaFo0?=
 =?utf-8?B?cjk1MkJRR2xNZnJSSFV5SFdVWUFuSXFIZjU3RzY2UENiVlVCQmtCVjlHcDFD?=
 =?utf-8?B?UmorOTV0enR0RHFoWEJuR0h3UUtTRVh6WE1xaXlzY2VKVXJwTVhZeCtxYktW?=
 =?utf-8?B?SjlHdFJQcFNaRDZycnFjUXAwY0RRMWxkTlRxa1RoZlBCTitqRERhOWxWTS9n?=
 =?utf-8?B?YXhLbzVZMFBPNlMvdFBzQVlnSjAwb0EzUkVZNXE5RWVjZ3lpYjdvQTF0aHha?=
 =?utf-8?B?SW9GRVNLaHBjOGRPUkM1dzhqQjBSQVJEN01nd3AzZTNla1dNQUJUZ1pERTdu?=
 =?utf-8?B?ZmtXamFtVmdmeXZ6UTlXSkM1eDB3L21vcDJxM1J6ZzNSbHV6ai8yQXJ6TVkv?=
 =?utf-8?B?SjdmbVNxTG9JMWZrdng5Q0FUM21nLzVNWTJja2FCdnZuQlI1NDJvMnlHUHUx?=
 =?utf-8?B?TUh6RmdQc2JSOWwxemZodUhNQ0M0c3JiU25zV3p6ZzV2Z3J2VEw3QUdtdS9G?=
 =?utf-8?B?dlFzdjdJNUdEd1hsYlAvSTR4NXBUaTVkQk5oNEM4ZTU1VHU1N3E3NnpHSXFT?=
 =?utf-8?Q?Rqk8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c325123b-2d24-4437-1397-08dc64f4d2c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 06:56:24.9881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8SBbUDearaAyTXKgnI7ofRv8mQ5EfKiYu5HG7BAU+UsUv3Xv/fj2ibHgDVKSKM2c8CuFg6e/xomDNPAQWRzvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
Pg0KU2VudDogVGh1cnNkYXksIEFwcmlsIDI1LCAyMDI0IDI6NDUgUE0NClRvOiBIdWFuZywgVGlt
IDxUaW0uSHVhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzog
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KU3ViamVjdDog
UmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IG92ZXJmbG93ZWQgYXJyYXkgaW5kZXggcmVhZCB3
YXJuaW5nDQoNCkFtIDI1LjA0LjI0IHVtIDA3OjI3IHNjaHJpZWIgVGltIEh1YW5nOg0KPiBGcm9t
OiBUaW0gSHVhbmcgPFRpbS5IdWFuZ0BhbWQuY29tPg0KPg0KPiBDbGVhciB3YXJuaW5nIHRoYXQg
Y2FzdCBvcGVyYXRpb24gbWlnaHQgaGF2ZSBvdmVyZmxvd2VkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBUaW0gSHVhbmcgPFRpbS5IdWFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jIHwgNCArKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmluZy5jDQo+IGluZGV4IDA2ZjBhNjUzNGE5NC4uNmRmY2Q2MmU4
M2FlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmlu
Zy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMNCj4g
QEAgLTQ3Myw3ICs0NzMsNyBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfZGVidWdmc19yaW5nX3Jl
YWQoc3RydWN0IGZpbGUgKmYsIGNoYXIgX191c2VyICpidWYsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHNpemUsIGxvZmZfdCAqcG9zKQ0KPiAgIHsNCj4g
ICAgICAgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gZmlsZV9pbm9kZShmKS0+aV9wcml2YXRl
Ow0KPiAtICAgICBpbnQgciwgaTsNCj4gKyAgICAgaW50IHI7DQo+ICAgICAgIHVpbnQzMl90IHZh
bHVlLCByZXN1bHQsIGVhcmx5WzNdOw0KDQo+IFdoaWxlIGF0IGl0IHBsZWFzZSBkZWNsYXJlICJp
bnQgcjsiIGxhc3QsIGUuZy4ga2VlcCByZXZlcnNlIHhtYXMgdHJlZSBvcmRlciBoZXJlLg0KDQpZ
ZXMsIGl0IGlzIGJldHRlci4gV2lsbCBhZGp1c3QgdGhlIG9yZGVyIGFuZCBzZW5kIG91dCB2Miwg
dGhhbmtzLg0KDQpUaW0uDQoNCj5BcGFydCBmcm9tIHRoYXQgbG9va3MgZ29vZCB0byBtZS4NCg0K
PlJlZ2FyZHMsDQo+Q2hyaXN0aWFuLg0KDQo+DQo+ICAgICAgIGlmICgqcG9zICYgMyB8fCBzaXpl
ICYgMykNCj4gQEAgLTQ4NSw3ICs0ODUsNyBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfZGVidWdm
c19yaW5nX3JlYWQoc3RydWN0IGZpbGUgKmYsIGNoYXIgX191c2VyICpidWYsDQo+ICAgICAgICAg
ICAgICAgZWFybHlbMF0gPSBhbWRncHVfcmluZ19nZXRfcnB0cihyaW5nKSAmIHJpbmctPmJ1Zl9t
YXNrOw0KPiAgICAgICAgICAgICAgIGVhcmx5WzFdID0gYW1kZ3B1X3JpbmdfZ2V0X3dwdHIocmlu
ZykgJiByaW5nLT5idWZfbWFzazsNCj4gICAgICAgICAgICAgICBlYXJseVsyXSA9IHJpbmctPndw
dHIgJiByaW5nLT5idWZfbWFzazsNCj4gLSAgICAgICAgICAgICBmb3IgKGkgPSAqcG9zIC8gNDsg
aSA8IDMgJiYgc2l6ZTsgaSsrKSB7DQo+ICsgICAgICAgICAgICAgZm9yIChsb2ZmX3QgaSA9ICpw
b3MgLyA0OyBpIDwgMyAmJiBzaXplOyBpKyspIHsNCj4gICAgICAgICAgICAgICAgICAgICAgIHIg
PSBwdXRfdXNlcihlYXJseVtpXSwgKHVpbnQzMl90ICopYnVmKTsNCj4gICAgICAgICAgICAgICAg
ICAgICAgIGlmIChyKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcjsN
Cg0K
