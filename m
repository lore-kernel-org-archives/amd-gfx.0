Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CEDCCD192
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4A710E45D;
	Mon, 13 Oct 2025 14:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3JbLRQEm";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87FD910E111
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHTdN/5HEYT4EWMhajWriPlkUOX1WsKI7JkBwMugynNG+MUfMsrc/NW7nSnBLwxufby9+I5OLVit2jUoKBjA48sEx/HvLes5Xrt6QZQcKkQYsDIDhDWXOBWQMe2G21btwHMz/BpkCMP4U3pdEEG0yd/Zr1PPdHbV//2J4wO96M35Meha5hKnJM69i0n5xg8R5735lbLXB7yFITQ/MG19UjWtdlrHv4y/KemsTtX+xOFom/WB0byUc/HobMdZ7VSm91sbK9Ou9S0+kKJ8+VzXiXOOadj7QfETkLMuw3ES/bIHFwh7HT5yL0DOhEyX+nkUKXRab72xqrCFmDw290UfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZ7t+ThVjEfYgn1kuluNNCLbF7z1tuC80GzHhjV0CIc=;
 b=UblUG2Xcdn+ED6VeXwfRhdqj5hlkKCdwXflWSvpiZLyxfARbyxSFWsQC4GAZXNsIfTPTd/UqG1VSjsQmCMulWkhOJ/1O2bTnKUnAQ2ZYEJmYkpn8pOWUiOa1TXCit3X301/R9ZIvU4VkZRkUP7ql30JrXbSXFaQFbcsFL2+0h+1eErDf7tAz3Zu2UUVrDrUbBIx28NiZgZFMkSxg3/y+kzt+4Ngkwzy3ZCI2Xoq07b5heTK/2gXutVchuXxLOjO8RFZh3Wyoi8Q/ctumBYO8d2iwc0ZfDvqAp5hGxfygJVfuXoteavS/ZRf5WhwK0I41QrvQDDnTkzKeGLwOWhIuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZ7t+ThVjEfYgn1kuluNNCLbF7z1tuC80GzHhjV0CIc=;
 b=3JbLRQEmv2x08znyjRlTAflmoS7b3UlilpCcI9suRQ89dF7hJKFDw7sb3lhXTSavdGhs+7sja4gbuk493P+bLEFmSYdZjWqtBHaaVw3M5PVvHQIbcWlH5wmuomnRRz0sULH9KkgeupA2MbNS4Kj5QXhB9yUIMSM5V2KVtWYDMhU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 14:14:56 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 14:14:56 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/7] drm/amdgpu/userq: fix SDMA and compute validation
Thread-Topic: [PATCH 2/7] drm/amdgpu/userq: fix SDMA and compute validation
Thread-Index: AQHcOisW0h9hxPSqy0iafKTpVKEuRrS/vLWggABdiwCAAAH7MA==
Date: Mon, 13 Oct 2025 14:14:56 +0000
Message-ID: <DS7PR12MB600582007B0A04E9FFCDEF34FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-2-alexander.deucher@amd.com>
 <DS7PR12MB6005B24D4FB1959CA75A6B3DFBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_Mf2kH0YvkMBFnOFRo4zGCD=3X4Kcc2mqi4i5p_6h5a3w@mail.gmail.com>
In-Reply-To: <CADnq5_Mf2kH0YvkMBFnOFRo4zGCD=3X4Kcc2mqi4i5p_6h5a3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T13:50:14.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA0PR12MB8207:EE_
x-ms-office365-filtering-correlation-id: 1a73f664-3a03-4734-4ccd-08de0a62e2d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UE14ZSt0cklWWWpVSElKQkVhQ3dFcmxzNlhLQ2M1OEtsWGNCVWNkYjFEM1Jj?=
 =?utf-8?B?RTRzRkg5T0E1bnd1MG5JL0xCMHlSenRDU1pVNEtzeVI5TEx6TGNydGx3bXJW?=
 =?utf-8?B?WWVWZklyV2pYTjhpRHNRY2ZkdThuT1RMSWpKTm1TQitxTEgyUUlCTXluSjg0?=
 =?utf-8?B?Ymt6R1ZLRTk4cWNWaVN6eEs1ZXBCQy84dExKeGlGditVcXFjdkxlemxFcmYr?=
 =?utf-8?B?MG1YVkRiM01tQlgxZkM4eDNRZkU1U1JsdERqSGE1Rm9CYVF4S0l2ckNGTDFS?=
 =?utf-8?B?ZjZNeHlmb09wTlYyZnRJUmVKUGlWbmd0ZmR0RENjR3lIbmVSb0hSR2x4OXpo?=
 =?utf-8?B?Y3IzMWh0WXNWdjBjRWJYc3JVR3gxbXRnNjFBZlcyRXpaaXZhR0Uyc1Q2N3lh?=
 =?utf-8?B?ME9wV1I4dm9aWitEL0lEOHlPVXBBbmljOFRxeDZPa1p1M2pCWU45elFDWHRE?=
 =?utf-8?B?MU95R0kwbGo5UXNiSHlwbDd3b214bHFXUnJvVHBkY1U4c05NMzN3THpyNjd3?=
 =?utf-8?B?WVhEQnRmMHJPUXQ1YVpzMmhnaitQYWh1L2FxcVZwVzlxUTNETExQdnBielAv?=
 =?utf-8?B?WFNiTlMydGsvNEV6MFFoRWJwdklxNVNyQmJ5b2pwbjB1S2ZCRW9sM2ZyOTFZ?=
 =?utf-8?B?ZVZidDltZ2p1Zks3dzZHaHlTV3ZMWmM5SzBpM09sSXEyN2VIeVkyV2xkdjg1?=
 =?utf-8?B?RXBJajYyRWdsNHNHcGNTVGt0VU1zTWgxRzE3OFZvcVFOb3JaVHVjSDg2MzFF?=
 =?utf-8?B?UDZiRWczNk01eXp0R1pRWmZZbTRaMFNLVmo1aFR5ZksxZThReE9nUUNlelcz?=
 =?utf-8?B?M242OHJXVDBGRHl3VmdpWVBTRWlmd3JwQmpoa3Z0VzA1TTVuVmpBdnp2TWl2?=
 =?utf-8?B?dGJwYW9RK3N5bHpSL28xeW50V3M3UWMwWTBqR0NPNE1zQk56ZDNVaGFJVXZl?=
 =?utf-8?B?Q2ZCYmM5ci9rM0dhWGVsOEFEMjRXdzZ0SklqZjhibXYyVEhuK3J0YXFNSHJ6?=
 =?utf-8?B?bEZXcnUvdFk1eTRqQTJKUXE1b0Z3SEVVbU5ZdGFXbWp3Vko1YW0zTjVaL1I4?=
 =?utf-8?B?clNId2N1cEdIa1lSVERIeUg5KzNZMkttVklmK05WVmErYVpReU5rZmxiV3Mx?=
 =?utf-8?B?Vy9UNXFTd04rRzdBMVl0NnpzeDh1UDhCZThRcU5VdWgvcS9ua0ZlSWdXVXBl?=
 =?utf-8?B?enp6Mnl0SzZqZjA0T0JyRTExb3h0SEJCNnV5VXVlNkJJYXJ4Z1hxSlEwWHMx?=
 =?utf-8?B?K2k0VEdRWGpJZXJTVjN4MG8yUVlEWFBoRnd2TzFjam1YejJaaS92N3l1Zzcv?=
 =?utf-8?B?WmZuQUprYzBqSW05bHRrYkVzOVA0TndQd2VVK1YxVTc3Uk5jc2pkYVp6Q3E4?=
 =?utf-8?B?b0JTUENzVUpCOFNGV045MUkzdWE0dzBUVzRZK1FqWmRsTGY3MmVXeE8yMGxr?=
 =?utf-8?B?ZktTOCtTUk5YRHFrR3BVVzhBandvaTMyL1FmQ1JEcC9NTFNBZmhkZ0xkY2dr?=
 =?utf-8?B?UEEzcEhRVkllNmZPUisxMnNRMzF4WTlSL1l2Y1R5UHFGZjNSNEdKS0VkaXky?=
 =?utf-8?B?ZWNEU0gzWTBRcWR0SlNIaml0eGo0cjNHL2dmNUliZVlZTHFTK0RjLytmL2g1?=
 =?utf-8?B?YUcvMWl3TU5pcE42RWF4alRJWE42cGF2bXNIWFdudGtxM21xS0QzeGJ6OFVN?=
 =?utf-8?B?cGNZN3VjaDZ0UmgrdjNpSXNhY0tMR3RDTDlTSWZGc2VsUmZ2RmQ2YUR0YThi?=
 =?utf-8?B?VTg2T0NtaWJXam5vTXBSZnRNREtHUFBDVUdQWW5JVUE0eTNlbVdWYlNsemRG?=
 =?utf-8?B?K1RzaUp3Vld1L2NsZlR3OGltRzVhTzcwN0VqeFlyTWloU0dDazE1TjlvT2h4?=
 =?utf-8?B?dEY5WHRDRmRSaDdJYlNneWpLNk5NUnVPYUxTMDBvaFVmcHUvcE9KeXdIUjdD?=
 =?utf-8?B?ZkJlMEttS241MmUzb0pFWEk3UlZRbXBkbjlrWG9YSER3aUFoY3J1NEF5RTJp?=
 =?utf-8?B?eDVVRDUvL3Y0V0tocVdMS2tDc0JzckVzY1dCTU9RR2tmaUczdmk5Nmk4Y3Jt?=
 =?utf-8?Q?lXsL5q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVkvVlM2dEhtRG1mQ2RSbjZaUFJZOUo3VG4wcXpSYXNWSkYwZWphWkExM0lt?=
 =?utf-8?B?R0dJVzJMZ09WM1BzYk1RS3lTZ2RBNHpIVW9oeGpPOXdwK05jSVlsN3FSMDNo?=
 =?utf-8?B?K2FtdUJIRE5xMkhiU2lMUVZsK0JUYWlYWEo1L0V3R3M4ajVCd3NBUEFNWlcz?=
 =?utf-8?B?NE5uaGg0ajRyUzg2S0FxMkQxWDJwN0d4MVVVcWhjQldrd1dBeTJZelBjSUR5?=
 =?utf-8?B?ME5xUHRmeUZNK0V5VHZWODB2UVY2TzhZZmJlTHZ6cHc1aEFUR3BmNkdsTEsx?=
 =?utf-8?B?R3pLVUUrM1Q4SzEzdHFzNWFPb1d4cXUzV2tWTDl1YjNyelpQNmtrbTlQM3M4?=
 =?utf-8?B?dVpSaG5JVmh5QWk1SGh1eEltZWc5elNya1hzNmFIck41WmZidUxRdVBFUGdW?=
 =?utf-8?B?QTRSWWRjMjlTQ3NjbC9ONStGQmp2cUIwMWp2NUFZR0RKeGVrMVRaNnNVcnpL?=
 =?utf-8?B?Tjg1ZlJjMWlScWdLaU91ZHArVzJKbjU3aG1JQlVNR1BwMWZRclgzV01oMFVJ?=
 =?utf-8?B?UW83N1BuL0lnK2thd2xCdTE1YXBTeks4bGFrandxbTlPbktIcG9zUVVoNWFY?=
 =?utf-8?B?bjN4VTJuZGsvOGc0c3BLeExSWHo0Z2tDeGVhY29EVmpFUWZ5VVl0c2orTHRW?=
 =?utf-8?B?ZExNTDEvNGpzSXdWeTVXeW0rQTBMczZoYlpzSzJGVUhWQXZRODR4OXlqSEwx?=
 =?utf-8?B?QTdveGlpU3BFS2tDeWp6S05ja3RLNVZxOVAxQURrL1hEbTFDMENaV0lHWU5L?=
 =?utf-8?B?VGFlb3h1bmdpeWd1UTN0MVcwMHEydFY5TzUwTVlURThvZGZSeHYwZzhjb2gy?=
 =?utf-8?B?ajNtVFRhVUVpRkorTmpGOWh5Wjd1SnBueDhpeGdyK2tDZEhJZUhYUm1OODFQ?=
 =?utf-8?B?Q2plb2l6NHlVRHlDeXJLUzRXUG9RNExKVERldVVLRW15Z0V3a1BrcVBCSjVD?=
 =?utf-8?B?Y243V0U2OXBDd3I5dWh6ZmROczYvR2FCU051alRsT1R4dWh1WndPQ3VCWEZa?=
 =?utf-8?B?d0ptR0xvMTFpZXhvRHVYTkE3NDMySWFwTllld3JlZlVYSGlnWXNHbG9XSzVV?=
 =?utf-8?B?V0VSd2swUTJzaXhiWGpmQ2lZRDZ4ME9Id0dxMC8veWx6blJ0TXZYQ3pqNjE0?=
 =?utf-8?B?Y1NNcDhSajd2OWlqL3BZcXVPNjIrRnZadlNXdG1td0hvSHo4bTZMUmRzaVZa?=
 =?utf-8?B?V3daQmpiaVZpSkNXdjVadkg4UDNGR2NaMUF0QkpjSVV2Y0Z0OGZRZHpVbTYr?=
 =?utf-8?B?NTRRZzBkRUkvTjNqcm1odzc3WSsrT1R2S1k2VEQ5ZVNjMDJaWmFtSXIvSTZq?=
 =?utf-8?B?anFoK2hzWkRCOS9FZTFtbkpYZlpRb0xTaUFGT0w2clZBNWVaV3ozdk5jMlk5?=
 =?utf-8?B?UEUrWUJlNTM5aWg5UzJoMXEveEpNVSsrbnVCRTlLNE5kem43MndSMnprSG8z?=
 =?utf-8?B?dnF1Z0hRbTU2R2pEVnZIVUtSYm1GYVM3QWxOd0liczJiNENXeXFGbXFkWENR?=
 =?utf-8?B?R3BlZUxoWFdXR1FOVlBZbjZXbWNwaFoyL29CRS9xb2o0NVF1dUVodGQvR20v?=
 =?utf-8?B?cUdxN3VDMUduWmU3UUQraWNFM09DTFQ3SGFFVmZad01OMjF4ZHdwTlcrQ1Iz?=
 =?utf-8?B?Q1AwRDVDY3JHN05EVUw0RmlCV0tjTUQ2eC9SUVREZ1FIQ1IzdXJzUVFBSEIy?=
 =?utf-8?B?RGNBa3pIbUpRWUxKak9LYlo0eWVZTGRyeWNVcTh1SnIzN013V0ErOFhydWp1?=
 =?utf-8?B?L0VwSGJGbElRdlFidVBtbjhXWHpPWjdoNGo2K2I3ODN1TGtzRm1ZK0lZSFp1?=
 =?utf-8?B?MlVzVUxDcFcvNVhqOEo0NHM5UFNQcEVITDZ5MWJZeHB6aW1mSzcrc2VtY0FB?=
 =?utf-8?B?NXhCWVFFOXBJOTJ4RFdOZXliS3psN0VuTTZ1ZU40Sy9ZeFgrSUFoQzNjWHRU?=
 =?utf-8?B?Zi9GdzBpNkhxOGhIdlB2VFZScGJaeFVXM1hWRjhCUk0zWGtPZm02SE5JN3BC?=
 =?utf-8?B?VmZhNDcrc3lEenlaTVFqTUdQVkFBU1JZMWJVM0haYzJ1bExzT21yMUhoV0RG?=
 =?utf-8?B?MThKaUpUeXZvQThoWW5wQ0NlY2Z4U0JNNmw4WFJQNmRyQithUElKZy9SSWtM?=
 =?utf-8?Q?swbY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a73f664-3a03-4734-4ccd-08de0a62e2d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 14:14:56.1441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5zw7MqzHa2DL0EOAkJoJfBWLsu4+A/b1bg/9D6EQ/CDbB4J96J6zXnxZoJNJ335
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+
IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxMywgMjAyNSA5OjQzIFBNDQo+IFRvOiBMaWFuZywgUHJp
a2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzddIGRybS9hbWRncHUvdXNlcnE6IGZpeCBTRE1BIGFu
ZCBjb21wdXRlIHZhbGlkYXRpb24NCj4NCj4gT24gTW9uLCBPY3QgMTMsIDIwMjUgYXQgNDo1MeKA
r0FNIExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBb
UHVibGljXQ0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiAgICAgICBQcmlrZQ0KPiA+DQo+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1i
b3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+ID4gPiBBbGV4IERl
dWNoZXINCj4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDExLCAyMDI1IDU6MTUgQU0NCj4g
PiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+ID4gQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQ
QVRDSCAyLzddIGRybS9hbWRncHUvdXNlcnE6IGZpeCBTRE1BIGFuZCBjb21wdXRlDQo+ID4gPiB2
YWxpZGF0aW9uDQo+ID4gPg0KPiA+ID4gVGhlIENTQSBhbmQgRU9QIGJ1ZmZlcnMgaGF2ZSBkaWZm
ZXJlbnQgYWxpZ25lbWVudCByZXF1aXJlbWVudHMuDQo+ID4gPiBIYXJkY29kZSB0aGVtIGZvciBu
b3cgYXMgYSBidWcgZml4LiAgQSBwcm9wZXIgcXVlcnkgd2lsbCBiZSBhZGRlZCBpbg0KPiA+ID4g
YSBzdWJzZXF1ZW50IHBhdGNoLg0KPiA+ID4NCj4gPiA+IEZpeGVzOiA5ZTQ2YjhiYjA1MzkgKCJk
cm0vYW1kZ3B1OiB2YWxpZGF0ZSB1c2VycSBidWZmZXIgdmlydHVhbA0KPiA+ID4gYWRkcmVzcyBh
bmQgc2l6ZSIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9tZXNfdXNlcnF1ZXVlLmMgfCAxNCArKysrKysrKystLS0tLQ0KPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiA+IGlu
ZGV4IDAzNzBlZjcxOWE2YWEuLmFiMzkyZGUyYTIzODggMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+ID4gQEAgLTI1NCw3ICsy
NTQsNiBAQCBzdGF0aWMgaW50IG1lc191c2VycV9tcWRfY3JlYXRlKHN0cnVjdA0KPiA+ID4gYW1k
Z3B1X3VzZXJxX21nciAqdXFfbWdyLA0KPiA+ID4gICAgICAgc3RydWN0IGFtZGdwdV9tcWQgKm1x
ZF9od19kZWZhdWx0ID0gJmFkZXYtPm1xZHNbcXVldWUtPnF1ZXVlX3R5cGVdOw0KPiA+ID4gICAg
ICAgc3RydWN0IGRybV9hbWRncHVfdXNlcnFfaW4gKm1xZF91c2VyID0gYXJnc19pbjsNCj4gPiA+
ICAgICAgIHN0cnVjdCBhbWRncHVfbXFkX3Byb3AgKnVzZXJxX3Byb3BzOw0KPiA+ID4gLSAgICAg
c3RydWN0IGFtZGdwdV9nZnhfc2hhZG93X2luZm8gc2hhZG93X2luZm87DQo+ID4gPiAgICAgICBp
bnQgcjsNCj4gPiA+DQo+ID4gPiAgICAgICAvKiBTdHJ1Y3R1cmUgdG8gaW5pdGlhbGl6ZSBNUUQg
Zm9yIHVzZXJxdWV1ZSB1c2luZyBnZW5lcmljIE1RRA0KPiA+ID4gaW5pdCBmdW5jdGlvbiAqLyBA
QCAtMjgwLDggKzI3OSw2IEBAIHN0YXRpYyBpbnQNCj4gPiA+IG1lc191c2VycV9tcWRfY3JlYXRl
KHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyICp1cV9tZ3IsDQo+ID4gPiAgICAgICB1c2VycV9wcm9w
cy0+ZG9vcmJlbGxfaW5kZXggPSBxdWV1ZS0+ZG9vcmJlbGxfaW5kZXg7DQo+ID4gPiAgICAgICB1
c2VycV9wcm9wcy0+ZmVuY2VfYWRkcmVzcyA9IHF1ZXVlLT5mZW5jZV9kcnYtPmdwdV9hZGRyOw0K
PiA+ID4NCj4gPiA+IC0gICAgIGlmIChhZGV2LT5nZnguZnVuY3MtPmdldF9nZnhfc2hhZG93X2lu
Zm8pDQo+ID4gPiAtICAgICAgICAgICAgIGFkZXYtPmdmeC5mdW5jcy0+Z2V0X2dmeF9zaGFkb3df
aW5mbyhhZGV2LCAmc2hhZG93X2luZm8sIHRydWUpOw0KPiA+ID4gICAgICAgaWYgKHF1ZXVlLT5x
dWV1ZV90eXBlID09IEFNREdQVV9IV19JUF9DT01QVVRFKSB7DQo+ID4gPiAgICAgICAgICAgICAg
IHN0cnVjdCBkcm1fYW1kZ3B1X3VzZXJxX21xZF9jb21wdXRlX2dmeDExDQo+ID4gPiAqY29tcHV0
ZV9tcWQ7DQo+ID4gPg0KPiA+ID4gQEAgLTI5OSw3ICsyOTYsNyBAQCBzdGF0aWMgaW50IG1lc191
c2VycV9tcWRfY3JlYXRlKHN0cnVjdA0KPiA+ID4gYW1kZ3B1X3VzZXJxX21nciAqdXFfbWdyLA0K
PiA+ID4gICAgICAgICAgICAgICB9DQo+ID4gPg0KPiA+ID4gICAgICAgICAgICAgICByID0gYW1k
Z3B1X3VzZXJxX2lucHV0X3ZhX3ZhbGlkYXRlKHF1ZXVlLCBjb21wdXRlX21xZC0+ZW9wX3ZhLA0K
PiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1h
eF90KHUzMiwgUEFHRV9TSVpFLA0KPiA+ID4gQU1ER1BVX0dQVV9QQUdFX1NJWkUpKTsNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAyMDQ4KTsN
Cj4gPiBbUHJpa2VdIEhvdyBkaWQgdGhpcyBpc3N1ZSBvY2N1cj8gSWYgd2UgaGFyZGNvZGUgdGhl
IHZhbHVlIGhlcmUsIHdpbGwgdXNlcnNwYWNlDQo+IGRyaXZlciBFT1AgYnVmZmVyIHJlcXVlc3Rz
IHN0aWxsIGJlIGNvbXBhdGlibGU/DQo+ID4gV2UgbWF5IG5lZWQgdG8gYWRkIGEgVE9ETyBjb21t
ZW50IHRvIHJlcGxhY2UgdGhpcyB3aXRoIHByb3BlciBFT1Atc2l6ZQ0KPiBxdWVyaWVzIGluIGEg
ZnV0dXJlIGNoYW5nZS4NCj4NCj4gSXQncyBqdXN0IHRlbXBvcmFyeSB0byBtYWtlIHRoZSBwYXRj
aCBlYXNpZXIgdG8gYmFja3BvcnQuICBJdCdzIGZpeGVkIHByb3Blcmx5IGxhdGVyIGluDQo+IHRo
aXMgc2VyaWVzLg0KPg0KPiA+DQo+ID4gPiAgICAgICAgICAgICAgIGlmIChyKQ0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9tcWQ7DQo+ID4gPg0KPiA+ID4gQEAgLTMxMiw2
ICszMDksOSBAQCBzdGF0aWMgaW50IG1lc191c2VycV9tcWRfY3JlYXRlKHN0cnVjdA0KPiA+ID4g
YW1kZ3B1X3VzZXJxX21nciAqdXFfbWdyLA0KPiA+ID4gICAgICAgICAgICAgICBrZnJlZShjb21w
dXRlX21xZCk7DQo+ID4gPiAgICAgICB9IGVsc2UgaWYgKHF1ZXVlLT5xdWV1ZV90eXBlID09IEFN
REdQVV9IV19JUF9HRlgpIHsNCj4gPiA+ICAgICAgICAgICAgICAgc3RydWN0IGRybV9hbWRncHVf
dXNlcnFfbXFkX2dmeDExICptcWRfZ2Z4X3YxMTsNCj4gPiA+ICsgICAgICAgICAgICAgc3RydWN0
IGFtZGdwdV9nZnhfc2hhZG93X2luZm8gc2hhZG93X2luZm87DQo+ID4gPiArDQo+ID4gPiArICAg
ICAgICAgICAgIGFkZXYtPmdmeC5mdW5jcy0+Z2V0X2dmeF9zaGFkb3dfaW5mbyhhZGV2LA0KPiA+
ID4gKyAmc2hhZG93X2luZm8sIHRydWUpOw0KPiA+IFtQcmlrZV0gIFdlIG1heSBuZWVkIHRvIHZh
bGlkYXRlIHRoZSBnZXRfZ2Z4X3NoYWRvd19pbmZvKCkgY2FsbGJhY2sgYmVmb3JlIHVzaW5nDQo+
IGl0Lg0KPg0KPiBJdCBzaG91bGQgYWx3YXlzIGJlIGltcGxlbWVudGVkIGZvciB1c2VyIHF1ZXVl
cy4gIElmIGl0J3Mgbm90LCB3ZSBkb24ndCBoYXZlIGEgd2F5IHRvDQo+IGtub3cgd2hhdCB0aGUg
dXNlciBxdWV1ZSBtZXRhZGF0YSBzaXplcyBhcmUuDQpZZXMsIHRoZXJlJ3Mgbm8gaXNzdWUgZm9y
IHRoZSBtb3N0IGNvbW1vbiBjYXNlLiBCdXQgZm9yIHRoZSBOUEkgZWFybHkgcGhhc2UgdGhlIGNh
bGxiYWNrIG1heSBtaXNzIGltcGxlbWVudGluZyBhbnlob3csIHRoYXQgd2lsbCByZXN1bHQgaW4g
YSBudWxsIHBvaW50ZXIgaXNzdWUuDQo+IEFsZXgNCj4NCj4gPg0KPiA+ID4gICAgICAgICAgICAg
ICBpZiAobXFkX3VzZXItPm1xZF9zaXplICE9IHNpemVvZigqbXFkX2dmeF92MTEpIHx8DQo+ID4g
PiAhbXFkX3VzZXItPm1xZCkgew0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIERSTV9FUlJP
UigiSW52YWxpZCBHRlggTVFEXG4iKTsgQEAgLTMzNSw2DQo+ID4gPiArMzM1LDEwIEBAIHN0YXRp
YyBpbnQgbWVzX3VzZXJxX21xZF9jcmVhdGUoc3RydWN0IGFtZGdwdV91c2VycV9tZ3INCj4gPiA+
ICp1cV9tZ3IsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2hhZG93X2luZm8uc2hhZG93X3NpemUpOw0KPiA+ID4gICAgICAgICAgICAgICBp
ZiAocikNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGZyZWVfbXFkOw0KPiA+ID4g
KyAgICAgICAgICAgICByID0gYW1kZ3B1X3VzZXJxX2lucHV0X3ZhX3ZhbGlkYXRlKHF1ZXVlLCBt
cWRfZ2Z4X3YxMS0+Y3NhX3ZhLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNoYWRvd19pbmZvLmNzYV9zaXplKTsNCj4gPiA+ICsgICAgICAg
ICAgICAgaWYgKHIpDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgZ290byBmcmVlX21xZDsN
Cj4gPiA+DQo+ID4gPiAgICAgICAgICAgICAgIGtmcmVlKG1xZF9nZnhfdjExKTsNCj4gPiA+ICAg
ICAgIH0gZWxzZSBpZiAocXVldWUtPnF1ZXVlX3R5cGUgPT0gQU1ER1BVX0hXX0lQX0RNQSkgeyBA
QCAtMzUzLDcNCj4gPiA+ICszNTcsNyBAQCBzdGF0aWMgaW50IG1lc191c2VycV9tcWRfY3JlYXRl
KHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyDQo+ID4gPiArKnVxX21nciwNCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGZyZWVfbXFkOw0KPiA+ID4gICAgICAgICAgICAgICB9DQo+ID4g
PiAgICAgICAgICAgICAgIHIgPSBhbWRncHVfdXNlcnFfaW5wdXRfdmFfdmFsaWRhdGUocXVldWUs
DQo+ID4gPiBtcWRfc2RtYV92MTEtDQo+ID4gPiA+Y3NhX3ZhLA0KPiA+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNoYWRvd19pbmZvLmNzYV9zaXpl
KTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAzMik7DQo+ID4gPiAgICAgICAgICAgICAgIGlmIChyKQ0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gZnJlZV9tcWQ7DQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IDIuNTEuMA0KPiA+
DQo=
