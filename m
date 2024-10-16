Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B63D1AD50
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 12:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13FF910E5FC;
	Wed, 16 Oct 2024 12:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ajBFOBB+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA4710E5FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 12:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFZBQXxdFj4K2uczUzZ9wZhQ2WSx/NPRnQ1O+T22st+QeHZjwAjlXZ9BUOnrhakDjIWrobeiPAdm6qkNLyL8fCkKqmbeI2nbqcuK9gKwrAHjpomn+2J//OA+SH4hpRIhJCkWlrmDdLHdxjfnkXvCi71GJOpwuqaJyFgtj0elBTxESlF+gu0FDTlr9LiON+wGTwyScskGl/V9s6vmjtyrIr1qmMc0Dwpp0sD9YQ0lW87fBIU7YyRxmywVD/dK9iAOEaxs3gqkedqvlhLIjuCf6q3LSkFnq54ad5SILYwWn/87/XHX4rT+s+aj0C7iD692DyXj0wUXOGAurBzpA9/NBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ifijvj/YC1ghwVk4GgYkMhJy0XcvnbLglYtLOZDVXjo=;
 b=wkiMpuO9jE9mkxjqbapfpQXFP0M9/9ix1fglNY5NcWnZt3ZGn1nNmVrbMycpyNnh1ipS21TEkZPyl5Dh8Zheaw0FczQ0Wa+XA7PfidK5G/x5XvQzX78n+W0LoMEj0oLP+yyw/oe85o60WV2O139+2PHZZJaQiBKoGGLX/e14XTKb0f7djSRPt4Q1Y2zqhTmRSVavt9mFygFK9sHMOqie3ZZ2G8bQkW6LQQPqOt7Fc5O03bpGD5yEOVJ/FsXnH6QNcoMr4hNRo2I03Mvz4ChHqUnwHN7NpEsVCYIEt/4XZMgr18ob57JX62ti6pefs46NjhSE1lTB6cYtjhwPZ71EUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ifijvj/YC1ghwVk4GgYkMhJy0XcvnbLglYtLOZDVXjo=;
 b=ajBFOBB+9XAb5Wy1tOWYzc/jmF7m9J0y5zF+HnPGB8t2iy4wVnhZCK86zLlzHYTBOy+wMVDpkqOHPJGEXDjmSuFeq8fFx1vxyx7WcSUvP/2RLNsPmVbSlJk5JuxAVoN7u/czLd1UvA+vYDiQIapYs9S/D1qn2kLwbPtmkZdb/JA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 12:37:47 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 12:37:47 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: update deep sleep status on smu v14.0.2/3
Thread-Topic: [PATCH] drm/amd/pm: update deep sleep status on smu v14.0.2/3
Thread-Index: AQHbH5u7T/ZH5XCbuE6OFkxZIni5ObKJTrKQ
Date: Wed, 16 Oct 2024 12:37:46 +0000
Message-ID: <PH7PR12MB59978FA51CE8CF4FE824B9DA82462@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241016071919.2138181-1-kenneth.feng@amd.com>
In-Reply-To: <20241016071919.2138181-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=05235d79-50f8-4a4a-9ca6-5d3f42278dc3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-16T12:28:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|LV3PR12MB9141:EE_
x-ms-office365-filtering-correlation-id: 77ece9d8-0633-46da-5019-08dceddf56d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dDAvV3NJSTFmaldrWWRBbGNEcmUvWEpCTU1hbjdsbjlCYnU0VnZhSnM2L1cr?=
 =?utf-8?B?dlkxdFFOeEI3MHRnUXBVV0dxUFNGNXE1UDl3V3Z3alRNL3N3TDFaOWp2NFl0?=
 =?utf-8?B?enZvSVJsZlczUWxxU3VSU2llWDJDVnNJMDBVRTF2eHdOWnpLSUtvaUJoSkVR?=
 =?utf-8?B?K0JZN1dlVEhEM2tpTXBwOU5zbHpzZHRSN3E4SlN0WTE2QzU4M3lrY0NUdGlO?=
 =?utf-8?B?a2MzU3c0aG12enQ2Tjkrc1FGeTJPc1hjSUtsWTVkMnhmaC9KVldpdmlDd245?=
 =?utf-8?B?VTMrVEhqKzQ4dzhaUzhsRW5QQ3ZHMlp4N2F2TTBMcDVoUFlqb2lhaTRWNXo5?=
 =?utf-8?B?QXNmQW53aEVjL1pnc3NEZmVlRUkyK2R2L2s0eWk0WVZNWXhxd2RMTDI5QUxh?=
 =?utf-8?B?dFhqMnNpc2gxRlQ2WVl6VGJzS0ZtTGh0QmRpWi9Jbk8wc0w4VUpDay9HS21z?=
 =?utf-8?B?OHVxU2Q5NUJmM3h4QjZoaU5TdlNlSHhjcjZwd2d3YnpRb0ttZHpmSU9WRldt?=
 =?utf-8?B?U0NnY1pOZmVGZEhJNU5ZaEliZ1dzOXVVK1ZFMGs3OVBQUTRpWlIzKzFoZ0dq?=
 =?utf-8?B?c1VzWWF6dEwxcTEyc1IzL3YyenFPdjhIanlpTFR0bHZ2MDNRTmZkS0xFVzE2?=
 =?utf-8?B?cTVxZHFmN2M1bjFRdXBNc0FnT2luZzNaMTRFcW8xU3IzS0Jad0U2UlpnMzF0?=
 =?utf-8?B?Vk42cWplZmtML2ZiYlpaSXNpMlhGZkVjRnJzWXdTZFBqQzlpdldoV25mN2Uv?=
 =?utf-8?B?aFpmdWlvaEN3T3BRRzFqQjAyM3ljc01qVmFoeXlzOXJzWjJoSG9hRlZheGE5?=
 =?utf-8?B?eGdsSTdXajRXU0k2MVZpcU43dnljSHc1bXdub0gveWswcTh0UkNEditKbEx0?=
 =?utf-8?B?OGVtWFNDcDRrT1hKWVhnV1hSV2xHeU14MW9BNDNiZ3RJamhGb3hjL3Fhb2ZX?=
 =?utf-8?B?STQ5RWtpVmJodUxZd3pmNVh0NUpuWCtXeUdqKzNiQkVoWC8yL0tpVjVieFdp?=
 =?utf-8?B?OTd3T0dmd05WYUVMd0VHVkZRajZ3Q2tFQzZFL2hCdEZqSDBwakQ1TEZEYTlp?=
 =?utf-8?B?SHpKMmNMUUlXYWoyOUNhcDVoNVpmNEhxT0VoZWlIaVAzTmd1a0NjL2ZsTkMz?=
 =?utf-8?B?dXN4SG45aEpVMkRqUDlMOWhUSFBmUHdDa21mKzJwY2ZSS0E5Qko4dkU5Z29n?=
 =?utf-8?B?RzVJNXIrVkNxdC9GNnp6MWFncFdWWFFsN2FJd1hzYWNaZHd1NE9Db2xTaHBq?=
 =?utf-8?B?ZGtIQUlpdTVqaEs3MjRXdCtEanNrZkNuS2JlRGNZQ2JHZHFsSEhEbGpzUHdQ?=
 =?utf-8?B?Y3pRM3VXTkNpeHFPeDFoNlowWGxmOFc0Ym12bWZUeW9LdkcrdFlBSkdYVTBN?=
 =?utf-8?B?UzhIK2cwZWlEbGdXR3lVYm4rVVlLTndZSzd2VXNPV1MrOE1vMUFWek5HekpP?=
 =?utf-8?B?U3A0aDU5V3hiNThySS95bzE3K2hpb3lENGRGNUd6aTNBcTd4VmswbWYzOEFp?=
 =?utf-8?B?SHhITmpYc25oeGthYWF5QUhDOXpVd1Y2SmNYdzhwcjVzNXJlNGRpSUNNOUtD?=
 =?utf-8?B?bEZycFpNcFo5VEJFR1lpMGg1eFBFZHZZWG1wWldja1VweWVCbWNBSWZWd1U4?=
 =?utf-8?B?WVB3NG5ZT3NGVS9WM3FTZ05tVWxQRWgvdElEUURzTGlqaVhFUUJ0UU15T2ly?=
 =?utf-8?B?RU9vVFhlWk9vWHM0a2dhSjR6UVRyNlpGc1pGWnI4dEN1TmF0M2ljbk5YNFQ3?=
 =?utf-8?B?WkVNUTdHNXlHZ3NHM0RmQU5aaHRHVVVwRFRlN0hRaDdzaVlMeXRKL0c5aFkv?=
 =?utf-8?B?QnF6b21EQmhaSEYyLzJSUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVJjMTIrRTNEd3FBbjI0QjlHR3RYZzZwb2trUVBhMXJueFcrNlgxSG14QWxo?=
 =?utf-8?B?MS9ienR3b3BjZjJ1UGFXMXhmZ2k4dWZDVWZrbEM3V3l1V1ZKV1BmOStLWjJz?=
 =?utf-8?B?RGl3YTdPczd1SjFncEtad2hxVUtkWjFwdDVhTCs2UGRMbG5lY0JtT0hxN0RK?=
 =?utf-8?B?ay9pY0Uxc1EvSVlFZVllV2x5OHhjMjNnU2ZIZ0Q4OUJVSFd5OEVjc2swSTR3?=
 =?utf-8?B?R04wK09oSnRFNkE4citrN0UrSHNkSTFwb0M4N3FlRmRnOENWdjZqQnlLUkl0?=
 =?utf-8?B?WW1OOHZTVHRZVGI2RVB1VDlVMWt5VVhpN01RSlJ5aWVQUjd6RklDUmt5dzZw?=
 =?utf-8?B?ZThsZnZXbmlUM0dRWU9ydWJBMDU5MWhvYWlYQWhxRC8wR1kvdFZjZHM4ZEEx?=
 =?utf-8?B?eExGdjkzK3ZVRUZKeUpWQUU1ZmtKdEFvR0tKc01VNG4yYVE0YkpOalRjQVo3?=
 =?utf-8?B?SzdTa0hsZFdzZHl6OGdJUFVVUitzY0RQWGdmcnZWT01iWHlxSWxnOUVmMVJS?=
 =?utf-8?B?QUo2TE5rcHl5amdxWWVsZXVuLzVNU0VRVUQxRk9FMStxY3lTei9OYXk3by9r?=
 =?utf-8?B?NVFwU3h6aHdqY0N4NGRuWkhDZFpBaXFwZWRxRlVLc29iN2JIZzZ0WVlDU2gy?=
 =?utf-8?B?dW5GZUUyZ29GZVVSemxJYlFtbGlnNm5qdDFCd280NlE1UHVVY2tod09pdjh1?=
 =?utf-8?B?RTBLcHlwend4YWFEQ1BPb1Q4Vnp1YnhLRlltYUlaYm9qWGY0WnNGbmtZb1Fu?=
 =?utf-8?B?T2FQQ2tSdkRUTjJVQkFTYUcwOVJTWTdJc0tvOHlsTjk4VzlwdmQzTk5hWmR3?=
 =?utf-8?B?b3VQa0hZbzZ0TFVCd1RvYzc2U05LdGorVkladUZQRllZcG1ZY21uOTk4T04y?=
 =?utf-8?B?NmdXNHlURnFwaGNVYkw3bFhPUVdEU0xleVE3M1RZelNON09ORWNCZGRyNTRG?=
 =?utf-8?B?R3lGWGNqa2ppT3VXOVpMeVFIVHpCZGR1T0preFRqcnI4a0ZZSTd0SitmdFJw?=
 =?utf-8?B?c3FqOHNjR0VOVVBiTitmeWFPOWU4YllTaUJVN3JMYjBVYjFYS1B3RkpoV21X?=
 =?utf-8?B?aWk5bWF5bythRFpkS2ZLckNBL3NDSXhtWTlDeHRlL1VwWHM0eTVyRUxtV2tO?=
 =?utf-8?B?Z2luK2pYUmRrTGJqd1JhWHpFVHgzdVRVdmdOQWF1WjdHbURabERZanZ6UVFU?=
 =?utf-8?B?ZVhmcmVsZjd5TXVzWVN1ZndOMlZsZDVERnBVbDhrelRpdkRqRHFmd2RRaGov?=
 =?utf-8?B?VWxFN05MQ1pzTFI0REFXUmFyQzZscTF4ZkZTbVM1Q3ZHd1NBL05hN2VXd095?=
 =?utf-8?B?RHFWVmIyeXRERFFQWC9kTlBubFlOK2hnWjRCdncybldNdFV5UFgrUmJtY25U?=
 =?utf-8?B?eUpqTEk2NGNQdjFreC8wZXVwQ2tqYjlrcmZUa0EvZlRjdDkwRXFnVlJva25p?=
 =?utf-8?B?dGd1TzZJKzZ5L2tBRW9jMDdkVUU2K2Z2Vmg5Nkt4OHh0Y2VDcE5Ta0pPMnZ2?=
 =?utf-8?B?ZTV4WFNRdy9QMDN2WVpzZkt5T085ZVpoTzZCM05pelpOOWQzalk1czZoUm52?=
 =?utf-8?B?ZmhGZnkvWFRvcTNmbDFGWEU2WDJ3Y0RpVVkySEUrQ0pBRE5CNzRpMC9xZDVX?=
 =?utf-8?B?WUF3SU1FdkhTeFpPUmg4MzlPK0c4QjlOempzWWNlbDIyN3UvejBRL3ZnMTJv?=
 =?utf-8?B?SUhINWpwTGt4M3UzNzNRbG9VK2EwMmw0Y0JIOTM3bm45Y0VOTDV1Y1o1QTJy?=
 =?utf-8?B?V1hyK0MxWXcxdmplcm9lc01kcHZud3locHdIZ1M1clhUYThUMm1kemhkaVh4?=
 =?utf-8?B?SWlCa2ZxMTFiNU9TS0J0NHpFNzNvOGYyN01sWUJnN2gzUVhOVUd0VTJ4VVZC?=
 =?utf-8?B?S2JDWmRodXhmS1grZ3hJYzBmeEk3OENoY2VxNEgrYmtNOEFYNEVPQ1Z2WGJl?=
 =?utf-8?B?UnJ0aWdyUGIvS1ZhSG5LWG11V0RjOUJvK29nZUM0U0kvUkY0OG53bnVoRjhE?=
 =?utf-8?B?QUlRTkcvbVZOc29vcmRzVHh5eWIvYUZkTGVVTm1WWVdlVkE1V2hJQ0NOclRp?=
 =?utf-8?B?eDlVODFWazAycTgrd3U5Tk0rMmk2V3NlVkZoRDJ4T0xadE9vckxhb0pIRVpu?=
 =?utf-8?Q?9dh0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ece9d8-0633-46da-5019-08dceddf56d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 12:37:46.9764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKXNRoVQD0YE85rdjd5hAGHlzDNeT2Ak8cFY5KWhL81uRjjrHh65aVCuxyH9CtEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtlbm5ldGggRmVuZyA8a2VubmV0
aC5mZW5nQGFtZC5jb20+DQpTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTYsIDIwMjQgMzoxOSBQ
TQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogV2FuZywgWWFuZyhLZXZp
bikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdA
YW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9wbTogdXBkYXRlIGRlZXAgc2xlZXAg
c3RhdHVzIG9uIHNtdSB2MTQuMC4yLzMNCg0KZGlzYWJsZSBkZWVwIHNsZWVwIGR1cmluZyB0aGUg
Y29tcHV0ZSB3b3JrbG9hZCBmb3IgdGhlIHBvdGVudGlhbCBwZXJmb3JtYW5jZSBsb3NzIG9uIHNt
dSB2MTQuMC4yLzMNCg0KU2lnbmVkLW9mZi1ieTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdA
YW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQvc211X3Yx
NF8wXzJfcHB0LmMgfCA3ICsrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTE0L3NtdV92MTRfMF8yX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxNC9zbXVfdjE0XzBfMl9wcHQuYw0KaW5kZXggMjdmNGUwY2U0NDdkLi5lY2RkMTFhODcz
MTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92
MTRfMF8yX3BwdC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3Nt
dV92MTRfMF8yX3BwdC5jDQpAQCAtMTc4NCw3ICsxNzg0LDcgQEAgc3RhdGljIGludCBzbXVfdjE0
XzBfMl9zZXRfcG93ZXJfcHJvZmlsZV9tb2RlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KICAg
ICAgICBEcG1BY3Rpdml0eU1vbml0b3JDb2VmZkludF90ICphY3Rpdml0eV9tb25pdG9yID0NCiAg
ICAgICAgICAgICAgICAmKGFjdGl2aXR5X21vbml0b3JfZXh0ZXJuYWwuRHBtQWN0aXZpdHlNb25p
dG9yQ29lZmZJbnQpOw0KICAgICAgICBpbnQgd29ya2xvYWRfdHlwZSwgcmV0ID0gMDsNCi0NCisg
ICAgICAgdWludDMyX3QgdGVtcF9wcm9maWxlX21vZGUgPSBzbXUtPnBvd2VyX3Byb2ZpbGVfbW9k
ZTsNCiAgICAgICAgc211LT5wb3dlcl9wcm9maWxlX21vZGUgPSBpbnB1dFtzaXplXTsNCg0KICAg
ICAgICBpZiAoc211LT5wb3dlcl9wcm9maWxlX21vZGUgPj0gUFBfU01DX1BPV0VSX1BST0ZJTEVf
Q09VTlQpIHsgQEAgLTE4NDIsNiArMTg0MiwxMSBAQCBzdGF0aWMgaW50IHNtdV92MTRfMF8yX3Nl
dF9wb3dlcl9wcm9maWxlX21vZGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQogICAgICAgICAg
ICAgICAgfQ0KICAgICAgICB9DQoNCisgICAgICAgaWYgKHNtdS0+cG93ZXJfcHJvZmlsZV9tb2Rl
ID09IFBQX1NNQ19QT1dFUl9QUk9GSUxFX0NPTVBVVEUpDQorICAgICAgICAgICAgICAgc211X3Yx
NF8wX2RlZXBfc2xlZXBfY29udHJvbChzbXUsIGZhbHNlKTsNCisgICAgICAgZWxzZSBpZiAodGVt
cF9wcm9maWxlX21vZGUgPT0gUFBfU01DX1BPV0VSX1BST0ZJTEVfQ09NUFVURSkNCisgICAgICAg
ICAgICAgICBzbXVfdjE0XzBfZGVlcF9zbGVlcF9jb250cm9sKHNtdSwgdHJ1ZSk7DQpbS2V2aW5d
Og0K77u/DQpUaGlzIGNvZGUgbG9naWMgZG9lc24ndCBzZWVtIGVhc3kgdG8gdW5kZXJzdGFuZCwg
SWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgY2FuIEkgbW9kaWZ5IGl0IHRvIHRoZSBmb2xsb3dp
bmcgd3JpdGluZyBzdHlsZToNCu+7vw0KSWYgKG5ldyBwcm9maWxlICE9IGN1cnJlbnQgcHJvZmls
ZSkgew0KICAgICAgICAgICAgc211X3YxNF8wX2RlZXBfc2xlZXBfY29udHJvbChzbXUsIG5ldyBw
cm9maWxlID09IGNvbXB1dGUgcHJvZmlsZSA/IGZhbHNlIDogdHJ1ZSk7DQogICAgICAgICAgICBz
bXUtPnBvd2VyX3Byb2ZpbGVfbW9kZSA9IG5ldyBwcm9maWxlLg0KfQ0K77u/DQpCZXN0IFJlZ2Fy
ZHMsDQpLZXZpbg0KICAgICAgICAvKiBjb252IFBQX1NNQ19QT1dFUl9QUk9GSUxFKiB0byBXT1JL
TE9BRF9QUExJQl8qX0JJVCAqLw0KICAgICAgICB3b3JrbG9hZF90eXBlID0gc211X2Ntbl90b19h
c2ljX3NwZWNpZmljX2luZGV4KHNtdSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBDTU4yQVNJQ19NQVBQSU5HX1dPUktMT0FELA0KLS0NCjIu
MzQuMQ0KDQo=
