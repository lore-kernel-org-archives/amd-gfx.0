Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4886E68948
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 02:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B8110E825;
	Thu, 31 Oct 2024 02:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hh8UOq4S";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC9B10E825
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 02:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNtpd37EXE2TGOO/lD3oqbbqWheFwo3/t0Qq8PlIJV5ZgxDeVCEmdbXGMBQecii7PIaOeVOh/yUywrPYf56f2jibaQTpzPxRDBd6IUXwiQsMJ3UAwlmrfwuKn8ZJmGDhg/hGLrU3Amo7y+Ltn05MJm4rahNOLGOWE9dShps5OgCAgyJjZAcLiBil50cZPKYgBrn9xDrmosg9envmrHbwJxhqvjzpmdul+T5+qIKWzQ4Ll13koqaPE9uxIiTE03NQYRD009eiYiIMPF1giRSPJPYKtwAsRKNK/eeuPkfpJ68gpyX/bZumxhWSFDOtoqSjRQw2sfigY1iNYUcEDA6SZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xIVONlGnW4u0HDZ76usgywnWGIBwr6/zYA9p2C87p0=;
 b=w0KwxBJBGHsqTXntODSWuQdlUmlovVXH5/C5hRB4aSYnn/FSvjx6jVOgyMdG3dLs7IANnWR3kx4gdBZ7Gzma+hJVqsiG4XjOWMpqUz11IZw6HVbueQX8H+WBEOxmieKiNwaQUT0fQ4alYeB4mH3nP8k0i6Hi1S7ICMcQ3y2NPwQ1i+33q25bStRXxzT2h38TTk1Mf6Fia4g08Lq7S9dDvhcefNh5UI6qXSW7+nJbEVNdwaenYSydxRhzJ6vz1PUz7UHsZes6AU8LCqIUKGgaiB5CKlcuCkn3Jr5dBXYDv4miZqdqtOXTbuLhNbSFitsYM5dH4fIcIPLB0oCuR69cpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xIVONlGnW4u0HDZ76usgywnWGIBwr6/zYA9p2C87p0=;
 b=Hh8UOq4SmcIBRaHvs4EUp/KKsleKpedxZCqOsCIImvoikYaoY4Tt9fi8ls+/AR38dJfBNI3NazL44xeg3av8nfG7pw+h07ehty6xBgLd31x6FsDmXjFcghTCrrFrKn8gR+KTiFAvJCjmLDWuo/hZmlTWGJO1yog5BUHU6cltSMQ=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 02:23:32 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 02:23:32 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: Adjust debugfs register access permissions
Thread-Topic: [PATCH 1/3] drm/amdgpu: Adjust debugfs register access
 permissions
Thread-Index: AQHbJY8a9hiRk1N62ESoyaJyX7V45rKcRDQAgAM68oCAAK1skA==
Date: Thu, 31 Oct 2024 02:23:32 +0000
Message-ID: <PH7PR12MB599777B2FBF5C082AF2CC2D282552@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241023210342.685808-1-alexander.deucher@amd.com>
 <CADnq5_M3ar8qGBFVF5p7YUbVsjZvzCdkDcJ-GM7J+T15vfJOhQ@mail.gmail.com>
 <CADnq5_OAwioJzxgonFEPNCHSWNOvmCowh=_OCQ-jcowP-Bcomw@mail.gmail.com>
In-Reply-To: <CADnq5_OAwioJzxgonFEPNCHSWNOvmCowh=_OCQ-jcowP-Bcomw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0d9cff56-ecba-4e19-b7d7-b4fab9cee01f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-31T02:23:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB8108:EE_
x-ms-office365-filtering-correlation-id: 7b2691da-a7b2-4f3f-0c18-08dcf95303df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eVNuMnRzSHZFOENQR3c4ZXZMcTRCZ3hINTNrd2owSkk1aW1ieXB2MkRwV1Zx?=
 =?utf-8?B?a0RtUzJjbVlESVZ4RlV1ZHE5ZmVsSnVlM2xWTS9DMmRRN1BVK05CNUdYaGVz?=
 =?utf-8?B?M2MwekFvMkNmbU1rZ3VybHJuSSsvdVJpUU43azd6RXpLN1h4T2lxcGJaMDFF?=
 =?utf-8?B?NHRJZEtEd2xxeWVZNDRteGxPN3FOczlKMU1FTThrWVROQ1F1WEpIQkorU2la?=
 =?utf-8?B?dDlSeEw2aklzNGRzWXFnQXJTL1phS0RjUStnQzBnUHd6MUkvWUNUTVpEKzR6?=
 =?utf-8?B?YVpHakRPY0crQlZQS29HdEFkTjVzejR0THRnNmlBTVZUSlBrdGdTcDJJVWZo?=
 =?utf-8?B?WlROMC9ReFhxUEk0b1pYMUJGa2VlL3l1ci8ra3cxUlNTVlNYTEhkbnJYaGRt?=
 =?utf-8?B?NEVmWWlBVUthK1QrTEZDejdwaG8yYm05L212Q1ovdVBQSnBSNC9uUWMySjFY?=
 =?utf-8?B?Q0MwQ3lOd09yNFQrNnVxNURBbEpyQ3VTS0JXVW9RWFlidlpLeEFSR0UxL3Yv?=
 =?utf-8?B?OXpvVTFSUnoxdEExN3VJMkZ6aDZyYy96ZG05a1QzTXRkSGdRTEFqeko5eE1X?=
 =?utf-8?B?TlJaZTFWQWlyWjlFaU11aUNYalQ5SUw2bW5DSUQ2NEcyRTJ1bXpzMHdBRVhB?=
 =?utf-8?B?YUswejZ6TGhGakpBWTBLMk9tdHlXYk9oMmladDZnL0FiVzdDcmNVaTY1dzJJ?=
 =?utf-8?B?TnM0dy8rYkZJYTF3dy90V2kyeG5jc29OOHY1dC9vSXB6eHcyVUp4aXVxNGc2?=
 =?utf-8?B?RWxNcW50RVNscnFCZys3bGI0WHFMNjE4bS9tSEYwcXowZmZ1RVJtTlRiUXNJ?=
 =?utf-8?B?enNUWWxIVnJTZ29lN3VISmlzR0taaUtic1JzUHNNVFc4eHRlYWM4SXJpOUZ1?=
 =?utf-8?B?S1NMaWROa3g0eG9iWlBWZU9DcUFzSk10WGVPNUZSNjZGb0xFQ3NXT29GZ2k3?=
 =?utf-8?B?TEU3RTcycERQZVQ5RmQyRSs1a085Rmh2RGI1bUtlYzVvV041WFMvQ24wRHNr?=
 =?utf-8?B?MFF1VlJJSXhJRFRqajZZQmNpNi9QKzJpOWpnR3dPZXRjc3YvUHluUFNUdis0?=
 =?utf-8?B?MFQyUXYxNFNXMC91eUJ3ZjdvOW1vZXRDOTFseWZYOERNM1FiMDlUSmRRblUw?=
 =?utf-8?B?Wm81aDdqNHNGMzREZERaT1VuemYxTVRjcXBmOWdUcDMzYU81dlF4NmNYak12?=
 =?utf-8?B?d0EvWHdpOVFhQzcrWkV0VzM3akVKajFZenFKUUxRS3dhSENsNHQwWGNyOFhI?=
 =?utf-8?B?TW81M0xGWUswY1FIR3IvdzI0ZFM1WkxWdlhiRDdZdkJLTVY5ai90ZG9xSGUx?=
 =?utf-8?B?NlVYcGJrNHlEZlZqNURsSENRNnFJMDFLTTdTSW9uQ0VPYlJhQkVWRDh5dDdQ?=
 =?utf-8?B?dHFkSWFSUFJXS2lhV3UzelN4Y2l5akpnbXdIamsyUXZ3YWpjbVd4MEhXRWph?=
 =?utf-8?B?Y1hKdmhnQWdrZDEweHNtWUJNMFVKNkpJR0drMnIvL2tlemJ3aFNMWlU5TWIr?=
 =?utf-8?B?a1Q0d1g1T1UzbWdxSjFteHI5U3h6RmNiSHltZnJRMlo0clFEVzZJVkNheEcx?=
 =?utf-8?B?dVpEcitZeGVId3gxeCtROWZNVS9KdkRVQ29uTWFrMngvNzFZMTFLOVBmM2R0?=
 =?utf-8?B?QTcvNDFxK0h5MHQyb0FyNm55eUhxd1U4alBqU3pCc1cvTi9LWDFCV3FiRUpv?=
 =?utf-8?B?Q3AyeGozbGFXMngwTVNzRXBXQWxla282eDNtSXNmRVN2OTMzbGt1NnlpblZn?=
 =?utf-8?B?SmpOaU9ISEhHQkNkZmtGSjhyVm5CalQvWHZFbjlXYXljbUZ0OCtWYW1PcHA4?=
 =?utf-8?Q?XOXpWiXzKjpB7CFcN/JPy/4qgSQR7vuQSsArY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2ZLR016YmFVVHZ0eTEwNHVHSGxrS3Q4NldncXNMUTdGMTJGTFZJNWthNDJi?=
 =?utf-8?B?Z0hQY1RHZlgvREttZm9aS2tjb2pPaDZQTEF0VFhSMWUzdEpFZ3J5eU5TczBD?=
 =?utf-8?B?dUVzL2JaV2p2OHFCWUdjKzBtdXB3d0EwMHBMRnY2akFKS1hveGkwOGQ0WFZM?=
 =?utf-8?B?ZXJ5ckZUSk5VV0V5TG0yRHczY3FFNFZQL0F6MG1iODZTS3JGR3hQTmROZVN0?=
 =?utf-8?B?OTRxWkluaElMcXJ6Vno3YU1peEFhdjMzLzJLc25jckt6Wm8ycG5uZjY2VmFr?=
 =?utf-8?B?RDZ2OWhFOUNZU2xQbE5uK05GQXF6RWNZRVA4NDdObVdjdWxqUE5ySzlhOXdv?=
 =?utf-8?B?RUZJNTc4aTJxeVVwOTJ2MkdsQ21lUlVVSFBXZDVIWExvYk80OG11UXZPM1Y1?=
 =?utf-8?B?UWs1RlQwaVVZZEFCT29kWUpwZ2VSbS9zMnZmTERwRm5xd2lxL09QMjBONExj?=
 =?utf-8?B?a05RWlpmMTB1Tnd3NVlQVjlVYStkTEVBMDhRd1FuYUYzTDc2UFk4bmJURUdK?=
 =?utf-8?B?YUFqY2dxWXJnWkI0OGN0bHFNMTk3S0NyNDJWOFR3TjA5L0VybG5nVDNVZm1I?=
 =?utf-8?B?Zmo5cm5IUkxqcW96aUIzb1IvUjk1am1sSjVOWThWRHBLeVFwUXFGbysxcUsr?=
 =?utf-8?B?TzRUOHBXSTZNTHIrL3BScmUxU1BPait4eVpaRk1zUTBiWnJOZFhPUS93dnlK?=
 =?utf-8?B?cFVsZmMwdWVDdXJ3cEpUUGdreUhZc2pOeHk1SDNIMnplT0pOSXYxL3p6U0Rz?=
 =?utf-8?B?aXZOVm1WVk0xMlkrbXRqQ2dOVXpHR1VQZXN5TlNOQXdETlhhUHdOVis1Yng5?=
 =?utf-8?B?QUozWm45OFJsNlVtWUZqbFozU2RHYnRVUFJRcjdyZHkwWFhLaDcwYVd1aEQ5?=
 =?utf-8?B?WkdhUTJJNFVBNFFwWGlLQkhDN3FaQkhHVldsMTJPRUNYVXJmR0N2bHl1TzhZ?=
 =?utf-8?B?WmE3UnNNYWJ5SHplTHRDSCtDZXF5cGpiOXErenlZQU9GVnZsdHdERkVMMVZU?=
 =?utf-8?B?SEg0TWo3QkxkVmwza2RTZXVZSXBDQnhQdGNzR2twUUd2M0RFVW0vQ05qYTgr?=
 =?utf-8?B?U2RQOGRQZ3F6Ukx3SDJYK2pNS2phM3hTYVFTVmJTNXZBK3cwcnUwZUFIWFNR?=
 =?utf-8?B?K3hLNGhYUzNFTnRhblZNdUdLUFY4ckwyOHlQMklNOXNEMlpWUmxjRDVsM04x?=
 =?utf-8?B?WllDYUROL1Z2a3VSa1BIZjZwajRLTEM0R2dIWG53cVkzRVVFeHFYZWtZNmxG?=
 =?utf-8?B?cW1wV2drcHE2UFc4eGovaE96bEY2VW53TVBrL2ZYOEpVcENuVzBCYWtYY3c3?=
 =?utf-8?B?V2VueGtORkl4VzYrcnZ1RU4xRENWdnI4NnVPZ05sSnhQQWkvb0hKaHA5OWo1?=
 =?utf-8?B?K3lCS3gwa2ZiTzZXVVV6aUFwbEFQL3BrTHR2dFhvMFcrTks3Q1ROcVAvaHBy?=
 =?utf-8?B?N2RmL2t2K01EL0JBbjhlU1YwdjYxTGl0K2s3NHlqejBHQ0NVdFUvNGs0a2tq?=
 =?utf-8?B?aG12cTgzVkRWSklkSFZtVG5DQ3o3a3hvalR6dExPaHExZDI2ZnZxSGV2TlR6?=
 =?utf-8?B?VXJCa3lhOVpRY09KUlBIYWxEZlFac1pwUlU3aUhxR1FaeXdoM2QvR1VDMGRz?=
 =?utf-8?B?b0JHdXhKRjlrb0piQjNsWlc1c0xVSy9UTFpKWTVNTVV4dnV2UWF6N0VZdlR5?=
 =?utf-8?B?NFppcEM3a0NmQXpXTVh1UGFtK2w1RWFVSDZRN3hmbXJOQVUvWk1EblhBcFZR?=
 =?utf-8?B?aTBqK2tTcWN4dDNac3NFY3o3UGVvZDNYNXRXMzBnVWF1Q2s4clJJWDZNbTZ6?=
 =?utf-8?B?VmoxK2hIREg1WGxHYjN5c3ZHYkVoeEM5QXh2RXd3SE9ZS0FNT3JLZE5TWG9J?=
 =?utf-8?B?ZDhjd1pkMFRUWGFoemVCNEUrUWdXT0pqZnNIK09PdWZiSXI1dStCbXB3NTVW?=
 =?utf-8?B?WGhaRWNjV0c1Mjlnb0Rhem5sUkt6cjJNMWJNMGJqbFVheGc2L0dBMjYySU1j?=
 =?utf-8?B?dzBNR3hhckRzVHlva2RkK1pZM3hKSVFsRmQreHl4YzdqbzdNWXYvN1FaU0Jz?=
 =?utf-8?B?akIwRVlGNUNXUit4ZHJSUWRZb2xtVmpvVkhZcFE4aXBYWWRIcXVDOEhGM1l0?=
 =?utf-8?Q?7NiI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2691da-a7b2-4f3f-0c18-08dcf95303df
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 02:23:32.1903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evFSje6ZNNvuurgbm/n2INssek0O2lIMeDfOsy+Aayrf5ViiU0aUXUnVbYLdjKba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108
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
Cg0KUmV2aWV3ZWQtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCg0KQmVz
dCBSZWdhcmRzLA0KS2V2aW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFt
ZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBP
ZiBBbGV4IERldWNoZXINClNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDMxLCAyMDI0IDEyOjAzIEFN
DQpUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDEvM10g
ZHJtL2FtZGdwdTogQWRqdXN0IGRlYnVnZnMgcmVnaXN0ZXIgYWNjZXNzIHBlcm1pc3Npb25zDQoN
ClBpbmcgb24gdGhpcyBzZXJpZXM/DQoNCkFsZXgNCg0KT24gTW9uLCBPY3QgMjgsIDIwMjQgYXQg
MTA6NDLigK9BTSBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+
DQo+IFBpbmcgb24gdGhpcyBzZXJpZXM/DQo+DQo+IEFsZXgNCj4NCj4gT24gV2VkLCBPY3QgMjMs
IDIwMjQgYXQgNTowNOKAr1BNIEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBSZWd1bGFyIHVzZXJzIHNob3VsZG4ndCBoYXZlIHJlYWQgYWNj
ZXNzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGVidWdmcy5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RlYnVnZnMuYw0KPiA+IGluZGV4IDZlNjA5MjkxNmQ0ZS4uZTQ0YTQ0NDA1MjY2IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2Zz
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5j
DQo+ID4gQEAgLTE2NTQsNyArMTY1NCw3IEBAIGludCBhbWRncHVfZGVidWdmc19yZWdzX2luaXQo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4NCj4gPiAgICAgICAgIGZvciAoaSA9IDA7
IGkgPCBBUlJBWV9TSVpFKGRlYnVnZnNfcmVncyk7IGkrKykgew0KPiA+ICAgICAgICAgICAgICAg
ICBlbnQgPSBkZWJ1Z2ZzX2NyZWF0ZV9maWxlKGRlYnVnZnNfcmVnc19uYW1lc1tpXSwNCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTX0lGUkVHIHwgMDQ0NCwg
cm9vdCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTX0lG
UkVHIHwgMDQwMCwgcm9vdCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBhZGV2LCBkZWJ1Z2ZzX3JlZ3NbaV0pOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAo
IWkgJiYgIUlTX0VSUl9PUl9OVUxMKGVudCkpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
aV9zaXplX3dyaXRlKGVudC0+ZF9pbm9kZSwgYWRldi0+cm1taW9fc2l6ZSk7DQo+ID4gLS0NCj4g
PiAyLjQ2LjINCj4gPg0K
