Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55FEC3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 15:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C2110E185;
	Mon, 12 Aug 2024 15:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="39O0BjhB";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB1E10E185
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 15:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzZgjEKR2oLnO+yJYJLP0Vj+qZ5D+2ZQBjNjpzsW0sFMDsuXqteebmvKZTCL5wRvBfyxevxjWMl2+qH3hHPEk87WrRRTNRx1mvfUs8PRD4bPpX6jsSRIvNUUUgxQ27o/K4nz8E6JSitkmcfK29omECEYPLr7muH0D/D2esWKfTk8YUw6eNGVfRq0we17Pin+Mnfvy297Z+SYJTA28wOQuAh3J7hbiIWgvRFH3Rk2IEm/aU/VSdnufLKPIV5JhPaArKGoA5y0zZ22Jjq5XCuOYCi2/TwQsc0QDU+6K7AvD8nVyWcVs/rC1wDOFs4TiERHyM5a2EBPZMJyESWfic3mZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xg9C9mg8NcMcLGlNYnjuzifRlXq2vJzK/qp2zL2vn4=;
 b=X37pP0qiHIRSDMWNZv1/AmahPwOgaprXr0MKB1j6tPi5NWNZzH/BnYYcDLVzd64ZBDal5DISqqP44mZH1YCs0VhHs2916O60Y3I1LreYodu6n0orFohvtfV1UGJDS6J0yYjkTlRUoeHrInr1tWiPgPdeMPelAwV3mWq288DHcE1w5Zfz5GOLXacEc7IQChqqrTXMqurr1+MuJLB7ls1KdLZc5selUoYrGnM1O/Zyrc2RMBV13d3yjMPWJxow0eXciF+s/I9aq3mHahCQGuqw9XZ5jDamPUsZbAuwUwmfaAte3mOVEfRAZLCNcnvGFV8wZrAjBQ3xm9U6irC6X4rsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xg9C9mg8NcMcLGlNYnjuzifRlXq2vJzK/qp2zL2vn4=;
 b=39O0BjhB/OY3QqSw/kh4fcfIDi/YRmMn7TG5hQ6CRx7UW8Gqu4RbKxOWbFj8L/zxcDDfPRhHQLO+dQn09EJnCPT4knOol3KLr08pUM/HCqahTiWg+95XnRD5tuMq85AS6hPagiZvRsxCgfcu233T1gC7TSWp4IT7MUxZiLPDcp0=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 15:49:15 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 15:49:15 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 GuoQing (Sam)" <GuoQing.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvisibleVram
 fail on SRIOV
Thread-Topic: [PATCH] drm/amdgpu: fix KFDMemoryTest.PtraceAccessInvisibleVram
 fail on SRIOV
Thread-Index: AQHa6KT8z/UQclw1mUySEvc/ed9xdbIfnB8AgAQrkSA=
Date: Mon, 12 Aug 2024 15:49:15 +0000
Message-ID: <CY8PR12MB7435CA13D741BA7C917B205285852@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240807083624.1729349-1-guoqing.zhang@amd.com>
 <9dcd8afe-5c96-4ef7-ba5d-8b1d4c47b66a@amd.com>
In-Reply-To: <9dcd8afe-5c96-4ef7-ba5d-8b1d4c47b66a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=3bed1ff9-17c1-487d-a5b8-55de85fabcba;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-12T15:30:14Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|CH3PR12MB9196:EE_
x-ms-office365-filtering-correlation-id: d988b227-6b63-4526-b608-08dcbae651aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RUNtTnF2QXgvczdZcnVlVkVIRngvZFNwUm9GZVlqTkdRaUlMbFlmbk9KLytr?=
 =?utf-8?B?aW1Cdi93QVVSbzV2SS9qODR6SlJqYkRpbDQxWWRkZGc1TTJvUDFzbmc5a1cx?=
 =?utf-8?B?Y0ZvQ25mejRJZFVLYm5UcGFvZmFWVjIrU0JmSDVEREIrcitlVU01VDhUTXJQ?=
 =?utf-8?B?bVh6L2twYWQvM0k3UXAza1llTkRYYjlSL3B4VVFjV1gzNWRxZXd5YTFMNFNo?=
 =?utf-8?B?bDZuTkZyT1ZtbVR4WVRuQlFJbDEzWUFVQ0YrVHNENG4yNUxMSVdPU2tFcXB6?=
 =?utf-8?B?WjhMT2pUTEpjeVpTS29zcU4yRVRhalFRN3htSTVqdXIxNnpvVFBBZUh2L0lk?=
 =?utf-8?B?MDlzeVFWcGswaC80bkZuVW5OYnRmOGdKS2J2U01hTUVpbDcrbDJ4U0szL2lR?=
 =?utf-8?B?Q256UDRpQnEvS2FkRDNLUkF4YTNMd0NYV21XNDlFM051MzE0SDcyVmJYRlYr?=
 =?utf-8?B?OTBBazRpWUd2YWlBTmV1blpsZDU4V2NwTEhHaHV5bnNMTktpWTd2OU16c05R?=
 =?utf-8?B?cFRGM2JJMDFacnVuUG9nLzloVVgzdWRHTzRxTVY4RmJvOUlBWmpjeXM1R1Vr?=
 =?utf-8?B?NmFaYUNTeFRBSmlQNWg4UE9lTkdFdHpRdG9zaVhOZ05pSERpY0ZINWJNallj?=
 =?utf-8?B?UzBaUHZuM3JWdUNITzNrREJBWVZKOEcwNUNFRUY3cXhyQWloeXFHTWFralZD?=
 =?utf-8?B?QnNXYklERm5Hb1gyTzhSZnUyUHZ3MDZ4Zm8xWnlWTTRmOEtrWFYyNWh2d0Q5?=
 =?utf-8?B?dmJDRzQxdFJlUTRjVldkN2RZTHdUUkE2Rm1vRUVRVE9OS2d4TmMwZUtIN2FN?=
 =?utf-8?B?aS8vWlloNzZGc3Urd09kODZXK3ArRG1NMXQrTS84ZlRXeDRpU0daZEhjd0ZI?=
 =?utf-8?B?cWwyY1FodlorU0l5bHFKZ0xKeXA2VDlhTTlFVjlONnZlSVpQWVFsMzkvZXA0?=
 =?utf-8?B?eDBlSTdscnJYVXJ3YnFaYWJMVUs4TzZ5TUpuMWFuUERFRS9MWHhuR1RiUUta?=
 =?utf-8?B?SkFveVJKVW50R3RER0NIVjdSb3hTM0gvcEV6NVhCaVlScjlHaGZrMTNCNkdl?=
 =?utf-8?B?U0QwMGxxcWJjQ1VzSEZTZzl1Smo0WmptMlVFQ0txL1JJMExpVVVCUFlNSG4z?=
 =?utf-8?B?OS9XYnRyV0ZJSnBIUWJtRTZRSXVTZG9DOGpnZ0ZxSE1GVGltVCtiWS9kUU9S?=
 =?utf-8?B?d3NqN1VHS0NOWlRBZjF4Y2FxU1NDODYwVEw2QXhOUnhwZm0yYmNUckx0MFNS?=
 =?utf-8?B?VHkyNGEzOU00STdoTVZQcXB6dk84STFWOTdzWTRiNWtaTVY1bEVYdDkyQS9G?=
 =?utf-8?B?Q1JVTHpXcXUvYzhyS0tmQVFoVEtFMU1GL1NTS25OUHZsSUlGU0luQmdEMTRr?=
 =?utf-8?B?blRYMHdjYnZEelpjaVNtVStjcjZTV1NEcFd0ekJMZlZ6ZVQ0UVEzWnBVZkUw?=
 =?utf-8?B?UWpqTXlhMUlTckVWQXlHV2s3RkJ2dTh3ald3aTh2Mm5qdEJmUUtHREg1NDEv?=
 =?utf-8?B?QW5qVDJnK0dncGtWSFI1WWpaQitTZlZzYWtMYzJnUFRhekRpNFdMR1REOGdH?=
 =?utf-8?B?MlQyZFBLNTBhTUtDS0VHb3B4VHZVU3VEcFhJd2dQbDhrYnBSMTFKMzVRbFhl?=
 =?utf-8?B?aUhWMDVZdnFNYWlLclBYNm84QzBMaVh4NUs5QVIyeXBEU1NDRitleGNGSHFG?=
 =?utf-8?B?d1NKUlBodTFBZXVVb3I4Q0dLTEtsc1M4OHpibGtDS3A2VjBqUm0vS1BSWHEr?=
 =?utf-8?B?K1FFZ1kzdk5KSDJLMjBmbWFvYkN4Q1dzb2FXVnY4YzRaTjFNY0cwOGR2VC9O?=
 =?utf-8?B?amhhNWxLdjgyYVRaMktlMkZqSk00dGF5RmhtUE00RWFJQklaZXRUMHZ2ODFQ?=
 =?utf-8?B?YmtYS3pHK3ZFcjJ0dm0wK1hGM1A1N0loanBtaEIvQWhWaVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1RseHVKSU5WeHVhRmNZMGRKNEVRNWozYjhqUnJYZjduYzlTQ2R4dDdyanZs?=
 =?utf-8?B?c0E0ZUpjZ3FYcWF5WCtUZmV3ejFxZUxja3FFUEw1TXZpVm1RRjBUeXV0Y0V1?=
 =?utf-8?B?MFpCVUZ5QVNFdjU2VUFRME1ZWDJ2anJHc25ZQmZwd2dQRk8vQjAwTklCRVU1?=
 =?utf-8?B?RmdxWHJVOEpEejJqYlVBT3FFUVlmclgvRHVVQ3hjclkvLzFUUnNTcGJYM3hk?=
 =?utf-8?B?NHlRQms0OTZiYnF6ME9mbitHV1lRSm5WYnR4eC9DZURna1FiOFFoQnVvWEdu?=
 =?utf-8?B?YnllRzRzRm5JODIrRm9vWTBVbXpiNm5yOXNyMHI5dWxmZjhabStJU2NXMjFC?=
 =?utf-8?B?dElibFYrdFo1N0pIZUNDYStESXRGWE9vRUk0TkI0MmNxUThmUENjZE9SWDRh?=
 =?utf-8?B?cmM2d3dSMUtaT09zR3hpamhTY2d4VzhzQ0h4M1pCNlQzeElIUlRpZ1QvZ0xq?=
 =?utf-8?B?Q0lYN1lRNGpDQ0cxV2hEcE9oS05ibi9PbGx3ZTVWWE84UlVsbFdkbGJpQ0w1?=
 =?utf-8?B?Y21UclJVS0xkbHZXdjFFM2FISXFMNGZxRVNyblJ6QmVINWlxVzF5MDNYVUJz?=
 =?utf-8?B?YWRwZWNiV2dCYVRiK1RiYXRjV2todnU5K0JaRCswUmpVUy84bFBuOEhVbU56?=
 =?utf-8?B?anVPOWdhSFdNdXN1dmdvRjA5WlRxSTlNUjhDS1d2RDQ5dFRiYTZnNlRPVXFH?=
 =?utf-8?B?eUFOcTFRNlQ3NnFoQXl1bGd3ZXA4cE1qSmxLVmVnc1V5a245NjltYVdkaXd6?=
 =?utf-8?B?MndDY1IxVERzV045QmZRUThRcUZwNUJBREl6aVV5Qk9LN1drbWRyRHdFVStL?=
 =?utf-8?B?SDU3Nys0aHE3NGU1bjNuK1hvRDBjOStWU3BHSXYvUFd4MWtaS3BwYjRwUmlq?=
 =?utf-8?B?Z1N2WDljbVNFQ1hJVVRsQUMyTW1DRFhsK3BJYXRGbnRGcUg3VFJlb3Baa3pJ?=
 =?utf-8?B?Qmo5K1VLT2IxRzVhNnFCZXZMaUdvMlcvbUdlM0RyUVNnTXZvWkZkZ093Y0l4?=
 =?utf-8?B?Qm9SZWlyaUVzelk3NEx1am9DWnhlRXVpWnpxSUJheWI5clp3bE10MVZrS0lt?=
 =?utf-8?B?bFdmUkZDUXgvYzVrd01JbW1La1dtUktGK3FUZ0V2eWxEYjBnLzRsN0UyUS9r?=
 =?utf-8?B?YTNyYlBabEk0MU5hL1dxWWZsdDNXRXJFWFZFSWIrdWtiQU9acHB0MGdCZTY3?=
 =?utf-8?B?MDZiaHA0MVRNaHI3cmZ4Z1dOUmN0ZjVjS0s1ZW9wM3RRcmlCZ0tueFRqd1hF?=
 =?utf-8?B?TEQxSExDWkY0UzJkRGJjd2lmbkp5aVRlWk1ONndWOFFlQ0tpQXNJZWgycnQw?=
 =?utf-8?B?U0lxTTFrM2d5R1dWVzBweXdPT3JFT2FxbktrY3Mrb0d4MkVMcWM5WmNSSDda?=
 =?utf-8?B?NWgzaHlzWUZrcHdFODZxSEJ0RnhuYW1BS3F0eVRVdFk4bitBOXlKM0Z3TVAz?=
 =?utf-8?B?eC9mdU8zTUp1UnlOMUFEdUQ2blU3V3A5emFJY2dXL1o4dGJyNGk0aCt6WEU2?=
 =?utf-8?B?SWdkbzFGQXFoWnFrUm9yYk5hQXdTbmNhV1lna0NqZGxIYkNMNEFPU0FmYUwx?=
 =?utf-8?B?aWx6SFk3NUpLZElGQy9QM3RMOTZUUjRCSm05Z3JRbEN0VGNPLzNUaVYwTjNM?=
 =?utf-8?B?Q0sxR3NoS0l0NC85MUgrUFlVYzJPMlFkYjRVb0lBV1VuV1hJT2JhcC81NmNK?=
 =?utf-8?B?cDZiT0YxY1V0b2Q2ZUViR25ELzA5dHFnaWVVZDJuYTg5Tm44eUl1Y21ldERD?=
 =?utf-8?B?bllabWNpUWlLbTcrZ0EzT3E1cElDcW50bm1oNjlaRDloUC9jZmF1NGw1d0hy?=
 =?utf-8?B?TFczWEFPQTltMVBYQTV0amZLZlVKaXFQRVIrQjVTNXIweUNtYllWZjRrNW9y?=
 =?utf-8?B?WVQ0MWZoYUxXVWxxRUd6dXZlWktVa0R1RlJ0YzRaMGo5ME5Hay9meVpTUEsw?=
 =?utf-8?B?YThTMzFLT0QrWEF4ZU9vcnN3bGR0YmdReUhoMERLc01QL3V1RFQyeGo5QjVr?=
 =?utf-8?B?dmdETkxodjlVSCtlbmlxYkliN083OHlrQnloNWhINW94NGZ1RE02NlhiY1hF?=
 =?utf-8?B?VmJGQys0MFM1SW50SXlMd0RuREhrYmZSa1Y4ZTd4SGNMbThRUTU3VmdjMFRD?=
 =?utf-8?Q?klPk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d988b227-6b63-4526-b608-08dcbae651aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 15:49:15.5106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pD/YgpzvjOkOsUCYdOiiBRjXmJZ/wj9x4YvIEfA7egn6vE9xuY8vmaDL6hU/k3lg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGlu
ZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0
IDksIDIwMjQgNzo0OSBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpo
YW5nLCBHdW9RaW5nIChTYW0pDQo+IDxHdW9RaW5nLlpoYW5nQGFtZC5jb20+OyBLaW0sIEpvbmF0
aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2Ft
ZGdwdTogZml4DQo+IEtGRE1lbW9yeVRlc3QuUHRyYWNlQWNjZXNzSW52aXNpYmxlVnJhbSBmYWls
IG9uIFNSSU9WDQo+DQo+DQo+IE9uIDIwMjQtMDgtMDcgMDQ6MzYsIFNhbXVlbCBaaGFuZyB3cm90
ZToNCj4gPiBQdHJhY2UgYWNjZXNzIFZSQU0gYm8gd2lsbCBmaXJzdCB0cnkgc2RtYSBhY2Nlc3Mg
aW4NCj4gPiBhbWRncHVfdHRtX2FjY2Vzc19tZW1vcnlfc2RtYSgpLCBpZiBmYWlscywgaXQgd2ls
bCBmYWxsYmFjayB0byBtbWlvDQo+ID4gYWNjZXNzLg0KPiA+DQo+ID4gU2luY2UgcHRyYWNlIG9u
bHkgYWNjZXNzIDggYnl0ZXMgYXQgYSB0aW1lIGFuZA0KPiA+IGFtZGdwdV90dG1fYWNjZXNzX21l
bW9yeV9zZG1hKCkgb25seSBhbGxvdyBQQUdFX1NJWkUgYnl0ZXMgYWNjZXNzLA0KPiA+IGl0IHJl
dHVybnMgZmFpbC4NCj4gPiBPbiBTUklPViwgbW1pbyBhY2Nlc3Mgd2lsbCBhbHNvIGZhaWwgYXMg
TU1fSU5ERVgvTU1fREFUQSByZWdpc3RlciB3cml0ZQ0KPiA+IGlzIGJsb2NrZWQgZm9yIHNlY3Vy
aXR5IHJlYXNvbnMuDQo+ID4NCj4gPiBUaGUgZml4IGlzIGp1c3QgY2hhbmdlIGxlbiBjaGVjayBp
biBhbWRncHVfdHRtX2FjY2Vzc19tZW1vcnlfc2RtYSgpIHNvDQo+ID4gdGhhdCBsZW4gaW4gKDAs
IFBBR0VfU0laRV0gYXJlIGFsbG93ZWQuIFRoaXMgd2lsbCBub3QgZml4IHRoZSBwdHJhY2UNCj4g
PiB0ZXN0IGNhc2Ugb24gU1JJT1YsIGJ1dCBhbHNvIGltcHJvdmUgdGhlIGFjY2VzcyBwZXJmb3Jt
YW5jZSB3aGVuIHRoZQ0KPiA+IGFjY2VzcyBsZW5ndGggaXMgPCBQQUdFX1NJWkUuDQo+ID4gbGVu
ID4gUEFHRV9TSVpFIGNhc2Ugc3VwcG9ydCBpcyBub3QgbmVlZGVkIGFzIGxhcmdlciBzaXplIHdp
bGwgYmUgYnJlYWsNCj4gPiBpbnRvIGNodW5rcyBvZiBQQUdFX1NJWkUgbGVuIG1heCBpbiBtZW1f
cncoKS4NCj4NCj4gSSdtIG5vdCBjb252aW5jZWQgdGhhdCB1c2luZyBTRE1BIGZvciBzbWFsbCBh
Y2Nlc3NlcyBpcyB0aGUgYmVzdA0KPiBzb2x1dGlvbiBmb3IgYWxsIGNhc2VzLiBGb3IgZXhhbXBs
ZSwgb24gbGFyZ2UtQkFSIEdQVXMgd2Ugc2hvdWxkIGZhbGwNCj4gYmFjayB0byBhY2Nlc3MgdGhy
b3VnaCB0aGUgRkIgQkFSIGJlZm9yZSB3ZSB1c2UgaW5kaXJlY3QgcmVnaXN0ZXINCj4gYWNjZXNz
LiBUaGF0IG1heSBzdGlsbCBwZXJmb3JtIGJldHRlciB0aGFuIFNETUEgZXNwZWNpYWxseSBmb3Ig
dmVyeQ0KPiBzbWFsbCBhY2Nlc3NlcyBsaWtlIDQtYnl0ZXMgdHlwaWNhbCBmb3IgcHRyYWNlIGFj
Y2Vzc2VzLiBNYXliZSB0aGlzDQo+IG5lZWRzIGFuIFNSSU9WLVZGLXNwZWNpZmljIGNvbmRpdGlv
biBpZiBNTUlPIHJlZ2lzdGVyIGFjY2VzcyBpcyBub3QgYW4NCj4gb3B0aW9uIHRoZXJlLg0KPg0K
PiBASm9uYXRoYW4gS2ltLCBjYW4geW91IGNoaW1lIGluIGFzIHdlbGw/DQoNClJlbGF4aW5nIGxl
bmd0aCBjaGVja3Mgb25seSB1bmRlciBTUklPViBtb2RlIGlzIHByb2JhYmx5IGEgZ29vZCBpZGVh
Lg0KU0RNQSBlbnF1ZXVlIGxhdGVuY3kgaW1wYWN0aW5nIHBlcmZvcm1hbmNlIGZvciBzdWItcGFn
ZSBjb3B5IHNpemVzIGhhcyBiZWVuIG9ic2VydmVkIGluIHRoZSBwYXN0Lg0KUGx1cyBNTUlPIGlz
IHN0YWJsZSBldmVuIGlmIFNETUEgaXMgZGVhZC4NCkkga25vdyB3ZSBoYXZlIGZhbGxiYWNrcyBh
bnl3YXlzIGluIHRoZSBnZW5lcmFsIGNhc2UsIGJ1dCBpdCdzIHByb2JhYmx5IGJldHRlciBub3Qg
dG8gcHJvZCBhIGRlZnVuY3QgU0RNQSBpZiB3ZSBkb24ndCBoYXZlIHRvLg0KDQpUaGFua3MsDQoN
Ckpvbg0KDQo+DQo+IFRoYW5rcywNCj4gICAgRmVsaXgNCj4NCj4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNhbXVlbCBaaGFuZyA8Z3VvcWluZy56aGFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgNCArKy0tDQo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYw0KPiA+IGluZGV4IDVk
YWEwNWUyM2RkZi4uYTZlOTBlYWRhMzY3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90dG0uYw0KPiA+IEBAIC0xNDg2LDcgKzE0ODYsNyBAQCBzdGF0aWMgaW50
DQo+IGFtZGdwdV90dG1fYWNjZXNzX21lbW9yeV9zZG1hKHN0cnVjdCB0dG1fYnVmZmVyX29iamVj
dCAqYm8sDQo+ID4gICAgIHVuc2lnbmVkIGludCBudW1fZHc7DQo+ID4gICAgIGludCByLCBpZHg7
DQo+ID4NCj4gPiAtICAgaWYgKGxlbiAhPSBQQUdFX1NJWkUpDQo+ID4gKyAgIGlmIChsZW4gPiBQ
QUdFX1NJWkUpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiAgICAg
aWYgKCFhZGV2LT5tbWFuLnNkbWFfYWNjZXNzX3B0cikNCj4gPiBAQCAtMTUxNCw3ICsxNTE0LDcg
QEAgc3RhdGljIGludA0KPiBhbWRncHVfdHRtX2FjY2Vzc19tZW1vcnlfc2RtYShzdHJ1Y3QgdHRt
X2J1ZmZlcl9vYmplY3QgKmJvLA0KPiA+ICAgICAgICAgICAgIHN3YXAoc3JjX2FkZHIsIGRzdF9h
ZGRyKTsNCj4gPg0KPiA+ICAgICBhbWRncHVfZW1pdF9jb3B5X2J1ZmZlcihhZGV2LCAmam9iLT5p
YnNbMF0sIHNyY19hZGRyLCBkc3RfYWRkciwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgUEFHRV9TSVpFLCAwKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgbGVuLCAw
KTsNCj4gPg0KPiA+ICAgICBhbWRncHVfcmluZ19wYWRfaWIoYWRldi0+bW1hbi5idWZmZXJfZnVu
Y3NfcmluZywgJmpvYi0+aWJzWzBdKTsNCj4gPiAgICAgV0FSTl9PTihqb2ItPmlic1swXS5sZW5n
dGhfZHcgPiBudW1fZHcpOw0K
