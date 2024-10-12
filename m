Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC9CD1A44A
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Oct 2024 08:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3621B10E308;
	Sat, 12 Oct 2024 08:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BPNMdVxq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568CD10E308
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Oct 2024 08:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/nuYvr5fKq5fCp4hxr5RKBN2eEK2CtAWMTTHv7HoSTpUeVzrT/i3GsDosWLu9uypZFnZNROnXz7XjczZEQ+VthsaN+d5XXwxtv15+i8VSz8IM02TwERFiOG8UxhzDlSGnFLQYUDGzJF6G7DB6U+PQsH+HVDeXuPZGl/lrS/CPudAgYwxBI9ke6Ad4DgBGbDeiQ465alHx8NS+DShVwMbCF8CDB3qZmZtwEctX+7vnzLr3P3QFVQTPaITbZ4yi1FGDWFfWbTlkIs+uX63I9IUEI/HBFufRlBU+l9VhX6XqxAWpQjD+uIirjelTYtnqqoofAnbehQgkzX/nlcC+dx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5RPSFQ/PcB9vgV3OBRKHsaYOzWYpFmTFXUB6LOfl30=;
 b=PQ6RBNJRa4Y2Nb22hsFGrFp2TGniwNt9pISENi0bo3RYI42jQM5w7PH6Ozuxp7TuAY+RQJnGpgr/EdojAmsy96FSlhuE4h+RgOFyrvgW/ananBXPdJjUdEcXEJwsOdtK503qzyuS4lXSdWZ0q0uXBLO3Xjikx0FSm8eMqUHMq1o6M7CHIu4IJuND+uTgWm8CpLcE2VQkyVfgeYAk6c4lcT6Dc2LXMFZrdUDVk9kOGqfGHR3DKxNLpGXecqwzzd0haH9nYQ1XtqAsOW+7zyim+s8ooxn/PPbJBtzpfD55b99IPJw0WTqOgnigCYPlp8oqFD5VdWYzPYBST/mxfYyjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5RPSFQ/PcB9vgV3OBRKHsaYOzWYpFmTFXUB6LOfl30=;
 b=BPNMdVxqk4Dc7ADaB/HROE/k4xJi/ydWcpooNSjY6SizU6OS/uDqnvqLIp35jZ3chh20PJVNfxY8sxvUnJKsXCkw6oOFKUQOGsBQ0bIN0M4vtD07AFb3Ut3NVYepzJ9PXtBGTptZcDIXp7DHD4225taH4ceiLrjv4ItH1jqtzQs=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Sat, 12 Oct 2024 08:03:50 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 08:03:49 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: correct the S3 abort check condition
Thread-Topic: [PATCH 1/2] drm/amdgpu: correct the S3 abort check condition
Thread-Index: AQHbG6L/pwDiEFCe1EeFS2UBmV2GnrKBRo0AgAFqhAA=
Date: Sat, 12 Oct 2024 08:03:48 +0000
Message-ID: <DS7PR12MB6005DAEFE6CDC4888FF3037CFB7A2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20241011060106.1745314-1-Prike.Liang@amd.com>
 <124d02ee-2ace-466f-b9ef-47e71bc162f4@amd.com>
In-Reply-To: <124d02ee-2ace-466f-b9ef-47e71bc162f4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1cb586b3-450d-4fb4-901b-f6c7e8e1f54c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-12T06:58:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MW3PR12MB4459:EE_
x-ms-office365-filtering-correlation-id: 12432037-18d0-4039-fa71-08dcea94675a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R1M1c0pZTE1tRVMrVTd0elBYSHF4aGpKdU9qQUpMR0F6SUxxeGFXNXcwNkpx?=
 =?utf-8?B?MGFEcDhXNld1QlExbEM1OGJ4WnYvQkhEMDFvcXVFU3gyQzRoS0NnVmtwdWV0?=
 =?utf-8?B?R1FvSDFlQ1dFcHF0cVlmejJCaDYwNSsrTUF1a2lmdkpzS3hTNC85b2M0dklX?=
 =?utf-8?B?a1k1VmJZMFBPcDVyZ0ZlbmRVTDR4elpZRGl2Ky9xZFg3b042OGFKbFBWdzVx?=
 =?utf-8?B?N1JDdDFLTy9maEtyQnZ5c1hjUktCR1lDMTRjRmFXcTdSQlprTTJCUnFwcmFy?=
 =?utf-8?B?K25nMlhpV0pzQitGZmdUZkdUWmNLSytDcTVqbnZveHZsS2dKNkNDNHUvaVFq?=
 =?utf-8?B?V3VOMWhvWU9VVFZGdUNMYXBSbjlvOCtjTkNxWmROMUJRaDRKUmJSNUM1NEFQ?=
 =?utf-8?B?MGJRR0sxS25CNkRha3RheUlMN2lUVE9MdWN1djEya21qUXVGWnZhaEpTVStL?=
 =?utf-8?B?aG45M2JWMm93cGxOU1llTkdmQ3cyNVlYVDhWcW9rZmVHU283ZkpFOXR2dW9s?=
 =?utf-8?B?RlkyaDB2cXl2SVVFSDA1Qk10S2Q2dEZSRndUb1RaVUpncHVjUm9sem5yY09F?=
 =?utf-8?B?RGlxcVF3OHIxb2FmZS9ucExveWJwN1p3RVhuSU9GSkdsR2x2QnA3cWdRU1cz?=
 =?utf-8?B?OEJSRFc4MFJuYjhQRE5xZlI3THZ4RkIzRG9QR2J0YWl5SktQUXgralAvVzNF?=
 =?utf-8?B?S21VTkEwdHFzSzdNVXVZZ1FQNkZhaFZ4Tk1oMEh6TDRkMTA1VTRmVnlsaXU0?=
 =?utf-8?B?ck9kZElJbHhKNndEemxZelJpbTQ4OGNtUVFIdHBSVDFoVDhHK2Nvcm8xdkE3?=
 =?utf-8?B?WU5Oeldwc0ZxOXRUY3ZZYTFmMm9zQVQyN1JpS3hKemZWbzAxeVJncEMrRUd2?=
 =?utf-8?B?RjhVa1lVQnZPdFlJN3BWQjFzTzBkV2NkME5paGxGZFFRTWpOQnJ0WGQrN1Z3?=
 =?utf-8?B?SGhOTjdZeHFpVmtnNm52SkVZU09vaXdWUTdsSWJDbFE3ZDVhMEw5WDd3WFlT?=
 =?utf-8?B?dnRhS3JXQmZ2WCsrUzU1bFI2Q1cvM3lidUptQkwxQVdSbzNqTnVLaHpOTmx0?=
 =?utf-8?B?cC9kd21MbUpGclFIeFA5S3d2SkFXWVpmMW5XbEdkR2pSYk9saUFZZE5JSVdS?=
 =?utf-8?B?d0FEbk1wbzh0TnVBUjI5andaaHNOc0VJNWpZbGJ4Z284MWdqM21KdFlQMkNa?=
 =?utf-8?B?MFpscnR4bVVpRkEzb2NQNVcxS2YxRW8xM2VBZnZsZmlJTy9POUtZRktiSXZN?=
 =?utf-8?B?bU1vYlYrQTRMSW9zUDJuWFBmTllLRjJIUU9KVHNtR2tRRlE2bnZQL1NEc0tz?=
 =?utf-8?B?QkVFQkplUVV4bHNqRHY5em9XelBHZlJNV1BvS3VObzZaQnJCQmNBVGxIbFBz?=
 =?utf-8?B?L0tZa0hiZ2IyR1EvQVVIWmQ3MTRpMEJDQUJ3WlIzY1BTVDJNNGk3OTBEZXRG?=
 =?utf-8?B?YmFpcnFUeWxQb2ZlbzI1aHJheE9lRVh6YzRZa3ZxWlNRMHFvZm1RSWExT3BF?=
 =?utf-8?B?c3F3RFpQNzZqMS92TURjdzRCUDBNcHRzYzBBcWpaK290b1Uyb2czUEhyT1FL?=
 =?utf-8?B?eFJYZWdOYmhRQzVwSHBrcXZUOUxnVEZURnJveEhrRmF5T01zckFBYWlqblox?=
 =?utf-8?B?b0hJRFFGZmhzNUk4aXgwQ2YyWDNGMFR6VWtTNDZTQW43VytaNFBNQlFGNEc2?=
 =?utf-8?B?N3pGY2lSbUF3aWJKQ2toTDZRamhJNlFRNVo3cnZibmEvMEt3cGFRS2k4OXBT?=
 =?utf-8?Q?0WJTVk8H3RgtJK8q9AFfNsZwWeLbkQiKjgCUUFL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG1rY0JIUm8rWksrSXBRaUUybWdMaU5jWlhNYXFTWEN0YlRYVGtRbDBHaEVD?=
 =?utf-8?B?VVZpYjFabWZFWnBMRVhuTXFxSGk0LzB5MUlUSHQ5eThUb3RmYzBmdWN2SGds?=
 =?utf-8?B?WEtRSHZDb2doWHdkMXBIWWZKRFExa3RqYlhrb3pTNk1KendYOW40RS84Y1FZ?=
 =?utf-8?B?NjF4ZEs0SFNuNURVS3pReGZoUVlWUDU0a1ZIRWp3WXo3YmtXYXF1bnkyQXV0?=
 =?utf-8?B?dGZRVmsySnZ3UXRQQmZqMUlDdWZCcWU2cXAzdzJXZHM4dGwyZVFWRDk2RXhT?=
 =?utf-8?B?ck9uQitDS0l0aXY1NVdYMjVvaEdpd1J6Um9pTW9oajBJcmVLRVBlQ25sblN2?=
 =?utf-8?B?ajlVazdsNXpBWFVtTUt5bkFCUVlZTEZxQUhCNTg3NXhaWXZiaUl2a2tvdlZh?=
 =?utf-8?B?QlhTQkxIWUU2d0kvOTQrL2NlT0lqWWlFU05DTzdhZVhsdGhValYzNHY0SStq?=
 =?utf-8?B?YmpDWkpsY3NOV0RDK1NSOG52dkh0aUVtQVNQaFFtZjR5VFBlRTM0eXJNZWdX?=
 =?utf-8?B?OEJUTFFBWi9kbysveG9WSXZRajNHZnV6MUhSNDRCVzlYUDRXWDBTNEl2U2ZG?=
 =?utf-8?B?empud0pncFlBTmR4Tm1HWk5HUWkxZ3J4TG5oSTNEb3ZremhZdWx6ZHhoaWVG?=
 =?utf-8?B?MWhnZG5XZFhMSHE5MmdaaUJJcnl2VVEzSWo4WE1tTHROdTJyS0VQRmlXaGM3?=
 =?utf-8?B?cWlHV1B5Q3ZBamFOaW9LYnpPdHVTWUhaSDBYRFFJVFR1SHQ5NDFpUktrTnlX?=
 =?utf-8?B?QkxsQUIrZlljVEVHa3RhUXNVYWZkWEhrTXR6TFB3bWY4OGFLcUUwclVDVGRa?=
 =?utf-8?B?RkszMHZRQ0k2MTZoa01ETklnVGhmUzNua09kSWpFT0RTcjFJcVQxVTRTaTU4?=
 =?utf-8?B?TXR5c2tyUmM1ZjhyN002VWx0SkJIMm5maGFjcjc0d3h3b2wzYkRDaEJWeFFO?=
 =?utf-8?B?TllwM2VpWmJzVWQvZDdhVnNkRWd4K2VBNlI3Y2xuUU1nSDBoNWhLRG9sb1Bh?=
 =?utf-8?B?TGdaVVR1M0FPRVpGNzF1WGZoWHI0RGs5dm1kK0k4L1FQY29RcjF5RW1TeE1k?=
 =?utf-8?B?VGFMMnpWeHBBT1I5M0hwT293VlVUeEdtbnZaRndxN0ZjUHl5cmtKRHF2c1Q4?=
 =?utf-8?B?NWMyMnoxQ2p1SFZ2N1ZETnRMTEtQQzMvWU9wenljSkRxN2owNlpscUcwbHc3?=
 =?utf-8?B?OGxUOVpNSXE5S3AxT2RpMUhBZGUvZVBJODBRN0taSERHM0NNaU9lQ1V1aSsx?=
 =?utf-8?B?RFYvRVBLUWhFbjBnMnhNM1ltUnJvM0szOU9xYmYzMzA2S1NHZExITDZZSUJr?=
 =?utf-8?B?OVg0d3JQMFoxRGhRRTJRYmU2SlpRaGVVbEpMSW9xcytRUmtyYzAxaU9ZZEF4?=
 =?utf-8?B?aFhGeEd2dEFPaSs3VGYwdmpSQUVuSWYxaGFIeldLclMrZ1VkMVF6bU51N3FY?=
 =?utf-8?B?L3pKMnUzTjdyL2NER1E0RkFDTGJjQm9FZE85WTZHYjA1cjkzVUFzS2dmUTRR?=
 =?utf-8?B?ZXRKckREd1lRRU96V1JrMmNtYmt2eU9xWkFmc1RtSy9idjB1Y0lmNDRrSG5D?=
 =?utf-8?B?ODRsQy92Z29OV3NBMzRXWkVxNVJpSXB1ZHl4by8vUFhpZ1pWcFE5RXBFcWRn?=
 =?utf-8?B?WnEzaUcrQlJPZWN3M1dpNmVuUWVHRkc4ek42YUkydzBGTUVZcnlVWE9FRGRv?=
 =?utf-8?B?TWVLRzlyQm9ERENsb3JCYTNxTFAxNUNUQmJCd2JVdzdNcjZSRTlVR0NybmFN?=
 =?utf-8?B?Qnhwbk1pWFR3bVNYVEtEeEVQenU4VXBFQmZkOVE1eTNEYWtKdjdvTCtiOCtK?=
 =?utf-8?B?M1U2U2svTGpmY1M3ODBNUmdzQ2lOT0UwVitBZWllZ2d0VExIUS9UNGoyeVI5?=
 =?utf-8?B?SHJWOC9rVktuZWZkZHM0ZTkwb2t2STZLcXE3UEMzRlNIeWlNZTg4NlNGM3VR?=
 =?utf-8?B?aExMZXp5SEszcUsvallQR3Nzb3dqV2lqWkhkVHova2d2Tk1tSHRMOWhYdVJx?=
 =?utf-8?B?ejFnZkxsdmRrUWFmRFVmNFdwcWs4Ukh5SDdwR3A0alVNR2ppSlJqZDhhN0NO?=
 =?utf-8?B?eGM0eXlGWEdYRVBaZ0xJa0lFRGNBMEZXc092L2xaWEd1UmdBaGJ1b2tiM0g4?=
 =?utf-8?Q?DfJ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12432037-18d0-4039-fa71-08dcea94675a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2024 08:03:48.9730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAzVfkrcJFUCPsEUIl5mpqv7FT9E4NQS2VWduOv9bNyNc3RFRTepOeW8OfLRj/SD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
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
Cg0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBGcmlk
YXksIE9jdG9iZXIgMTEsIDIwMjQgNToyMSBQTQ0KPiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5M
aWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IGNvcnJlY3QgdGhlIFMzIGFib3J0IGNoZWNrIGNv
bmRpdGlvbg0KPg0KPg0KPg0KPiBPbiAxMC8xMS8yMDI0IDExOjMxIEFNLCBQcmlrZSBMaWFuZyB3
cm90ZToNCj4gPiBJbiB0aGUgbm9ybWFsIFMzIGVudHJ5LCB0aGUgVE9TIGN5Y2xlIGNvdW50ZXIg
aXMgbm90IHJlc2V0IGR1cmluZyBCSU9TDQo+ID4gZXhlY3V0aW9uIHRoZSBfUzMgbWV0aG9kLCBz
byBpdCBkb2Vzbid0IGRldGVybWluZSB3aGV0aGVyIHRoZSBfUzMNCj4gPiBtZXRob2QgaXMgZXhl
Y3V0ZWQgZXhhY3RseS4NCj4gPiBIb3dlcnZlciwgdGhlIFBNIGNvcmUgcGVyZm9ybXMgdGhlIFMz
IHN1c3BlbmQgd2lsbCBzZXQgdGhlDQo+ID4gUE1fU1VTUEVORF9GTEFHX0ZXX1JFU1VNRSBiaXQg
aWYgYWxsIHRoZSBkZXZpY2VzIHN1c3BlbmQgc3VjY2Vzc2Z1bGx5Lg0KPiA+IFRoZXJlZm9yZSwg
ZHJpdmVycyBjYW4gY2hlY2sgdGhlIHBtX3N1c3BlbmRfZ2xvYmFsX2ZsYWdzIGJpdCgxKSB0bw0K
PiA+IGRldGVjdCB0aGUgUzMgc3VzcGVuZCBhYm9ydCBldmVudC4NCj4gPg0KPiA+IEZpeGVzOiA0
ZDU4YzU5OWRmNzUgKCJkcm0vYW1kZ3B1OiB1cGRhdGUgc3VzcGVuZCBzdGF0dXMgZm9yIGFib3J0
aW5nDQo+ID4gZnJvbSBkZWVwZXIgc3VzcGVuZCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2Ug
TGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCAyNiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQo+ID4gaW5kZXggNjE5OTMzZjI1
MmFhLi5kMDdjZjgxMzdiZDcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc29jMTUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1
LmMNCj4gPiBAQCAtNTc4LDE2ICs1NzgsMTggQEAgc29jMTVfYXNpY19yZXNldF9tZXRob2Qoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UNCj4gPiAqYWRldikNCj4gPg0KPiA+ICBzdGF0aWMgYm9vbCBzb2Mx
NV9uZWVkX3Jlc2V0X29uX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikgIHsNCj4g
PiAtICAgdTMyIHNvbF9yZWc7DQo+ID4gLQ0KPiA+IC0gICBzb2xfcmVnID0gUlJFRzMyX1NPQzE1
KE1QMCwgMCwgbW1NUDBfU01OX0MyUE1TR184MSk7DQo+ID4gKyAgIGJvb2wgc3VzcGVuZF9jb21w
bGV0ZTsNCj4gPg0KPiA+ICAgICAvKiBXaWxsIHJlc2V0IGZvciB0aGUgZm9sbG93aW5nIHN1c3Bl
bmQgYWJvcnQgY2FzZXMuDQo+ID4gLSAgICAqIDEpIE9ubHkgcmVzZXQgbGltaXQgb24gQVBVIHNp
ZGUsIGRHUFUgaGFzbid0IGNoZWNrZWQgeWV0Lg0KPiA+IC0gICAgKiAyKSBTMyBzdXNwZW5kIGFi
b3J0IGFuZCBUT1MgYWxyZWFkeSBsYXVuY2hlZC4NCj4gPiArICAgICogMSkgT25seSByZXNldCBv
biBBUFUgc2lkZSwgZEdQVSBoYXNuJ3QgY2hlY2tlZCB5ZXQuDQo+ID4gKyAgICAqIDIpIFMzIHN1
c3BlbmQgYWJvcnRlZCBpbiB0aGUgbm9ybWFsIFMzIHN1c3BlbmQgb3INCj4gPiArICAgICogICAg
cGVyZm9ybWluZyBwbSBjb3JlIHRlc3QuDQo+ID4gICAgICAqLw0KPiA+ICsgICBzdXNwZW5kX2Nv
bXBsZXRlID0gISEocG1fc3VzcGVuZF9nbG9iYWxfZmxhZ3MgJg0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICBQTV9TVVNQRU5EX0ZMQUdfRldfUkVTVU1FKTsNCj4gPiArDQo+DQo+IElz
IHRoaXMgZXhwZWN0ZWQgdG8gYmUgZG9uZSBhZnRlciBoaWJlcm5hdGUgYWxzbz8gVGhlcmUgaXMg
YSBmdW5jdGlvbiB0byBjaGVjayB0aGlzIC0NCj4gcG1fcmVzdW1lX3ZpYV9maXJtd2FyZSgpDQo+
DQpZZXMsIGl0IGFsc28gY2FsbHMgcG1fc2V0X3Jlc3VtZV92aWFfZmlybXdhcmUoKSBpbiBoaWJl
cm5hdGUsIGJ1dCB3ZSBoYXZlbid0IHJlY2VpdmVkIGFueSBTNCBzdXNwZW5kIGFib3J0IGlzc3Vl
cyB5ZXQsDQphbmQgdGhpcyBxdWlyayBpcyBjdXJyZW50bHkgbGltaXRlZCB0byBTMy4gSW5pdGlh
bGx5LCBJIHRob3VnaHQgb2YgdXNpbmcgcG1fc3VzcGVuZF9nbG9iYWxfZmxhZ3MgdG8gaGVscCB0
cmFjayB0aGUgZmxhZyB2YWx1ZSwNCmJ1dCBub3cgaXQgc2VlbXMgdGhhdCB1c2luZyBwbV9yZXN1
bWVfdmlhX2Zpcm13YXJlKCkgd2lsbCBiZSBuZWF0ZXIuDQoNCj4NCj4gPiAgICAgaWYgKGFkZXYt
PmZsYWdzICYgQU1EX0lTX0FQVSAmJiBhZGV2LT5pbl9zMyAmJg0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgc29sX3JlZykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgIXN1c3BlbmRfY29tcGxl
dGUpIHsNCj4gPiAgICAgICAgICAgICBhZGV2LT5zdXNwZW5kX2NvbXBsZXRlID0gZmFsc2U7DQo+
ID4gICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gICAgIH0gZWxzZSB7DQo+ID4gQEAgLTYw
MywxMSArNjA1LDE3IEBAIHN0YXRpYyBpbnQgc29jMTVfYXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1
X2RldmljZQ0KPiAqYWRldikNCj4gPiAgICAgICogc3VjY2Vzc2Z1bGx5LiBTbyBub3csIHRlbXBv
cmFyaWx5IGVuYWJsZSBpdCBmb3IgdGhlDQo+ID4gICAgICAqIFMzIHN1c3BlbmQgYWJvcnQgY2Fz
ZS4NCj4gPiAgICAgICovDQo+ID4gLSAgIGlmICgoKGFkZXYtPmFwdV9mbGFncyAmIEFNRF9BUFVf
SVNfUkFWRU4pIHx8DQo+ID4gLSAgICAgICAoYWRldi0+YXB1X2ZsYWdzICYgQU1EX0FQVV9JU19S
QVZFTjIpKSAmJg0KPiA+IC0gICAgICAgICAgICFzb2MxNV9uZWVkX3Jlc2V0X29uX3Jlc3VtZShh
ZGV2KSkNCj4gPiArDQo+ID4gKyAgIGlmICgoYWRldi0+YXB1X2ZsYWdzICYgQU1EX0FQVV9JU19Q
SUNBU1NPIHx8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAhKGFkZXYtPmFwdV9mbGFncyAmIEFN
RF9BUFVfSVNfUkFWRU4pKSAmJg0KPiA+ICsgICAgICAgICAgICAgICAgICAgc29jMTVfbmVlZF9y
ZXNldF9vbl9yZXN1bWUoYWRldikpDQo+ID4gKyAgICAgICAgICAgZ290byBhc2ljX3Jlc2V0Ow0K
PiA+ICsNCj4gPiArICAgaWYgKChhZGV2LT5hcHVfZmxhZ3MgJiBBTURfQVBVX0lTX1JBVkVOKSB8
fA0KPiA+ICsgICAgICAgICAgICAgICAgICAgKGFkZXYtPmFwdV9mbGFncyAmIEFNRF9BUFVfSVNf
UkFWRU4yKSkNCj4gPiAgICAgICAgICAgICByZXR1cm4gMDsNCj4NCj4gSWYgdGhpcyBjaGVjayBo
YXBwZW5zIGZpcnN0LCB0aGVuICEoYWRldi0+YXB1X2ZsYWdzICYgQU1EX0FQVV9JU19SQVZFTikg
YW5kDQo+IGdvdG8vbGFiZWwgY2FuIGJlIGF2b2lkZWQuDQo+DQo+IFRoYW5rcywNCj4gTGlqbw0K
DQpUaGVyZSBhcmUgdmFyaW91cyBSYXZlbiB2YXJpYW50cyBzdWNoIGFzIFJhdmVuMiBhbmQgUElD
QVNTTywgYWxsIG9mIHdoaWNoIGFyZSBtYXJrZWQgYXMgUmF2ZW4uDQpIb3dldmVyLCBoZXJlIHdl
IG9ubHkgd2FudCB0byBmaWx0ZXIgb3V0IHRoZSBvcmlnaW5hbCBSYXZlbiBkZXZpY2UgdGhhdCBk
b2VzIG5vdCBzdXBwb3J0IG1vZGUyIHJlc2V0Lg0KQXBhcnQgZnJvbSB0aGUgb3JpZ2luYWwgUmF2
ZW4gZGV2aWNlLCBvdGhlciBnZng5IEFQVSBkZXZpY2VzIHJlcXVpcmUgYSBtb2RlMiByZXNldCBp
biBTMyBhYm9ydCByZXN1bWUNCmNhc2VzLg0KDQpUaGFua3MsDQpQcmlrZQ0KPiA+DQo+ID4gK2Fz
aWNfcmVzZXQ6DQo+ID4gICAgIHN3aXRjaCAoc29jMTVfYXNpY19yZXNldF9tZXRob2QoYWRldikp
IHsNCj4gPiAgICAgY2FzZSBBTURfUkVTRVRfTUVUSE9EX1BDSToNCj4gPiAgICAgICAgICAgICBk
ZXZfaW5mbyhhZGV2LT5kZXYsICJQQ0kgcmVzZXRcbiIpOw0K
