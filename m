Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A847ACAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 06:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E1B210E840;
	Thu, 25 Sep 2025 06:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ODGIifdc";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624FB10E840
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 06:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivUxc6xZr5euyGKCyfPBnPJB6E5NZxzOTctfUFPS/q76eZXFAXpucYSz8XGh8sNkw0MGtRSuktomc6/T3vSdmsVoiD1viNxz8uT/JPsIma68YKHKbXOE0vhzwCfus0CkXpo+M9XmKI7T6Al+kDIhE+EDb9TTHxEPZeeDjAxFU/ZHDIVS8mZdF9gVLDPcJOWDpRt7KVXfXYSSCnXvP7L1Q3j20C2iK1h4FmYdVjtqbsZd3sypYsMXp3vzbig4rLRQs4ateE3L3VMeD2Q7uE5DAbSVZZj6GzLqeyd8xs7XCoJR84hTYd8+snwJRhSlhQzumXh+lR8xJUNV0DPiIxFdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KAZCs+dkjicqGL/yXBidGpYTguY1qer/i4spN0Cr8o=;
 b=bufc9jUzRwXq8P7VTEbpBkLi/d0Qn0IVr35WSiXIAl56fw7wsOb0vwqhqN0n41/xKBPmC3TCkrvOPGphRWlWvbxnQkwDwU7y1qvngamf81JFKn0+Qvr1uJAScWFuZVzXtWu7QhUoXWpSA64xaCWH9YB3c1i7gp9KOE0X3JM62OAtP4Q8MRDEZBZyjfdd8+eBmamZ1MFSNlYdo3VwuDA4aKby79riKiSQNbtqUxz+e7TMRlEKwVT0c985Swgpex12/7giypc6hKTiN/ZTQv+abMVsvkxQpELP4MOrH/upFpOIlqqtald0B6Veh/BSbIvOCQtsvpjfPsHYs5vWeR/n3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KAZCs+dkjicqGL/yXBidGpYTguY1qer/i4spN0Cr8o=;
 b=ODGIifdctUWkA2fE7bdw8L2RxnLYeQvNE5Cua7cVMGJaEnm3Eb8Yrbm51TUUVnfh2UWVZewFiouAgIVZhLuTRigeqi/Y6O+YOsmlWBbUTkt0jtJptuswMz1aE4s7PwQZ0Xm3sG/jWBXOIGJ+0dPoTPDPb0tOAoo1ePaekSnXhRc=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 06:41:24 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 06:41:24 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Thread-Topic: [PATCH v4 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Thread-Index: AQHcLWgTnPLagjuNFECF58wZePJndLSi7+WAgAB93wCAAAFusA==
Date: Thu, 25 Sep 2025 06:41:23 +0000
Message-ID: <CY5PR12MB6369FE21B3A3079D6E658701C11FA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20250924152929.2234747-1-yifan1.zhang@amd.com>
 <ccc729b8-640e-6e71-3522-7208413990f0@amd.com>
 <DS0PR12MB7804DBACD17E1583644F9430971FA@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB7804DBACD17E1583644F9430971FA@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-25T06:18:54.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SA0PR12MB4445:EE_
x-ms-office365-filtering-correlation-id: f0fbad74-5b70-4c9f-61f5-08ddfbfe8b9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?WjlzU1RKZmptZmV4cWxQS1JyZVJUWXRtMlM0aVd1anpBSEJvL3J4akpUK2d3?=
 =?utf-8?B?T3pwb0NIQjdjRmg0K0RWSVA1NkttUDd6Zi80ZkxpblE0TXNwOFNBaFNSeFJB?=
 =?utf-8?B?aFB6eVJVVWhwVXYrOWJaM2p0N2QzSWdBTzh4SlFyNlpEaWUwQ1dYdzg2R2tL?=
 =?utf-8?B?YkNkTlQ2YlZ4dDh2N05uTVhteHFEcmpVTUh0eUxKekJhQVB1SGZGVXVPcUxz?=
 =?utf-8?B?NnpoMVVpVWpNeTlMaEdNQjRSYzNWenFPM1ZlQ1lGOUw2bE8yMGZaU0RFYTht?=
 =?utf-8?B?L1lTNHdpR29lOEhhZ3hMRWhwYUcrd1dxRnd4WVk3ZDNRUFBtK3lDcVJGMWlu?=
 =?utf-8?B?ei93VW5uTEhxaGpiNG5LK3VXcVhpbGQ4OUJyc1NFUU1CMElUZktRQko1cVhD?=
 =?utf-8?B?OU80QW1UQXY2c2JkM0dBcDY5b0FjbHlCSm9pYjVuVW5iSTY1QmxuWTFEREM5?=
 =?utf-8?B?MzdBYW5rMEU3WlBFRzRlNEMwZ2FrQmVlZ2lkcVFzdlMvckJHMXdKNGYyQUpY?=
 =?utf-8?B?L2lUYk10QzVFWnNTOGVIRXBvSTRVbGIwRUFTMnpzdFdxNEVJVzRvU1FablZJ?=
 =?utf-8?B?U3Q4dE4vRTVmYjZjY0szRENPbzVsQytCblJvZEtNaXdWcXE3eGJZNWlCdjBr?=
 =?utf-8?B?UDI0TUhSK1dFQXFUWHZ1WkR3VEJZK2h5Rm1LZi92Z1BpWW1xZDREWGYwR1Nh?=
 =?utf-8?B?amxhRHBMMVB2SDBIMlViTzdhblIwbUIxUjJ3aUx0R2FVQVdiNUk1eG45Qk9N?=
 =?utf-8?B?b2JWd0xtNjVoQ1VKSHFXdzhyV09GZnhCOCtsazcvS3p3L1pqekg3UDJCalhr?=
 =?utf-8?B?S0l1QVg5c1B3aGlYUU9jWVhrZG53dE9aYXRtMHNkeFRGL2pBV2xtNGt6b2p0?=
 =?utf-8?B?VHI5M1UxVHIyZS9QYlRPRW1IejFpUnNMS3NKQTBWT2dWMFBqUFozOW4wcE13?=
 =?utf-8?B?TGo5OVgwQ000elZyYUIxaDhpZHNVbkR3M2FIajRrQm5oM21md1ZGUW1BUEVl?=
 =?utf-8?B?K2VRNVVuRWtSVDNQSnYyRXo1dHVwZko3bDA2eHdRZjU4WURCSERIbXVrM0x1?=
 =?utf-8?B?NTI1QzRIU2dERW5jcnhlZVVweVlaWHhMOHJMT1ZnY0ZhQytKZGJVakdhR0JX?=
 =?utf-8?B?MnRVM1ltdXNuQWRUNVBweHdxNnVRaUpwMU9PZ3J0QUxpTFhJMytxaEVYbWw0?=
 =?utf-8?B?Qzg0c1FmeGlUZjkwaXNJenhGSC9tRitCOG1NdFBoYVIyTzJ1UzVFanhFOUtu?=
 =?utf-8?B?bzl4NXd0dU1GWHJnUXFYNWpuR2JOczlLMkdYeWppZWpUWndiaEoyaEtQM3pL?=
 =?utf-8?B?WGxET2VFMVlGVFdKclJkR3RTTUR3TVpNOHR4Rng2THBOakdPWHhtQUFxVE81?=
 =?utf-8?B?YmJrUUVJRFNENjBJZ1hGZ0pBYzlrZ1FQckRXMkFQYlJqR242Ym5jUWZzcUg5?=
 =?utf-8?B?U1NuK3p0ZGZNNGplcUdiT2ZiQVloa1o0TUNtOTNHUVl0TkM1eHBtUmdsVXhm?=
 =?utf-8?B?UW42YytrTXp5MUlZbmN6L1RqRnNiZ2RUZkwyOXJLTU9JSElXMXh0R0lPd1VZ?=
 =?utf-8?B?ejBYYktTeURtQzFWZ2pwZ3pjVzlaYzlta0wrZUNiNXoweG9KRytSQStEUmdR?=
 =?utf-8?B?TzlnODd0cmU1T0dNdVdwR1d2dmkvQ2Qxb2xwczV2THdhMEtZNUFscW1oRHg1?=
 =?utf-8?B?aWhqdUFHYmU0NjU1b3oxTm1UemRiZzJXSkZVU0V5VVZGWG1xTVJNMkNzbjlh?=
 =?utf-8?B?WEJtNVFBdWFMNjZwZnJLdktNZjhvT2x0SHMzU3Iyd1pHRGwvTkhSK1hFY0w0?=
 =?utf-8?B?ZW0zcTQ1dktyRDBpd1NCczF5Y1NGQ3ZGTEw1TzlVaDRGMnZLc29nZmJvdGQy?=
 =?utf-8?B?Zm1QTXhlOGhTSkh3Uy8xN01BRTdCUTY1UXMzTCtQVFdubWR2WGo3N0FFN1pW?=
 =?utf-8?B?RmM3ODVLb0xNSUZKcTdURXh3NU1xRU4razFUd2VoYTlUUmluemQ1bmlrZTVU?=
 =?utf-8?B?YWFEai9jTmd0aDdXT1poMy8yem1jZmFIdGRYaC9tbjdHWmRpRGdKc29weHBt?=
 =?utf-8?Q?WDRlxz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVppbVZURFpPbUNqR2ljeGllVko2ajh6NFFsNTlqRDFIalBMMXRxT2tUSUEw?=
 =?utf-8?B?Rno1K3VoZ0VEeXlLaTZ6TGlOa0pIRWtCYXA4Z29BVkhobnVLMit4cjFmRVlU?=
 =?utf-8?B?TFV6dGN5SXBxNG5jcGtFaXJkMkhVRFRXUDU3U3lLRmVaZGtTcFVTYTl0NUJN?=
 =?utf-8?B?NWF6WHJXanMvRDZTcGxPYUltL25zZDY0NU9pUVRZdFFhZFJTamcxZjRkYXEr?=
 =?utf-8?B?WDBuTkdHQnZjeUJOQ1V2Qjh1UldXNVlpRWpEUjhUT2YwdEZYZzdIdlhYNHhH?=
 =?utf-8?B?bnBzdm5qUWZWV3NhME90aG5PVHl0dzRTb0pTWWM1OTZENE5GeXpTTVY1NXNI?=
 =?utf-8?B?eDYzSFRCUGRsUU9SV05iTDFYWFR2UXVDV2g2UnJ2SzdZeWJRTk93ZmoyZnZH?=
 =?utf-8?B?bDJBODBnR2YrTU9xTUk5MWp6eE9RQ01uSWNXUk1TVVlxaEdTVVN1aFdXWm83?=
 =?utf-8?B?YlVJYmhwdnY4UFBHQjVQa055L2ZEU1duNDBzK1BDTDRGcVRWZ0o4TlozajdD?=
 =?utf-8?B?NW9MbW5yaWZSZ0R6SkZtUkpRSEZ3L2ZlQ3N2V0gwOXhuVlcwaDY2OWZzcWR6?=
 =?utf-8?B?dGRxOXNZd1B0dHhPa1RadzR4Y0htUXdTckpUblJLODViUVNpdFBRK2prR1oy?=
 =?utf-8?B?bDBTdGRaRDNxVTVtREhWRW52Wms0OTZNQXhrd0I3dmp1M21RVTdPNm92elEr?=
 =?utf-8?B?a1ZYeERrYndkVXdzNW4vZ1pkLzY2MXFSU2JVUXhjVUxGUTBVLzF5UDA0dGt3?=
 =?utf-8?B?bGMxczhmQVYwN0srL3pGYTE1TUhyN0NpVWd4SGtjSy9JRmtNTTBTOFFkMllF?=
 =?utf-8?B?N0xhckpTQ0VlSFBVY21tdzdxaW82YlFIRTkrNEJrcTY4a2hIZC84cVh2TFRr?=
 =?utf-8?B?RU9Zcjg5UnVkWnVDZnhZQlIwODB2VjZkcWpabUI2NmZDSDA1enNxelpEZ2lB?=
 =?utf-8?B?MFRsbWlxbXlET01EdGVRNWRiTnQ2SVBLWFBzYllQanNHUGpETVE2T1NQY3ds?=
 =?utf-8?B?ZkdGMUNEQ29iWlRpd1IzcU0xU1dLa3pMSUdvNk9UZURLVEowb0JwWnhaNzRD?=
 =?utf-8?B?bE16QWJJMkRjclRyRWduQTN3dko3U09OM0ZQSStUZklPdHRLWmdLTDBJeURp?=
 =?utf-8?B?SndydDFEVkNaTDNWdFFGcG9yTktMNzBBcDFpQUdJTlBHRlhYWUNqOUlCc1Q0?=
 =?utf-8?B?YnR1MzU5TmRza08yYTVVMEZmSUxFWkRUUWNBT0ozOTltTkZqVG05SHhibkdI?=
 =?utf-8?B?RC96RllaRVc3TUNIakNFRlZrc1BFckdPSmxoczFsQVV3ekljZ0ZlM3RJYnBl?=
 =?utf-8?B?UTJRUm0xdVRUK3hmSDlVMVdyZFVoZy85akI2UjlGZkQ5SFdvR0xVWXhSM2Zr?=
 =?utf-8?B?YXpVVFlIcTBkQi8xOUFURHBad2tCUXlwWS8waFNiTEZ0ZDczTThYSVlGbE1w?=
 =?utf-8?B?K0s4MUxzNXFYMGM0T0VWM0MrbXd6emVyQUROMXBZY0JweWtGT1NCbDQwT0c5?=
 =?utf-8?B?S3QzY240ZFJ5alpqVGY2RjlDR0JlK21SVU5jUk5aTCtodTVONmtuUmxKTUc4?=
 =?utf-8?B?Uk1YM08xMUZRZEZTemt5S1VoNlpuZTVsMGZxSVcyVUkyU0NMcEdIQytEUGFW?=
 =?utf-8?B?alVReWd0V2pMbmE4d2xMWW14WnpTZ3dudlVScFNBY0kyZW1ZMTh0bjNoY1dv?=
 =?utf-8?B?cUNQSjl1SEZmbHdlbjdFQ2ZZY0JuOGNGSkMvMjZFSDdDKzdoV0NKeDJzYzFT?=
 =?utf-8?B?dlgzMjE1azg2ZXAvSnVXZmU5bytwWFlBTC9QMk9rd2s3MTI5ZW91U21OM0E2?=
 =?utf-8?B?NE9JNFBLQ1VnV2c4b2l3OVlhU1IzbFh2YUo2TjFEQTFmQTYrQUxpTC9nb2tB?=
 =?utf-8?B?VnJwY0krTFI0Sy9Lc1FaSXpHZncxelNnU1psOG5paGJBb05BUDlUeE10ak1m?=
 =?utf-8?B?NDRQSHhyZVBSc01TaG5pcXkwM1FJY1M4emt5Qm96R203Q2ZHRG5TbWlsSVlx?=
 =?utf-8?B?aDNQMzROVWRLS2NGcnhuZ2htZEdmWlFmN3hpS0NzNklOL0tHRVVUS3ZFMHJ0?=
 =?utf-8?B?YlpZK3VjQm1ROWJsNG94QU1rR2U4ZFcxS29WK3lKWENwUm51R3kzVTR3RHFr?=
 =?utf-8?Q?FN+c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fbad74-5b70-4c9f-61f5-08ddfbfe8b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 06:41:23.8924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXYPh3nZPfW5wHvlAffa8ecJPQoNYAd01EtpYYcJbxxaGKaCG1kjj6BcTPpj+rZd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
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

W1B1YmxpY10NCg0KVGhlIGludGVycnVwdHMgYXJlIGZyb20gS0dELCBzdGlsbCBhY3RpdmUgYWZ0
ZXIgZmx1c2ggaWhfd3EgYW5kIGtmZF9kZXYgaXMgZnJlZWQuIEFuZCBhZnRlciBrbm9kZSBpcyBm
cmVlZCwgbm9kZS0+aW50ZXJydXB0c19hY3RpdmUgaXMgYWxzbyBpbmFjY2Vzc2libGUuIFRoZSBy
YWNlIGNvbmRpdGlvbiBpcyBhcyBiZWxvdzoNCg0KSW50ZXJydXB0IGhhbmRsaW5nICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN3aXRjaCBwYXJ0aXRpb24gcHJv
Y2Vzcw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAgICBmbHVzaF93b3JrcXVldWUoa2ZkLT5paF93cSk7DQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICAgICBkZXN0cm95X3dvcmtxdWV1ZShrZmQtPmloX3dxKTsNCmFtZGdwdV9pcnFfZGlz
cGF0Y2ggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQph
bWRncHVfYW1ka2ZkX2ludGVycnVwdCAgICAgICAgICAgICAgICAgICAgICAgICB8DQprZ2Qya2Zk
X2ludGVycnVwdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAg
ICBrZmRfY2xlYW51cF9ub2Rlcw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgIGtmcmVlKGtub2RlKTsNCnNwaW5fbG9ja19pcnFz
YXZlKCZub2RlLT5pbnRlcnJ1cHRfbG9jaywgZmxhZ3MpOyAgICAgICAgfA0KLy9OVUxMIFBvaW50
ZXINCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6YXIsIExpam8gPExp
am8uTGF6YXJAYW1kLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjUsIDIwMjUgMjox
OSBQTQ0KVG86IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT47IFpoYW5nLCBZaWZh
biA8WWlmYW4xLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
Q2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEt1ZWhs
aW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJFOiBbUEFUQ0gg
djQgMS8yXSBhbWQvYW1ka2ZkOiByZXNvbHZlIGEgcmFjZSBpbiBhbWRncHVfYW1ka2ZkX2Rldmlj
ZV9maW5pX3N3DQoNCltQdWJsaWNdDQoNCj4gUmFjZSBpZiBhbm90aGVyIHRocmVhZCBpbiBiL3cg
a2ZkX2NsZWFudXBfbm9kZXMNCg0KVGhpcyBjb2RlIGlzIHRoZXJlIGJlZm9yZSBjbGVhbnVwIG9m
IG5vZGVzLg0KICAgICAgICBmbHVzaF93b3JrcXVldWUoa2ZkLT5paF93cSk7DQogICAgICAgIGRl
c3Ryb3lfd29ya3F1ZXVlKGtmZC0+aWhfd3EpOw0KDQpTaG91bGRuJ3QgdGhlIGludGVycnVwdCBo
YW5kbGluZyBjb2RlIGNoZWNrIGlmIGludGVycnVwdCBoYW5kbGluZyBpcyBlbmFibGVkIHJhdGhl
ciB0aGFuIGNoZWNraW5nIGluZGl2aWR1YWwgbm9kZSBOVUxMIHBvaW50ZXJzPw0KDQpUaGFua3Ms
DQpMaWpvDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBZYW5nLCBQaGlsaXAg
PFBoaWxpcC5ZYW5nQGFtZC5jb20+DQpTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDI1LCAyMDI1
IDQ6MTkgQU0NClRvOiBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5j
b20+OyBZYW5nLCBQaGlsaXAgPFBoaWxpcC5ZYW5nQGFtZC5jb20+OyBMYXphciwgTGlqbyA8TGlq
by5MYXphckBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzJdIGFtZC9hbWRrZmQ6
IHJlc29sdmUgYSByYWNlIGluIGFtZGdwdV9hbWRrZmRfZGV2aWNlX2Zpbmlfc3cNCg0KDQpPbiAy
MDI1LTA5LTI0IDExOjI5LCBZaWZhbiBaaGFuZyB3cm90ZToNCj4gVGhlcmUgaXMgcmFjZSBpbiBh
bWRncHVfYW1ka2ZkX2RldmljZV9maW5pX3N3IGFuZCBpbnRlcnJ1cHQuDQo+IGlmIGFtZGdwdV9h
bWRrZmRfZGV2aWNlX2Zpbmlfc3cgcnVuIGluIGIvdyBrZmRfY2xlYW51cF9ub2RlcyBhbmQNCj4g
ICAga2ZyZWUoa2ZkKSwgYW5kIEtHRCBpbnRlcnJ1cHQgZ2VuZXJhdGVkLg0KPg0KPiBrZXJuZWwg
cGFuaWMgbG9nOg0KPg0KPiBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFk
ZHJlc3M6IDAwMDAwMDAwMDAwMDAwOTggYW1kZ3B1DQo+IDAwMDA6Yzg6MDAuMDogYW1kZ3B1OiBS
ZXF1ZXN0aW5nIDQgcGFydGl0aW9ucyB0aHJvdWdoIFBTUA0KPg0KPiBQR0QgZDc4YzY4MDY3IFA0
RCBkNzhjNjgwNjcNCj4NCj4ga2ZkIGtmZDogYW1kZ3B1OiBBbGxvY2F0ZWQgMzk2OTA1NiBieXRl
cyBvbiBnYXJ0DQo+DQo+IFBVRCAxNDY1YjgwNjcgUE1EIEANCj4NCj4gT29wczogQDAwMiBbIzFd
IFNNUCBOT1BUSQ0KPg0KPiBrZmQga2ZkOiBhbWRncHU6IFRvdGFsIG51bWJlciBvZiBLRkQgbm9k
ZXMgdG8gYmUgY3JlYXRlZDogNA0KPiBDUFU6IDExNSBQSUQ6IEAgQ29tbTogc3dhcHBlci8xMTUg
S2R1bXA6IGxvYWRlZCBUYWludGVkOiBHIFMgVyBPRSBLDQo+DQo+IFJJUDogMDAxMDpfcmF3X3Nw
aW5fbG9ja19pcnFzYXZlKzB4MTIvMHg0MA0KPg0KPiBDb2RlOiA4OSBlQCA0MSA1YyBjMyBjYyBj
YyBjYyBjYyA2NiA2NiAyZSBPZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCBPRg0KPiAxZiA0MCAwMCBP
ZiAxZiA0NCUgMDAgMDAgNDEgNTQgOWMgNDEgNWMgZmEgMzEgY08gYmEgMDEgMDAgMDAgMDAgPGZP
Pg0KPiBPRiBiMSAxNyA3NSBCYSA0YyA4OSBlQCA0MSBTYw0KPg0KPiA4OSBjNiBlOCAwNyAzOCA1
ZA0KPg0KPiBSU1A6IDAwMTg6IGZmZmZjOTBAMWE2YjBlMjggRUZMQUdTOiAwMDAxMDA0Ng0KPg0K
PiBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiAwMDAwMDAwMDAwMDAwMDAwIFJDWDogMDAwMDAw
MDAwMDAwMDAxOA0KPiAwMDAwMDAwMDAwMDAwMDAxIFJTSTogZmZmZjg4ODNiYjYyM2UwMCBSREk6
IDAwMDAwMDAwMDAwMDAwOTgNCj4gZmZmZjg4ODNiYjAwMDAwMCBSTzg6IGZmZmY4ODgxMDAwNTUw
MjAgUk9POiBmZmZmODg4MTAwMDU1MDIwDQo+IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAw
MDAwMDAwMDAwIFIxMjogMDkwMDAwMDAwMDAwMDAwMg0KPiBmZmZmODg4RjJiOTdkYTBAIFIxNDog
QDAwMDAwMDAwMDAwMDA5OCBSMTU6IGZmZmY4ODgzYmFiZGZvMDANCj4NCj4gQ1M6IDAxMCBEUzog
MDAwMCBFUzogMDAwMCBDUk86IDAwMDAwMDAwODAwNTAwMzMNCj4NCj4gQ1IyOiAwMDAwMDAwMDAw
MDAwMDk4IENSMzogMDAwMDAwMGU3Y2FlMjAwNiBDUjQ6IDAwMDAwMDAwMDI3NzBjZTANCj4gMDAw
MDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAw
DQo+IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmVPN0ZPIERSNzogMDAwMDAwMDAw
MDAwMDQwMA0KPg0KPiBQS1JVOiA1NTU1NTU1NA0KPg0KPiBDYWxsIFRyYWNlOg0KPg0KPiA8SVJR
Pg0KPg0KPiBrZ2Qya2ZkX2ludGVycnVwdCtAeDZiLzB4MWZAIFthbWRncHVdDQo+DQo+ID8gYW1k
Z3B1X2ZlbmNlX3Byb2Nlc3MrMHhhNC8weDE1MCBbYW1kZ3B1XQ0KPg0KPiBrZmQga2ZkOiBhbWRn
cHU6IE5vZGU6IDAsIGludGVycnVwdF9iaXRtYXA6IDMgWWNweEZsIFJhbnQgdEVyYWNlDQo+DQo+
IGFtZGdwdV9pcnFfZGlzcGF0Y2grMHgxNjUvMHgyMTAgW2FtZGdwdV0NCj4NCj4gYW1kZ3B1X2lo
X3Byb2Nlc3MrMHg4MC8weDEwMCBbYW1kZ3B1XQ0KPg0KPiBhbWRncHU6IFZpcnR1YWwgQ1JBVCB0
YWJsZSBjcmVhdGVkIGZvciBHUFUNCj4NCj4gYW1kZ3B1X2lycV9oYW5kbGVyKzB4MWYvQHg2MCBb
YW1kZ3B1XQ0KPg0KPiBfX2hhbmRsZV9pcnFfZXZlbnRfcGVyY3B1KzB4M2QvMHgxNzANCj4NCj4g
YW1kZ3B1OiBUb3BvbG9neTogQWRkIGRHUFUgbm9kZSBbMHg3NGEyOjB4MTAwMl0NCj4NCj4gaGFu
ZGxlX2lycV9ldmVudCsweDVhL0B4Y08NCj4NCj4gaGFuZGxlX2VkZ2VfaXJxKzB4OTMvMHgyNDAN
Cj4NCj4ga2ZkIGtmZDogYW1kZ3B1OiBLRkQgbm9kZSAxIHBhcnRpdGlvbiBAIHNpemUgNDkxNDhN
DQo+DQo+IGFzbV9jYWxsX2lycV9vbl9zdGFjaysweGYvQHgyMA0KPg0KPiA8L0lSUT4NCj4NCj4g
Y29tbW9uX2ludGVycnVwdCsweGIzLzB4MTMwDQo+DQo+IGFzbV9jb21tb25faW50ZXJydXB0KzB4
MWxlLzB4NDANCj4NCj4gNS4xMC4xMzQtMDEwLmExaTUwMDAuYTE4Lng4Nl82NCAjMQ0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQpSZXZpZXdl
ZC1ieTogUGhpbGlwIFlhbmc8UGhpbGlwLllhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jIHwgMTAgKysrKysrKysrLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYw0KPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYw0KPiBpbmRleCAzNDljMzUxZTI0MmIu
LjA1MWEwMDE1MmIwOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2RldmljZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZp
Y2UuYw0KPiBAQCAtMTEzMyw3ICsxMTMzLDE1IEBAIHZvaWQga2dkMmtmZF9pbnRlcnJ1cHQoc3Ry
dWN0IGtmZF9kZXYgKmtmZCwgY29uc3Qgdm9pZCAqaWhfcmluZ19lbnRyeSkNCj4gICAgICAgfQ0K
Pg0KPiAgICAgICBmb3IgKGkgPSAwOyBpIDwga2ZkLT5udW1fbm9kZXM7IGkrKykgew0KPiAtICAg
ICAgICAgICAgIG5vZGUgPSBrZmQtPm5vZGVzW2ldOw0KPiArICAgICAgICAgICAgIC8qIFJhY2Ug
aWYgYW5vdGhlciB0aHJlYWQgaW4gYi93DQo+ICsgICAgICAgICAgICAgICoga2ZkX2NsZWFudXBf
bm9kZXMgYW5kIGtmcmVlKGtmZCksDQo+ICsgICAgICAgICAgICAgICogd2hlbiBrZmQtPm5vZGVz
W2ldID0gTlVMTA0KPiArICAgICAgICAgICAgICAqLw0KPiArICAgICAgICAgICAgIGlmIChrZmQt
Pm5vZGVzW2ldKQ0KPiArICAgICAgICAgICAgICAgICAgICAgbm9kZSA9IGtmZC0+bm9kZXNbaV07
DQo+ICsgICAgICAgICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0K
PiArDQo+ICAgICAgICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJm5vZGUtPmludGVycnVwdF9s
b2NrLCBmbGFncyk7DQo+DQo+ICAgICAgICAgICAgICAgaWYgKG5vZGUtPmludGVycnVwdHNfYWN0
aXZlDQoNCg==
