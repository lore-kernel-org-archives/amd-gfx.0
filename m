Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ED0D35676
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 05:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BC810E61B;
	Wed, 28 Jan 2026 05:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iftz5eJP";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4320710E61B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 05:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUWXQjUOxoaKx4zRkk89csTMHCpRY9f74alP5iGHcWaRx/vvyRqBwtOLwvjUiiczDu+zH1AGMIniMBVDdcd5d5PEeym9xQZG6ETz2iVz4vqKDdFK3HwVmB2B8KK4a3AtVBwZDKA54BiguoPhlsTmUq103+LHhALgYtf0tqlLFfV1ZcI8NM2PuOlSOSItMVFGZQdbiNCLYmrH4rI1+xrb4KO2+9cakGF0BPIaPOJBJZo5SE1RjKeQcgHlEN42eOOCSgKuh6H24F/pldlpz1+DH03qYAWVAzgw15ib7SMHhVDPr7INYid7EA9lRHzi6GGxULYLTVRNN341xEo4s1bVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X24E8uanYjumRYFvaaCxGISz4ydbh8hCx1lrpceczrY=;
 b=S8Tn5W1KlENJisBZu80x9auEG07R1dH4rPPHqIpc8FAsfTvEUQuSAl4O+m6ziY5s66neFnzQt8AM+uIledVBm1gK8K2eyw7GUWZ6dF+PBCYnOGZg5XD/x0Xm0W31lDh92thH2Nts+HOd9FRWma3MxQ4gAdNtIvjAxpzC+jcZwfAuyEWdB8Fk0S0aeGH3jkvLBI/Ef+6UBsTdHiX6+2vq6YjmBQbSNrOmV80ZvbFKC8DMrHe3sXd20NdGuWgjLdwFY/2gDU4WcV7lXSq6yg2ML+WvqEjnYpTWXIyYUWh+N6k0lGgqso/3v8qbzxYsyd8li/S276o9r+y9glNcdXewOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X24E8uanYjumRYFvaaCxGISz4ydbh8hCx1lrpceczrY=;
 b=iftz5eJPkDmDAVfsQEfJFdNMhvpl3VLLAWrIy91x02Z6d2r4lOJzkzeJuCi3+nfORQfLzmfD+23m5KNuWCxtHYALjeS24MpNabizK5ptZ5Rz5ZkcGfIV8u1lJRtD0g0wL6RA4gKnsgg+5hwOq7MRLbsGEIf0+lbVmn5FXFF8izA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 05:19:08 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 05:19:07 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/soc21: fix xclk for APUs
Thread-Topic: [PATCH] drm/amdgpu/soc21: fix xclk for APUs
Thread-Index: AQHcjJyd98UdijyCmEezXPf/591Jp7Vmpr+AgABrPUA=
Date: Wed, 28 Jan 2026 05:19:07 +0000
Message-ID: <DM4PR12MB51526A655E103AAA2C34D316E391A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260123191500.18619-1-alexander.deucher@amd.com>
 <CADnq5_ODe5fCk3BKZdU6z7=VsUCk2aOMh79myfqE3X-VDE97tQ@mail.gmail.com>
In-Reply-To: <CADnq5_ODe5fCk3BKZdU6z7=VsUCk2aOMh79myfqE3X-VDE97tQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-28T05:18:58.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW4PR12MB7191:EE_
x-ms-office365-filtering-correlation-id: 65115892-04ae-404a-faf1-08de5e2cc30c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?T1IxS1NpRkEwVlNiRWFtbVVVeUlLb3pDOGFhcklpdWl2eW9QVU9TeVV3NG5S?=
 =?utf-8?B?Uk1GMmhvU2lSKzFqWVNyNHljZThQdmNXTHdIRTUrRGlNbzB3SjNYcWh1WVVI?=
 =?utf-8?B?cThiK2xPMlg4cmdOODJKZjg3Mm41NnEyaHFVMXl2RGUvYVNacENZaFh3VlYx?=
 =?utf-8?B?WHgwdUU0Uy8yR3hxRmlPMGREY1pWcFg1WUMwcmhud1VIaGRPbSs4TlErVnpN?=
 =?utf-8?B?clFWZnMvR3JvRVZ6TEsxZWZ0d0JocTltMUVkSDJZazk5by95NUVmUVRjSG5Q?=
 =?utf-8?B?WjlpenpqQ01jdU91ZGkvWnYvS0xEbTl4c2ZEeHVQcmtTQlIzaE0vM1c0bUtr?=
 =?utf-8?B?WHEyeUVoNUlaZDA4alhPN0lwTjgzK2dwU0xFcGpYVmVEL2c2dUNyM3RnVU1X?=
 =?utf-8?B?WHd1bVFPV2VQdGJ0Q3hLYmJCTi9jclJjM0haeHMwUHhlUnExWUQxUEE1M3BM?=
 =?utf-8?B?eWhxcUNvcmlmZXBISlhDMER4U2tzblRVaURiZVMwMTkyMXk5YUlYV082Snhh?=
 =?utf-8?B?VXNCaWZONnozQlVRZUJ5SlYwOXFTdFpxc2hmNkU1N2FncTNpVm1mVm5MY0FP?=
 =?utf-8?B?QlFERnZRMmIxdzZnT2tmUGJHWkJUVW9oeHpoN3A1UjhXTTJsNWt0cmhLWW9y?=
 =?utf-8?B?MnJUcjV2ekRZaHJTVWVXdHlTZ21qNDR2alNFajdpYnQ3Z2l1bnlsN29tNnlI?=
 =?utf-8?B?WWhRdjVSRys5cmxGTlFoS201ajg5M0k2T3UwT295ZExZb3pLTk5JNE9WUGVk?=
 =?utf-8?B?RmNRZFBIdmsvWVkwL0lxRjJpdnB2QnVxTm1pOEtOMkROQjBWRFpqaStpb1Ns?=
 =?utf-8?B?dlRIb3Q5Q2ZIS0RLQzJqeVJZK1ZVY2JVSEZFQUpPbER2anFnaXhxT2tYbWNM?=
 =?utf-8?B?VmJCZ3M4ZEl1TWJjV29HVTZvVndBOHhoS25QTEtmcjF0MWdpRlNCU2x2dFBn?=
 =?utf-8?B?ZUJ6Wm5PVmxncHdTeXhPVW9hN201VFpzR0F3TVZwQ3RsVk1Pc3lEMlFraUZv?=
 =?utf-8?B?L2VubmRyK0M3WVpPUU1HRDAxaGI1Ukhta0Z1V1dzMThpNWhxYm5zWmlCY215?=
 =?utf-8?B?NHgwY0RZdWlYYmlGQVlhc251cmFwT1djbW50WnV2K2ZiSlhXaVpjeHVmRWRN?=
 =?utf-8?B?VVNPT3QyVDYzcHF5MDZIVEpIWGFIU0NXSzVuNlZ3SGhnUG5mSUkvR0FadFhD?=
 =?utf-8?B?SE03UUlkT05YcHBnYzJFd01LSnRYV3cybkdSejR4azlWYU9kN2ZBQ1owYmQw?=
 =?utf-8?B?S1hVMDg2Nzk0QTd5ZzhoYUdJNkpla1NFMm5CVkh0bkVoUFBwYmJ5R2RUNjRw?=
 =?utf-8?B?b0htOW50aFgyU1hNeWF2NDlGVHVKZ2sxaSs1YWJYZkFJbFJiNnlWRmJ0VGVo?=
 =?utf-8?B?aVEzSHhLTllDUlFWYXdHMHdycXRRR3RVSG1MV1J6czdmTC9sakt4RnJaZWtZ?=
 =?utf-8?B?b2hBbUc4anh0dHhnSjYrL1BHeHBNbzNKcS9OUHE4T1ZXcUhNd2lyT0MrZjVH?=
 =?utf-8?B?WndibmpXeVkxaVBydXZ4ckhhejZyOVcybXhONVpvR05tU0VEd09PTnBSeDRM?=
 =?utf-8?B?Ui9DcWYyMUphT0ZaYjRmY29PaXlLdGlsR2NESEE1ZmxEYnFUSXlNdC8xKzlv?=
 =?utf-8?B?a2gzbFlkRFJBb29mUE85dm9rRTJNTjZHeHlqelhCZDZDNGoyOUVZdkhFTXdq?=
 =?utf-8?B?L3N1ZXMyZGo5SFZSUm12NlY1aE45MXNOQndvMGtNR0tFZTYvdHRBRlFGclRx?=
 =?utf-8?B?dHFaSW0yU2p5V0RyQ1Q1UGxSekR0NDFSQ3lKYmsvZG5tRFMrWUkyT0JXRTRM?=
 =?utf-8?B?UGl1ZURCRXBOQk1oUzJiaHYvM2VCcURsT1JsTktpOE5qTVorRFhxZ2tjKzBZ?=
 =?utf-8?B?bmtBUXc2ei8vYXJsV3M4WTZHa2g2OEpnMGNEYzBPRjFaYzhTVXArWnZJN3Nt?=
 =?utf-8?B?R2dyTEZLVnFGTFE5TFc0bWU5aWdTZXR6WVp3MUFETXF5NmRPYkVmTndoTnN5?=
 =?utf-8?B?MHlDZVJOMGl3Z3YwUFpoMi9ncTlHT3FVY2w2YVlrREhUckpZdEx6UHZ2eXlq?=
 =?utf-8?B?a00wenYwSmJHakJFOWN3eFIzT0taM3BKdm5MNEU0SE9ZN2JKSUxLL3FETUt1?=
 =?utf-8?Q?Vwwk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2pCUGNkcktaSGhLNjlYcmNFMjVhOFViNWlGUXZCbHBkYThFci9oaFplQmVl?=
 =?utf-8?B?QkNxMldIWDJrNDFqSjVYSjlKazk1L2JxbmZjRDE1VzBPenQzRVJlSFQrRWh0?=
 =?utf-8?B?Z1N5dFhGcW14WUZjNlVSZW1xc3ZmenY1UzMvL3kyQ0VxMEhVNGN5MmJacjN4?=
 =?utf-8?B?TVRCZ2YzUFh4c2JHcGNWdUdxUDkvdzJBYUt5ZEFRRkdZU1lJUDQxR2E1VW85?=
 =?utf-8?B?WTlVaTFRaFptQ1diUkRsdVBFdyt5UHV5Kzg3V1l4UEE1L250RGdyYjRWc2cx?=
 =?utf-8?B?YVV3OHRENWlraVhjSEl2dHQxM2EySnU5aThtU0s1WFdUbGtGcjRnTmhOa3V0?=
 =?utf-8?B?VW9odmdSNWgrVmFYaHJEREtnWTRrYmpWcWtYNzlLMFVMYmw2NHY5emZwQkor?=
 =?utf-8?B?dmdPV1R0NEVFb202eFBXdDBhcVFYVXpIYmJ3ZTdkTTJ4RHQ2QmJmdTQyV3hE?=
 =?utf-8?B?a2huaURobzhRWnhZMXdubXlrNDlDcWt3UE1tUmNYUkZrVEs3QTZORUZYemJM?=
 =?utf-8?B?c1kwYm51N21DaDJFQkg5cUZGWnNPa1ZGVXhWQ1FyVU5FTGtYeFRBaElWeXNq?=
 =?utf-8?B?N21Na3BYTTIyMWhTNDFobldWUTR0dG92UERJU1FTV2NOeVpMa2IwR1RTbFFw?=
 =?utf-8?B?eWUwTHJENUdGZ3h0WVhQbHUwTG1ib0JhRGhGZmZZQ2F1Q0pSSE1iMDF2VGw4?=
 =?utf-8?B?VmRRTUxReWV1bEtFbXEvOUxFZ1pFOFNmN0VQcGxlTENTbGtMb3ZhZXI1MnVj?=
 =?utf-8?B?b1J5eE5KOC9XR3NYSzhSaWFhU2VlUEJXUDFoeFFBYkVadGJlU3o5NVFMaVlm?=
 =?utf-8?B?UU5LdktpclptcWZ3NlpkOXVwWDdjV0hvRnh4OVJtZkEvOVQ1enpwYTh4eXNn?=
 =?utf-8?B?RmpSR0d4Tm5vV2ZQQm5ndkhWUUk4aU9TV3FGL1EwU2JValZUNlFBSFRPSUpT?=
 =?utf-8?B?NlVhS1lINXkxR1loYVJ2NmdQeDdaNTdZbTh2YVdDTmVaR1VZNG1SdmgrZ2Fq?=
 =?utf-8?B?TWFSRmhWUjNEQ0VWRnlOOVBZOEdpOU8rUjFCYzVYRWNLTTJJUmQ4RE5KdTU3?=
 =?utf-8?B?T3ZUczlNQVRHeG5LRnBEN045dVNOM0JCZ3hBOFJRYS9yRnM0OHhab3RQSXk5?=
 =?utf-8?B?UGNjQVl3WXZEZTU1RWxVUjdjN1VOZkl3b0dKTXZ0T1ZLN3VQSHJOSGJycitO?=
 =?utf-8?B?YXU3Y1BOSnBDTE8wRUVkMHNrK0JEckJSd0pwRmZ5ZGFMM3k1MGxoSjRpTUtH?=
 =?utf-8?B?RVoxeVo5MHdRV2VuQk1Ra05vN1dNQ1NQcEFSa1NSbTQ0S1d6TmRlSWJ5Ujd4?=
 =?utf-8?B?aG5xQi90cTZKczQ1Y0lHU1JSUkVWOEN1VlJrNWhDR0QyNCtUWXAwU0ZnbU1w?=
 =?utf-8?B?cHg1emVJZU5zS2Y0RDFlTFppZHQzR20rUFhwR1ova1kzWm9kY2pWTXMyclkv?=
 =?utf-8?B?VisvVFkwMTNnem1IMFM1WW8xYnRCQVgvZU05RUZNSUJCL3lhMmp2d1NQb2FW?=
 =?utf-8?B?aHVtQm00WWRwUmk3amtYQ2JzVExMM3pQU2NWMm1HOEo3R2pKNS9TQlE4K25w?=
 =?utf-8?B?M1Z2UWNoQUkyclVaK3UxV1UzSHIvMHFwUVFyR2k3TmU4N2hDSDZzOGRwYW8v?=
 =?utf-8?B?MERKSCtmaHNZbGE1VURnb2EzcHVPL3YrS05JNGxNK0sxcXJnbGVPUzVzd2ho?=
 =?utf-8?B?cFNTSHI5WXQxVkFGc2YwN21CcFpCNWxuZTczdUNnazEvcXZVSy9HQm1QOEp5?=
 =?utf-8?B?anJ3ZUw2ZnA2REY5ejZraEVkM0pvM09ZTFdEREhZS2svekJVYzh2RUZGNEU4?=
 =?utf-8?B?U3p0dWhIcFRRT1JGclZLTk1KdWJxLzVHMVlPdkMzMkpBeG1wU2pQUStaOWI3?=
 =?utf-8?B?eWJFM0pHOFg5R0VGZXBwblYyK25qY0lPZEovU0VZVGYwK3pHWjlBTFRtRDdH?=
 =?utf-8?B?d3FRMDBodHdYN0xnNkhwdlZvOEhCQndkdjAwcnZ0TU5oTTZZckhUQVVaZlRx?=
 =?utf-8?B?U3luYW9QQkJCWnFJcHJrSUhIUi9FQ0tvVUhMYk9ucHZoT0JpTEkzODVaU29C?=
 =?utf-8?B?RXJtam5RMUI3UVVRVnNtUU1JWjVlWEZZc0JXeXpsSDRaR2YydG1iVEJ3aThk?=
 =?utf-8?B?UTdzbFZobW5oKy81eXBrOEpEcHJjN1J5Y0syZGlyR1NsZ0lQYjdLT1RKcm9r?=
 =?utf-8?B?WFd2ZHkySGR2UkIza0lQRERQMnVkd1BZRFRvWFZ6ek9nMm04YW9kUmxFTjJB?=
 =?utf-8?B?eEFKRVFBTE1jL0U5NThOcTlvaEk1S3pMTy9kMEh1VDEzSVBGSm5KYVhvVmFu?=
 =?utf-8?Q?vyzx3IZ4Uzg2Q0DD4M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65115892-04ae-404a-faf1-08de5e2cc30c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 05:19:07.6701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3Ix/K8P3fSsn4AGjhp32mnu2l7fyqJExUl+Vcle5byW+SQKNmlO8/7EFQL7LYAlgtfJnsnpyQtZeu7Qxes2mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191
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
Cg0KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4
LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleA0KPiBEZXVj
aGVyDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyOCwgMjAyNiA2OjU1IEFNDQo+IFRvOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1k
Z3B1L3NvYzIxOiBmaXggeGNsayBmb3IgQVBVcw0KPg0KPiBQaW5nPw0KPg0KPiBPbiBGcmksIEph
biAyMywgMjAyNiBhdCAyOjIy4oCvUE0gQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFRoZSByZWZlcmVuY2UgY2xvY2sgaXMgc3VwcG9z
ZWQgdG8gYmUgMTAwTWh6LCBidXQgaXQgYXBwZWFycyB0bw0KPiA+IGFjdHVhbGx5IGJlIHNsaWdo
dGx5IGxvd2VyICg5OS44MU1oeikuDQo+ID4NCj4gPiBDbG9zZXM6IGh0dHBzOi8vZ2l0bGFiLmZy
ZWVkZXNrdG9wLm9yZy9tZXNhL21lc2EvLS9pc3N1ZXMvMTQ0NTENCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMgfCA4ICsrKysrKystDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jDQo+ID4gaW5kZXggMmRhNzMzYjQ1YzIxYS4u
ZDljYzY0OWQ4MWFkNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zb2MyMS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYw0K
PiA+IEBAIC0yNTYsNyArMjU2LDEzIEBAIHN0YXRpYyB1MzIgc29jMjFfZ2V0X2NvbmZpZ19tZW1z
aXplKHN0cnVjdA0KPiA+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4NCj4gPiAgc3RhdGljIHUz
MiBzb2MyMV9nZXRfeGNsayhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikgIHsNCj4gPiAtICAg
ICAgIHJldHVybiBhZGV2LT5jbG9jay5zcGxsLnJlZmVyZW5jZV9mcmVxOw0KPiA+ICsgICAgICAg
dTMyIHJlZmVyZW5jZV9jbG9jayA9IGFkZXYtPmNsb2NrLnNwbGwucmVmZXJlbmNlX2ZyZXE7DQo+
ID4gKw0KPiA+ICsgICAgICAgLyogcmVmZXJlbmNlIGNsb2NrIGlzIGFjdHVhbGx5IDk5LjgxIE1o
eiByYXRoZXIgdGhhbiAxMDAgTWh6ICovDQo+ID4gKyAgICAgICBpZiAoKGFkZXYtPmZsYWdzICYg
QU1EX0lTX0FQVSkgJiYgcmVmZXJlbmNlX2Nsb2NrID09IDEwMDAwKQ0KPiA+ICsgICAgICAgICAg
ICAgICByZXR1cm4gOTk4MTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gcmVmZXJlbmNlX2Ns
b2NrOw0KPiA+ICB9DQo+ID4NCj4gPg0KPiA+IC0tDQo+ID4gMi41Mi4wDQo+ID4NCg==
