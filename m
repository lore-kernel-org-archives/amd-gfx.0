Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEDAC02199
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 13:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C4010E170;
	Fri,  7 Feb 2025 13:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DOqk9LSB";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46B710EB0D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 13:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBlzUtQ94/YKA9ddsZTklJU4gWQ4B18xkqQN7LbN37FgUzDBb4yf5NiLJfvN0FhVCATyr7xst3p+auXMbytuprPcm7uJ0NZjoEE01/YIMASXyvhdr/Tu1ExZbRFRWQqYfxXMA82BSrivW341seYxC2VU/UR6gD9Oti9npz158GQ62qEb11kwILk9Zo6yTTgL2VrkTWaWI2tA1P5vmAcFQtJq9OenUE3gICkEZ0AJhczgnZCxfrRL0oPBHeZfY1q2JQ7bxvL3CLFA3sy5QMjhPo/vQUztVNz89eQvdtdnSgMnAKGGB7zsKLXRDYn6bWv/MzQG8D6OnkuiQs20iO/BNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOBtmuS1NumksJ2o1Ojdko35ZNxAkMbPXu+b4RVOUQI=;
 b=iI1h7/HvjOZBhwdpVZDo0zpOce+0F/mNSNueTcy3pOqiL3FJS+T+iueZ0nS7mGVRzqSzDJVK/VVfwiM3G97lB1ZJfMicvDsz/ieLEp+UqMtlde/QFrnqC3PYPf8Hry9w55R61CCOipWIQDF1MxxQw+xcINypPxpdeZh2YqbtiQjlZOyzdm7P1SeNbSa6l7dkqONpCgN7yWVrjoIHpLrB5BSqqKrK0hsE7IjB6GuCwjiPDV7ZROItH+QTqakgcsj72GjjwlPFmRntWPIoPCnoWrzB3xfEWJKbBzhO5HuJosr1iBipLNzvNC8z/0iv/EofzoZxn3kxqiFSD74LgyQ/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOBtmuS1NumksJ2o1Ojdko35ZNxAkMbPXu+b4RVOUQI=;
 b=DOqk9LSB9mGRzb01o3ibqMBv3UGDIGs/fz278STzBCerp+ZZDS85UQNXVxVDhXhFZ46Qo2JP7XrhexffEE12Z6Geggz/0B/7fazVtwNb9vGFf8X+Z7DEEPQHiqbnxKZ5hV9b3XPlzqSE1oOJCOEbCGHj/qEaBgIzMY0M0Jd8vGg=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 13:59:28 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 13:59:28 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Topic: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Index: AQHbeJjnBkTSX11A7kaLj0Yc6dV7/bM66/vQgABLTACAAKRScA==
Date: Fri, 7 Feb 2025 13:59:28 +0000
Message-ID: <CY8PR12MB7435B4D359268091F915407F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-3-lijo.lazar@amd.com>
 <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
 <22d2c3e8-98f9-4ea3-9737-08e9812d312a@amd.com>
In-Reply-To: <22d2c3e8-98f9-4ea3-9737-08e9812d312a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f4c2cad9-99f0-4fcb-858c-47a68a269650;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-07T13:47:11Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|CH3PR12MB8658:EE_
x-ms-office365-filtering-correlation-id: 8cf08da1-aef0-49b7-c74f-08dd477fa388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Z1o4WkZQK04zbVlsWVQ5c3gxRnpIWmVIcGlveEFDeGxUeExjUUk3RFZRZWVy?=
 =?utf-8?B?bVV6b3BSSFNZeVM4UFcrN0t2RUpNdGx5dnIyY1c0U2V4WkpPRkdnNGtJaC85?=
 =?utf-8?B?Y091MkovRzFUeWVLUWxQU1hFdnN4ZWVCU1BNYkcyMEZvd0FQdy9MTUZGZ0RX?=
 =?utf-8?B?UHFZNk1uR2VvOWx4U2VId2hrUDVKdFI2QjVNQVlCa0VFZXNNRzZRQmhIZUtO?=
 =?utf-8?B?dVllclRPNXZNdEUrNkgyQncyTWtQRHlINTA1aGdtWkFBRXFRSnhPRGxTdUFs?=
 =?utf-8?B?eTVsQUd2Y1JpY2ZnSmJ0RjJ0dXRiTnJtWE9JM28xd0x1SWJVVFF1b1FzNkdU?=
 =?utf-8?B?UzVoWHpPdkg2RmJ3cDRYYmU4a1F3d3paZnNodW9sS1R5Uk05OGtBVFFhUFIx?=
 =?utf-8?B?UVh4cE0zMk9GaGRBRDIyem5YcGx4eE9PRG81MzV5MDdjQTJyK01TNzlGQ2lI?=
 =?utf-8?B?N25lcDNHaDRoV3RyV29tQmJKZ1M5SEZ3VlAvVGQ1cmtra24vWEt2ekpDczRa?=
 =?utf-8?B?OE9FSEhpUENvZ1pNNUxPNFBTZE56T25jaHVTSzJ2c3RZd2hlTWtOcm1qNlBP?=
 =?utf-8?B?L3ZVRkQvbjQ1SmtHazIvdTRZZ05ISnBTZURkVGhYTnRiOEV5Rml4VjBnZ0xa?=
 =?utf-8?B?b2o5cVF1d29sVTl5T25tRDhJQllKS3FwRDE3d0JFbXhLdVh6QUVpR0JmS2pr?=
 =?utf-8?B?UUtpZnBHWUt2ODZXOEovMmFGQU5vTDJXVU43RlI0YzdCeHZLZjVlVWhOMkZV?=
 =?utf-8?B?YWUvL0VGMEFIQnVSNjV6MDhOMzFMeHlsZjV4YUFLM0NGUTlWQWNGR0lpenJN?=
 =?utf-8?B?RklJTFhzRis0N0xGbGtXQm45eVhiSzdlU05VZTZRYTNVZ2pVeldWL0k4dUZq?=
 =?utf-8?B?MkUyUjRCTXlOcmsxTFpSYzBLUFRHQmZBbUxsZWlmMFlmMTJHMGZ3SS9qeFdi?=
 =?utf-8?B?Snc0MDVJV25PT1psaTZXYmN5Z1hLVWJhRkdGNllYT01kV3E4SmxZSkJJMkh5?=
 =?utf-8?B?cFBDa0RucDlXR3h5emUxUnJza0pzalM1RWc4SkhTT2ZxWExzSGUrdEpEbHdQ?=
 =?utf-8?B?b1p3ZW9hV1hqdUNJd1ltQXArQ3pmeDltR0x2UWhNanpmdkFsT1krQlR4a2Ix?=
 =?utf-8?B?MWVKeFpWeVNpZm1sVWhZc2FUZUNxY3lFQkdpRjhNdm4ydVFsNlEwOWUycUpF?=
 =?utf-8?B?emZGVTdBekZHQXBYZzZITHRESlNSMGhxRGduV01meVkveWQrM2pUYng4WFQy?=
 =?utf-8?B?VTE4MmtxV0llZlBhZnlvemt5WDNxeUt6MDB3YUpVa1Y0SDlGNWxqMDI0TG5N?=
 =?utf-8?B?YW5LdlBMRFZCc1RmaWpRK1luZVFTNnZ3Qzdtbmdmd0U3RjBGM3dnK1hMMHA4?=
 =?utf-8?B?Z21NL01uai9ZZHhWM1BOTXppS1VTWTFpeEFUT1luTGpBNnMzYjVaM01zOWM0?=
 =?utf-8?B?d1JRdnpKL0dJQ0JvTlhZNnlSZDFIZ1NwMXF0QytFa1M2Tk1FWEk5dk5aRno5?=
 =?utf-8?B?RFZyMnpyN0M4dEM2eWs4NXJGajQvcWNKT2lSUGwyR2x1WFJjcUQ0ZEJUdXBH?=
 =?utf-8?B?Mks3R2FTRkZNWVpBQnQ1dDRSeFh5T2pUUnVRMEU2WmNrWW5rNm10WDRiaWpM?=
 =?utf-8?B?UVltUGJFdm5jbWFBdHdDQk1KbmRQVGs4Uk1rQkRndzZJU2VidGRzYVRmemxO?=
 =?utf-8?B?M0hBRGNiVGt6RmZocUN0QlFOVUdzWkpBeUNzMXliNTJMbjZYd3Z0K3JTQXRP?=
 =?utf-8?B?b3JDZ2VRa2Ixa1NyQ0ltUFRVdzdoV2ZrZ2VWZ1R5MXJaWlVvRXo4c3VXT3hB?=
 =?utf-8?B?Uzc5SDVXQmVpb0VmQUFqanBjREFNRklzaXBJRlNaejNvUEhzd1UzbklxM2Jz?=
 =?utf-8?B?UkVvbkErdEFpSlBqeXc4RGlxdFJTNGhWZHUrZGJ5dHVoVVY4UkdaZnRSWGo3?=
 =?utf-8?Q?l8HyIWuu1uruZPkUq+5HwDIVlnPMVd1V?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1VUM3U1bGlFb2MyY1BtY2NLNHFRZGFhTHdNdi9WbEtPNzZ1NHR3TVA3bmJF?=
 =?utf-8?B?ckUvS29kWUsvaU92YzAyVVk0dDlYWldPejhvT0swTTAreWpOOFkxaTdiVGZX?=
 =?utf-8?B?RlFiakFOTWkrdk1BSm5FZWRydzlMb0dPYmJlZnl5ZTRCZWJzUFl2TGZqNlJx?=
 =?utf-8?B?bmpGTWdhWkU0YVpXMkovZ21mS1JsMDZ3SmRVSDVxc1AyUGVqUndTUjlDa1NU?=
 =?utf-8?B?eXAzQ2dlWG1RZnkydDg3M24yQjFuOXlEejJrYm9MaXpYNmhYRDlLNjJlejRK?=
 =?utf-8?B?a0xzUkwzNkJKMUdaNEs4UEdyRzluSmdIdzhYa1BybmFJUzRremQzR040QSt3?=
 =?utf-8?B?S3p5WDZpenRieC82MWVOY2p4MFpuaUxvZmpXYVFPd0RUdlJPcG8xSmY2U2FG?=
 =?utf-8?B?a3pMS3V2T2NlQ3dLTW5iVU00RzFsSEFVdFMxL2twd2VweGR4Q3kxcVdPQ3JW?=
 =?utf-8?B?ZlRIeTdrUThvbE0vbCtxWEJvZGx0MWFkT2t4N3lvTUpMREtuM1NUeHN0WlR3?=
 =?utf-8?B?bGV3YmVsV1VpN3R2MUQvWHZBeHZUTVpRb2R1MTRDbDNVT1NPeEtYT1hrZXNG?=
 =?utf-8?B?bnBWZnFhQUhXRlF2RjVJbm53OFN5Rm9YZWhRcGN3OVdkeGdVd3lVSmJ5MkJZ?=
 =?utf-8?B?bXRYbUZhOFVwS1ZkcjNRZkdFVFV1WkNMcGNCKzN4WHlNSDY2RlhPSnNxVE1D?=
 =?utf-8?B?Y2VYbnNrT29lZ3YySkt3MGZ1clFUcW9mcmZVdzVUWHNTQzArWDRGdi9mbEtP?=
 =?utf-8?B?cStLZ3pjbjY4ZEw5OXYxRHo1SDFuYzd2aVZYNDlVTisya2NNWmtrbG1KUnVN?=
 =?utf-8?B?eVY2TEpWWDdRdFA3aVFZZGpnMnhxc2RpT1loWUxSOHU3NExWenNTZWZvSmFC?=
 =?utf-8?B?Zk1WTWRzUzhWbTRNdUN4RGE5dlpsZS9aUTh3RlFGTUFUVXBkcUFLZHlmUlB4?=
 =?utf-8?B?QnhzaHFWdm5TUzV0cktjVUdyNS9kL010RmUwa2Zuc3B5RDRFNE9ia1I3b1Fz?=
 =?utf-8?B?dkFBT1gwWHNHeFNKWmtLN1NLbEFlbnV3Y1c0WmxXNHUwNVJOOW9Ba0JML1Ev?=
 =?utf-8?B?OEZaQy95V29rSFFuUUJ6TWtwRll0citsekx6aCtURERBRkErTjFqMm41dHIv?=
 =?utf-8?B?SE82eU9kcUFobFdSbGQvU1ROckJiS0RIc2hUVUZFRWduQkNtdU16VUVZQmhw?=
 =?utf-8?B?K1J4SGhEeGV3eFZUU0xlT0RBQ24rampuYm15b2lwK1k4ajdiN1BqbmlWL2dG?=
 =?utf-8?B?Nk5Dd3Q1Sms4anJxMDJYMmxaMTgvb3lwbElLaHpia1ZoRUhvWnQxUlNFV1N0?=
 =?utf-8?B?UXNXVnJpcVpLOU9tUmwxQnUxRmdUejk4WUd2Z3E1dDN3SjlCajRDQWZPb2VZ?=
 =?utf-8?B?c0JWQkpoam41MWVDVlFHTEhtR0FhOXNhVTV5SVVwSVh5RXVZT2NON1NVTHZL?=
 =?utf-8?B?L01zOFlEdGlRWW5JKzhrRjQxTTZqNVpZMHZUT2hCcVBlc1JwVDNlZUJLaWk1?=
 =?utf-8?B?cm1nenhOVE5YZURyMDk4eGlqYXl1dzQ4WlgwSzBBcnZVVllhbGkydkt1Tnl6?=
 =?utf-8?B?elA3empIRW4xWmFTVkpkanl2Lzd3ajBwMURxVjhYaERCYm5XT252OTRURHFw?=
 =?utf-8?B?cGZPeFJ4cTdVSkVyRnY2eERBZlllU2tHVTRCSzBDOWV4bTdhZi9nR2p2V2hP?=
 =?utf-8?B?R0tlWjR5Qm8xTEVld1FlT0V0VUlSRWhaZ1ZxNWk5ZGpqTGNUVnByeFYvM0Mw?=
 =?utf-8?B?UUp4c1pxMlRkQUN4Skw0QVVoL05EQlo5ajVsMEwzTGVYNDVJUTJGVEdMbHRY?=
 =?utf-8?B?K2N1cGxqZmlyeGN5bE1yeThTSUxGTzM1OStScHRiM2hyMmtVKzBiWWtkMFNX?=
 =?utf-8?B?Z2ZCejMrZzY3bm5NZit6U0lXcTVvdHFUa1RrbDh2bmh1T1lVR2xoQTAyeDVj?=
 =?utf-8?B?MEhwekVRMUVqUWVJUlhMTVZvd2lWY2w1TTFPYkpsRndFUnk2SjN0RFhUaFFC?=
 =?utf-8?B?WDBKbmJtNVQ3T1hGUi92cjhRaVgydlMvTXhsYWdIcUVLTjhadXJEQmtERUkr?=
 =?utf-8?B?TmhLRG5IOUk2NjdpVDg0RjRydWVLY1RiREZGZ0EyeU1RWDJOY1dhZytTVXZl?=
 =?utf-8?Q?Q5ck=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf08da1-aef0-49b7-c74f-08dd477fa388
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 13:59:28.5983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFVtJgMaDDwxpHYwU1LMVCy0+iEg01YhcKH4bmIBJ58ObZw+iLggYo9wEa+LoFqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgNiwg
MjAyNSAxMDo1NiBQTQ0KPiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+
OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogWmhhbmcsIEhhd2tpbmcgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzRdIGRybS9hbWRn
cHU6IEluaXRpYWxpemUgeGdtaSBpbmZvIGR1cmluZyBkaXNjb3ZlcnkNCj4NCj4NCj4NCj4gT24g
Mi83LzIwMjUgNTowMyBBTSwgS2ltLCBKb25hdGhhbiB3cm90ZToNCj4gPiBbUHVibGljXQ0KPiA+
DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IExhemFyLCBMaWpv
IDxMaWpvLkxhemFyQGFtZC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA2LCAy
MDI1IDg6MTMgQU0NCj4gPj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiA+PiBDYzogWmhhbmcsIEhhd2tpbmcgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT47IEtpbSwgSm9uYXRoYW4NCj4gPj4gPEpvbmF0aGFuLktpbUBh
bWQuY29tPg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggMy80XSBkcm0vYW1kZ3B1OiBJbml0aWFsaXpl
IHhnbWkgaW5mbyBkdXJpbmcgZGlzY292ZXJ5DQo+ID4+DQo+ID4+IEluaXRpYWxpemUgeGdtaSBy
ZWxhdGVkIHN0YXRpYyBpbmZvcm1hdGlvbiBkdXJpbmcgZGlzY292ZXJ5Lg0KPiA+Pg0KPiA+PiBT
aWduZWQtb2ZmLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQo+ID4+IC0tLQ0K
PiA+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jIHwgMjAg
KysrKysrKysrKysrKy0tLS0tLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gPj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gPj4gaW5kZXggZWNhNDMxZTUyMDM4Li5k
NGVhZGUyYmQ0ZDMgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gPj4gQEAgLTI1MDIsNiArMjUwMiwxOSBAQCBzdGF0aWMg
aW50DQo+IGFtZGdwdV9kaXNjb3Zlcnlfc2V0X2lzcF9pcF9ibG9ja3Moc3RydWN0DQo+ID4+IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4+ICAgICAgIHJldHVybiAwOw0KPiA+PiAgfQ0KPiA+Pg0K
PiA+PiArc3RhdGljIHZvaWQgYW1kZ3B1X2Rpc2NvdmVyeV9zZXRfeGdtaV9pbmZvKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiA+PiArew0KPiA+PiArICAgICBpZiAoYW1kZ3B1X2lwX3Zl
cnNpb24oYWRldiwgWEdNSV9IV0lQLCAwKSA9PSBJUF9WRVJTSU9OKDQsIDgsIDApKQ0KPiA+PiAr
ICAgICAgICAgICAgIGFkZXYtPmdtYy54Z21pLnN1cHBvcnRlZCA9IHRydWU7DQo+ID4+ICsNCj4g
Pj4gKyAgICAgaWYgKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIEdDX0hXSVAsIDApID09IElQX1ZF
UlNJT04oOSwgNCwgMykgfHwNCj4gPj4gKyAgICAgICAgIGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYs
IEdDX0hXSVAsIDApID09IElQX1ZFUlNJT04oOSwgNCwgNCkpDQo+ID4+ICsgICAgICAgICAgICAg
YWRldi0+aXBfdmVyc2lvbnNbWEdNSV9IV0lQXVswXSA9IElQX1ZFUlNJT04oNiwgNCwgMCk7DQo+
ID4NCj4gPiBDYW4gdGhpcyBzdHVmZiBnZXQgcm9sbGVkIGludG8geGdtX2luaXRfaW5mbyBhbmQg
Y2FsbGVkIGRpcmVjdGx5IGludG8NCj4gYW1kZ3B1X2Rpc2NvdmVyeV9zZXRfaXBfYmxvY2tzPw0K
PiA+IEJyZWFraW5nIHVwIGRpc2NvdmVyeV9zZXRfeGdtaV9pbmZvIGFuZCB4Z21pX2luaXRfaW5m
byBhcyAyIHNlcGFyYXRlIHRoaW5ncw0KPiBzZWVtcyBhIGxpdHRsZSBjb25mdXNpbmcuDQo+ID4N
Cj4NCj4gSW50ZW50IGlzIGxpa2UgdGhpcyAtDQo+ICAgICAgIFNldCBJUCB2ZXJzaW9uIGluZm8u
IFRoaXMgaXMgdGhlIGpvYiBvZiBkaXNjb3ZlcnkgYW5kIGtlcHQgaW5zaWRlDQo+IGFtZGdwdV9k
aXNjb3ZlcnkuDQo+ICAgICAgIFNldCBhbnkgc3RhdGljIGluZm9ybWF0aW9uIGRlcml2ZWQgb3V0
IG9mIElQIHZlcnNpb25zIGFuZCBub3QgYXZhaWxhYmxlDQo+IGluIGRpc2NvdmVyeSB0YWJsZXMu
IFRoaXMgaXMga2VwdCBvdXRzaWRlIG9mIGRpc2NvdmVyeSBmaWxlLg0KDQoNClRoZW4gd2h5IGFy
ZSB5b3UgcHJvcG9zaW5nIHRvIHNldCB1cCBzdGF0aWMgaW5mb3JtYXRpb24gaW4gdGhlIGRpc2Nv
dmVyeSBmaWxlIGluIHRoZSBmaXJzdCBwbGFjZT8NCg0KSm9uDQoNCj4NCj4gVGhhbmtzLA0KPiBM
aWpvDQo+DQo+ID4+ICsNCj4gPj4gKyAgICAgaWYgKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIFhH
TUlfSFdJUCwgMCkpDQo+ID4NCj4gPiBNYXliZSByb2xsIHRoaXMgY2hlY2sgaW50byB4Z21pX2lu
aXRfaW5mbyBpLmUuIHZvaWQgZWFybHkgcmV0dXJuIGlmIG51bGwuDQo+ID4NCj4gPj4gKyAgICAg
ICAgICAgICBhbWRncHVfeGdtaV9pbml0X2luZm8oYWRldik7DQo+ID4+ICt9DQo+ID4+ICsNCj4g
Pj4gIGludCBhbWRncHVfZGlzY292ZXJ5X3NldF9pcF9ibG9ja3Moc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQo+ID4+ICB7DQo+ID4+ICAgICAgIGludCByOw0KPiA+PiBAQCAtMjc2OSwxMiAr
Mjc4Miw3IEBAIGludCBhbWRncHVfZGlzY292ZXJ5X3NldF9pcF9ibG9ja3Moc3RydWN0DQo+ID4+
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4+ICAg
ICAgIH0NCj4gPj4NCj4gPj4gLSAgICAgaWYgKGFtZGdwdV9pcF92ZXJzaW9uKGFkZXYsIFhHTUlf
SFdJUCwgMCkgPT0gSVBfVkVSU0lPTig0LCA4LCAwKSkNCj4gPj4gLSAgICAgICAgICAgICBhZGV2
LT5nbWMueGdtaS5zdXBwb3J0ZWQgPSB0cnVlOw0KPiA+PiAtDQo+ID4+IC0gICAgIGlmIChhbWRn
cHVfaXBfdmVyc2lvbihhZGV2LCBHQ19IV0lQLCAwKSA9PSBJUF9WRVJTSU9OKDksIDQsIDMpIHx8
DQo+ID4+IC0gICAgICAgICBhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBHQ19IV0lQLCAwKSA9PSBJ
UF9WRVJTSU9OKDksIDQsIDQpKQ0KPiA+PiAtICAgICAgICAgICAgIGFkZXYtPmlwX3ZlcnNpb25z
W1hHTUlfSFdJUF1bMF0gPSBJUF9WRVJTSU9OKDYsIDQsIDApOw0KPiA+PiArICAgICBhbWRncHVf
ZGlzY292ZXJ5X3NldF94Z21pX2luZm8oYWRldik7DQo+ID4NCj4gPiBJZiB5b3UgZG8gdGhlIHN1
Z2dlc3Rpb25zIGFib3ZlLCB5b3UgY2FuIGp1c3QgY2FsbCBhbWRncHVfeGdtaV9pbml0X2luZm8N
Cj4gdW5jb25kaXRpb25hbGx5Lg0KPiA+DQo+ID4gSm9uDQo+ID4+DQo+ID4+ICAgICAgIC8qIHNl
dCBOQklPIHZlcnNpb24gKi8NCj4gPj4gICAgICAgc3dpdGNoIChhbWRncHVfaXBfdmVyc2lvbihh
ZGV2LCBOQklPX0hXSVAsIDApKSB7DQo+ID4+IC0tDQo+ID4+IDIuMjUuMQ0KPiA+DQoNCg==
