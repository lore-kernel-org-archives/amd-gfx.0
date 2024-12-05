Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36415E7716D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 12:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B411C10E39E;
	Thu,  5 Dec 2024 12:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CV246NVk";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 004BB10E39E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 12:15:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWwWml0ANTn4Krqqbls39SJ8QEM/9sL66HqA++sqTAEnUNxH4qDzg5+u3gp0OJLJI5y29K4HjKr9w8BFZ0v7fqsnpgxtlHKp3g6K5FWbSYaNT7XRkdcHbsEY5Lvg+f9A71zGg2f5ymxoICwqXK8Zaxc67FZvyJkxoajo4Z5VEi0k0VthPIv1k3uA4U0VH7kDqAB2R42oGx0UlAy/XM2b2PauRpEyY/OgJM/vDTacGhg2KCmsXFVCiVe8ttHkI+T9rmDFL+/iWvdNlSYXMLH1WV8459VIyPyanDAPoaxB7hiu86EUJHKQiWiYu5GAFzfoYBR22NzlziRF4f6jntde6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3m39Ff2ue7uiLN3bIYduq+ZSOwopUwVYxG+up7jbjE=;
 b=p10XalyIh7QagKUT9YNg3KBV6NFIvL+9TTkndYz5YQBWv1eQpYHvi0nA2ayJPeXArZX+74jB36sbebw49Bp2r145I++2LhTQaNT1MMOAQhau62uSH8O0lBMWbaIKkOv4VQ6uzWel+TAIQtiIgwL5874X2ClWyximzL0/hhK6gMdENYbn/6CBUXn3dNIYiMiUwG7oY6BXuIc/6H/ywGHCoR9HLW+TJbRdNZkvuPjw6MFJZ4N6wHUB2LJ5W0PUaJ0JFWV5y5hZCre1GFzAa3Tmvqki35K22Tyz34ErO5YDUoQgp1DVd49KrsA+FSzoIipodIAwQypmnJdjidHY+B5ODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3m39Ff2ue7uiLN3bIYduq+ZSOwopUwVYxG+up7jbjE=;
 b=CV246NVkVAZHb1kUNI8Iz4a69SJEQc01OnBat/iWr8kLzcGSCWmOTJBOzVVebC9o39i6a6bVYOFnoahfuOpuQOEz+tx3adgQilIzj7FyPMtEi5esXSnrUoety3n3tyPyzyVKSEw1fSIXLX/eNqqX4xVg8rd+s+TuJuetlorWIoo=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 12:15:36 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345%4]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 12:15:35 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Tudor, Alexandru" <Alexandru.Tudor@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Dereference null return value
Thread-Topic: [PATCH v2] drm/amdkfd: Dereference null return value
Thread-Index: AQHbRLgZyq26XXtJgUmTZK8ljO3OVLLUlnoAgAIxgQCAAMgZsA==
Date: Thu, 5 Dec 2024 12:15:35 +0000
Message-ID: <SJ0PR12MB8138AF773B64F091BE9B8B39F5302@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20241202124505.1760749-1-Andrew.Martin@amd.com>
 <BL1PR12MB589848536293468002D55C5885362@BL1PR12MB5898.namprd12.prod.outlook.com>
 <c510c8d3-ed30-493b-97a3-5f3d5f324a66@amd.com>
In-Reply-To: <c510c8d3-ed30-493b-97a3-5f3d5f324a66@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ba1d188a-a084-432b-8c9c-aa4dc763c2dc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-05T11:56:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|SJ2PR12MB8652:EE_
x-ms-office365-filtering-correlation-id: d49f22e6-426d-4aa0-8c32-08dd15268616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OXRkZDRsR09jRktRam5ibUZ3dTIrZVBiTW1Jdm13YmF6MjEyK3JQclR1NGlU?=
 =?utf-8?B?S3BvUGpHR1JjbG9GVWdXaDVZUkN0ZHhiaEtab01wSUE3TGpydXY4ejNvMXNR?=
 =?utf-8?B?YlBGUmppK2VpRjF6WXNWL1dJMGxreFhQV3NpV0VjNmxSYXJIYk13SDlnWk00?=
 =?utf-8?B?VjliNmdpRHZ6YlBJeUxyWm1XRXdYY3FITEkyUW1GZlVKa244dWdaUVQ5bklk?=
 =?utf-8?B?TVRkV1g0b3BRSndJR0NGOVlMbktzK25aMjl1d0t6dVVob2NESVIramZrbWQ3?=
 =?utf-8?B?TnFEQUlUZGUzQkx1MFd6aXNiRmt1cVdQYlpLdER5SUtMODVnL0FjeDJaTXB0?=
 =?utf-8?B?ajVVNjIzbzBNaXhxckNCQkw3K0pEblFjOGd1L0l3aENBQ3Z1b2UwN3FKWjFK?=
 =?utf-8?B?TUx4cDA3dmZSdFV0MFU0MXlQWjJoMEdNandVTWhET3ZBbk8vVlptcEpYa3ZY?=
 =?utf-8?B?bTdsR1NzMk42TVNvR1NWMmNnTGZWZDFaWi94L3ZlT09mQW1CUXkra2lCVEpw?=
 =?utf-8?B?aUJORmo1dEp6OTVyd0ZtT2ZVTnhIaVRKSTJyUW5hYklhY1pPWEI0aEFXNUd1?=
 =?utf-8?B?L2gyYlkxZEFrMzZhT1JYM2hLMVdHS3FYU3ltSW5PNzkvZ0NaZC9nc3ZmN0N1?=
 =?utf-8?B?L2huNndtYVk0Q1BKSHFQZEphNi9VZS9uTVpHYjVUbTg1UWhjUG51VmlnZWhS?=
 =?utf-8?B?NW5vSFU2QU8wdFRSS3IrWUlsNERrMUlDK09sUjhGS0txaHFlZmw0dFVqUVpY?=
 =?utf-8?B?cHlPVzVVUjBHOVNiSkJFVllIejJZa1BYRWxKZU1NUVJySEFxM1NVK296SW1w?=
 =?utf-8?B?WXlIcDlVQ043VlpWUWFTTG0yVzJRZnlMWlo4M3ZLbXRiRFNTZG92NCs4cGRQ?=
 =?utf-8?B?bWR5WkxCMG5jejRQdS9OZXFDUXBHM2pSZWZod0kxWkdhMnI2NWtRT0RkdVdK?=
 =?utf-8?B?S3RPazh4QTFFTUQ2aDIwekR4OGpkZXNRRWFnb0d2MkM3blJOaERtS3NMWE96?=
 =?utf-8?B?UjFLbTFFQjdncFM1QVFSTWdTTjhiUVc2SDZnbktlMkFtVGVRNG0xeDcyeUUx?=
 =?utf-8?B?cHdOdEFRM09WRWFJOGkvU1NNWVY3Rk5iSndqOCtBNk4xZ3E0TXh0ZnBiK2NQ?=
 =?utf-8?B?MVFqMVh0Q2JjSTVTS0FvRTViMXhYeGE5S2lkRW53TDBid005a21pUmZGWmZy?=
 =?utf-8?B?TGF3T0swRmFxNklzb3VwSkZRZkpvZWNvMHhYa3VGeSsvenRFN3BIeVNXYXkv?=
 =?utf-8?B?UlZPRVBPVWRhaE1OWERKT0pxdDRkTVFWMmJiVW5IQk5YdG1yQkFxYy9jRFR5?=
 =?utf-8?B?SXJKQTlRVjZHTUc1YmNZYU1LZElVekNNbElSOHUwZ2hQSjExL2Zlb3RzTnhC?=
 =?utf-8?B?RzZKbStkTm1GazZ0N3BsbGNHbURBZ25BYVdGUUx6TWtKUTZ4YUY0R0FjS1FV?=
 =?utf-8?B?Y0xVUmNxaldlZEFRbFlGZHUwT1pTeC9FR1N1MFVDM1RPSEd4bHBNWmFIRjlK?=
 =?utf-8?B?S2d4eStRdCtKZnpVbDBIMHh4V2t6ZjJXNENoeG1IWFRkZFRScGJ1RFRGdDFN?=
 =?utf-8?B?TjdYVFRtWWtNbE9RenczNGlPUzlVcU5NY1lYNlkwTTM3SVZ0WGdkcU1WYXhU?=
 =?utf-8?B?bk1uS1EwSjBiRTR6a3RQYzZmMmpiVGZqR2VqNTdFdE9iNEpXOXFRQWhJMkQr?=
 =?utf-8?B?cVlTSk1hZ2JBd0p3NHMrL0V0U20zUVJadXNTZ2JlWThVV1BYTEZGQlV2cml6?=
 =?utf-8?B?Ymw2dW9wS01rYTZjNUYrQ05jejI4b3UxeUxZZG9tTmE2RC9RZlpPZGg5WFh6?=
 =?utf-8?B?aGM2cXY1bnZCWlZaZmFHOUJMUjF2RzNwSmFpaElnZFNtNnJSRlZzVGkvZTFW?=
 =?utf-8?B?eWJnSVU1c3dwNUpnNG1SMkVseEw2NjNjWmtVR29COFJ0eXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFRYcFh3YXpQdHFyNVUvRFAwcDhXd1ZLMnRSNkNRRmozckJSbXJHMmtkdHgr?=
 =?utf-8?B?ODJrWmt2VjM1TVVWdjVaS2tPWW1pWGl2elVyc0FJWnJtbU5GeCs3WFVLZmNt?=
 =?utf-8?B?c3FjcU8vdjNQRVRvYnJ4akNxeFBSbjJnZkZ2dE5yVHdoRXE3UmJqSEw2NVZ5?=
 =?utf-8?B?NzVkem9KMVhFOVlibFZGWjhPbzhFSkxQdnM1dHhUTU9WVWNpcHdzdXY2cUtB?=
 =?utf-8?B?TDVKcnArSlpvYzVwdlRRVnRrR0ZFaHJhemNwSFMzSmJvN3JoUlZ3b3FtWngy?=
 =?utf-8?B?Yk05V0JxSGZHOU1xVW1pb0pwajRyRmFDWlNOMVlRMGd2ZElnR3E3WHl1dVZH?=
 =?utf-8?B?M0FWaWZxNWpYMlhwNHJTa1N3di9jbGIyRGxuMmRTTS9WREhKR3ppOG5KNHhH?=
 =?utf-8?B?c29BZ1E4Ynl3alVoWGZSU2ZJSE9BMDIzQ2dKTjl1Y3p2cVNyd3NGSGJ4NGpp?=
 =?utf-8?B?MEtaeWVObEszVUNyTHgxajI5L3FiMUhyL2YxcS9UZkV1U2U0VVpvUjg5U0tQ?=
 =?utf-8?B?L3dkZFBFa2FFVTNWYmlTL1czQ05Yak83VWdkQVk1d294bXNSaEdQVUR3Y1VG?=
 =?utf-8?B?OGFMYzVkNlBRMi82b3BWSTRrN2hFeWxXRzdMTkkwZFZZM3FHek9NZXVxa1NW?=
 =?utf-8?B?M3cxUW1JVS9SRFpVVnNIdUNqc3hJQXhzK0FjK2d2dmRnWFMvM3JrZk9BYzE1?=
 =?utf-8?B?eTFsbDI4dWYzSGJ4SE90NGRQeGdiQlltdzhmVWpnVjNKNFA1T3FhZVpadStY?=
 =?utf-8?B?cUtxSjFDNVJ3Q01aSUdSU2VzWkNVMFl2NGhXT21FL094anB0U0o2dXZVUXUr?=
 =?utf-8?B?Y01rL2hpdVBWd2t4WGIzRnM1UVQ5ZWlUWW9NeXpxWHFlT2VQdElRYXVHc1Bm?=
 =?utf-8?B?akxyS3NDT1dsaHhQWlA4V3NQc3FoR21rSm1jMHVtd01KeEdZRVc5VmdnZk93?=
 =?utf-8?B?WmhSemplZitKOThpeGtsS29TM2h3MVhTY3h2Z05HL2ViVW5id0NZcHNZUFAy?=
 =?utf-8?B?RENHU1FCa1pRNkd6QTdDb0FURm9UMGlKMFlRK05WK0VzSWVnMUFnRUVwWDRh?=
 =?utf-8?B?OFdKYWs3VVhwZjVJbVRheDRyWmo3NjJNQTBYQjVnV0R0Vy93TEs5NEIyWnlS?=
 =?utf-8?B?bkZCTkhPcE8vVHNvMkhSNHpWc1Y3YnRrNjlQVXEyM3N0ZkhHbEhkazBDTVV6?=
 =?utf-8?B?UnBDQzQyUEhJTmtXN1lMenJYYVdMc2tKR3BrYmtLODhBeGhqUEdHT2tFT0ti?=
 =?utf-8?B?TUlaYzNVVnlDYjJlQm5NMFEwMHRQcXoybGNNdHpkYVVHZWF2UFlZNHQ1djN1?=
 =?utf-8?B?WDNNTVdCc3E2N2IvdHJ4a2dSZ3NwTTVTVVpaMVlVeDgvNVIvUmNnWDM2Y2hF?=
 =?utf-8?B?NGk0QWJsQWd1OFhjaWZWbmdieTg2Z2VDN3ZQSFdyclllcHhXQ1FjK0ZTTlZj?=
 =?utf-8?B?RWhVVEsxWTE4Mjd4Y0p4bEtPZXRuQVdaS3d0MVR0MU50NmJJTkZUQlBudnFT?=
 =?utf-8?B?K0J5TnJ2QTI3MHBiV3Yvckx6MkY1dnVpV2Q4UG9FTFpyaVB5a0tHNGUrNWVx?=
 =?utf-8?B?WkdWMmFMQm83c1RxTE1VZmxHV3dTUzFXYmJxdWd2NGgrQVo2eDlEanNDdXpa?=
 =?utf-8?B?OFJlZkxzOFhRQVFwRHlaaXQybWk1Ykd3UitEblBxS2xpZlh2VXJSdmJPcmlr?=
 =?utf-8?B?OGZXcWo2YzdHSHNVS3lxSldyeS8wSXdjUlpuNlVMbTJLWE8rWlRVUWpGYTRH?=
 =?utf-8?B?UGZnTmhZdnBWT01xV0p0amV1SGw0QWJDY2crYTVVYTJSTVdHcCtZSkwvMFk2?=
 =?utf-8?B?TzFKT3VmTytReWR1R2d6ZWdUYWtjVnNobGk3dkdyTnFTZCtmUlJ1SGJ5UFpL?=
 =?utf-8?B?Tm5tZkZSckNoaVhneUFwUnl0TG5WVkhQS3hYMmxEajV2OGRzOEFNRlZhOFN0?=
 =?utf-8?B?d0pMZnk2Q2t4a3ZnRm1vdUVJVTh1WmJRSDVNRjVNbWFlWm5SbDhzRFl0aGkw?=
 =?utf-8?B?dnoxYW5CM2M3SVFhL2k2eFJUNTNnaWQxbUFPQmxjcTJTbFY0TXZMbzBYUk5k?=
 =?utf-8?B?MHlUYkEvQS9IckFPbjczY0MwdTNMYjhVWU00R1RBd0FyMWU5RVlnNU0rK252?=
 =?utf-8?Q?SYqA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49f22e6-426d-4aa0-8c32-08dd15268616
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 12:15:35.8952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eysm8VlTvuMBzRWlz6T4W2cQv2EOAnsDQ2sP2eVQK+WSR4lsmaQXuOW6m4dL75IwhP71TOwLj78kbcQZMfdcEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgNCwg
MjAyNCA3OjAxIFBNDQo+IFRvOiBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47
IE1hcnRpbiwgQW5kcmV3DQo+IDxBbmRyZXcuTWFydGluQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogVHVkb3IsIEFsZXhhbmRydSA8QWxleGFuZHJ1LlR1ZG9y
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGRybS9hbWRrZmQ6IERlcmVmZXJl
bmNlIG51bGwgcmV0dXJuIHZhbHVlDQo+DQo+DQo+IE9uIDIwMjQtMTItMDMgMDk6MzAsIFJ1c3Nl
bGwsIEtlbnQgd3JvdGU6DQo+ID4NCj4gPiBbUHVibGljXQ0KPiA+DQo+ID4NCj4gPg0KPiA+DQo+
ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+IC0tDQo+ID4gKkZyb206KiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJv
dW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBvbiBiZWhhbGYgb2YNCj4gPiBBbmRyZXcgTWFy
dGluIDxBbmRyZXcuTWFydGluQGFtZC5jb20+DQo+ID4gKlNlbnQ6KiBNb25kYXksIERlY2VtYmVy
IDIsIDIwMjQgNzo0NTo1NSBhLm0uDQo+ID4gKlRvOiogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KPiA+ICpDYzoqIEt1ZWhsaW5n
LCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IFR1ZG9yLCBBbGV4YW5kcnUNCj4gPiA8
QWxleGFuZHJ1LlR1ZG9yQGFtZC5jb20+OyBNYXJ0aW4sIEFuZHJldw0KPiA8QW5kcmV3Lk1hcnRp
bkBhbWQuY29tPjsNCj4gPiBNYXJ0aW4sIEFuZHJldyA8QW5kcmV3Lk1hcnRpbkBhbWQuY29tPg0K
PiA+ICpTdWJqZWN0OiogW1BBVENIIHYyXSBkcm0vYW1ka2ZkOiBEZXJlZmVyZW5jZSBudWxsIHJl
dHVybiB2YWx1ZQ0KPiA+DQo+ID4gSW4gdGhlIGZ1bmN0aW9uIHBxbV91bmluaXQgdGhlcmUgaXMg
YSBjYWxsLWFzc2lnbm1lbnQgb2YgInBkZCA9DQo+ID4ga2ZkX2dldF9wcm9jZXNzX2RldmljZV9k
YXRhIiB3aGljaCBjb3VsZCBiZSBudWxsLCBhbmQgdGhpcyB2YWx1ZSB3YXMNCj4gPiBsYXRlciBk
ZXJlZmVyZW5jZWQgd2l0aG91dCBjaGVja2luZy4NCj4gPg0KPiA+IEZpeGVzOiBmYjkxMDY1ODUx
Y2QgKCJkcm0vYW1ka2ZkOiBSZWZhY3RvciBxdWV1ZSB3cHRyX2JvIEdBUlQNCj4gPiBtYXBwaW5n
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTWFydGluIDxBbmRyZXcuTWFydGluQGFtZC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNz
X3F1ZXVlX21hbmFnZXIuYyB8IDYgKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMNCj4gPiBp
bmRleCBjNzZkYjIyYTEwMDAuLjg5YWE1NzhmNmM2OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMN
Cj4gPiBAQCAtMjEyLDExICsyMTIsMTMgQEAgc3RhdGljIHZvaWQgcHFtX2NsZWFuX3F1ZXVlX3Jl
c291cmNlKHN0cnVjdA0KPiA+IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLA0KPiA+ICB2b2lk
IHBxbV91bmluaXQoc3RydWN0IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtKQ0KPiA+ICB7DQo+
ID4gICAgICAgICAgc3RydWN0IHByb2Nlc3NfcXVldWVfbm9kZSAqcHFuLCAqbmV4dDsNCj4gPiAt
ICAgICAgIHN0cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2UgKnBkZDsNCj4gPg0KPiA+ICAgICAgICAg
IGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShwcW4sIG5leHQsICZwcW0tPnF1ZXVlcywNCj4gPiBw
cm9jZXNzX3F1ZXVlX2xpc3QpIHsNCj4gPiAgICAgICAgICAgICAgICAgIGlmIChwcW4tPnEpIHsN
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBwZGQgPQ0KPiA+IGtmZF9nZXRfcHJvY2Vzc19k
ZXZpY2VfZGF0YShwcW4tPnEtPmRldmljZSwgcHFtLT5wcm9jZXNzKTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQgPQ0KPiA+IGtmZF9n
ZXRfcHJvY2Vzc19kZXZpY2VfZGF0YShwcW4tPnEtPmRldmljZSwNCj4gPiArIHBxbS0+cHJvY2Vz
cyk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKFdBUk5fT04oIXBkZCkpDQo+ID4N
Cj4gPiBXb3VsZCB3ZSB3YW50IGEgImNvbnRpbnVlIiBpbnN0ZWFkIG9mICJicmVhayIgaWYgdGhl
IHBkZCBpcyBOVUxMPyBKdXN0DQo+ID4gaW4gY2FzZSBvdGhlciBvbmVzIGluIHRoZSBsaXN0IGFy
ZSBzdGlsbCB2YWxpZD8gT3IgaXMgb25lIE5VTEwgZW5vdWdoDQo+ID4gdG8ganVzdCBXQVJOIGFu
ZCBhYm9ydD8NCj4NCj4gSSBhZ3JlZSwgd2Ugc2hvdWxkIHVzZSAiY29udGludWUiIGhlcmUuIFdl
IGFyZSBsZWFraW5nIG1lbW9yeSwgYnV0IGxldCdzIG5vdA0KPiBsZWFrIG1vcmUgdGhhbiBuZWNl
c3NhcnkuIFdpdGggdGhhdCBmaXhlZCwgdGhlIHBhdGNoIGlzDQo+DQpHcmVldGluZ3MgS2VudC9G
ZWxpeCwgc2VuZGluZyBwZWFjZS4NCg0KVGhhbmtzLCBJIHdpbGwgbWFrZSB0aGUgY2hhbmdlLCBy
dW4gdGhlIHRlc3RzIGFuZCBzZW5kIGl0IG91dC4NCj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhs
aW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPg0KPg0KPg0KPiBUaGFua3MsDQo+ICAgIEZlbGl4
DQo+DQo+DQo+ID4NCj4gPiAgS2VudA0KPiA+DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm47DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIGtmZF9xdWV1ZV91
bnJlZl9ib192YXMocGRkLA0KPiA+ICZwcW4tPnEtPnByb3BlcnRpZXMpOw0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBrZmRfcXVldWVfcmVsZWFzZV9idWZmZXJzKHBkZCwNCj4gPiAmcHFu
LT5xLT5wcm9wZXJ0aWVzKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgcHFtX2NsZWFu
X3F1ZXVlX3Jlc291cmNlKHBxbSwgcHFuKTsNCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo+ID4N
Cg==
