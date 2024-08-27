Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD02AC54734
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 13:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 571D210E0B4;
	Tue, 27 Aug 2024 13:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="naEeINUy";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D4D10E323
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 13:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zh7o8ybdq8gwowuSD8E04JT+MDe0ng8Lt/c1mkNuecuQCTOpKMNBJXkyieczs7QFWVB/G+0errdSRdppw5EeJymRBtvvc0VQwuwrXv0cWOtZ2R2eoaMa7SFo9bDIxBedAlv6lUuOoPlDWFr3P4ZQuc3PqhvuJ5uP1Qg3C3HV3rcShcWQfmp8vKJ6v8s2b4tKujjhwVFqGxfwr4uYjUFs9OWN84iVFq3Duc/7zo+IRAzanDlCmUWdXBYn5sz++jEdslgqOzOzmvGnAteiLwjy3xy9tOCb6R6395S/FMQDNqu2kcKa/meMoYV/kmQ98bQkcHOtu8iEeanOztby0r6/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAbI/nb1FRPUUW7pqTZesChH1JTIfSt378uRY2ofHLk=;
 b=dHnB3esc3DldS5o7/6dc4PLB7fT8UNEhMe0/TytwcUidLaR3xX0RRGC5ah5fomty/ENG8lL2p0q93RbUHZZei9q5YhrHYnlYmR+u0dZobzijlbKVM3NhEorY5uEsBQS8Ibkshypa6fc2WELytgi5wY7Ob4Zah2a6Pat9bXpRDLMCHDZJvfDpoqoMRLaGWLhMzCJzI8/Y0CNPn5GFRFTCE+9AX41QXaqqNZWUb04WRTLDzHcih8uYJjOSPb3WPG1n30TlBz3ER54VE/ejbF45dMB3fu8t1hR0kWEmH8pRGKruAtd/emeUyqHtp0h7J3GMDArT2nLXuRX/j6kPnrqjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAbI/nb1FRPUUW7pqTZesChH1JTIfSt378uRY2ofHLk=;
 b=naEeINUyQRGexR24NSWpfrfxTR/oT4XOP8FN1BmV8sRlqs3kB5Lj2UI+15dOCGdraVAnbaaH6yAwKHaA+8EXDXIw98N9UtxBC08U01Kysn/TKtATmBFCXBGbmUkWPyU+3P0Ikw/m0qNaKbELje8XyTmfN3uMOfEChzL6F0Rrx2s=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Tue, 27 Aug 2024 13:24:33 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:24:33 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>, "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Don't drain ih1 for APU
Thread-Topic: [PATCH] drm/amdkfd: Don't drain ih1 for APU
Thread-Index: AQHa+FJzIAbyLJRiKUebhO0vFDxFKrI7E5mAgAAEQrA=
Date: Tue, 27 Aug 2024 13:24:33 +0000
Message-ID: <CY5PR12MB6369792D679BE14531839A19C1942@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240827072600.60239-1-yifan1.zhang@amd.com>
 <CADnq5_OiakRUpXvdXaKF4CXwLeep=a5jNH0kGQ8hpNM0weL-Qw@mail.gmail.com>
In-Reply-To: <CADnq5_OiakRUpXvdXaKF4CXwLeep=a5jNH0kGQ8hpNM0weL-Qw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6bddaba9-dfdb-45c0-b6e4-6b661a93dfcd;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-27T13:23:05Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DS0PR12MB6559:EE_
x-ms-office365-filtering-correlation-id: 9cc9e2ea-06d9-4b57-9bf8-08dcc69b9731
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RTlzSEVuY3loT1NYaU5IcWtOaHFyLzVsN3dBMVo1WkZoRjlkYUJiU1N6TW5J?=
 =?utf-8?B?Nk95R2wyd0VpYnphZkp3UkxMWW1vWkpDeWlnbFRSVFlWZmpjT1hIUzRZVHA2?=
 =?utf-8?B?eXRCZktVUTRvN2dKckhrcDZ5MWVBd0RBWm5jcWNld1JUSlJlTExVVFBiaU9i?=
 =?utf-8?B?L0NCNGdIb2VuYS9iOEZkdWR2MVRadEYyWHJVNWxFeWorRmMweVhEeFNFVlRj?=
 =?utf-8?B?QnY3S2plNlVPU09mVlZmdE9FazUxcy9GSXd0UUF1cFhtamxtdk9seWUxWUVH?=
 =?utf-8?B?aVM4cGpiT1FVcjlwb0xUUEJoZFE5OVNQSkE2WEZ4TEFtSi9Eb3pnQ0ppVzA0?=
 =?utf-8?B?WG93SThkcktuL2NDVGpEYlhrejlvRS9GajQyMGxWK3R0cUU1YVphR3F2VHJ5?=
 =?utf-8?B?TTRQNzlZakUrbFNvWXYrSTVValVyQ0JqRTZMaXZ1WUZqcEcwd1l0UzNVbERG?=
 =?utf-8?B?MllOZCt5bEVzNEZYREx6V0FGMUVmQU1LejVFYW5Za3lpY0pLNkJtTnZ0RlRQ?=
 =?utf-8?B?QzA2R09LRVpDVGsxdHFPWHBGRDYxbFduOXQ3RnFQQmJIODhvOHJHbDNQQitH?=
 =?utf-8?B?TzZGVWd6RXNWSTZkdk5CM3ZVM3NoNDhhN3pPS2tQVG9EUXlZcHlxWDlPc2d6?=
 =?utf-8?B?TUJVM3hOTlBCdGpnQWo5TmR0NXVXMEM2V1J1NUQrRkVDaEFXbTc2MVRIa1dT?=
 =?utf-8?B?S0IrZjd2aUxKbEVWd2NiL3pwdlBTRTBjNVprVWJxVGFLUlEySDhPNkxzQU5S?=
 =?utf-8?B?MXgxN0tLVVlTb29TZVhOU01hbUY0QmVHNWlyWEVsRGkxSkVVVEhscy8zQXov?=
 =?utf-8?B?eXgrMWVKSmY2aE1HdXR2ZXNIdUhWWVB5TDlyTUI5aTVOSGYweDJPaE96QWVR?=
 =?utf-8?B?NVpZSmhQZm9IVXRpcVowV2hWR1BlYzZvMVhRa0cybCswejB2dnRHOHB5eUVM?=
 =?utf-8?B?dXFGNXVtM1ZwcTIxUDlsd291REZuWnRRTzFBVWtNckI5eHUwQjdUWGd1NVR2?=
 =?utf-8?B?Ykp3RGxrdUVkY20zTEQ2ZHE4dWp0dGlmeVQ3YjBTcHhraGswd0drVzVIcDgv?=
 =?utf-8?B?L1lSMVhSOFNhdHl1YkE4MC9IakxYZ1NEQ1psKy9PcUU1YWd5WTdjRnc4MXJQ?=
 =?utf-8?B?YUhZY1IwT1lrZk1yakU5UEs2Y0hHRXFRZGhJUE1kZzk0L3BnTG1oeVdDWFAx?=
 =?utf-8?B?VlROQXJVWVBndEtUQVgrc3I4WHd1Z2QvV252dm9yanNjSEpIYmU1SVMyK2M3?=
 =?utf-8?B?MnNDRWptc1p2VFdFNjVlcktoR1JhY2VQYTdyKzFRVE9odTBGNWM2dWQvZHF1?=
 =?utf-8?B?TkE5OEcwMUdOcmxhZWszQkpQdlhqWnUwSkV4bVEzQ3dlaTcwaHBWZ2lSUTAz?=
 =?utf-8?B?bktrUFRCM2d3a2Exckp4K0tvek9VaVNWTzdsc2xaalFUT0ZoemhIMkd1aW0x?=
 =?utf-8?B?M1VpMTFtTXJnSmlsaUxhUVJDY2ZseWZXSjhZb2o1T1lMU3k1NjN1SDVISHRn?=
 =?utf-8?B?L3ZoN2RNZ2JzNjBUU2RNa0V6bTNzQnJ3SEg2QnBxUWkzTUhvT3J2U2swR09S?=
 =?utf-8?B?d1BuTHc4djRPcmk5YkFzNkRhYjNJdTRVbDBsWHpnNzhMNVVOWEJ1WS9Zd2NK?=
 =?utf-8?B?NEFEMS9FSHM1Mlozcml2NFlpdFQyU0RNcHErMjd5eFl4TS8zdzFDVmZZZ2RV?=
 =?utf-8?B?eTJxM2lEMUJ1YWNtbEdKSDdpZU9FRFRHSnR3a0Q0SDZYWGFkOS9xZ1ZUNTVW?=
 =?utf-8?B?RFJZanJ2eUZMQ3N6TEdIR3UwaHczcVd6dlVpOGlvZGFFWVY5K2lVYnpPQXBl?=
 =?utf-8?B?NnltNjNuNDJWbDhtR0M1ZGJ2eit5b3Juei9yL0d5dkliN2VGeGpLY1hnZTNK?=
 =?utf-8?B?aVFsSnJwTFRGRGRiei8xR2l3eGFQZjhCY2lHbEVlTnhjZVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2didHFEOUFKZ0dXZFdRZUQvUXlnQW5kbjBacXFGOGNjd1FpVnRDY2pDMTZD?=
 =?utf-8?B?am5QOCsrN1BRUnoxUU94ekNMMTZrWHFwdWtjZ2NOcWw1K3VjcURtTTZwRnZC?=
 =?utf-8?B?OW9xVzBBQlVrTC81OGRDVHJ6UEJMTlhlTnRDQzFRSjJNYkxscXprN0hjWEtj?=
 =?utf-8?B?VGRxdHBJa1Z6QllDNEpwZDlvM1dMOGFXL1BsdDYyT2UyYjhGa1BOTktBR2Yz?=
 =?utf-8?B?NlY3dVJ3c3NhM1YrZzkxMjVCb3ZnS0oxRjFOU1FnNGcyeEtJWnlMSGN0dmdT?=
 =?utf-8?B?TCs0Tkd0NzVNaStrSDlvMzhiUXgzM0Q5N1FxQmJBcUkzdWtuTEJNRlgxR3A2?=
 =?utf-8?B?VmNqRTFBMEQ0LzNXQnc4S3FDN0hoMTI5a1JWT2wvQnZTakhOdk1IcysyM2Zq?=
 =?utf-8?B?ZVMwb2VqTXFpaVdvT1IxcytmMmVsd25EdURJOS9qcmJ2bnpFTXdxS1NERi9V?=
 =?utf-8?B?ekhHU25UNU9SS3dlRVZUV2lSU0Uwd2d0a29aKzlFakdyQ3o5cW1EaU9JZSs5?=
 =?utf-8?B?Y1VCdTJtWjNVbGZCK0NkSmZyMmpLV3lBbE5TTHdYcC85TUVScWN6Tit1S2pL?=
 =?utf-8?B?dk8rcHJzaGVaQ0RuVCtBa2JyQURKYmFZNE5rMWpiRWxhbmptRHZkUkRSZ3Z5?=
 =?utf-8?B?bjZOT0dWcDVaWHhHdnZCOThPSjR3Tmh1dng2cXAvMVpWalZDY2Jna1dLOXg2?=
 =?utf-8?B?bTk1MjZYc1VmL1RyRkdXelhJdTVBQkVPTlZ0ak4yaWE5dmZldFRVWmtSeUli?=
 =?utf-8?B?bENtMk1Yb2tTdlJENkpVZFlVa2x0YnM2Z3VPNCtvQnloRkZhcHMwaDJJQTcz?=
 =?utf-8?B?NE5yWCs1UHdNdk0vQmxnVGI3K1cxVDhyRnVzM1MrMjRZN0FuUEhjVzR2b1hH?=
 =?utf-8?B?VDdiazNRV05uUVhpT1FHUFV5Vkl6Zm02UTFvNW9RSXlEL0RoSGlOT295RjZT?=
 =?utf-8?B?bmtJVXJHY0k1UWIxU052SjN1UC84TVJjT0NSWS9uR0d0OWI4R2tKaUtybXJJ?=
 =?utf-8?B?UW9HaXRHajFUMW9xb3p1VjExQjFVc3VuZXdoV2QwMmIrSnVBU21CT1NFTTdE?=
 =?utf-8?B?MzJMaEtzbFBjbTJtSUtCTS9qTElLb01qZlBwOE9TckhwV3RubEpRN2xUQXZF?=
 =?utf-8?B?WXpmOCtNUDZrMnZJY0VTQkpFVFBKNHNMM1pYYUFSZW1VVzZTV0RNclJra2hn?=
 =?utf-8?B?YkR1M2NaUG02aDZBbnhLS1FiaGJqQ2ZmZCsrZXpKMG5OMys1WmFjWUtHMHcw?=
 =?utf-8?B?c1pIak94bktkV2xyNHlHTU94R09CWlExZkM1M21EeDE1QXBkdDNQWm5yWnZl?=
 =?utf-8?B?UWxnR2YrVnJjWmczc0RvT0kvVWNpYnpVNDJCcVFHQy8xYXFPTW4vN3ZTNWJu?=
 =?utf-8?B?M1ZhZWpIZWhEZW1yM3hWYW02MEE5bW5xQWl6MThmRS9PaEpkeDNIZ09VUUs2?=
 =?utf-8?B?UHdoYThtWGZ1azMvQmhGaEFWa0ZEYW94MXdISSs2b3VOOHdhSzZCbXNVN1h1?=
 =?utf-8?B?WnVocXFYOFZudEQ2eDFTeWw4b256aDFBQXNpRkpGQWdzazFYbmtkeWJrUk9t?=
 =?utf-8?B?bU1pemM2NVZETmErQnZjQWEzZU5wU3FpM1p4ckduUnk5V1p4L1UyVFc0aWV1?=
 =?utf-8?B?RXJGY1BtanJJUVI0cmRVaFNybk5obUJ5TVhLRFo1Mm13ek1hSG9RSnNIM29Q?=
 =?utf-8?B?Um5ETTVVVHA1NXVydnRKZkxNTW9GaWRFUHQvT1BUZ0VxemxPMFgwQ2I1MWR6?=
 =?utf-8?B?QXhDYU9RY3QydzVTRFd6a0dXblA4dERqZjMzQVNSN1pxT3E3K0RXaERBRjNF?=
 =?utf-8?B?QUtsTUZWNW81a2tuNFMvU1BJTnVFdG81cHo0Vi9SMEk2emM0QVJlb2J3VEMx?=
 =?utf-8?B?Y1hSWExIQVpLYmtKbDJ1bktSOWZ5UUw5aEsyVlVNbGlweVpkc2kxajJ4RWkv?=
 =?utf-8?B?M2xJenI3VEFMWC9uRVdySk4xRlRXS2RKcmZkbDFuTXlJNS95MFdzcjZSSXVt?=
 =?utf-8?B?QUpzRUZPeWhQNGgwVHBCeWZhWkFDdlk2akVHMWwzWHFaVU9vRjdOYmJ6S1Vy?=
 =?utf-8?B?UTBOa0hFdHhPWTA5dG93ZWNQVDFSTndDd1lRVGt6SFBwY01lY2ZrL0g5V2Fk?=
 =?utf-8?Q?raoQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc9e2ea-06d9-4b57-9bf8-08dcc69b9731
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 13:24:33.8576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EquwlDqyqWUIXtiW8P7KYc/ojhPsEZ9qSwRQ2qUZX13TuniJaBS/yD8Dx6tTPbzE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
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
Cg0KVGhhbmtzLiBXaWxsIHNlbmQgVjIuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6IFR1ZXNkYXks
IEF1Z3VzdCAyNywgMjAyNCA5OjA4IFBNDQpUbzogWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdA
YW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS3VlaGxpbmcsIEZl
bGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFuZ0Bh
bWQuY29tPjsgQ2hlbiwgWGlhb2dhbmcgPFhpYW9nYW5nLkNoZW5AYW1kLmNvbT4NClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IERvbid0IGRyYWluIGloMSBmb3IgQVBVDQoNCk9uIFR1
ZSwgQXVnIDI3LCAyMDI0IGF0IDM6MjbigK9BTSBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5nQGFt
ZC5jb20+IHdyb3RlOg0KPg0KPiBpaDEgaXMgbm90IGluaXRpYWxpemVkIGZvciBBUFVzLiBEb24n
dCBkcmFpbiBpdCBvciBOVUxMIHBvaW50ZXIgZXJyb3INCj4gd2lsbCBiZSB0cmlnZ2VyZWQuDQo+
DQo+IEZpeGVzOiA0OTBmYzIxZmU5N2MgKGRybS9hbWRrZmQ6IENoYW5nZSBrZmQvc3ZtIHBhZ2Ug
ZmF1bHQgZHJhaW4NCj4gaGFuZGxpbmcpDQo+IFNpZ25lZC1vZmYtYnk6IFlpZmFuIFpoYW5nIDx5
aWZhbjEuemhhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfc3ZtLmMgfCAxMiArKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfc3ZtLmMNCj4gaW5kZXggYjQ0ZGVjOTA5NjlmLi4xZDA4OTc4OTU1YzcgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMNCj4gQEAgLTI0NTgsMTEgKzI0NTgsMTMgQEAg
c3ZtX3JhbmdlX3VubWFwX2Zyb21fY3B1KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBzdHJ1Y3Qgc3Zt
X3JhbmdlICpwcmFuZ2UsDQo+ICAgICAgICAgICAgICAgICBhZGV2ID0gcGRkLT5kZXYtPmFkZXY7
DQo+DQo+ICAgICAgICAgICAgICAgICAvKiBDaGVjayBhbmQgZHJhaW4gaWgxIHJpbmcgaWYgY2Ft
IG5vdCBhdmFpbGFibGUgKi8NCj4gLSAgICAgICAgICAgICAgIGloID0gJmFkZXYtPmlycS5paDE7
DQo+IC0gICAgICAgICAgICAgICBjaGVja3BvaW50X3dwdHIgPSBhbWRncHVfaWhfZ2V0X3dwdHIo
YWRldiwgaWgpOw0KPiAtICAgICAgICAgICAgICAgaWYgKGloLT5ycHRyICE9IGNoZWNrcG9pbnRf
d3B0cikgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICBzdm1zLT5jaGVja3BvaW50X3RzW2ld
ID0gYW1kZ3B1X2loX2RlY29kZV9pdl90cyhhZGV2LCBpaCwgY2hlY2twb2ludF93cHRyLCAtMSk7
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiArICAgICAgICAgICAgICAg
aWYgKCEoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSkgew0KDQpXb3VsZCBiZSBiZXR0ZXIgdG8g
Y2hlY2sgaWYgdGhlIGloMSByaW5nIGlzIHZhbGlkIHJhdGhlciB0aGFuIGNoZWNraW5nIGZvciBB
UFVzLiAgRS5nLiwNCg0KaWYgKGFkZXYtPmlycS5paDEucmluZ19zaXplKQ0KDQpBbGV4DQoNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgaWggPSAmYWRldi0+aXJxLmloMTsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgY2hlY2twb2ludF93cHRyID0gYW1kZ3B1X2loX2dldF93cHRyKGFkZXYs
IGloKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGloLT5ycHRyICE9IGNoZWNrcG9p
bnRfd3B0cikgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN2bXMtPmNoZWNr
cG9pbnRfdHNbaV0gPSBhbWRncHVfaWhfZGVjb2RlX2l2X3RzKGFkZXYsIGloLCBjaGVja3BvaW50
X3dwdHIsIC0xKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgfQ0KPg0KPiAg
ICAgICAgICAgICAgICAgLyogY2hlY2sgaWYgZGV2LT5pcnEuaWhfc29mdCBpcyBub3QgZW1wdHkg
Ki8NCj4gLS0NCj4gMi4zNy4zDQo+DQo=
