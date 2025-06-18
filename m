Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4163EC71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 02:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA8810E0E1;
	Wed, 18 Jun 2025 02:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tg2aX544";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBDE210E0E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 02:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoUxjnQ2ptvDR+exOXeLVUKYZR5if2rsMPMiSiEH2OFJGVd2mRMJGBot0LIkJVjUgp1kcejcYotDOVy2in3jvbnlbjI9ZapH6e5IhxWu2ejEHdgRW7A29TZWUBJi2xwVAruQZKRBZA1VZAJAcqSxfUCbTM+sZx9eETQbHGSyBSf9JHKakEc8IJgXo2KVfhSurPvoYDQzlh/wNagn/ysfz0r4e7ERwt88BTmsgta5u+2EjKgVRZ4N4W4hvgmGL/VuAFKSzJGURhKoVgCstgyuNgVpquncywEnLkDwry7nCT6/xozMUK5coBeiTDEoN9vhIfGWXKM1c5o0VlhxditOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxjsaTNDZgvM3CXFNFkDsag2w1g/SHfvE/8rvQyLWEA=;
 b=OK0A0SEgaI3rI5YbLadTCM637LYJWLpAyOXWPmjTzXJoHzHrhayp1OXQKNOZ56m9SvxBy99ONWAGjBfODnrHscOgquMrQfvnBd0E8sXwA4sd2TYDafo2lPiv2iNbjJfHEuYTT22qfEl331zxorSQGH/cQQBMZXL5TWsxABtdAyaGt9wt+037FUfBFqmX7kbJANGBKYbcUJUHMkIMxmWpZ46hUwxIf/dvK0KamG8HzqYCbqXYvP0zCD+m+xtoajWfpl7OeuyYwO4ppiHy//rzaUN3hWjac/bdcnwzO5mgCXwl8dBTQzj7tOK8eysbxPER1OySSH1sHRXrMiHxeHn6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxjsaTNDZgvM3CXFNFkDsag2w1g/SHfvE/8rvQyLWEA=;
 b=Tg2aX5442Uzr4fZOXLAV0PbQkdsB7nAWSVi5qK97dOIkcBR67DdhxUyM+F+nmoY2oxhW+5t9rEfaBjRm0RkSIc83Z6+aSKy/lzpssghz4eFiiwVZhTSJJ1RMbtNJNUjPMATqFYGeqNC688R8JXx2b2hsRUBEK/ctPbR+86k9Jv0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 02:44:22 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 02:44:21 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [v3 8/9] drm/amdgpu/userq: add a detect and reset callback
Thread-Topic: [v3 8/9] drm/amdgpu/userq: add a detect and reset callback
Thread-Index: AQHb32mCoOTL4+f+A06KTPueZxqdIbQHHWEAgAEYaxA=
Date: Wed, 18 Jun 2025 02:44:21 +0000
Message-ID: <DM4PR12MB51523E85ACDA7D14C4D12D60E372A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
 <20250617092243.2769580-8-Jesse.Zhang@amd.com>
 <69db08d7-4976-40e8-845e-b125efa9fa9d@amd.com>
In-Reply-To: <69db08d7-4976-40e8-845e-b125efa9fa9d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-18T02:40:10.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA0PPF84D37DD5C:EE_
x-ms-office365-filtering-correlation-id: e7f6c05f-da62-4010-7b67-08ddae12078c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?L0RWZTcyYll3OUVORHZvaEhBZWZNanNGL2RrYjk0MkhaVk1uaGdsa3RYcEc4?=
 =?utf-8?B?YXlJZ2liZytJY3NWSFIvV0FzYUVGRFZkRUh1M2hja3JtT1RjbThaQWMrYzhB?=
 =?utf-8?B?Yi8vamt2K1BkbDV2WU01OGNXUWNvK3RZUDJaUG9rTTRRYUZXbzJydG1wNVI1?=
 =?utf-8?B?SHpyMEcyMEY0dW01bHBHdzZEcHZ2cXJRck13TnhoYW1RRE1FcjV0MWc4ZGd2?=
 =?utf-8?B?UzBNZVNuNEdndExlWG5meVQ2TnRCUGpUUHFNZlhRWFR1Q0ZXOTFuV21MTSsx?=
 =?utf-8?B?TWVkMzR4NTN2T3dVVjV3c1FTUE5rb2RMdmxiL3NYVU5laFN3NDErenFmOUVP?=
 =?utf-8?B?K014MFJKbmpvdnJYQTNLV1FSYUFrRkszWFFRNHFieU5EYkR4OWxWTWVyV3pK?=
 =?utf-8?B?ZkJ6WnVWZjNuWTNuaWVpZ3BZZ2dGei9CL1BKYUVCdExpZ3JadTlFUkZYaUMx?=
 =?utf-8?B?bXZUSWlML3VxUlNyWWQxMlY5SFZPdE12V0FnMHBWSHdFdHVKaE5ka2ZOWE9a?=
 =?utf-8?B?NnA3aFZkNzJiOGQ2eDBZVHNhd3hWTklHN1RiRk94N2dJdVZzcm5WNS9MWXdw?=
 =?utf-8?B?d3ZXQnpMaEt5NVdoZlYwWmdCQUt1elV6bGhHUmF2WU9vOW9SSmhnRFhWOTNk?=
 =?utf-8?B?VTU3R29TWThRRE9WMmVQTURJRTBIN0VLK3BBbHljTTlWUlFSNWVVME13cWVl?=
 =?utf-8?B?ZFVhSGlzQ0RqUmp0ZmpoendIQVFkWkZVaTZGeEVJUm1yK0daUTUyVU5WNXZL?=
 =?utf-8?B?TjBJeTZmbGl1SFk2SFBFRG4rd1Qxb2FXSGZBT0F4bjIvRU9YTG9zaWJZY0Jy?=
 =?utf-8?B?SVBVc3NyQ0RqVlF5YlN4ZC9iOUhodVZ5OWNsRGRVTDZUNDIyaXJuMk84RGM2?=
 =?utf-8?B?RzdxWEZSV3ZxcjY5YVpDVnFFenA0dlVid0hnazh3a2VGVlJvRG1OQ3VPOFZG?=
 =?utf-8?B?MXAzRkhIb3lmUTB1SHRWZFdZTGJCS0RmdmVnRlZQRnlFVVN1ZmoyVk8vWFA1?=
 =?utf-8?B?RERsVTJ2dW9aZEpmamtRbjZTczFxZVpCTGpJeDIyMkgzQ3EyK29XclN1cXd4?=
 =?utf-8?B?V2U4dE9LSEhMSGxJTlRkMkdmSEw5VzVHY3NqSHBQMlVoU1NNai9yRSszRzQ0?=
 =?utf-8?B?Mk5za01PYjJ5YWhMMk1MVjMyM05EZHRabTZHNmR6ZU1aNTRQQVdMN3hNdVZJ?=
 =?utf-8?B?aHBZek8ybnFWMk1xWS9GSlg3VFZueGk2RTZheklTU2Z0cE45MFhEbEZmT1o4?=
 =?utf-8?B?NmNiTHZRbGhxMmNGcVFBTjFQTG45S0lhQVFjZC9nMDlvTSsrY1BMVTlyV1Fa?=
 =?utf-8?B?YTVDeDhNbDBaQWxYUnpzc0RpS1l5TXpJbmg4Zjl1dnVGdkMvQ24ycXYyZURo?=
 =?utf-8?B?c0JkTGJ5dTB5MGpTUHpEOFdaRmdUMW5GWjh2YnA3U1Vid00vTy9ZN2RaaDdx?=
 =?utf-8?B?b01JSktyZm5SYmkvKzk2eW1lRU5TOGVqRkZ2NXUwTW1vb2d5Q3NtRHZJSWow?=
 =?utf-8?B?WXZpME9OTFdTeVoxY3U2L2dtMUVNZE50YkhHanc0NDRIUDFHQXZrVk8xdzRF?=
 =?utf-8?B?TlNVeGRHTkpBSW16SEwyQ2Y1cnh0aEtGblZReGhmSVRmOVhTK0FuZjB4VlFX?=
 =?utf-8?B?UlhJallhZ3dBbFBrUExMZmprT29uM3hybWNYNm9CWHVjSmtuU09SeEkwWEo1?=
 =?utf-8?B?aGtjeDdDeXhvbi85Sm1YY3ovc0YxYXhUb0Q2U00xcFB3Tmo5NjVtWVE5OFUv?=
 =?utf-8?B?aXJlcThCT0pOMURhemxndE5DdHF6UU5ZN21xZnpudmtGNTlybGFDNDA4MHl0?=
 =?utf-8?B?NGNIUVBvT2FUaG9yaEs4UWFFTVFkN29FWEV2bUtlQ0pXTGNTR1N4aGFRS2gx?=
 =?utf-8?B?VUZHOE9KVk9TbHFOSlZGQ08wcGQ3RW9ZdFdCVmEvcjVyTXJVQ010ZUtqM3Zo?=
 =?utf-8?B?ak5ybUdhRmZHd1hzWVZuSjc5MHphVkRQN2N3cnFWb1YwQjJRR3NNL2F3L3lY?=
 =?utf-8?Q?MHkS0rrycshOPnIEtCCMBJDyngDF8k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RU1ReTBHYmhvbWZ5UlVZbVVETHQrRllhOHRkT0pxUVVncm4vVjNJZ2RlWDFU?=
 =?utf-8?B?dFlwdmdaNDNiWFlQU1JZaVlEOVJiWXdwU1E2Y0dGS0phQWxyWFpXQkRlZ2No?=
 =?utf-8?B?cXZWUisxZlZ3eU41ZmNzZzlHOVh0SkJZRk5jNGxSbFZrMzRZYnMvN3F4SnYr?=
 =?utf-8?B?ZWpRZmZlWkFPalQxRGMrejBJZjBRY2RocEY4TnN4UWRKWWhMT3EvSWFqRlFP?=
 =?utf-8?B?UDJoZEUzbXg4b2RSaGdITnhadWxlcm1UQmJGWExYenNqQ3dyYSszUlFEK2gw?=
 =?utf-8?B?eUloV1ZUQzBIR0tydXBtbDNnc3djR3hkbC9ic3RQQ3p4NDh1S2RnKzFYQVZQ?=
 =?utf-8?B?dmlEZEZocVB6SlNzL016OGhqUG9Zb1BrY0tkNmM4ZS9zdWtldUdPaDA2UllK?=
 =?utf-8?B?TnRVaG5qMnFWTFBhTisxUlBFb2kyZWhDOFh1YzBFdVF1ZFJKOUNQeTVzMXA1?=
 =?utf-8?B?Zi9mQUVBL1lQbnczYXkyQXg3UXhxaU0rdGtCYk5EY0lXN0x6QUlsMmJyUFMv?=
 =?utf-8?B?U3UrRjdGMTJIemJ2MnVob0ZzamFWWWxiZmM2cU91Y0xWNGN3cHM2ZjlMNy9s?=
 =?utf-8?B?aTRWa2hvNXFEU05Cbk9zN1ZrRElTM3F5bElhZ3p4TGtRaVNJUEFPeWhmQWtS?=
 =?utf-8?B?b1lUbFdxSy9GNTZTU0xrUXFZTStXc2psVFdPeVRHU2k0TlVkN2Z2Tm90UlUy?=
 =?utf-8?B?VmdnVkdpSzY0L1B1RGtwZ2M2V1dpVktQTHhlVUxsVXJIM0txQzFLTi9IU1Rm?=
 =?utf-8?B?ZjVJYkEwTEVwa1RuNnpjbkJsMWhRY0MrenVZUU9iRUNQRGRBMGtPMHE0c3E1?=
 =?utf-8?B?WWEybmw5T2tGamRCUGYzWWZIRDk3QlRqQjVmZ2pjQ2czSTQ0R2RCekpocEVk?=
 =?utf-8?B?TElwYlFnalR0b2RzeUh6Wnc2MmV0SG1EUmhKS2tTc1ZsYThDMDNGcmRUUDNp?=
 =?utf-8?B?VUhjUGtyN05TenU0MEw2eWNFRDhnbzkxUTBsZ2NCa08wRzIxeWFXMEVmY1NM?=
 =?utf-8?B?N05FaGZSUWFUckJjVFV6V1VWZW4vb1RjUGNGVGJwbHZqM1h0Zm9YZGgyN24x?=
 =?utf-8?B?WFZjMC9EeEFJTk84YmtLR1VOTmFEYkRvVkJjWDcvKy9TVUNYbnM3dzI1TkxJ?=
 =?utf-8?B?SnYrcXd2SHkxM3FldUMzK0JrempFUTZ4RjhNblhQbDN0cDUydnBvM0hXN3JQ?=
 =?utf-8?B?dXpsMG9OSlhEdjNyRmEyRndxZm0yTk1jMjdrTjZNUGN1OTMrTndqajRzM252?=
 =?utf-8?B?OXEwM2tNWllRMkFGakR1SU1VRkFHaGFobitvclEyaFVzZkp4QlFxei9ua3dT?=
 =?utf-8?B?citwRGlzNXhEK1NIanZ0dmsralR2OEU1bTJuU3k4SmVuM1p1Q0o0QVduWDZa?=
 =?utf-8?B?QWpvZ1RQVzFMNDJoUWxQUVZIRWQ4bUx4Ym41WVZXdFVKMXcxUCt2R3kvYSs1?=
 =?utf-8?B?Zkg5ZENSQkRHSnp3cDJRK2Njd3E2V01MN1FWdUJpc1FhMXB5UTJ4Y2plWHdH?=
 =?utf-8?B?T1JNenB0UEF1N3F3dHFVRHd4dmI0WXl3OTUrY1RvaGpMRlhWTHFyTzRucFBD?=
 =?utf-8?B?dUlIWnlNL2xaeUxjYXE2S3ZLbUtldnlCMWFHRm1yZnh5ZUFPS3VGTzdJenVB?=
 =?utf-8?B?YVpwWlJYUDJZdEZNdjdvUjhSWjRPRFZHc3AvL3h2RytHQmthRWtVVytzdDNn?=
 =?utf-8?B?VHRRalNPUmdKZ3RiT2FzemxjSnFjVTJlZmF6Z29yMU5qdUdiZTNZTUNYbjY4?=
 =?utf-8?B?b05vaVpSQTR3clFjRFVvRGgwSGRZdk43REMwRVJpSHVyaHc2MFNCeDlqdGZn?=
 =?utf-8?B?Tkl2MGRzVWFXYnlLU3BROXpIY1F4aWlkZkZZOU50VDk1SFJ0anZYVS9pVGFu?=
 =?utf-8?B?eEpINGYvL3pBNUJBUTJ3MmdRcmdvZWl4aHUwV3V0a0pqL0RYRDFFM3hlVHRn?=
 =?utf-8?B?dlFkQ3BmdWFGcHYrSUg5ME1VOEkwQ2E2cjg2SEdBU3VXS2pDOG5qNElWcnJH?=
 =?utf-8?B?SUxyWWQ0a2FQOTRvbUJYRjVZVTdJMjlQRkpReHZvLzVqVjBwaktrdWNnM3JN?=
 =?utf-8?B?c1lKTC9QSHFmU2lLb0N6bXdYa3IyaS95SkpXSzNrZUVIREZjZDdLcjR4dDRj?=
 =?utf-8?Q?8x0g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f6c05f-da62-4010-7b67-08ddae12078c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 02:44:21.5182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W143jQIf0KkahRmbJ7iujR1ibRtDwJiN4hFhpa3xIuZdboj518IzkjtHWhk74x/x9ceaqfruClB8O1Ot4NNT5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+DQpTZW50OiBUdWVzZGF5LCBKdW5lIDE3LCAyMDI1IDU6NTcgUE0NClRvOiBa
aGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClN1
YmplY3Q6IFJlOiBbdjMgOC85XSBkcm0vYW1kZ3B1L3VzZXJxOiBhZGQgYSBkZXRlY3QgYW5kIHJl
c2V0IGNhbGxiYWNrDQoNCg0KDQpPbiA2LzE3LzIwMjUgMjo1MCBQTSwgSmVzc2UuWmhhbmcgd3Jv
dGU6DQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4N
Cj4gQWRkIGEgZGV0ZWN0IGFuZCByZXNldCBjYWxsYmFjayBhbmQgYWRkIHRoZSBpbXBsZW1lbnRh
dGlvbiBmb3IgbWVzLg0KPiBUaGUgY2FsbGJhY2sgd2lsbCBkZXRlY3QgYWxsIGh1bmcgcXVldWVz
IG9mIGEgcGFydGljdWxhciBpcCB0eXBlDQo+IChlLmcuLCBHRlggb3IgY29tcHV0ZSBvciBTRE1B
KSBhbmQgcmVzZXQgdGhlbS4NCj4NCj4gdjI6IGluY3JlYXNlIHJlc2V0IGNvdW50ZXIgYW5kIHNl
dCBmZW5jZSBmb3JjZSBjb21wbGV0aW9uIChKZXNzZSkNCj4NCj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5oICB8ICAzICsrDQo+IGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYyB8IDUxICsrKysrKysrKysrKysrKysrKysr
KysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmgNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuaA0KPiBpbmRleCBlYzA0MGMyZmQ2Yzku
LjAzMzVmZjAzZjY1ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3VzZXJxLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3VzZXJxLmgNCj4gQEAgLTc3LDYgKzc3LDkgQEAgc3RydWN0IGFtZGdwdV91c2VycV9mdW5jcyB7
DQo+ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICpxdWV1
ZSk7DQo+ICAgICAgIGludCAoKm1hcCkoc3RydWN0IGFtZGdwdV91c2VycV9tZ3IgKnVxX21nciwN
Cj4gICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICpxdWV1ZSk7
DQo+ICsgICAgIGludCAoKmRldGVjdF9hbmRfcmVzZXQpKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgcXVldWVfdHlwZSk7DQo+
ICsNCj4gIH07DQo+DQo+ICAvKiBVc2VybW9kZSBxdWV1ZXMgZm9yIGdmeCAqLw0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+IGluZGV4IGQ2ZjUwYjEz
ZTJiYS4uNTJkNDM4YjVkY2VmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bWVzX3VzZXJxdWV1ZS5jDQo+IEBAIC0yMSw2ICsyMSw3IEBADQo+ICAgKiBPVEhFUiBERUFMSU5H
UyBJTiBUSEUgU09GVFdBUkUuDQo+ICAgKg0KPiAgICovDQo+ICsjaW5jbHVkZSA8ZHJtL2RybV9k
cnYuaD4NCj4gICNpbmNsdWRlICJhbWRncHUuaCINCj4gICNpbmNsdWRlICJhbWRncHVfZ2Z4Lmgi
DQo+ICAjaW5jbHVkZSAibWVzX3VzZXJxdWV1ZS5oIg0KPiBAQCAtMTk4LDYgKzE5OSw1NSBAQCBz
dGF0aWMgaW50IG1lc191c2VycV9jcmVhdGVfY3R4X3NwYWNlKHN0cnVjdCBhbWRncHVfdXNlcnFf
bWdyICp1cV9tZ3IsDQo+ICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPg0KPiArc3RhdGljIGludCBt
ZXNfdXNlcnFfZGV0ZWN0X2FuZF9yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHF1ZXVlX3R5cGUpDQo+ICt7
DQo+ICsgICAgIGludCBkYl9hcnJheV9zaXplID0gYW1kZ3B1X21lc19nZXRfaHVuZ19xdWV1ZV9k
Yl9hcnJheV9zaXplKGFkZXYpOw0KPiArICAgICBzdHJ1Y3QgbWVzX2RldGVjdF9hbmRfcmVzZXRf
cXVldWVfaW5wdXQgaW5wdXQ7DQo+ICsgICAgIHN0cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUg
KnF1ZXVlOw0KPiArICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21nciAqdXFtLCAqdG1wOw0KPiAr
ICAgICB1bnNpZ25lZCBpbnQgaHVuZ19kYl9udW0gPSAwOw0KPiArICAgICBpbnQgcXVldWVfaWQs
IHIsIGk7DQo+ICsgICAgIHUzMiBkYl9hcnJheVs0XTsNCj4gKw0KPiArICAgICBpZiAoZGJfYXJy
YXlfc2l6ZSA+IDQpIHsNCj4gKyAgICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgIkRCIGFy
cmF5IHNpemUgKCVkIHZzIDQpIHRvbyBzbWFsbFxuIiwNCj4gKyAgICAgICAgICAgICAgICAgICAg
IGRiX2FycmF5X3NpemUpOw0KPiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAg
ICB9DQo+ICsNCj4gKyAgICAgbWVtc2V0KCZpbnB1dCwgMHgwLCBzaXplb2Yoc3RydWN0DQo+ICtt
ZXNfZGV0ZWN0X2FuZF9yZXNldF9xdWV1ZV9pbnB1dCkpOw0KPiArDQo+ICsgICAgIGlucHV0LnF1
ZXVlX3R5cGUgPSBxdWV1ZV90eXBlOw0KPiArDQo+ICsgICAgIGFtZGdwdV9tZXNfbG9jaygmYWRl
di0+bWVzKTsNCj4gKyAgICAgciA9IGFtZGdwdV9tZXNfZGV0ZWN0X2FuZF9yZXNldF9odW5nX3F1
ZXVlcyhhZGV2LCBxdWV1ZV90eXBlLCBmYWxzZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmaHVuZ19kYl9udW0sIGRiX2FycmF5KTsNCj4gKyAg
ICAgYW1kZ3B1X21lc191bmxvY2soJmFkZXYtPm1lcyk7DQo+ICsgICAgIGlmIChyKSB7DQo+ICsg
ICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJGYWlsZWQgdG8gZGV0ZWN0IGFuZCByZXNl
dCBxdWV1ZXMsIGVyciAoJWQpXG4iLCByKTsNCj4gKyAgICAgfSBlbHNlIGlmIChodW5nX2RiX251
bSkgew0KPiArICAgICAgICAgICAgIG11dGV4X2xvY2soJmFkZXYtPnVzZXJxX211dGV4KTsNCj4g
KyAgICAgICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUodXFtLCB0bXAsICZhZGV2LT51
c2VycV9tZ3JfbGlzdCwgbGlzdCkgew0KPiArICAgICAgICAgICAgICAgICAgICAgaWRyX2Zvcl9l
YWNoX2VudHJ5KCZ1cW0tPnVzZXJxX2lkciwgcXVldWUsIHF1ZXVlX2lkKSB7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChxdWV1ZS0+cXVldWVfdHlwZSA9PSBxdWV1ZV90eXBl
KSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZm9yIChpID0gMDsg
aSA8IGh1bmdfZGJfbnVtOyBpKyspIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChxdWV1ZS0+ZG9vcmJlbGxfaW5kZXggPT0gZGJfYXJyYXlbaV0p
IHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcXVldWUtPnN0YXRlID0gQU1ER1BVX1VTRVJRX1NUQVRFX0hVTkc7DQoNCkFmdGVyIGEgcmVz
ZXQgYW5kIGZvcmNlIGNvbXBsZXRpb24gb2Ygd29yaywgd2h5IGlzIHRoZSBxdWV1ZSBzdGF0ZSBt
YWludGFpbmVkIGFzIGh1bmc/IERvZXMgdGhhdCBtZWFuIG5vIG1vcmUgd29yayBjYW4gYmUgc3Vi
bWl0dGVkIGV2ZW4gYWZ0ZXIgcmVzZXQ/IFdoZXJlIGlzIHRoaXMgc3RhdGUgY2hlY2tlZD8NCiBE
ZXRlY3QgYW5kIHJlc2V0IHdpbGwgYmUgY2FsbGVkIGF0IHVtYXAsIGFuZCBpZiB0aGUgcXVldWUg
aXMgaHVuZywgdW1hcCB3aWxsIGJlIHNraXBwZWQuDQogIFRoYW5rcw0KICBKZXNzZQ0KDQpUaGFu
a3MsDQpMaWpvDQoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYXRvbWljX2luYygmYWRldi0+Z3B1X3Jlc2V0X2NvdW50ZXIpOw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVf
dXNlcnFfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24ocXVldWUpOw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkcm1fZGV2X3dlZGdl
ZF9ldmVudChhZGV2X3RvX2RybShhZGV2KSwgRFJNX1dFREdFX1JFQ09WRVJZX05PTkUpOw0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfQ0KPiArICAgICAgICAgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgIH0N
Cj4gKyAgICAgICAgICAgICBtdXRleF91bmxvY2soJmFkZXYtPnVzZXJxX211dGV4KTsNCj4gKyAg
ICAgfQ0KPiArDQo+ICsgICAgIHJldHVybiByOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IG1l
c191c2VycV9tcWRfY3JlYXRlKHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyICp1cV9tZ3IsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fYW1kZ3B1X3VzZXJxX2luICph
cmdzX2luLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3Vz
ZXJtb2RlX3F1ZXVlICpxdWV1ZSkgQEAgLTM1Miw0ICs0MDIsNSBAQCBjb25zdA0KPiBzdHJ1Y3Qg
YW1kZ3B1X3VzZXJxX2Z1bmNzIHVzZXJxX21lc19mdW5jcyA9IHsNCj4gICAgICAgLm1xZF9kZXN0
cm95ID0gbWVzX3VzZXJxX21xZF9kZXN0cm95LA0KPiAgICAgICAudW5tYXAgPSBtZXNfdXNlcnFf
dW5tYXAsDQo+ICAgICAgIC5tYXAgPSBtZXNfdXNlcnFfbWFwLA0KPiArICAgICAuZGV0ZWN0X2Fu
ZF9yZXNldCA9IG1lc191c2VycV9kZXRlY3RfYW5kX3Jlc2V0LA0KPiAgfTsNCg0K
