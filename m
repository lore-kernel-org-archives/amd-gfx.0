Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F09C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 15:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876D588EFE;
	Thu, 22 Aug 2024 15:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="viYVaLfN";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E3810EB23
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 15:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdBtorPLxzgDo6sZ1d3kfe+G9i44zoz/d8PuHmSOfGscltg1IgVgYLqdoGytsXtY7OHxbyVck+2TgB+rxPr57e2WKOi5j7rMZ7tLZYRHx/mAxNMEO1AbHxdZlJnmL8ZPMmw7v4smDdW8Y56RcKYKXP1ZKSRluyk/dsR3jAIE1dBQo0WgDJhiIoR0vx7YX8wusqE4fNH1OjSl3ebM3zFouaA6gOftIso78VbjoiGupr+XXWyXadSbkLkghplpeW7OMxfdjYxI7490qkJuM6VQj5I0btn/HJcZTLQlMynZoBGmgtz8XK1HSkuDJzaggR2EOGjMKlmRrjeYtq3bl4Wthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p0Rq0U4fhl4CYUJkzrPd7TtPLxMdCYkGpYC7UTbTpA=;
 b=y/lHJd4S9xbxgjxZCfh1cw0hrtk/adED6XGDeXrqIL1s42DgnHXmUYC1KxnGyy8XaGUa9y9xK/+wm3GT1Hl/nDClt/sGYb/rBkf6KU92JGFxYhrFXQzRozFQ+shDjK9njwhqoHlO9PsqeC3Uw5C0DZAnWelw78/b1XLcg+XTSzmSTsNJAT5CH4JPi1nD8nLYvdvymql1vW9wQajznuCPYy7bm3v0hu2iasUdKIt3FGuaAX5dX/ZXulNTBAiSEeYpo++dSNebmjbxTrnnjr8DC1Fb33+suMGLiYpN3HLIZbOm/XgBuqhInGPsYhvarIxbKyD3dZWFmA+0YdEQj/KuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p0Rq0U4fhl4CYUJkzrPd7TtPLxMdCYkGpYC7UTbTpA=;
 b=viYVaLfN2v6oHm2FaeWv0q82Oh+rHK766XRb4LZaw2cNkN6sS3oF1fePIsTRA4S/h9vRMkuW3/Zmn4/4SixMyHXLVUCaS3i9zxwsEhm85nR6RhucOLIYY0QKxmwlPw6SH8Tgsds71kETW9og2IWOCGKjRZ3rizOkblDoS+Xpw7M=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 15:10:27 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 15:10:25 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix missed queue reset on queue destroy
Thread-Topic: [PATCH] drm/amdkfd: fix missed queue reset on queue destroy
Thread-Index: AQHa9A+TRAByZ+PVEkibHZOy8g9icrIyQDWAgAEh1CA=
Date: Thu, 22 Aug 2024 15:10:25 +0000
Message-ID: <CY8PR12MB74355B5FF47FF8F7A4A0FB98858F2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240821211737.4154269-1-Jonathan.Kim@amd.com>
 <c69f3e14-696a-4b77-a490-76f6dfcf4be2@amd.com>
In-Reply-To: <c69f3e14-696a-4b77-a490-76f6dfcf4be2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=b67660d3-6221-4d83-894d-7f8173e89751;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-22T15:10:13Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DM4PR12MB5793:EE_
x-ms-office365-filtering-correlation-id: aa94cf1c-a150-4d6d-2b8e-08dcc2bc8ce6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WVBUeUtXc01BYmQ1dTNDdmRXVlVrQzI2Y2l5UnRseTUyZ253WWRjYnRUUnRB?=
 =?utf-8?B?R1MyeXhGNGREeDY1TmV3cWxJdmEwdENCWVQyNThFVGZYbVV1dWhXRlhNdDkw?=
 =?utf-8?B?TG01NWdTV2FzZStkV2hHN3BzUnhQWEhxUUhTQlNpYklGdFFLeFBUWnFzV1Nu?=
 =?utf-8?B?WnlyVVBkdEd5ckJZckN0MDBEVFRrRTdSSS82SXhCbTJiNUg4UVlCRDc0T2VK?=
 =?utf-8?B?dmxCVmNHREs3NHlsb21WVXFoSlh3eDExaG1kL0tNVnI0NjkvRUxrNDZyRFBV?=
 =?utf-8?B?dVdxcWN4YzBpZTlqRlNMZG55dXJWZDNCN0FGYTJnWWs5T2ZTcEovaWxaTmE2?=
 =?utf-8?B?S3FscWM0UG9RQlZaY1JGOXFZV3pvZlJOZG9LdDN1czU1Snp1azFpN0VBdk8y?=
 =?utf-8?B?bWhNK28wT0FvMjE0ZVBKQ0o1S1hDOGdQYVM0UUUySGF1cTNYMkhjaC9FZTND?=
 =?utf-8?B?TE9USmUvUUdhY0xCVCtMYnBtbHM2TWRWZ3Zrb2x6Z0N4WXBHc1ZoTWFWNHVM?=
 =?utf-8?B?WVV4STRPY2xTdUsrSDJvdDFlZklQaUlZa1N2dHVUWm44QVdQWi94ck5PaDZs?=
 =?utf-8?B?NUcxbFRNUWxyV1BGNkFjMHEvM1RGZjRwZHBwYU5hdlpyMWFvb0F5SGRLbFh1?=
 =?utf-8?B?VGJTOEZqZDBESGFOanAwaVNPRW9mcGxxVTFmV3N5TjNQeDV4ci9UQnJhRUlx?=
 =?utf-8?B?VVordE1vOWJMYUkySXg1cTZRTmsxT0xiU3BxUU1xQ2FkcXdDRHlYU3JUYTVm?=
 =?utf-8?B?UDZXbnZxMDNPcWppdkdpQWIrUWhvbjVoRlAxYys0c1doaVVRaXdZWlQxRUt4?=
 =?utf-8?B?cWxFRENJYlZqZlVIempyVnV4WGhCdUVWWWhoK2RpVWJFTDdXUUp0MVNOaUpE?=
 =?utf-8?B?TGIwWnBkK0JPT0YwakFaTkt4bThhLzZxQ1FlOFlkYWNDcHRsd3poOG5id1dy?=
 =?utf-8?B?OE11QWUzT3piMlIydy93OEQ0em5PK0xrc1hjcWlSaDMwMnJsMml6ZUFHUWVT?=
 =?utf-8?B?QVNRd0hST2JwL2JEa01La1p6c3p1aGRNbmlISXFmRmwwMUZKcHBtbDhGdFZj?=
 =?utf-8?B?elR1NnNraVRWQXVIeE1tMDBNWGZDdnIxZkY0cjJoU01MWDkwY1BzMkNOMmVE?=
 =?utf-8?B?VFczNmJreE9JZTBqTGcxM1pZWjRWS1lZaTRWbHRwZGZKWXh5SEpMcjhiYzRl?=
 =?utf-8?B?OEViUkNrRzFvcDJmUm8vRjBCUXNYd2JnZXBoMFFpSUw0RXE0Qk1yTjc0SDNB?=
 =?utf-8?B?dWlDV2dwOUhONG9YMGVYM0tHdlcvdVBKbk9RNituaUFobjNyUDlzeUovYnVz?=
 =?utf-8?B?dWNEV2NYeUg0WDNmWmMvY0ZWRVVDWC9YQkxKZ0VPa3B3TjVqTVdKYXN2SGRZ?=
 =?utf-8?B?cHM0SDRyY0hqN1pRR3psK0tPY05rSTBkYnNCQjNCWWtxZWY4bUpHU09NMjV0?=
 =?utf-8?B?M3J4TG5CNE0yME5VNERzaHkvTkM3Sm5JT2NSYWtyaml4ZWFDc0JUUStSdWw1?=
 =?utf-8?B?c0JqTTlHejNhLy8zOXYwWFN5N0VwUUlHWk1nU0ora2ttTitLSXladzNOaWFC?=
 =?utf-8?B?enBoY1h1SENiMTkwZktDTHhFN0hwSGdUbU1qRnpTZTZvY0hQQjR3ekpqUHlS?=
 =?utf-8?B?UktFZ1MxeE1BQW9RNklheXhOc0V3WHVPNjc5ejBkL3BCcyszOHR5NVdHVSs5?=
 =?utf-8?B?dTJQS0MrRFUyWWo3RGh0VWdRS3dhMVQrdjBQTUUva2FNMkZ4KzFFZ1F3ekE5?=
 =?utf-8?B?bXZ4S1ZSS2pWeGpQL24xczZSeUd0ZERzYjNXdVZpMDZLQzFYNkVLcXVkQ1lP?=
 =?utf-8?B?czNrZWx5Q0thbDh1QUVSOVBIRW1pUHhucUg1eFArQkxZTFpTVXNJZDZMaWZT?=
 =?utf-8?B?SkJxbHYvaW5DTHk0dG00OHNnUy9MVDJ0RWxOSEJKdlJTb0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFBMb013RWFERENlSm1HR2FYRDVyVVVjVVZBN1pDbnlCYWdWcUEzeFFqenl5?=
 =?utf-8?B?YmRBZ0JYWDljTklTbS9kQ1hYNG4rY0c2M25jYlM0OHRTbU9CdU4zNDV3YmJP?=
 =?utf-8?B?eGxacFVUbkhnVTd6WDQyUGswRGd5WU4zVk9XRFpyMlRxUHQ0eEJNKzZXNS9q?=
 =?utf-8?B?WkFURjFOT3RSNURnalNKcGQzMzFJNFkvdnV1Y2dXTDR0OGZ6clFLajBQUzkz?=
 =?utf-8?B?a2N2bkhyZDlrUm9vS0VVdm9sbTFmZGtFeGxlNWtkSmVSbTR3VWlnMTlxOC9u?=
 =?utf-8?B?N2NpVmV0MDJMenhDeTA4dHZJQllPTmRyZy9iTHNyVXBzQzUxbUFMLy9DTlQ3?=
 =?utf-8?B?bHpaREZmYTlnWnFKZnhYMExPU1NjL1NOdzc3SDAxTGRvRUhQUE96MGpWeVhU?=
 =?utf-8?B?aFQwRWdqdXhYclRVWmFzTU1VY01VdS9ldVljQ1BWV3g5ak5mb0JBanhDdkZQ?=
 =?utf-8?B?OEVyVXhabHFPNVh3ZXVaYUNQRitWL25XZmI4a1lzWllMaW5PUEZjT25WeGdE?=
 =?utf-8?B?bHA2Wk1GNVNjWEcwVGR5eENKZ1hrcTN1ZVhCR0ZnVDRSSkxwUzd2RUh3ZEph?=
 =?utf-8?B?OGljMnJTUXNxTFNVRTNRM29iZnB0L2tpN09zZXVQNExVQUtjTkpDZThpanIr?=
 =?utf-8?B?RFVhSTBkZTVIWFdBZGUwSXJFMnpmTHBMVlIwcXRROTM2U1d6UHgvVmVJWXdZ?=
 =?utf-8?B?ZDZNNysxSkFNWXVjOVBNR3UzVEhKVWhWTFo1TEVydTRlZThtb1pNRmxEakxP?=
 =?utf-8?B?WWo2aUlUc0ZKK05TZm5hS2RrS1VEL2xMM1kwYVJXUUthb0R1WDBXRW8vcXRF?=
 =?utf-8?B?WVFKdWIyd0ZWZkU3YzlTakZ0UjBQZ2FiMzlEQXpmSGVPQTk2UGpoNTd4bE1p?=
 =?utf-8?B?VkdRR2UwYzIzdU9IY0gxM0tnRjFJaURjS2pXODJ4V3hmSTZpNTFyd3d1SzRX?=
 =?utf-8?B?ODdiSmVHaUE2ZEszWFBleTFnbWpaUkswM1dmYjkrU01Jd3FYbWU3RVNOcUU5?=
 =?utf-8?B?Wll5YnBPWWNJMWRtSXlnbGJVcEVJRzlHUkpuOVZpL01FZFVTY3VNWWRTWjBk?=
 =?utf-8?B?WVVIeEJUSXBUbFNrNHNmRzNPOUFZYTBCclBkdURQb1hTamh5MHZ0MkYrci9P?=
 =?utf-8?B?Snl5RHJjSGd1QjA5MTk5ZVJOYzdlK2tnTDZIakM4MU44amZBSm5uUm9KbHgz?=
 =?utf-8?B?VmpzNjRsc2hGbzZKdkhCQnhaRFhPS2NsNWRnWEpPbFRFN1JJc0poVnU3NmJo?=
 =?utf-8?B?TStQdjI4R2FucGxkSEwrWWtRSmRTQnRLdVVGMU11TkxWM1lzR3BydEVhWnBu?=
 =?utf-8?B?aEpacDRjN3FORG01TGdRWUN3R0FReUlsNTAzNFdCSWQ0WXkralFMZ0JmV0xP?=
 =?utf-8?B?eTdNQzJjdnJ0Z2lqZCsxUjVLZUhnT1QvZW9mUGJaWjJOSHF6ZHE3Um5JR04z?=
 =?utf-8?B?anRTSVo2VCtTRXFWSzczMHFrdzUxYlgvTGlvUFI5UmovQnExSlVOK3RzMW9C?=
 =?utf-8?B?QzFXM2hTdWdSZjFDL2dzdEVrMHpQUlZHNng4bmlNWlBiTjQwMm1ocmZwNHpX?=
 =?utf-8?B?eCtmY3lzN1NDWnd2STRxQS9lOFNYRCtZMTh6N1BYTjkvWWcyNlpmT2ZKQjNn?=
 =?utf-8?B?R0xRcHRRb3pxN0tqL1AxZHNnSmZvc1NCU3ByOGdTM3hTdkpZZk00RWluVThm?=
 =?utf-8?B?MFhmS1Zra3VZQnF3ZDJyNmtONlNjMzVzaVNYK1czUmFTdTFJN1Zya0c1Y3l3?=
 =?utf-8?B?bVhtc21NWnJjeWlrRllySEZXMHFOUWtPOW5nemRtaFVxQndtWkVxZ3h2OVVk?=
 =?utf-8?B?NUFwL3JzK2RFUXlDTzNUVjVXMFd2eklKUnZQdGRlQTFhVHdvSEVscmJZUE5V?=
 =?utf-8?B?eUVkUEJmVlZtVXAyWjhuRUlRaTg5L0ZmajBPY2M4VFNyNlo1MHU1cHplSlhD?=
 =?utf-8?B?RTg1c01TZEVyWlRIc0drME9rSlNndWkwV0NzZG9LNzVRRnVaMnRSTWY3bE9S?=
 =?utf-8?B?Y3l1d0UxcGRRTC84elE2M3B3VnBpVE1sUUt1cjJDZWhFRGRENWJqRG9zb2Rv?=
 =?utf-8?B?NTNVK3cxRmdNaEVFZEVncE40d3ZzL1ZHSFptZWhBdmVSNGZlV2xhR29FOGc0?=
 =?utf-8?Q?z94Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa94cf1c-a150-4d6d-2b8e-08dcc2bc8ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 15:10:25.3008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtbiRavRBdY5Fj8KGxXWc0NU2cydxaN0rM0u2k7fgbYeqDKyhGPakvXsdP1Hc9u0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793
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
ZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVn
dXN0IDIxLCAyMDI0IDU6NTEgUE0NCj4gVG86IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBh
bWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEthc2l2aXN3YW5h
dGhhbiwgSGFyaXNoIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+OyBEZXVjaGVyLA0K
PiBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRrZmQ6IGZpeCBtaXNzZWQgcXVldWUgcmVzZXQgb24gcXVldWUgZGVzdHJv
eQ0KPg0KPg0KPiBPbiAyMDI0LTA4LTIxIDE3OjE3LCBKb25hdGhhbiBLaW0gd3JvdGU6DQo+ID4g
SWYgYSBxdWV1ZSBpcyBiZWluZyBkZXN0cm95ZWQgYnV0IGNhdXNlcyBhIEhXUyBoYW5nIG9uIHJl
bW92YWwsIHRoZSBLRkQNCj4gPiBtYXkgaXNzdWUgYW4gdW5uZWNlc3NhcnkgZ3B1IHJlc2V0IGlm
IHRoZSBkZXN0cm95ZWQgcXVldWUgY2FuIGJlIGZpeGVkDQo+ID4gYnkgYSBxdWV1ZSByZXNldC4N
Cj4gPg0KPiA+IFRoaXMgaXMgYmVjYXVzZSB0aGUgcXVldWUgaGFzIGJlZW4gcmVtb3ZlZCBmcm9t
IHRoZSBLRkQncyBxdWV1ZSBsaXN0DQo+ID4gcHJpb3IgdG8gdGhlIHByZWVtcHRpb24gYWN0aW9u
IG9uIGRlc3Ryb3kgc28gdGhlIHJlc2V0IGNhbGwgd2lsbCBmYWlsIHRvDQo+ID4gbWF0Y2ggdGhl
IEhRRCBQUSByZXNldCBpbmZvcm1hdGlvbiBhZ2FpbnN0IHRoZSBLRkQncyBxdWV1ZSByZWNvcmQg
dG8gZG8NCj4gPiB0aGUgYWN0dWFsIHJlc2V0Lg0KPiA+DQo+ID4gU2luY2UgYSBxdWV1ZSBkZXN0
cm95IHJlcXVlc3QgaXMgdW5kZXIgdGhlIHNhbWUgZGV2aWNlIGxvY2sgYXMgYW55IG90aGVyDQo+
ID4gcHJlZW1wdGlvbiByZXF1ZXN0ICh3aGljaCBzdWJzdW1lcyBxdWV1ZSByZXNldCBjYWxscyks
IHRyYW5zaWVudGx5DQo+ID4gc3RvcmUgdGhlIGRlc3Ryb3llZCBxdWV1ZSdzIHJlZmVyZW5jZSBz
byB0aGF0IGEgcG90ZW50aWFsIHN1YnNlcXVlbnQgcXVldWUNCj4gPiByZXNldCBjYWxsIGNhbiBj
aGVjayBhZ2FpbnN0IHRoaXMgcXVldWUgYXMgd2VsbC4NCj4NCj4gTWF5YmUgdGhpcyBjb3VsZCBi
ZSBzaW1wbGlmaWVkIGJ5IGRpc2FibGluZyB0aGUgcXVldWVzIGJlZm9yZSBkZXN0cm95aW5nDQo+
IGl0LiBUaGF0IHdheSB0aGUgcXVldWUgd291bGQgc3RpbGwgZXhpc3Qgd2hlbiBpdCdzIGJlaW5n
IHVubWFwcGVkIGFuZA0KPiB5b3UgZG9uJ3QgbmVlZCB0byBoYWNrIHRoZSBzcGVjaWFsIGNhc2Ug
ImN1cl9kZXN0cm95ZWRfcXVldWUiIGludG8gdGhlDQo+IHF1ZXVlIHJlc2V0IGNvZGUuDQoNClRo
YW5rcyBGZWxpeC4gIFRoYXQncyBhIG11Y2ggc2ltcGxlciBmaXguDQpTZW5kaW5nIGl0IG91dC4N
Cg0KSm9uDQoNCj4NCj4gUmVnYXJkcywNCj4gICAgRmVsaXgNCj4NCj4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+DQo+ID4gLS0tDQo+
ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIu
YyB8IDEwDQo+ICsrKysrKysrKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9kZXZpY2VfcXVldWVfbWFuYWdlci5oIHwgIDEgKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPiA+
IGluZGV4IDU3N2QxMjFjYzZkMS4uMDllMzlhNzJjYTMxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMN
Cj4gPiBAQCAtMTg0Miw2ICsxODQyLDggQEAgc3RhdGljIGludCBzdGFydF9jcHNjaChzdHJ1Y3QN
Cj4gZGV2aWNlX3F1ZXVlX21hbmFnZXIgKmRxbSkNCj4gPiAgICAgICAgICAgICBnb3RvIGZhaWxf
ZGV0ZWN0X2hhbmdfYnVmZmVyOw0KPiA+ICAgICB9DQo+ID4NCj4gPiArICAgZHFtLT5jdXJfZGVz
dHJveWVkX3F1ZXVlID0gTlVMTDsNCj4gPiArDQo+ID4gICAgIGRxbV91bmxvY2soZHFtKTsNCj4g
Pg0KPiA+ICAgICByZXR1cm4gMDsNCj4gPiBAQCAtMjEwNSw3ICsyMTA3LDcgQEAgc3RhdGljIHZv
aWQgc2V0X3F1ZXVlX2FzX3Jlc2V0KHN0cnVjdA0KPiBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFt
LCBzdHJ1Y3QgcXVldWUgKnENCj4gPiAgICAgICAgICAgICBxLT5wcm9wZXJ0aWVzLnF1ZXVlX2lk
LCBxLT5wcm9jZXNzLT5wYXNpZCk7DQo+ID4NCj4gPiAgICAgcGRkLT5oYXNfcmVzZXRfcXVldWUg
PSB0cnVlOw0KPiA+IC0gICBpZiAocS0+cHJvcGVydGllcy5pc19hY3RpdmUpIHsNCj4gPiArICAg
aWYgKHEtPnByb3BlcnRpZXMuaXNfYWN0aXZlICYmIGRxbS0+Y3VyX2Rlc3Ryb3llZF9xdWV1ZSAh
PSBxKSB7DQo+ID4gICAgICAgICAgICAgcS0+cHJvcGVydGllcy5pc19hY3RpdmUgPSBmYWxzZTsN
Cj4gPiAgICAgICAgICAgICBkZWNyZW1lbnRfcXVldWVfY291bnQoZHFtLCBxcGQsIHEpOw0KPiA+
ICAgICB9DQo+ID4gQEAgLTIxNjAsNiArMjE2MiwxMCBAQCBzdGF0aWMgc3RydWN0IHF1ZXVlDQo+
ICpmaW5kX3F1ZXVlX2J5X2FkZHJlc3Moc3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0s
IHVpbg0KPiA+ICAgICBzdHJ1Y3QgcWNtX3Byb2Nlc3NfZGV2aWNlICpxcGQ7DQo+ID4gICAgIHN0
cnVjdCBxdWV1ZSAqcTsNCj4gPg0KPiA+ICsgICBpZiAoZHFtLT5jdXJfZGVzdHJveWVkX3F1ZXVl
ICYmDQo+ID4gKyAgICAgICBkcW0tPmN1cl9kZXN0cm95ZWRfcXVldWUtPnByb3BlcnRpZXMucXVl
dWVfYWRkcmVzcyA9PQ0KPiBxdWV1ZV9hZGRyZXNzKQ0KPiA+ICsgICAgICAgICAgIHJldHVybiBk
cW0tPmN1cl9kZXN0cm95ZWRfcXVldWU7DQo+ID4gKw0KPiA+ICAgICBsaXN0X2Zvcl9lYWNoX2Vu
dHJ5KGN1ciwgJmRxbS0+cXVldWVzLCBsaXN0KSB7DQo+ID4gICAgICAgICAgICAgcXBkID0gY3Vy
LT5xcGQ7DQo+ID4gICAgICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShxLCAmcXBkLT5xdWV1
ZXNfbGlzdCwgbGlzdCkgew0KPiA+IEBAIC0yNDA5LDYgKzI0MTUsNyBAQCBzdGF0aWMgaW50IGRl
c3Ryb3lfcXVldWVfY3BzY2goc3RydWN0DQo+IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sDQo+
ID4NCj4gPiAgICAgbGlzdF9kZWwoJnEtPmxpc3QpOw0KPiA+ICAgICBxcGQtPnF1ZXVlX2NvdW50
LS07DQo+ID4gKyAgIGRxbS0+Y3VyX2Rlc3Ryb3llZF9xdWV1ZSA9IHE7DQo+ID4gICAgIGlmIChx
LT5wcm9wZXJ0aWVzLmlzX2FjdGl2ZSkgew0KPiA+ICAgICAgICAgICAgIGRlY3JlbWVudF9xdWV1
ZV9jb3VudChkcW0sIHFwZCwgcSk7DQo+ID4gICAgICAgICAgICAgaWYgKCFkcW0tPmRldi0+a2Zk
LT5zaGFyZWRfcmVzb3VyY2VzLmVuYWJsZV9tZXMpIHsNCj4gPiBAQCAtMjQyMSw2ICsyNDI4LDcg
QEAgc3RhdGljIGludCBkZXN0cm95X3F1ZXVlX2Nwc2NoKHN0cnVjdA0KPiBkZXZpY2VfcXVldWVf
bWFuYWdlciAqZHFtLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgcmV0dmFsID0gcmVtb3ZlX3F1
ZXVlX21lcyhkcW0sIHEsIHFwZCk7DQo+ID4gICAgICAgICAgICAgfQ0KPiA+ICAgICB9DQo+ID4g
KyAgIGRxbS0+Y3VyX2Rlc3Ryb3llZF9xdWV1ZSA9IE5VTEw7DQo+ID4NCj4gPiAgICAgLyoNCj4g
PiAgICAgICogVW5jb25kaXRpb25hbGx5IGRlY3JlbWVudCB0aGlzIGNvdW50ZXIsIHJlZ2FyZGxl
c3Mgb2YgdGhlIHF1ZXVlJ3MNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuaA0KPiA+IGluZGV4IDA4YjQwODI2YWQx
ZS4uNTQyNWMxZGQ3OTI0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmgNCj4gPiBAQCAtMjg1LDYgKzI4
NSw3IEBAIHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciB7DQo+ID4gICAgIHN0cnVjdCBkcW1f
ZGV0ZWN0X2hhbmdfaW5mbyAqZGV0ZWN0X2hhbmdfaW5mbzsNCj4gPiAgICAgc2l6ZV90IGRldGVj
dF9oYW5nX2luZm9fc2l6ZTsNCj4gPiAgICAgaW50IGRldGVjdF9oYW5nX2NvdW50Ow0KPiA+ICsg
ICBzdHJ1Y3QgcXVldWUgKmN1cl9kZXN0cm95ZWRfcXVldWU7DQo+ID4gICB9Ow0KPiA+DQo+ID4g
ICB2b2lkIGRldmljZV9xdWV1ZV9tYW5hZ2VyX2luaXRfY2lrKA0K
