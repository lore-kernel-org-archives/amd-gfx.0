Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48ACFD41C01
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 07:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF3810E742;
	Thu, 11 Dec 2025 07:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rWposipN";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B0CD10E73E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 07:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sro7gIAOyVM3lLkjAXImkgdeZXFkqK+M3DXR034IXK5W2IsWUGMJAhBTktv4pOupqniEt72WlSEnPMmSzbyT0Om/HSx4WgzTk+uNaIAlh95s2kJehzGZlVwcQra1X10yFiDjM9H4SLcVTm2jOKL8WEpYb7/TwqmHndDNoBfNeDLFTFEjpy6GLOWdTs9NqVrpoJcvg6QpiOjNAPvgkyUc+WCfL3t9lhUsdkwXxQvi+kE+XH+TWNQgrBrWWlOtSes8IS7+f5XAOZG4uCNKJK624ShT4ZtWBT6Xg8++WWTff8QMS8pAKfUb8jOZOHsDjht6XwGJ4fPtFLOaRIAzdl3NkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9ZnlwucRdaeN5ofY5nTVo1DkYd6C00fAn+m0JYQrHI=;
 b=A3Dw/3+QJAJwQKpaGyfU5SuJS3t+KCTpW17SL1o19okuu6P/EnVDfGUIIzwJfVUa40L+i1gbbf5TRGGCxfAOOq6pp9Ws13B6CJ4s10tpFWyqfx3mly/GKR6wez572z4A/Y0Z2J8jazoUcfpcVSPXyg8Lbt8g46JiVv3TL+AiVDAA3ZRgALJd3UkZcrbc6nOf729qq7TwhskjfrrbulZNYiHrwAjFzlGmxmij+96Ah0mD5+FwK5IMdQMRGnZxgh63ETWx0myyo51N7kFdfQnU95bS/9rDTVOD7vZQro1e6TWlijljLdABYO4Tny/X/1qXBfjxGEs24LXO06Dw684KPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9ZnlwucRdaeN5ofY5nTVo1DkYd6C00fAn+m0JYQrHI=;
 b=rWposipNgSgNbHTa+xoodq4oM9blfrUFbJb6YlsBlSW/LTwrP/Ju0vdmbqWqg+COmcBkbOGnRMwl/EAv+1otycsVrXDTF76uN5YgRNTtDd6gwm4ucIEbom12X7IFbr0tQLceQCDDDRfytMNc7hJCBj5uWhy2nm+oq4jSA/UcBp8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 07:51:48 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 07:51:47 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/4] drm/amd/pm: add smu pcie dpm cap & width convert
 helper
Thread-Topic: [PATCH 1/4] drm/amd/pm: add smu pcie dpm cap & width convert
 helper
Thread-Index: AQHcal1Mdaw8Pi1FBEeqZNYMo9vsdbUcD9UAgAAAe2A=
Date: Thu, 11 Dec 2025 07:51:47 +0000
Message-ID: <PH7PR12MB5997490A70601D2FAF2A90C682A1A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251211051555.652129-1-kevinyang.wang@amd.com>
 <dde64384-e87d-47d2-bec3-5f096540d2ff@amd.com>
In-Reply-To: <dde64384-e87d-47d2-bec3-5f096540d2ff@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-11T07:48:21.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS0PR12MB9421:EE_
x-ms-office365-filtering-correlation-id: 6df2bf8a-0fef-4ff6-047c-08de388a2313
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?RDhhbXpoMll6Z1d1dDlXOUY5eUhiL2ZzRlg0RHZyU0JRYXZFUkJ5WlZPMTdF?=
 =?utf-8?B?VHFOampPUVZnYkwvaWViNEpyS2VCcDBlV250SGdaeWkrZjFROTR6YjVsRlFY?=
 =?utf-8?B?YUQ5azgxUGk2bTcxMWFsYlFLWXp2Q2hqTjZpYmZHb29zY2F4K2MxMUczbUNI?=
 =?utf-8?B?bTBSUzF1MjR5VE8wb21tNWxES0ZNRG5OdGpSTVBHbHYybE5ZdWdHSm85MXI0?=
 =?utf-8?B?OXNTS1JOTVFGTURJaW51aDJvNy9VaHZJNFVXVzVvdEhSdjdleTMvOFplbWlQ?=
 =?utf-8?B?LzU2S1c3UklJNTRrK0l6R2V5UGtvL09NRklJTTc0eTh4d0Y1SlYzOGlXaDFo?=
 =?utf-8?B?UEFZZFdTZWdOS0JHRmxaT0FTeitlejdZQUlvOC8ycTlnZVY4bEFqY3NVSFRW?=
 =?utf-8?B?TnRIREpwQ21wbUVjZWZwSHhyc1k5THdsQlZSSm9sSUcrMzZwOHdoSm51Nnhu?=
 =?utf-8?B?TDk1NGJndEczb294VzNFaTdsVW5DUlorY05raWd6eFBqTjR2Y010Tlc0VmlW?=
 =?utf-8?B?a1hzVlRiMElFdWN6RXkyeHo2TUVTd2UrOHY3bng1RHpoYXF0L2VNMFJNcy9n?=
 =?utf-8?B?V0svcUxtY2RGQlhHbXFLcWgxd05sWVhQM3RzUElDVG9TTVFjZ1VBQ21vNU1s?=
 =?utf-8?B?Q0xYWW5hUnhzY3kwbytUODFnb09ZM2dHKzgvOXZrazY0U3k1M25pUzFMK0Fa?=
 =?utf-8?B?cW1uSU52YmNRWlNEbkRhV1NTWkd5dHhnQWZjOXIvbzdHSUR2NGY4QmNxcEl3?=
 =?utf-8?B?V3ZPbTNwQklpWmZiNWpXNWFxaDVwalpyVjZtczVDaHhaK0VjZzNNTGtndVpj?=
 =?utf-8?B?Sm9nb1MrNjcrMEpGOHBBZVBPQnNBd2JScTJNSUZ0OGN4K1U1YXlVOUM4Uy93?=
 =?utf-8?B?dGNzRDI2bFphVUM2dWNBUi9IVXFxQnEzcVorYyt2K2xwUVp4VjlMYWFuMTNy?=
 =?utf-8?B?UklyMm0xN0s2NUJBNVVqWTA0T1k3b3czckhpVDlobThhM2tMQ0xkUEwwSzd0?=
 =?utf-8?B?dDQxSExQeTlFMnEzYnkxZTg1ZXFQdS8rd0ttQXRqcGRBclM5aTZ0bksvUTli?=
 =?utf-8?B?a2E0NEl5OTFnRE1KS2U2cGh0cWJhbjBmVEZ1LzdKbDZJUmhDVUxYSDdKZnJM?=
 =?utf-8?B?OEdjU0wvQXdYZ3JydFpTYWRxM1ZuV0h2YndiZzNhWHorQlBSd1JDb3kvbmJY?=
 =?utf-8?B?MHM0K3JkRXdtT2lCQzVPakN4RkljRzIxSU5ZWE9pNnhMd1Y1WXhLWU9Lb1h2?=
 =?utf-8?B?TmN6Lzh4aUxqY0F2bU91M0R3Qm0rcDF3WW51V3Z2UW5zQ1ZpRkEwNTJaVGhV?=
 =?utf-8?B?RXZFa0hQY2NVV0tXeE1kbm9GTUw3RmhESnJOeVlkVW1ZOGt2aTZyZXdaaURz?=
 =?utf-8?B?MVk0MTg1Qlk4cmlDVytsM1JoQ2NZbVBhRFNCRklGaW5CdjY3NFlWWEFkSW5B?=
 =?utf-8?B?TkZIMHA1ajJSVEVEWU9udUpLUmZFY0QzQ2lad1NBL1pnTG5YdkhqbDdvb0ZD?=
 =?utf-8?B?VVZhQnlObHNHbzVSRkZVU08zLzlPTU1hdDYyUFl6eWk1ZGFva29kb1gzSFBs?=
 =?utf-8?B?WjRqTExLaGNEMkY4ZFU1RkV3R3h3dURYZGFTSjQwRFJLdXJyaGpPdDhpeGkw?=
 =?utf-8?B?a3ZzZmFRMjNGQUdwcVdaSXNtcnFjOXpTUkRNZElyZTRzQUR5aUxVUHo3UVc1?=
 =?utf-8?B?S05tZkUwYlpiNHJjMUl4RksxZ2lRMDJVQm5DWjRzdWNqSWlBVXk3S3c4R0J3?=
 =?utf-8?B?SG1zYzVXLzVveWdyL2RzS0ZVd3BiSmhuc3k3SytLZE1VRm9mTDBIS2xpSGtT?=
 =?utf-8?B?ZjVNMVhmTXgvVG5wTVozY3dqWElySGt3QUNvQUlkU2FrNmxkQTZkRGxTWDBN?=
 =?utf-8?B?QXFkK05pZENTaDlsTmVUOC84M3RkWnBZMWlxeGJ3TUFmbXRWc2EwcWc5dDVp?=
 =?utf-8?B?T3NndlhvbUI3Z1FmVnR2c1ZGUlBVQkpaQWdsT0hIMlAzSEtSNnBTZWtXQ3NK?=
 =?utf-8?B?cVV5eHFld2xtQ09JdFkweVNEWjh2K2Nxc0I5Qm9WeFFxNEgzRS96czZKSnk2?=
 =?utf-8?Q?Yj9Zbh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzBWbkRWcWEvNFB0Y0RsK2ZGOTh6RnFGOUloRjArOEs4UEROb1dmY1NDZmtI?=
 =?utf-8?B?QU9tVWZSajRzZ2YrL0ZOSTNZdXNCQWNmemk4TlJzQ0tqRFAxckNYTUdibzVD?=
 =?utf-8?B?dlBZUTEyOVMwYmZ2WVhlT3BGZzhkOHRqWFpHcSt3WHZ3NVlPNWZZVmdvNDU5?=
 =?utf-8?B?dWk1elgxMWVHU1F4ZU5BWHZlT1R6RXI5SXlFa3J2STd1R3FkVk1TalhKZ0JU?=
 =?utf-8?B?SUh0Q2RVc1pKSnNhajZHOUF0d1pjaTVkL3BGVTRQcGtEQTl6elBJQVQ0aHo4?=
 =?utf-8?B?di94QU1CeTdkZEZHUERnVUhwa2ZQWGVPZ214LzhRZkZhWVlBN1dTcmtab1Ft?=
 =?utf-8?B?OVp6L1ZGMDB1Qk96TktGeGV2SHE3d3BtblMvOU81L1l4NFRhZkpRTjJpK1Uw?=
 =?utf-8?B?aDUrWXF1M0U3enZlb2NWUEdQNEl6VTU1c1ZPTmdXSi9PcjZpd0pnN0FOUzVy?=
 =?utf-8?B?bWhFc0wrTk5VZStZNjJING9QdFJZWlFoNHJodHZUeDdwOUE2VEEreklVa0tJ?=
 =?utf-8?B?Rk16Ymd4ODhtS0hVKzVJejVtdVZsaVdOSC9KWlMrWHhjUi9vU2tnQzdPYW1D?=
 =?utf-8?B?cytqSmYrYUwvSUt1Rm1TNWFzSHBGNTZPdGtLZlVHZ1FHRVVZMUl4d24zZ1Zi?=
 =?utf-8?B?MGF0QkhpVzRrcVBIOEhrT2NUVHE2dGF0OU5xWUtSeDR5TDZZVmdESFMrTHpq?=
 =?utf-8?B?WmJTMjhTL05La0pNQTZ0OGdxbXpHY3BkRWxZMkpKVVFUQS92Tk1HWFJRMHR3?=
 =?utf-8?B?d0g5QTdvWEJYc1RwYkdrVmZmSXZHWVJwaHdub2hLWWpRbDNYU2pvOVFDaWMv?=
 =?utf-8?B?TFR3blc4TzBLWHlDL2JzMFZERDFVS1hRNEZyMmo0UHNqRWhsU2xuZ2NmK3p1?=
 =?utf-8?B?RVpVY0IyOFczc296TGRzSXBSZ3hva1BCQmlxa0pvZlBzMDVWTkZrTlR1RFlv?=
 =?utf-8?B?UHVGZWtTN04xU1Rza0NSSU4yWERSaHA1TmpQWVNrYVQ4T0dOOTFzYUEvQjYw?=
 =?utf-8?B?R3R5VXVDTE54WFB1cnR6Z3A3Yi96UjRsbWFPYm4xR2FBN0pXTTZWaFZVcEdI?=
 =?utf-8?B?MGVCTHdOWVJ4ZVBJZzBhR3hrNjM1T1hCekdJcStZMVJRK2J3VGdkSlVzSFps?=
 =?utf-8?B?VkYyck5US1Y0TXpZZTlhY0hkMHltZWYvUFhaaHU3NUNhZG15S3hvKzZZclN6?=
 =?utf-8?B?OUlNaXFySTZZQTRHRkFQMlVrMVBkOXNRczNvVlVTd05maUoyaXVHaDBiVllM?=
 =?utf-8?B?cURvVnNBVTZraWxqSFRESXk3MWh6VzZrNmg0OEE1Q0t3aG5NTk9wQUpVeGY1?=
 =?utf-8?B?MVB4MWpTYkdGU25neldzWjFEcFJFMFRPVW5EZVU3TGFJc1FTZTg1Z3pLS2x6?=
 =?utf-8?B?ZHRvakpwanV4Q1BtSjZjSzVXbEhGOEpBTGRXVzNRWmd3aWhIaFZ1WTlkSVVt?=
 =?utf-8?B?NFRFL0JHTDByd3VVZVBBWkNnRW10SXVUaGNPWGxwVlFuNzN1MW1YNDN6Qldl?=
 =?utf-8?B?emNTQThMVlY0YVRuL1JMbkFPaDFkYmlpa25oTG1ZTXJFMzhENXpTaWU4WFRh?=
 =?utf-8?B?VExxQU9NdDRZcmlIYTluSEl4NmYyOTZlTkwwa1hxeitoYXhrMTZKd3RMbWJ6?=
 =?utf-8?B?UnZBNEJKdlZ2YjYwclVTa3hWeEdYRlRRM0VPbWlVS2FBRDc5emp0eTVhTkJt?=
 =?utf-8?B?dkhnN0cxNnV6cS9ueWVrbXpNb241YnNUOGxiOW5BYkRzM1N5QWJ6eE56QllH?=
 =?utf-8?B?dWg0cSs0cDVvKzFsVHBhR3J5emhFL3BWK0drY01iWkVuREQ5ZnltaXFPZVoy?=
 =?utf-8?B?eWtvSGxmdUZHWWRQcUE4cGRZc1FHQmNhLzk2ZTB3aW5ma1NrNjgrM3hueGlu?=
 =?utf-8?B?SG8wdGpoRWZESGNwRER2cTZraE52aFNpYlg4MWxRRHczS0ZWRnhTdnBDaE15?=
 =?utf-8?B?OXZrNmcvY1NMZk02S0ZpZVdRR09ad0dicWpidmMrQURTai9iV0hOdkhCcEdm?=
 =?utf-8?B?bVdxSkRmcGpKbU1FdDJMNnhEc0xmbHNsWjZ5R0dLbWdJUTQyUGVqSXE3NXA3?=
 =?utf-8?B?Q2M5R1Z6c2hJcHhqWnZWUHJOSiswQzB2K2hBMHlXUnlPQklZWUgvZnF6UDdt?=
 =?utf-8?Q?g6kk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df2bf8a-0fef-4ff6-047c-08de388a2313
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 07:51:47.7749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sujB5bW02rJQ3VPCJgZiBi/1XDNMZTQqIeoTAwZpjgRv65ejUxilBidIbRTRoTFa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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
Cg0KPj4gQXJlIHRoZXNlIG1hY3JvcyByZWFsbHkgbmVlZGVkLCBjYW4ndCB0aGUgZnVuY3Rpb25z
IGJlIGRpcmVjdGx5IHVzZWQ/DQoNCkkgd2FudCB0byBoaWRlIHRoZSBpbXBsZW1lbnRhdGlvbiBk
ZXRhaWxzLCB3aGljaCBhcmUgY3VycmVudGx5IHVuaXZlcnNhbCwgYnV0IEkgYW0gbm90IHN1cmUg
aWYgdGhleSB3aWxsIGJlIHVuaXZlcnNhbCBpbiBhbGwgdXBjb21pbmcgQXNpY3MuDQppZiB5ZXMs
IHRoaXMgbWFjcm8gZGVmaW5pdGlvbiBjYW4gYmUgbW9kaWZpZWQgdG8gcGVyIGFzaWMuDQoNCkJl
c3QgUmVnYXJkcywNCktldmluDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6
YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAx
MSwgMjAyNSAxNTo0Nw0KVG86IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSGF3a2luZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzRdIGRybS9hbWQvcG06IGFkZCBz
bXUgcGNpZSBkcG0gY2FwICYgd2lkdGggY29udmVydCBoZWxwZXINCg0KDQoNCk9uIDEyLzExLzIw
MjUgMTA6NDUgQU0sIFlhbmcgV2FuZyB3cm90ZToNCj4gZGVmaW5lIGZvbGxvd2luZyBoZWxlciB0
byBjb252ZXJ0IHBtZncgcGNpZSBkcG0gaW5kZXggdG8gc211IGluZGV4Lg0KPiAtIFNNVV9EUE1f
UENJRV9HRU5fSURYKGdlbikNCj4gLSBTTVVfRFBNX1BDSUVfV0lEVEhfSURYKHdpZHRoKQ0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFdhbmcgPGtldmlueWFuZy53YW5nQGFtZC5jb20+DQo+IC0t
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jIHwgNTAgKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dV9jbW4uaCB8ICA2ICsrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKykN
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4gaW5kZXggYjYw
NjgyOWExZjNmLi43MzJkYWRjNGViYmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211X2Ntbi5jDQo+IEBAIC0xMzQ2LDMgKzEzNDYsNTMgQEAgaW50IHNtdV9jbW5fcHJpbnRf
cGNpZV9sZXZlbHMoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUsDQo+DQo+ICAgICAgIHJldHVy
biAwOw0KPiAgIH0NCj4gKw0KPiAraW50IHNtdV9jbW5fZHBtX3BjaWVfZ2VuX2lkeChpbnQgZ2Vu
KSB7DQo+ICsgICAgIGludCByZXQ7DQo+ICsNCj4gKyAgICAgc3dpdGNoIChnZW4pIHsNCj4gKyAg
ICAgY2FzZSAxIC4uLiA1Og0KPiArICAgICAgICAgICAgIHJldCA9IGdlbiAtIDE7DQo+ICsgICAg
ICAgICAgICAgYnJlYWs7DQo+ICsgICAgIGRlZmF1bHQ6DQo+ICsgICAgICAgICAgICAgcmV0ID0g
LTE7DQo+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgIH0NCj4gKw0KPiArICAgICByZXR1
cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICtpbnQgc211X2Ntbl9kcG1fcGNpZV93aWR0aF9pZHgoaW50
IHdpZHRoKSB7DQo+ICsgICAgIGludCByZXQ7DQo+ICsNCj4gKyAgICAgc3dpdGNoICh3aWR0aCkg
ew0KPiArICAgICBjYXNlIDE6DQo+ICsgICAgICAgICAgICAgcmV0ID0gMTsNCj4gKyAgICAgICAg
ICAgICBicmVhazsNCj4gKyAgICAgY2FzZSAyOg0KPiArICAgICAgICAgICAgIHJldCA9IDI7DQo+
ICsgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgIGNhc2UgNDoNCj4gKyAgICAgICAgICAgICBy
ZXQgPSAzOw0KPiArICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICBjYXNlIDg6DQo+ICsgICAg
ICAgICAgICAgcmV0ID0gNDsNCj4gKyAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgY2FzZSAx
MjoNCj4gKyAgICAgICAgICAgICByZXQgPSA1Ow0KPiArICAgICAgICAgICAgIGJyZWFrOw0KPiAr
ICAgICBjYXNlIDE2Og0KPiArICAgICAgICAgICAgIHJldCA9IDY7DQo+ICsgICAgICAgICAgICAg
YnJlYWs7DQo+ICsgICAgIGNhc2UgMzI6DQo+ICsgICAgICAgICAgICAgcmV0ID0gNzsNCj4gKyAg
ICAgICAgICAgICBicmVhazsNCj4gKyAgICAgZGVmYXVsdDoNCj4gKyAgICAgICAgICAgICByZXQg
PSAtMTsNCj4gKyAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgfQ0KPiArDQo+ICsgICAgIHJl
dHVybiByZXQ7DQo+ICt9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdV9jbW4uaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5o
DQo+IGluZGV4IGY0NTgxMjVlOGQ0ZS4uM2E4ZDA1YWZhNjU0IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uaA0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdV9jbW4uaA0KPiBAQCAtOTMsNiArOTMsOSBAQA0KPiAgICAgICAg
ICAgICAgIGhlYWRlci0+c3RydWN0dXJlX3NpemUgPSBzaXplb2YoKnRtcCk7ICAgICAgICAgICAg
ICAgICAgICAgICAgICBcDQo+ICAgICAgIH0gd2hpbGUgKDApDQo+DQo+ICsjZGVmaW5lIFNNVV9E
UE1fUENJRV9HRU5fSURYKGdlbikgICAgc211X2Ntbl9kcG1fcGNpZV9nZW5faWR4KChnZW4pKQ0K
PiArI2RlZmluZSBTTVVfRFBNX1BDSUVfV0lEVEhfSURYKHdpZHRoKSAgICAgICAgc211X2Ntbl9k
cG1fcGNpZV93aWR0aF9pZHgoKHdpZHRoKSkNCg0KQXJlIHRoZXNlIG1hY3JvcyByZWFsbHkgbmVl
ZGVkLCBjYW4ndCB0aGUgZnVuY3Rpb25zIGJlIGRpcmVjdGx5IHVzZWQ/DQoNClJlZ2FyZGxlc3Ms
IHNlcmllcyBpcyAtDQoNCiAgICAgICAgUmV2aWV3ZWQtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6
YXJAYW1kLmNvbT4NCg0KVGhhbmtzLA0KTGlqbw0KDQo+ICsNCj4gICBleHRlcm4gY29uc3QgaW50
IGxpbmtfc3BlZWRbXTsNCj4NCj4gICAvKiBIZWxwZXIgdG8gQ29udmVydCBmcm9tIFBDSUUgR2Vu
IDEvMi8zLzQvNS82IHRvIDAuMSBHVC9zIHNwZWVkDQo+IHVuaXRzICovIEBAIC0yMTIsNiArMjE1
LDkgQEAgaW50IHNtdV9jbW5fcHJpbnRfcGNpZV9sZXZlbHMoc3RydWN0IHNtdV9jb250ZXh0ICpz
bXUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgY3VyX2dlbiwgdWlu
dDMyX3QgY3VyX2xhbmUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hhciAqYnVm
LCBpbnQgKm9mZnNldCk7DQo+DQo+ICtpbnQgc211X2Ntbl9kcG1fcGNpZV9nZW5faWR4KGludCBn
ZW4pOyBpbnQNCj4gK3NtdV9jbW5fZHBtX3BjaWVfd2lkdGhfaWR4KGludCB3aWR0aCk7DQo+ICsN
Cj4gICAvKlNNVSBncHUgbWV0cmljcyAqLw0KPg0KPiAgIC8qIEF0dHJpYnV0ZSBJRCBtYXBwaW5n
ICovDQoNCg==
