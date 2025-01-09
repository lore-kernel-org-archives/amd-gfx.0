Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9201E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 14:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC4410EE1A;
	Thu,  9 Jan 2025 14:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WPqKga8B";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF5C10E45F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 14:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uwkotcei5yAMqnJadOzyNKQEqrQl/sDB9EuhB10mY7uuk/2+ajnaaz6Bcwly0jjGuXRl5svKlJ0nBBVbGX4qfmXS3gCjYZb3o5n5NidWrtKJKgnofYAB+hp1ZJKytsZeULJtNRrBKTpwinXCiAwgpJNerPKg7yZvQe4b5k7/JMq/2t3v+XSomdwi2sVcRis83qL1lmG+4uqNisu0r+Tn4hvBqiFgEEXtUAZiG+d0CyUadPmqWZXvAcTRBw3E+z8kIbEM9pxUgN5AGaKl4R0HJQUxO/ONBA8qKjrNPnX3DA31jagwfMH551GIy2GKmqWTJGQOvGzaEIZ+/+m0zHfCQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7WR1352DbtcqW+AvTfLA2xy04/WyLcoNO6830dcdg0=;
 b=fj80tOzWNu5WJs8ofApEyWt3JiZVodZAVIX6PunZqfx18JBo9MagcjdAwfANdPL2Zdnffh75LP2vKNMfrfYrSk9Y0ebM1+1I/+9wdkeJ4ilrZ6CgMPIZfCQkVe6ZiO/ldn/ez9tg+yD4BF3eHZyD0u5/JDq9VQhLRGyFSuEw7mO6B+8Oe0c9sMDkoVbYuFqSRRlxDXccQTvVSnATXTQ47i0fmkUM1Y7/x8Yr2P40IhUfkMCfQsx7x6QftVJo+IeuOXvaJa0dAxTDl5xChRvYje9xh0n62cZCf6kKhdKCymHZfXJauU/1uq1krhEeUgm+Z0VsXOW0LFfFBf3PbWhdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7WR1352DbtcqW+AvTfLA2xy04/WyLcoNO6830dcdg0=;
 b=WPqKga8B7vJuMUf9phG52SiA3nTJk5rqxp0PdRILSAF0zp7y4JM5ME1pnQLGIKi9ikP8fGCNhgBACqQAjB/Byb08oPnXT8gxqIE8681tiJOQYfLenraxV51kS8TOEb7cSIX0+fOGJmuOTQJiw+EQ0E7s346C+Q4jQExesI6lmlw=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 14:57:41 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 14:57:41 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
Thread-Topic: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
Thread-Index: AQHbYggg7TRtauGCh02VRE8z9Mjnf7MN908AgACHIuA=
Date: Thu, 9 Jan 2025 14:57:41 +0000
Message-ID: <CY8PR12MB7435645F2AB787B7BC57BB0A85132@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250108200121.2808908-1-jonathan.kim@amd.com>
 <0ab5d4aa-ac2c-4108-99e5-902f73f827bb@amd.com>
In-Reply-To: <0ab5d4aa-ac2c-4108-99e5-902f73f827bb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=419dc521-c288-4d77-a9d3-9d23e6440010;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-09T14:57:10Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|BY5PR12MB4227:EE_
x-ms-office365-filtering-correlation-id: 7b772cfd-e07c-47aa-0448-08dd30bdf74f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?UVIvMndueklTRzNnV2dCL04rZ0dwL1lDRFZjVElycU9OcXF6ZFJwOXdUSy9q?=
 =?utf-8?B?VnlJVmFpVGp0UGdpVTV1bGRNQjRmRnZqYkZEcGw4ZGdwVklnbDVZT3dLQ0pq?=
 =?utf-8?B?ajNLcjNkYk0xMU5KWDZ1cXF1WUNqUlJSOW4xSkROall6bHc2bEZmbGJqakZQ?=
 =?utf-8?B?clZVdkVXTlZJYTJIOU40V1ROTU9tZVg0Z1JXZm5FTnViZVVVaUlySTdHZXRV?=
 =?utf-8?B?SDZwMVFkbDdNZHZBOXV3b25jbml1MXdmMTNpUlhsaWJQVzQ3dm01dWZCWGlW?=
 =?utf-8?B?UFVCNm85RXE5ckY5ZG55TnB3S1o0Y1RuYmJVdE1CbUc5anBpR0Znb0xERW9T?=
 =?utf-8?B?b3hiaEJnSzNZcnovMjZTNW9LMllmZ3F1S2wxYWZWVkhsSnJ3Qzk0UTZKYjhE?=
 =?utf-8?B?YlNFZ0Y3bGlSenlxYzdidVJhQVlvbWdvZEQzbWxLempGTGhjVUVMVXQwUDlW?=
 =?utf-8?B?M3kvTFVMWkxPQVZ2TFd4MlZEa0hYbHo5SFRUOC9yTGNJTjdPeHFCdTRXcTdB?=
 =?utf-8?B?VU52WTF0a3pCaU9WNE8wZGc4bzBVVTV1QWRpZ0FuZW1VejJGdTkrTG5Cb2p0?=
 =?utf-8?B?OFpER0o0clNUbVRjYzJiL3NPYURZTXBJQzBjaXE5aE5QTDZaYmpGTnBKY3dL?=
 =?utf-8?B?c3IvRFJTWS9jQ1N3OEViZGtiNnpOa1lOcy84dWpRVmtpTzM3M3NOM3FheGQ1?=
 =?utf-8?B?NHp6Y1VVTnY0TWpJNUZ6QTVrRlZBeW56U1B6emtSUjBqTTJEWUI5SFIrclRa?=
 =?utf-8?B?cGdjdmloTjdxUmtGRUV1UVFDc1lNV1k2S3VBSm1VSDhwMTdIR1Q2OTYvK0Fv?=
 =?utf-8?B?cFhBVWM3L2VCSDZIRGlET3JtcUdYVFFkenBoOVdVSkx1Q1BjWGZFelRTRTNT?=
 =?utf-8?B?OEJiaE1OSVB3Rk9ZZFBLYkwybTR6bWkxZ2dETDNrdlhxcVh0NTg0KzMvaVIw?=
 =?utf-8?B?amNydHB2aXZCaEtMTHJKZCt2bjgxZ3k0RkxQcTVLeDk4NVVTOFVWejdpTWRY?=
 =?utf-8?B?dlBBWmZ5VjFLb3VXamJUaWY3bm5JV1BweDBXeUZsYUJmSVFJazV3NUdudmY2?=
 =?utf-8?B?bFpNeUVidHlyU3lDb1k2eTk0S3R6cmtUdjQ1Tk1WTndJblR0NTlsZmJ2TFRX?=
 =?utf-8?B?UmZiODQxV3FQVXM5cWNvR3RER1l1aHBaa1RkUGtEbFphcWk0VmFKeHJTOTBx?=
 =?utf-8?B?dXVWeDBSZ0NpNy9wY0RPN3ZWKzlQYkdDWnlOb1JGNnZiR3NhcVV3ZitCOTBO?=
 =?utf-8?B?NC9oMVF6SHk3aytNSCsyeUNqM2Vick1jdmNPZVlLYTlQRUd5S0pQK09mYUw1?=
 =?utf-8?B?SXJHRlA5NFh0N0hobVFyeXhwVHo4dFR6MjVqQmltdllhWFhQbldPVENzeEc0?=
 =?utf-8?B?c1lQa2h5ajNvb1lkazZxZEZ6U0tKZVJYUS9sc3hFclQxVXVxczE3Y05JWDUx?=
 =?utf-8?B?TmpYRzJkZmhCSFVYV1JxamFDMFBwY1lCVmsybUhqdGpZMFJaM1FWUldvMi9y?=
 =?utf-8?B?R012OUJ0dWdqWWFXa2ZKRkxRdFJuSmRJY1VRaVlrR3FTSlVxUWlqc0FFNENh?=
 =?utf-8?B?TjRJS3VlNjBQWks5bUZ5SFZHRURPZUFYNjFWUldZYmpJdmkrVmV4VUJTTStJ?=
 =?utf-8?B?UGM5Q2Y4N1JYQWlVVjF0WDdjYmEyUDFBdDY4LzJaUkJlSVB3K0dYQS8ralBh?=
 =?utf-8?B?VG1vLzVvQXhyNlROVEFORmIyN3BoZGRmQ3laVjUwWmN6elNQdHdIS1AraTAw?=
 =?utf-8?B?OGU2bGJFdnhONHdVcDV4d2VldUdaUGVoWE5IWkFvUHZhbXBHS2tOR0g2TmJI?=
 =?utf-8?B?V0VnSXhjZmpwQWFDV0JRemRTN1ltRURGZXFYL2JhM0NrOElHRFZieDZjMlJR?=
 =?utf-8?B?ZzUzaGg5UHhTN29kazFWZjI1bXFUblJZOVJpcWtkeFRsVGF3RDZnQmJHNGlz?=
 =?utf-8?Q?tokkmmDQmG0y1Q2dps5YHonZsME0IiZk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWp1b0xnTGRuSmVCdVEyaFpMd0xZMGIrZFVQcU5QZlYyb1JDeWkvNllZVTJo?=
 =?utf-8?B?b3ZQUllhRUhjNFMwY0dyM1ZuMWw4d3VqYVR3SmNwNVVqOFRuTmpiMzVGWCtN?=
 =?utf-8?B?d3NMTWVqYTB4cVJsbm16QTNZT25oY2ZxcXYwTmxnSXQyNFBKNXhhVDFtcnEy?=
 =?utf-8?B?OWI2WE1rWmRNaHN6U0F0ckRYRDR0VTF4am9NNFVTejdIYWR6eCtxMDNiTU5C?=
 =?utf-8?B?N3ZJQTEyZGNVTnhoVmo5Z2hnQ0JBaTR3bUFuSS9xZzJYWnhZNzZ1MVpVM2JR?=
 =?utf-8?B?c1lIVUl0Tzlqenk3SlFzRm4rcVdOMVRYcmR3RWdsdVYzSDFSTU1RWUg3Tkx1?=
 =?utf-8?B?NmE1MEI3MDBsWElWdDRBSFFqUEVpaWdvbG5zdXJHSFkzSWFzQmFVZ2tQcDhh?=
 =?utf-8?B?YTNBaFNQMWEyYkpwV0gzZG81R0lEYTA1WHJGRnFCNUZ6eWRFNXhWblh3OGRW?=
 =?utf-8?B?eTBGZnAvZGVZbDdQRlEvMDFFNVM1Z2lGTVJnK3FtdFlaRXRUV1BHVnRPd2c1?=
 =?utf-8?B?MlRUT21OcXU3SnFIT2xFOW8xeTlpcHpRZzJjOHJXU3ZDQmowWXVIZ3UyWjNG?=
 =?utf-8?B?R1h2dGRnRnFqSTg3NjlZYnhrYnMrOTFyY2NwOWRkUkRGSy9laTAya2xOVVdh?=
 =?utf-8?B?eThWMU9Od2ZkRWZsUWpRM00yaElCbWUxMzB2YWxIdS9wZmhtNy9nQVFMcTFa?=
 =?utf-8?B?NnlTbG9XbXFqeGF4eTJKcFlrbmpaU0tYZUFTcFlaeXkwNjBHdE9Pbmp4SjBS?=
 =?utf-8?B?a3BKYlRuOGY2ek1lL0pmRXFGQTRQT05OaUk5SkkvWm5rNkRITzlheDhnK1VR?=
 =?utf-8?B?ZjNtSS9JYVZUTkJqNGpYQjlrUmEwT3RCaUt3dlBoU3BGbnFTbm91OTlpTkow?=
 =?utf-8?B?clVBdFA5SEQ4d3YzZlhZRm14T2Rwcmh4WWMvckhFUUZrY3c5YkN0c05IZUo0?=
 =?utf-8?B?OWxkdEh0YUdTWmY4M013c1JmeENKT3ZpMVdWU2FyS21EMGhaZUFBTjlIS1Ux?=
 =?utf-8?B?RmdnNS9FbEZVdFE3a0hSYmpGaFF1LzJRQ2JxQ3FBNFNoT3d2YVczb1pvUG9t?=
 =?utf-8?B?S2cyRUJkcmdEWFBabDFGeGVuY0xhVlRqaUxFM3RabFdJM056c0xCZDJZSHg3?=
 =?utf-8?B?dVhMZlJuMVJKQXJOTUpBekF6MXRUNFdYYmQzcGtGYVlrVnllTEExeVdLU3I0?=
 =?utf-8?B?VjlvQ2xGb2N0blAzc293N3ZxRi9PTnFPZllHL0RoY3FqUWczcVh3eVNUOVRI?=
 =?utf-8?B?MFB0REZQZ1pXZHowWDV2WnR3N0dlbG1XeFRYUGd1bkg4bW5RblV0RDlEQ3Ex?=
 =?utf-8?B?TE9aajQxWDVxY1hzRDI5OTNQQ2FhNFpkVmRYVUE4VnJ1cHRCcVlqdnoxM3NU?=
 =?utf-8?B?WE5XdDg0dXd3bWRla1JMTTBzOEZ4SEFaOWlwVUozWFNvUGkrTk9jSFZuRHE3?=
 =?utf-8?B?bnh0Z2J4RDJiaVNYOEszekRqdGdCbllKZmVjU2o2MU1DZDhUdU9mMVdKV3NW?=
 =?utf-8?B?NnpLcWZnRWlWeExmMjF4UzJ3VGlodGxiOFlxenNoMDZoYWVKaHkxazlYNysx?=
 =?utf-8?B?cWFoRDNITmkvcnVrSkI3cWR3YldTWGh5bElwenY3QXkwV0U2WUVhN2VSbSts?=
 =?utf-8?B?SUZTKzY2SVVWU0FBQWVrblMxQUlhZVJFZW1mOXQwRUtoTkk0QXNFREpxa1d2?=
 =?utf-8?B?WkJJMi9vckRlOTZRZHB4bXBsZHlIc3RtaTF6cWhhdWNGS25zd3cxcWZvMFp3?=
 =?utf-8?B?UFQyL1NiSm5pRkg1bkJvdnFpMllCeFJ2eUtJZ09NeTEwUldtMUhTMWNZT2k0?=
 =?utf-8?B?WFNYMkd3MDNmVmJ1UTdDVDY4TjJXRHpqTDhpcGdraTFTbzArN0pwLzY3a0Yy?=
 =?utf-8?B?bnJGT3FmZ3lCNkszdlM5MXpzOGdIRHpONHRZOFR2c0hwZTJ5NHBlQnZNazMy?=
 =?utf-8?B?aEY0YTA3WG9wSUFwVHpMR0R6SkxMZGRSaE5IL1pFZWVaUVZEYzJhWmRuaUFI?=
 =?utf-8?B?RHN1dDlPNmFSZy9yRHRSR08vQm5EaTVyZnVVaTZaTmgyUTBpL3MyMGhXcDJP?=
 =?utf-8?B?c0sxSmZVcnBQRklES25HTXR6bzdET0tWdG9uSjd2cEMzbWYyenFyNGpFK2RY?=
 =?utf-8?Q?F/H8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b772cfd-e07c-47aa-0448-08dd30bdf74f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 14:57:41.2546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Su3KVHHBSDIgWlnxsodH9L8epQEYF7wyZW288ZNPxqLx0TcPTajL/9+SgnvxzjWf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSA5LCAy
MDI1IDE6MTQgQU0NCj4gVG86IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEthc2l2aXN3YW5hdGhhbiwgSGFy
aXNoIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWRncHU6IGZpeCBncHUgcmVjb3ZlcnkgZGlzYWJsZSB3aXRoIHBlciBxdWV1ZSBy
ZXNldA0KPg0KPg0KPg0KPiBPbiAxLzkvMjAyNSAxOjMxIEFNLCBKb25hdGhhbiBLaW0gd3JvdGU6
DQo+ID4gUGVyIHF1ZXVlIHJlc2V0IHNob3VsZCBiZSBieXBhc3NlZCB3aGVuIGdwdSByZWNvdmVy
eSBpcyBkaXNhYmxlZA0KPiA+IHdpdGggbW9kdWxlIHBhcmFtZXRlci4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMgfCA2
ICsrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhf
djkuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5
LmMNCj4gPiBpbmRleCBjYzY2ZWJiN2JhZTEuLjQ0MTU2ODE2M2UyMCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYw0K
PiA+IEBAIC0xMTMxLDYgKzExMzEsOSBAQCB1aW50NjRfdCBrZ2RfZ2Z4X3Y5X2hxZF9nZXRfcHFf
YWRkcihzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgdWludDMyX3QgbG93
LCBoaWdoOw0KPiA+ICAgICB1aW50NjRfdCBxdWV1ZV9hZGRyID0gMDsNCj4gPg0KPiA+ICsgICBp
ZiAoIWFtZGdwdV9ncHVfcmVjb3ZlcnkpDQo+ID4gKyAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4g
Kw0KPiA+ICAgICBrZ2RfZ2Z4X3Y5X2FjcXVpcmVfcXVldWUoYWRldiwgcGlwZV9pZCwgcXVldWVf
aWQsIGluc3QpOw0KPiA+ICAgICBhbWRncHVfZ2Z4X3JsY19lbnRlcl9zYWZlX21vZGUoYWRldiwg
aW5zdCk7DQo+ID4NCj4gPiBAQCAtMTE3OSw2ICsxMTgyLDkgQEAgdWludDY0X3Qga2dkX2dmeF92
OV9ocWRfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYsDQo+ID4gICAgIHVpbnQz
Ml90IGxvdywgaGlnaCwgcGlwZV9yZXNldF9kYXRhID0gMDsNCj4gPiAgICAgdWludDY0X3QgcXVl
dWVfYWRkciA9IDA7DQo+ID4NCj4gPiArICAgaWYgKCFhbWRncHVfZ3B1X3JlY292ZXJ5KQ0KPiA+
ICsgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4NCj4gSSB0aGluayB0aGUgcmlnaHQgcGxh
Y2UgZm9yIHRoaXMgY2hlY2sgaXMgbm90IGluc2lkZSBjYWxsYmFjaywgc2hvdWxkIGJlDQo+IGZy
b20gdGhlIHBsYWNlIHdoZXJlIHRoZSBjYWxsYmFjayBnZXRzIGNhbGxlZC4NCg0KSSBkb24ndCB0
aGluayBpdCByZWFsbHkgbWF0dGVycy4gIFdlJ3JlIGdvaW5nIHRvIGhhdmUgZGlmZmVyZW50IHJl
c2V0IHR5cGVzIGluIHRoZSBmdXR1cmUgdGhhdCBteSBjb21lIGZyb20gZGlmZmVyZW50IGNhbGxl
cnMuDQpJdCdzIHByb2JhYmx5IGVhc2llciB0byByZW1lbWJlciB0byBwdXQgdGhlIGJ5cGFzcyB3
aGVyZSB0aGUgcmVzZXQgaXMgYWN0dWFsbHkgaGFwcGVuaW5nLg0KDQpKb24NCg0KPg0KPiBUaGFu
a3MsDQo+IExpam8NCj4NCj4gPiAgICAga2dkX2dmeF92OV9hY3F1aXJlX3F1ZXVlKGFkZXYsIHBp
cGVfaWQsIHF1ZXVlX2lkLCBpbnN0KTsNCj4gPiAgICAgYW1kZ3B1X2dmeF9ybGNfZW50ZXJfc2Fm
ZV9tb2RlKGFkZXYsIGluc3QpOw0KPiA+DQoNCg==
