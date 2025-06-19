Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028EBC7115E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 08:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A30C10E35D;
	Thu, 19 Jun 2025 08:29:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rvt7FxFP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9CD810E35D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 08:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDLzvM9hWKtU5WCFg+wpdtzXxiSv5QSz/QK+OkeZqWrLyKhZB/XPpzyONiHR3hAvbUT9FO4jLUS+BhLs5lycs4xRMVy4NyWii0ON2uyQ/O1U7IhW6pyPBo0pj8dEafIIu5ajXmm/6wxt42UweYbkyESvUp+HynSoITADOBy2nXWw+rUSKvf2EdGeGQ8le7C9ajJRxCu6ghzCpUzgQ/LY02pGgkcvmhmmpm5CyfH7CF7hNhXN4u6hIsXtkbqC8aS4GaJ+6WSJnQ92dc6ipRt/esinAMz4LwfQaxpDD3CA1SjNvNrVQPIRByRMCPXSkgagL1Dl7eOznrC9oZoPxU/DQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83fltrVOjo30YeCciGozky9AO2+Yy87JZ6DtTl79pkU=;
 b=VBuQ3j7RTdImSl/n373dnF1aD6wjz++7Akenb6T/wcyrdUZME7PMVL2WRw8NlIoIiHd65S90wBxDHMGftn5Na7dPD6YNgBbt8oZ2swHxrBLnpdCuBFUiNu/8bDzGHC9bDJeCCyERXmSdSebQgNd23iyEJXK6MuE78ljKNwAVNpn34Z4TpAEyj/UwBFJUVgr+5rc/BnUFERrUjHFx5tYjo7EhD7sZ75/5AtbNUOjB+EUgg4jdly6Y57IfoN15dV2Ostf0FuHzFGLCgp5JfqJT3ZH6TOBxGHaHM7/w+8pxRaxLLuFhdbugh/nvZ6wWj/+0ouWUkZR5iIrUeliBwaOvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83fltrVOjo30YeCciGozky9AO2+Yy87JZ6DtTl79pkU=;
 b=Rvt7FxFPJi6wa5Ma/vH4ikCBEoLkHZ6aFNxOvVb5FEEfe+9TA7U41zGMXpbbZxwDs3TwyFWNamxgrCd6QR6SLqM809CMy+WPQ/+qsPUsJyB7gNeQt8cLOzkTwth1Ab6YZfa8DsRaCE4lgqn1wuu1rPBcWYnIzmnMKLp2ammR4fI=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 08:29:45 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 08:29:45 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2 03/11] drm/amdgpu: unify the userq doorbell object
 destroy
Thread-Topic: [PATCH v2 03/11] drm/amdgpu: unify the userq doorbell object
 destroy
Thread-Index: AQHb314tS+8VcOaJjEKEAq/z/ZOrCbQHdhMAgAKuCKA=
Date: Thu, 19 Jun 2025 08:29:45 +0000
Message-ID: <DS7PR12MB60058983BC4C64E8CACECFC2FB7DA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
 <20250617080151.1093481-3-Prike.Liang@amd.com>
 <CADnq5_M1D1+iASZCFJMu=_QBi5yMrXgofANJCXPby9jP1ZfgYQ@mail.gmail.com>
In-Reply-To: <CADnq5_M1D1+iASZCFJMu=_QBi5yMrXgofANJCXPby9jP1ZfgYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-19T08:09:18.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV3PR12MB9411:EE_
x-ms-office365-filtering-correlation-id: b2472648-d8bd-4858-4129-08ddaf0b722e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bjdRSW9iRTNRSE9lZkxxbE80emZ0S2NtT2R4SkM1bFk3Nyt5dU0vQ0V1NzIz?=
 =?utf-8?B?Y0RsN2szaXZSbVNlUUswL1R3MjM2dUdaZnB6MExRV2Y1b1dGaDQ0cjVDc2dO?=
 =?utf-8?B?SXkvaGhnREgwL1V4cUVuQUdwNmtPaVlUYXNNSWNCZlQ2clhNL1pSNklDLzNE?=
 =?utf-8?B?QW02WjZxZzJjbjM4WlozSDhSZVBMUnR1ZUhpYlpsR0pBQnpXelF2WC9EdDZ3?=
 =?utf-8?B?eHcyY1pPWTRrb0VZUUlFR2ZUOXViTExaOVl5U29GVFlaZFpqdnhDQ21xaTJ3?=
 =?utf-8?B?UkJiRVdSSW9VMmk4R0FBcklWZHQwblRrMmZwM1ZDUW42QjlCVjZ2alJCc21G?=
 =?utf-8?B?RUROYTRuZC8reGM0ZXB1ZTNnUktPbDBJN2JKZ3h5NjRrSlBUQzkrempDUk5J?=
 =?utf-8?B?blZlcFRXUEVsMXZNZWgyT0dkdHdpc3JCeUkrdkpPdEhvK2E1bGx6T1RTNG5F?=
 =?utf-8?B?MUFETDBsajY0RG9oV0VMRUIxZENkTWZpOFNvMmI5Z2MzN1VGa3owQ2FpWlNS?=
 =?utf-8?B?d3BYUllvdzVmcmZxa2lKeVhTeXd0dllUQ1oxK2hUUDdVVWhVMlpPZDNRTVNK?=
 =?utf-8?B?ay80T1RwSmM5N2dUakNER1NCZ1JCRlJpazFNNkV3OTIvekdJaVZNVnQxUmFT?=
 =?utf-8?B?ZFZYZ21PQTFmSEZhU2NFeEpiSnJHQmFzSTFvT1pqbWs3M0JaUE1uVmNOVld5?=
 =?utf-8?B?TzViZGRaSWd4RXZrSExmeW5FVjAzNGZLbFJGdzhtUkE2eGlqK0dBdUpCU1k1?=
 =?utf-8?B?VlpiU1B3N0gzeWVQMTNzQld2VUpRRkZZYUY4czNzMEg2MldCZEFFcnNmODdv?=
 =?utf-8?B?SERsRXFQQUtVWW5LM3hCcFJZVXdoK2pmL290dnlKNXg1YmdkWll3aFJnM3Vh?=
 =?utf-8?B?cnBHbjFiR2VkQ1lYMW5YWDgyUkU4L1BFOE5lK3lNN0VSUTc4YWRjbERXVHFz?=
 =?utf-8?B?bzllWC9SU2YwbDVrbGxndzFDZkl2ZC90d242WlF3aVd6VnFIN2QxVnByMStj?=
 =?utf-8?B?MjAyVUdIVHdreE9EeW9RV1pMVHR6dVA1WHd5Y2xiaHdDYUNZczUrZ1JvMVJM?=
 =?utf-8?B?RGpRcVNEN0pOclY0TURubFBWcnJGOEVpY2lRaExMTWNwTkFrNTNpL1JIVWQr?=
 =?utf-8?B?VEFwUUFLQ0lWMnk0UWpRMmsyU3grK2ZLTzJyaU1ST1ZCUzZXaG5GZUF1S0xr?=
 =?utf-8?B?SXdwR1BxVGlpbDR4SENRVW02d0NkWFBsTjB4dEZDTUpLTkJuV2JyU2k3QjVI?=
 =?utf-8?B?UmdFbEZNZkpvYVlMMkdMOUFHeHlZUmtFeDA0Y05takxyam5LSXQ4aFpDZnph?=
 =?utf-8?B?YVN2M0hZMzZxKzNSckozN0UwaDRmbFpWcnA2ZklqZzJCb1QzeWxrcWV5WlA4?=
 =?utf-8?B?MHBwZjRqdk9VOGxucUFzZk9FQXJRYUlIejlycVdSZ2h5MFhNdmNXQWE5NnZD?=
 =?utf-8?B?UTlJWUdDb1hSeElJU0wxUlBVTUtPa281R3phNUYxWnVJN3hNcmVGVlJvNzVG?=
 =?utf-8?B?dmZ3QjVvUHNLeFc3M3lmZzdSTzhHSWpGUG96c2lzUXRWZHg5YlR5akw1cUJa?=
 =?utf-8?B?dU00RmZUdmNFZXg4a2had3MvSUQ3b0huOHJxUVdRNXRoTEE4RVpmVEt4VTB3?=
 =?utf-8?B?d2pSRE14bXVxQ09wOW5yNmFIY04yS0lYMVphRFdUM2RLOThsZFZCVlhWZDlI?=
 =?utf-8?B?RU9IOGFSb3ZVZjJicUVMV1RtMGl3aVAyellwNmxSaS82RU1iRVJ6R3FVVWJw?=
 =?utf-8?B?WVpXSE5BWW5OclpYWFh0SllwcVJrUnRZNENhVlBvSG93QmVYeHFIU0dmRmRT?=
 =?utf-8?B?a3NTcWxUMTM3bm9aZG5OaFFkc0RVSXNObTUvaTZLTXlwbktiYjc2bmpIdXhK?=
 =?utf-8?B?cStWTnROcExIUGpZQW5DeUhIM2Qzcjg2ZnB4Vm5FOGJFRVRzUENIRmtmWGU5?=
 =?utf-8?B?SGh5RlU4WEt4SnZjTlJCRXpmaVlkeHQ2WndSMmdFMjhHN2xKWWNuYkxKZXVT?=
 =?utf-8?Q?IA/93wHHuIdcerj8ycvfMrc28Ziu+0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2dhNCtrRTlGZ3RJUlFsRjJyaldobjhEdzBJekVGOHJBTkJjUFEyVHlnNkps?=
 =?utf-8?B?c016dHBZMlZ6U3lGN1hHdnhmcTFnczBPR1VGaDJSU3FnVWxtWlp2ZzlCUFBl?=
 =?utf-8?B?bUV3MzVVZ01FYm4zWENxRk9RVStidm1oN3RST0JtRDVtYTNQSWFDZXgxMWUw?=
 =?utf-8?B?VCtucWYveUFYeks3Ri9uejVpakV4ejJyVjVPcldMNkpjMjI3NVpQMmkrOTVj?=
 =?utf-8?B?eHNRSFFXQTVleFkrc1FldktqT1g0MXlhVlN1UnY0SEtSNDZ6NHNCVk5WUitl?=
 =?utf-8?B?clNlNWlkNjloUUJVcEpxR1ZrNHgvL3lYMFE3VytUOXRwZGppNE5sNXdQWk9F?=
 =?utf-8?B?b2FiMnRXRWRBcVk1Z3JHY3E1ZUtwLzlOK0d5R1V1TzlTVUtPNWd3ZmIwb0ZD?=
 =?utf-8?B?SlIwdzFJdnZlcXNkNVpPeEhHUHNjMjJoc3ZsSWR3ZEs2dU15ajZGOVlvVVVQ?=
 =?utf-8?B?d20wYWJtblhmdGZ6TkkxREF3REoyMFZYNW5kNEVxNDBDUkw2Qlp5OU5melR0?=
 =?utf-8?B?MGp2WlQ0U0orOTVzSUczYXV6cUY2TlFCSzVPU2lIMEIzSksydWppSWowMzhU?=
 =?utf-8?B?TE4zMy84K211RlA0aFZnSXd4aWVBaEdkUVhsODNUR2JWUWQxK0ppV2pGV1FO?=
 =?utf-8?B?L1MrbWR2UmtDSm42d2Q4R1o1VUZ0SHExRzBGUmtoVk5jbmgxbkp1Ukg5bkhu?=
 =?utf-8?B?L2FKbzBEQmlFenc3UGxUTFhlSmtKNnM3NUlGMm8zRDhBU0I4ckJSS0t6cDho?=
 =?utf-8?B?b2E0SVVod0hLM2tWYWNScjBLck13c3FSVm1pbkNEdU1RWUUwTHhIZG1sR1No?=
 =?utf-8?B?UU8vV0NEZDFpNzEwclNMODMrMVR2R21UdG5kS0FleFhFdENFRGZ5MWxZVUJi?=
 =?utf-8?B?WXAxcHhvU2tLS3M2VmQ5M1hnZTNvakN4cWpJNFkzNE5WL2h2QW1PTmdqSkNx?=
 =?utf-8?B?UEk4aUt3L0w2aHYxQ1BLQ2tEeUI1bjJsRXVhdlh3RFpqeERFNmxvYzkzRklY?=
 =?utf-8?B?UWVScWg2RlVWZmJDRmV5Vml4Q2JoVzZwTEhneS9wbWUzZDRTcTViZVU5SW9k?=
 =?utf-8?B?eHBuWmJjQnUxcThmVlY2a2lPbEZtWWduZXQ5MUx0b3RxOEcxVmMvaU80T2pk?=
 =?utf-8?B?Z00xRHdLVzJHMFZkTXVHckRIdkh1SHdyNzV6TFFwWXM2REpteTR1RlVGR2Mv?=
 =?utf-8?B?T2toK3ZObWErMTg1ZDVBUlZKSDlMMVVndEZOYnJ5YkJFRGtsazhaTDVtSUJa?=
 =?utf-8?B?THZQZllvNW8ycFRwNHQxTnVObjYwRUZLeGRIbHJwejYzaG1lVnBZdTNKdmpr?=
 =?utf-8?B?b2R5eklhV0JWQ0MwOXdKdy9pVHJ0SWJMNmFaZnhScnc3Q1E0S05LV3lKL0JF?=
 =?utf-8?B?Y0VYTkptNjV4aStBTUppOG9CZEQ2cytoM3pOM0V2ckRGWFRhdm1uK2FxdVNa?=
 =?utf-8?B?bHVLYURJMytQdFFzaXB4ZXhGUW1jdEFsVDR0M0xSZElWYXZzL25iTGJTeWh6?=
 =?utf-8?B?QTFrZnl3U2FKYW5KblBmMHQvYm04Z0hISGZXcmRjRENHdkFCeDdsa0pLTHY5?=
 =?utf-8?B?bmZuRjRhb2ZKeUpjMkVLaFM2bXdJdi9NdUxuVEx6cUpEYVBRbzF5aUhVR2M1?=
 =?utf-8?B?RzNWMlpKMnREbk5meUpRYjYwa1NFTGZCNDdQT3VjcHlFZFVLbWY4RVErV2Jl?=
 =?utf-8?B?cmhicnBWZWtjMmdxSFo1OTlUdmE0RHQ5QmprbWJaTW80MmJwaThFbEJrQlpC?=
 =?utf-8?B?RVc0VHczRGRKUG5uLzI3R2d6dnZmd2FGNDBJdlZGVGZxMk1URGs5RWdGN1M4?=
 =?utf-8?B?Qm4xb2IxNDRFaERTZEFrR0pJSis4NnJLaEg0R2xnR1Vmb0JhTVMxTzZyNWJO?=
 =?utf-8?B?L1IySUdXOVg3akdQNzBUaHIxdmZUU0lnd29JaTlUeERwQXErS29ERzQydCta?=
 =?utf-8?B?WUM4N1dIdU5ic1AyQU9Za0c4YWFrWGUvUmFVK1NzZ3VVS1ZYNjFTdWdvZnhl?=
 =?utf-8?B?b29nNVNCT2RHYjZKQ3h3UGc5WmFkZzFCb2NoSDhzSGtOY2xMU0FCS1NYUEJ1?=
 =?utf-8?B?MnRhMVJPM3laeHpxbmEzbnpBUkRscElWYkVmZ1ZFYkQvczF5YXJWMHd1VERi?=
 =?utf-8?Q?Bh7s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2472648-d8bd-4858-4129-08ddaf0b722e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 08:29:45.1533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HarWWwusAiRvls66G/oOLil+hixiLGA2APYsa6u/kdGB0Pf6qKM4iBx+LB93eeZS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
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

W1B1YmxpY10NCg0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4N
Cj4gU2VudDogVHVlc2RheSwgSnVuZSAxNywgMjAyNSAxMToxNCBQTQ0KPiBUbzogTGlhbmcsIFBy
aWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjIgMDMvMTFdIGRybS9hbWRncHU6IHVuaWZ5IHRoZSB1c2VycSBkb29yYmVs
bCBvYmplY3QgZGVzdHJveQ0KPg0KPiBPbiBUdWUsIEp1biAxNywgMjAyNSBhdCA0OjI34oCvQU0g
UHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVW5pZnkg
YW5kIHJlZmluZSB0aGUgdXNlcnEgZG9vcmJlbGwgb2JqZWN0IGRlc3Ryb3kuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMgIHwgMSAtDQo+
ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jIHwgMyArKysNCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEu
Yw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBp
bmRleCBlM2NlYmU1MzJjN2IuLmRjYTBmNzZjOWZjZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gQEAgLTMxNyw3ICszMTcsNiBAQCBh
bWRncHVfdXNlcnFfZGVzdHJveShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHAsIGludCBxdWV1ZV9pZCkN
Cj4gPiAgICAgICAgICAgICAgICAgYW1kZ3B1X2JvX3VucGluKHF1ZXVlLT5kYl9vYmoub2JqKTsN
Cj4gPiAgICAgICAgICAgICAgICAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShxdWV1ZS0+ZGJfb2JqLm9i
aik7DQo+ID4gICAgICAgICB9DQo+ID4gLSAgICAgICBhbWRncHVfYm9fdW5yZWYoJnF1ZXVlLT5k
Yl9vYmoub2JqKTsNCj4gPiAgICAgICAgIHIgPSBhbWRncHVfdXNlcnFfdW5tYXBfaGVscGVyKHVx
X21nciwgcXVldWUpOw0KPiA+ICAgICAgICAgLypUT0RPOiBJdCByZXF1aXJlcyBhIHJlc2V0IGZv
ciB1bm1hcCBlcnJvciovDQo+ID4gICAgICAgICBpZiAociAhPSBBTURHUFVfVVNFUlFfU1RBVEVf
VU5NQVBQRUQpIHsgZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bWVzX3VzZXJxdWV1ZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNl
cnF1ZXVlLmMNCj4gPiBpbmRleCAzOWRlY2MwYjAwZjcuLmM2ZjdiNjEzZTY4NCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiBAQCAt
MzQzLDYgKzM0Myw5IEBAIG1lc191c2VycV9tcWRfZGVzdHJveShzdHJ1Y3QgYW1kZ3B1X3VzZXJx
X21ncg0KPiAqdXFfbWdyLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1
X3VzZXJtb2RlX3F1ZXVlICpxdWV1ZSkgIHsNCj4gPiAgICAgICAgIGFtZGdwdV91c2VycV9kZXN0
cm95X29iamVjdCh1cV9tZ3IsICZxdWV1ZS0+Zndfb2JqKTsNCj4gPiArICAgICAgIGlmIChxdWV1
ZS0+ZGJfb2JqLm9iai0+dGJvLnBpbl9jb3VudCkNCj4NCj4gSSBkb24ndCB0aGluayB5b3UgbmVl
ZCB0byBjaGVjayB0aGUgcGluIGNvdW50LiAgT3RoZXIgdGhhbiB0aGF0LCBsb29rcyBnb29kLg0K
W1ByaWtlXSBUaGlzIHBpbiBjb3VudCBjaGVjayBpcyB1c2VkIGZvciB0aGUgY2FzZSBvZiBhbWRn
cHVfdXNlcnFfY2xlYW51cCgpIGludm9rZWQgYnkgYW1kZ3B1X3VzZXJxX2Rlc3Ryb3koKS4NCklm
IHdlIHdhbnQgdG8gcmVtb3ZlIHRoZSBwaW4gY291bnQgY2hlY2sgaGVyZSB0aGVuIG1pZ2h0IG5l
ZWQgdG8gY2xlYW4gdXAgdGhlIGRvb3JiZWxsIG9iamVjdCB1bnBpbiBhdCBhbWRncHVfdXNlcnFf
ZGVzdHJveSgpIGJlZm9yZSwNCm90aGVyd2lzZSwgdGhlIGRyaXZlciB3aWxsIGNvbXBsYWluIHRo
ZSBkb3VibGUgdW5waW4gZHVyaW5nIGRlc3Ryb3lpbmcgdXNlcnEuDQoNCj4NCj4gUmV2aWV3ZWQt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4NCj4gPiArICAg
ICAgICAgICAgICAgYW1kZ3B1X2JvX3VucGluKHF1ZXVlLT5kYl9vYmoub2JqKTsNCj4gPiArICAg
ICAgIGFtZGdwdV91c2VycV9kZXN0cm95X29iamVjdCh1cV9tZ3IsICZxdWV1ZS0+ZGJfb2JqKTsN
Cj4gPiAgICAgICAgIGtmcmVlKHF1ZXVlLT51c2VycV9wcm9wKTsNCj4gPiAgICAgICAgIGFtZGdw
dV91c2VycV9kZXN0cm95X29iamVjdCh1cV9tZ3IsICZxdWV1ZS0+bXFkKTsgIH0NCj4gPiAtLQ0K
PiA+IDIuMzQuMQ0KPiA+DQo=
