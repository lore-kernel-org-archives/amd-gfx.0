Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F287CC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 16:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566A710E19A;
	Thu, 23 May 2024 16:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OIi5YWk5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7461810E19A
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 16:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVWSW7ZRCuhIZHYvYkDG8bWgk/pbGZe/Lm0DvtEqvMKsyjEOkrs9P3WF2QXEAaEZmD4qyfNmiSRAKj8J/41ISX0eO5kHTqYsb8pP0T/ybhfWnpecQn5m8xBCTLVki2BnXAHxGWIBAy0Xk6P0cFFhFUlXgc3jBt9LsrJuw6qVVi+OVSiQFS0z8E4Wq1+hdTT4WiRO+2xIgqn6SGFPoN6bWjxbPC400gY0q3cIj3f48N3Wo2HuTFgN1IcBjMlwAgIMbyejfcUT4De7X1ZB4jp0/3PZHpFastP6nk0sXzOwLKoMqJPWwSjRTlkcEBMox9IeOmJKNHlLyixC+C30unDyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH8jFCVefovLi5C5a+p2zQ6yn2CRr3qSqwMixBJpfzU=;
 b=cgUpR/+HWENKNV6T3fhTnxfiSNhq9lIzvagxICTvX013sw4lbL+irnhP7aaxb6x9Xdz4b6ydHzhzibF1xLyrjt+onpVTMCoNUP7d2mGV4IMDPXLsKe9wKO6XuRT8wL4kVKAHUalib7J5d79RowAHIJY3egAPuggUunwVliA+zlHAHAvm0/f7+5GzhbdV39x8cTKY95Yt8HqhqLC1M6xFysqEDzLaxMF3CRBgfo183A7R8gp+AM7Q6Docu7zLG18Z54xVCP7bY7mlRO6EaSwtMsetIYWnEocuOwTe3XcLTnJDs5BI5goeCWERubVMVwQz1Qt+y16sv05w2mthbAOujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH8jFCVefovLi5C5a+p2zQ6yn2CRr3qSqwMixBJpfzU=;
 b=OIi5YWk5lttJtaH+uLkK0r2s8HBp5W8J0B+awjmBi6uAVUBzYDMdzMw3znI3mCK3rsECDqp4smaIfVxLnrsPJw94qEy3OFooJTaQ2+RMSgGaU7m9eCrEAlHDkqkRQ07eYeGgRwljm/DRQJEY8TnITAq2Kv6v7IToKSK9YkT8xTk=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by DS7PR12MB6047.namprd12.prod.outlook.com (2603:10b6:8:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 16:58:10 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%3]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 16:58:10 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
Thread-Topic: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
Thread-Index: AQHarSKQOzx61bnDt0yx+t8TgYSFMbGk+sEwgAAOy4CAAACuwA==
Date: Thu, 23 May 2024 16:58:10 +0000
Message-ID: <SJ1PR12MB61942426002C44CC636AD5C295F42@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20240523150439.3274992-1-David.Wu3@amd.com>
 <SJ1PR12MB6194DBE65CF492DA12ED5BE795F42@SJ1PR12MB6194.namprd12.prod.outlook.com>
 <47f0ac94-d6cb-4632-9960-0f94832857be@amd.com>
In-Reply-To: <47f0ac94-d6cb-4632-9960-0f94832857be@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fe915213-18bd-4ec2-b3f3-8255593abfd1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-23T16:57:09Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|DS7PR12MB6047:EE_
x-ms-office365-filtering-correlation-id: b12f10e6-9158-4095-85b4-08dc7b4986a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Z1FhQTdwOEVUVlNkdXhLMmJOK1p5ckZoSllNMjV3MXhpL2N2ZFpxdXc3eE1O?=
 =?utf-8?B?czYyTll3d1RLZ1k1S0IrdzJabnltSXFmd3pjYmxlMm5jendwT3A1d1BhWXdm?=
 =?utf-8?B?b3RwaGtxSENDQjFjSHRGc0p1WUlOSHNKSXU1YXk3ekRucjgrTFZMQTBJbDZV?=
 =?utf-8?B?MDBaRVpMT1oyOTVMYjFmMGhwbGZqUUk0R0NBTDQ0V2tPVFE3WWRuOGhlMkFn?=
 =?utf-8?B?QXBoeGtiY1lPRVQwem84M1hOVWFtbFZsN0EzTlpmRkRuYzdMTkNuNjdZQlRJ?=
 =?utf-8?B?NVBRakhoTE9ZUlFsRTJLa2F3Um5WV2RvbjZadlpRNFlZUXRNelNYOVpERkZ3?=
 =?utf-8?B?NXFTSm8xT0xWYmV3Q2ExVW9KdUJDbGZJVGNIaDM4UlpzVCtTdkkwZGN4cmN0?=
 =?utf-8?B?TFhMa2NyZnh2UG5YT3g4di9WM25iWjQ1b1pJd1lsdUxpU1FwaHptVzZXK3BV?=
 =?utf-8?B?a0IvQnB2N1NNUTh4ZmFocmRURDB0d3dkOXdGd3FVV2RRa1hoUnpuYW5RM2FY?=
 =?utf-8?B?MmJFQTN2WUtqZkN5Nk1aanVoOFZkclM5bnBhNDlXeDlYODJkMUNWNEdhR1No?=
 =?utf-8?B?bXI4QjltTW1vcDBXS0oxcFBWZlNSN0lQaGxIcnFKWklTVTN3K3owLzJENXhS?=
 =?utf-8?B?VHdsVDJRQ1pCdlZjdlJRdnIvdWJIS3U2elc5akVWMzAzdHAwbm9ManpJWlpq?=
 =?utf-8?B?WDh1WGlHejZOc0dUd1RpRHhDSHhmd0ZLMWpNWngzU2YwWDJmc2oxRFRpc3BD?=
 =?utf-8?B?eWRtdnE3ZHBLZzFlSndPRTlpcVAwMEFPa1hEZEVQVHVWZ1RrcXYwT2k2YXFG?=
 =?utf-8?B?MGlsZlI3cWNLTXlqZTFRakdYdmFMaVM0Y1BQR3hRQU9KaWJDYWhjYUJmcElU?=
 =?utf-8?B?NzQyTjlhSTBaUlhKY2d2RmpwbWVpRkN6VlBoaHdNLzBBb1ZUaEphTy8yOEsv?=
 =?utf-8?B?emFRcUx4cDVmcmdCVnJadXBKZW0wWGs0QVUzd2xVZ1lDMTlhOGFJOFVRZmFl?=
 =?utf-8?B?Y1dUMzZlK0w3VGVYV0x5VGd6c0l1d0hVTWhuMndJcGY2ejFjWmtJV25ZN0FK?=
 =?utf-8?B?cWdRNUI0Y2cwVXI2eTRYUzVzNFY1MFN3LzZ4amJRZHVEMUJ5UXJ2NUhkWTVN?=
 =?utf-8?B?dlhjUm9nM0VmMlNiY3lrMkR1dEdqYVpnUU5Ed0J5b09sWDZBMGlrb2VOSlZh?=
 =?utf-8?B?VXdIb3A5RTZWNDNJZzZaZFhOME9WL0VGNzh3NllUaUdrZ3F5U2tNTUJwVWJN?=
 =?utf-8?B?c1VvZWIxVE9ZbUgwbE5UNVFXaDJORlBTYmJHbGlTb1FEM1NYR0ZYd3BRWUcr?=
 =?utf-8?B?cjdCYlR1Q1pZeUxCamtETXNzb0psOUo1eTZIV0l3TWc4aVJzR09oaEVlejc1?=
 =?utf-8?B?MWlHOWFrcjBVRXlxUkJQS0xNMGQ2alhWQ2c0WkxyMmpQNHMyY3NiZlk4NlQr?=
 =?utf-8?B?RzhOanppcnU0REtxNkFYWklPUjJTSTlpbUFxYmhKaG12MHJ2S2RiRkJGdGtw?=
 =?utf-8?B?ZGNjNlYrMzYwQWUyWUdUU2o0a0V0WmRmQUY0WXFoUm9obkl4Y3BUbG9GRk1G?=
 =?utf-8?B?V1c1RUt4by9LdEx5VUJCVGJ0R2lkY0lKaHBaRm5MZ1dNSjZSVUNhaXVvTkNl?=
 =?utf-8?B?UHg5QUtldE10c1dvTzNtN2JDa2M4SmU5cDRyNGI0K1Z2M3BLdjk3Wm9UWjVy?=
 =?utf-8?B?b0x4RUd1bytMYktpcmZMSFpTTkphV0ZXZGgrSXlxVFFiR2lLeDJVeXgxNW8x?=
 =?utf-8?B?NHZOSm1WbVFlUkFSKzEwSUZ5Uko3NjFVeEtQZmxwQm91aWJlYUJvOGFjVEw2?=
 =?utf-8?B?OWhmaURqMnROck5zWXhiUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1Z6bERBOUZvNXp0bWcyNXJaRHhyc21FcXFhWlA1L3JYMDhKUlNpNzJ0RlU5?=
 =?utf-8?B?UmFTRFpYdFNqeTVFZWpKZDd1eDhTWWNXUFg4OVFqL1UwNzFrTllKV1RNYkg4?=
 =?utf-8?B?MEpVQmdORHl4czlaWldDajlDeVJWUnE2N2VCNjNrU0o2TkJoa0VOU3dWWnFF?=
 =?utf-8?B?dGxZR3dEakZqNWVONlJJY3B4cWxkaUg2YmpGR3E2eHJjUkxJSTN5U293aXNW?=
 =?utf-8?B?dWR1UmtIMDJzNVJVMERqRk9ZRzU2dXh0WkVVbDcwS3QxUkswYU5Sb1cxYWNQ?=
 =?utf-8?B?VCt5aEdLNXhzSTJ0U042QzhHd0dlbFVSV3VkaWg2Y3FueExrUG5WQlJTbGpC?=
 =?utf-8?B?NHdkdytWdVR0TkFIYzROem9nWWlocU5EZnducXhXcm1JLzhFbWJuSW1zdXlO?=
 =?utf-8?B?eTVWbFRyVUJFUk9hMmRBb3o1QTRqaWUrQS96VTRGNS9aU20vMWFiNGt6bzVw?=
 =?utf-8?B?K0VOR1U3Y1p0c2pKODQ5aVFERklkZUk1SzM1bDMreklBOXJ1bXBncDUrNjRJ?=
 =?utf-8?B?RlVHcWZCcFg4b1l0TERjTHU4a3QydStXWk1Qdk9xeFFvcVhNOWtlQnRVaU9k?=
 =?utf-8?B?akF4Q1kzQ1hSVmJMWU5Zc2ZsQzRTTkpEbU5YTDkxZGY0bHFaTzBnblFuUU5m?=
 =?utf-8?B?bEhuQU01OUcwTkc0Q2thYk1wbUp0NDBvOERiUFhsNzQ4Ynp3dGV3QUhicHdh?=
 =?utf-8?B?ZG5wdHpnbWxMeTZaaWg5SW02NTlqcXJzQy9SN3RMNkorZHZxZUl2a2l3TWhZ?=
 =?utf-8?B?bnM0Tk5oSnVmdVd0cWhtOHlvQ25ZblpTbUVsRWVFT0toRTBlcmVmZW9NblBQ?=
 =?utf-8?B?T1J0SVJ3RklOdStadlBDL3Z4VVVaUU9zZ3k0NlpUOUtJV01FaE0xSS85dklq?=
 =?utf-8?B?bFZUWG0wdkhJZnNFTnZrTnVldG9VVFRRcFZ1TXdFUDRZUitaL0tSWFp0Zlh3?=
 =?utf-8?B?YTJLQ3NkbWlvaU5JY3U5ejhaL05uWUVjRnRsUUpicXBvYkRqQk1kNGIvWGVF?=
 =?utf-8?B?bkdieU9YOUVHWjdYbkFHSlVQamQ4Y1F6T2VtUytScm9mci9OUEg1U0JkdkRU?=
 =?utf-8?B?b3k0cGtUZmJ6alhHb1BCcTZGK0IySXhndmNMTnQ0QnlwWnZyUDQ3M1dPN25z?=
 =?utf-8?B?T01ZZEtBeXlPaGdONmMxbU9ra25rU01CVmw4S3VvSGhWbW9VaE8raGY5cEpz?=
 =?utf-8?B?VEhqZjlocFNkTTNiZHFmQUtLMTF1SDhtTjh3OThwYWdTVlNiMlA1VmpRRlhZ?=
 =?utf-8?B?c3J3U2RDOGF5Z2N6WmJLWi9kTzZCTWdWWFVUWVd6cnV0TFBQaWJUbXNjbWMr?=
 =?utf-8?B?dTVVQVdkVEZyTEcyS3dia2I5NWVuaUcxbFBhV05BYTJtc1AzRVFBL1p2QzQx?=
 =?utf-8?B?KzZacnlIY3NuTjRDWUlvNE1sQll6dzN5TzI0UTh0UU1FWlFubWNVWGNOMWVT?=
 =?utf-8?B?eVkzeDFtNFhvbjRvVjRqeno4OFZMZkpHdlgzTjUwL0I5LzRka0ZiMHV3SlNM?=
 =?utf-8?B?Q211QnB6b2tyVlBDU0FpQU1ta1dxbHc1QTNHSy9TVlFKZFFoQUtQZjZ5WVg4?=
 =?utf-8?B?VWZYQndReWhDSk80WGlpYTZzZldNYjZib3c5dWhiRXdsNVNUdUdER2Z6Sk5B?=
 =?utf-8?B?RFFQYmdkZXNuMUdDNHNoMDh4cWpZeFh3V1dWSEQ5OGJvZU8xM2dnTEhjVWRS?=
 =?utf-8?B?UHpKaVZIUDFIUWpsSlF1cTczdjZZUzdZdDJia0xERzQ4MEY0eERMeTQ5bTU3?=
 =?utf-8?B?OGJvcGs2NW9PcmszR0Y4eWNZR1B1c251N0ErTlM5bzNON1BTNWdrS2FxbkhJ?=
 =?utf-8?B?UEV2WWFhbW9YeTV3eEFEcWpBOGNjenBtY3RUU2MrQ3d5STUvTFJSRlZjT0pW?=
 =?utf-8?B?YW1mRFBSTE9GZ1QwczZieEZVRWlhbWVwMmF1SHRZNnFSL2YvR3o2dllIWGs3?=
 =?utf-8?B?d3NkT0lSK25sL3NtZVVUK0pJSmhTdUVwaGZxTnlLYkRvWUF1VXk2dmhzdFRY?=
 =?utf-8?B?ZURoUUNoTXlMRk5ScFV3ZHgxYktYTmRsUUl2TWh1eWlpQzNycUx4cXZHTkV4?=
 =?utf-8?B?VkRuQ3I1a3FEKzZDYmthWUxPY0w3ZWdtcE9HdHF0dDkzU3dDdGFGaUlnZ1Fz?=
 =?utf-8?Q?kWps=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12f10e6-9158-4095-85b4-08dc7b4986a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 16:58:10.0952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqZMqZqmVLXnsm0dLeAk4Rj297+6BXDE0+8OHaapbKrHr6kTB/cB4f/1E8SDeWhM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6047
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
Cg0KVGhhbmtzIGZvciB0aGUgcmVzcG9uc2UsIGFuZCBpdCBsb29rcyBnb29kIHRvIG1lLg0KDQpS
dWlqaW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBXdSwgRGF2aWQgPERh
dmlkLld1M0BhbWQuY29tPg0KU2VudDogVGh1cnNkYXksIE1heSAyMywgMjAyNCAxMjo1NSBQTQ0K
VG86IERvbmcsIFJ1aWppbmcgPFJ1aWppbmcuRG9uZ0BhbWQuY29tPjsgV3UsIERhdmlkIDxEYXZp
ZC5XdTNAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLb2VuaWcsIENo
cmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KQ2M6IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpdSwgTGVvIDxMZW8uTGl1QGFtZC5jb20+
OyBKaWFuZywgU29ubnkgPFNvbm55LkppYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBkcm9wIHNvbWUga2VybmVsIG1lc3NhZ2VzIGluIFZDTiBjb2RlDQoNCnBs
ZWFzZSBzZWUgaW4gbGluZS4NCg0KT24gMjAyNC0wNS0yMyAxMjowMiwgRG9uZywgUnVpamluZyB3
cm90ZToNCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRp
b24gT25seV0NCj4NCj4gUGxlYXNlIHNlZSBteSBxdWVzdGlvbiBpbmxpbmUgYmVsb3cuDQo+DQo+
IFRoYW5rcywNCj4gUnVpamluZw0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBXdSwgRGF2aWQgPERhdmlkLld1M0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5
IDIzLCAyMDI0IDExOjA1IEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsg
S29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpdSwgTGVvDQo+
IDxMZW8uTGl1QGFtZC5jb20+OyBKaWFuZywgU29ubnkgPFNvbm55LkppYW5nQGFtZC5jb20+OyBE
b25nLCBSdWlqaW5nDQo+IDxSdWlqaW5nLkRvbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBkcm9wIHNvbWUga2VybmVsIG1lc3NhZ2VzIGluIFZDTiBjb2RlDQo+DQo+
IFdlIGhhdmUgbWVzc2FnZXMgd2hlbiB0aGUgVkNOIGZhaWxzIHRvIGluaXRpYWxpemUgYW5kIHRo
ZXJlIGlzIG5vIG5lZWQgdG8gcmVwb3J0IG9uIHN1Y2Nlc3MuDQo+IEFsc28gUFNQIGxvYWRpbmcg
RldzIGlzIHRoZSBkZWZhdWx0IGZvciBwcm9kdWN0aW9uLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBE
YXZpZCAoTWluZyBRaWFuZykgV3UgPERhdmlkLld1M0BhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgIHwgIDEgLSAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvanBlZ192NV8wXzAuYyB8ICAzIC0tLSAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNuX3Y1XzBfMC5jICB8IDEwICstLS0tLS0tLS0NCj4gICAzIGZpbGVzIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPiBpbmRleCBiODk2MDViNDAwYzAuLjVlMmI3YzM0
MDcyNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zj
bi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPiBA
QCAtMTA3OCw3ICsxMDc4LDYgQEAgdm9pZCBhbWRncHVfdmNuX3NldHVwX3Vjb2RlKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElQX1ZF
UlNJT04oNCwgMCwgMykpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiAgICAgICAgICAgICAgICAgIH0NCj4gLSAgICAgICAgICAgICAgIGRldl9pbmZvKGFkZXYt
PmRldiwgIldpbGwgdXNlIFBTUCB0byBsb2FkIFZDTiBmaXJtd2FyZVxuIik7DQo+ICAgICAgICAg
IH0NCj4gICB9DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9q
cGVnX3Y1XzBfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192NV8wXzAu
Yw0KPiBpbmRleCA2NGM4NTZiZmUwY2IuLjY4ZWYyOWJjNzBlMiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192NV8wXzAuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9qcGVnX3Y1XzBfMC5jDQo+IEBAIC0xNDUsOCArMTQ1LDYgQEAgc3Rh
dGljIGludCBqcGVnX3Y1XzBfMF9od19pbml0KHZvaWQgKmhhbmRsZSkNCj4gICAgICAgICAgaWYg
KHIpDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIHI7DQo+DQo+IC0gICAgICAgRFJNX0RFVl9J
TkZPKGFkZXYtPmRldiwgIkpQRUcgZGVjb2RlIGluaXRpYWxpemVkIHN1Y2Nlc3NmdWxseS5cbiIp
Ow0KPiAtDQo+ICAgICAgICAgIHJldHVybiAwOw0KPiAgIH0NCj4NCj4gQEAgLTU0OSw3ICs1NDcs
NiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGpwZWdfdjVfMF8wX2Rl
Y19yaW5nX3ZtX2Z1bmNzID0geyAgc3RhdGljIHZvaWQganBlZ192NV8wXzBfc2V0X2RlY19yaW5n
X2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAgew0KPiAgICAgICAgICBhZGV2LT5q
cGVnLmluc3QtPnJpbmdfZGVjLT5mdW5jcyA9ICZqcGVnX3Y1XzBfMF9kZWNfcmluZ192bV9mdW5j
czsNCj4gLSAgICAgICBEUk1fREVWX0lORk8oYWRldi0+ZGV2LCAiSlBFRyBkZWNvZGUgaXMgZW5h
YmxlZCBpbiBWTSBtb2RlXG4iKTsNCj4gICB9DQo+DQo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBh
bWRncHVfaXJxX3NyY19mdW5jcyBqcGVnX3Y1XzBfMF9pcnFfZnVuY3MgPSB7DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjVfMF8wLmMNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjVfMF8wLmMNCj4gaW5kZXggMzZkNGNhNjQ1YzU2Li4w
NzBiNTY2MTBjN2QgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zj
bl92NV8wXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjVfMF8w
LmMNCj4gQEAgLTIwMCwxNiArMjAwLDEwIEBAIHN0YXRpYyBpbnQgdmNuX3Y1XzBfMF9od19pbml0
KHZvaWQgKmhhbmRsZSkNCj4NCj4gICAgICAgICAgICAgICAgICByID0gYW1kZ3B1X3JpbmdfdGVz
dF9oZWxwZXIocmluZyk7DQo+ICAgICAgICAgICAgICAgICAgaWYgKHIpDQo+IC0gICAgICAgICAg
ICAgICAgICAgICAgIGdvdG8gZG9uZTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IHI7DQo+ICAgICAgICAgIH0NCj4gICBbUnVpamluZ10gQXJlIHdlIGFzc3VtaW5nIHRoZSBodyBp
bml0IHByb2Nlc3MgYWx3YXlzIGJlIHN1Y2Nlc3NmdWw/DQoNCk5vIC0gaXQgY291bGQgZmFpbCB3
aXRoIGVycm9ycyBhbmQgaW4gdGhpcyBjYXNlIHRoZSB0b3AgbGV2ZWwgd2lsbCByZXBvcnQgZXJy
b3IuIE90aGVyd2lzZSBpdCB3aWxsIHN1Y2NlZWQoYW5kIG5vIG5lZWQgdG8gcmVwb3J0IHN1Y2Nl
c3NmdWwgbWVzc2FnZSkuDQoNCkRhdmlkDQoNCj4gICAgICAgICAgcmV0dXJuIDA7DQo+IC1kb25l
Og0KPiAtICAgICAgIGlmICghcikNCj4gLSAgICAgICAgICAgICAgIERSTV9JTkZPKCJWQ04gZGVj
b2RlIGFuZCBlbmNvZGUgaW5pdGlhbGl6ZWQgc3VjY2Vzc2Z1bGx5KHVuZGVyICVzKS5cbiIsDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgIChhZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JU
X1ZDTl9EUEcpPyJEUEcgTW9kZSI6IlNQRyBNb2RlIik7DQo+IC0NCj4gLSAgICAgICByZXR1cm4g
cjsNCj4gICB9DQo+DQo+ICAgLyoqDQo+IEBAIC0xMTIyLDggKzExMTYsNiBAQCBzdGF0aWMgdm9p
ZA0KPiB2Y25fdjVfMF8wX3NldF91bmlmaWVkX3JpbmdfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQo+DQo+ICAgICAgICAgICAgICAgICAgYWRldi0+dmNuLmluc3RbaV0ucmluZ19l
bmNbMF0uZnVuY3MgPSAmdmNuX3Y1XzBfMF91bmlmaWVkX3Jpbmdfdm1fZnVuY3M7DQo+ICAgICAg
ICAgICAgICAgICAgYWRldi0+dmNuLmluc3RbaV0ucmluZ19lbmNbMF0ubWUgPSBpOw0KPiAtDQo+
IC0gICAgICAgICAgICAgICBEUk1fSU5GTygiVkNOKCVkKSBlbmNvZGUvZGVjb2RlIGFyZSBlbmFi
bGVkIGluIFZNIG1vZGVcbiIsIGkpOw0KPiAgICAgICAgICB9DQo+ICAgfQ0KPg0KPiAtLQ0KPiAy
LjM0LjENCj4NCg==
