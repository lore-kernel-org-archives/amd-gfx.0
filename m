Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7A3C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 07:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5ABA10E6A0;
	Thu,  1 Aug 2024 07:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SRwN1EtA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 017C210E6A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 07:00:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljmlhmfqPe9j6+bfz9jQ5JIxguXe7q6axf844JRlMKWfkIFGpF+bHYyDXnwZ7W4GdTNgmDp9VFiCAnivNsYIePtGD3F7qqLVmT+l4ofX9aXG2Kz4+/E9jrefWGWzNKKGAlMe5DxMIi2Ogp6TuEd3BwzJrF0pSy9hj2RQ3Q8vcrSFQcoJLz8ScVbfoG7zKzJh2o+eiPSP2c3VBdnFuPSO4ft+nnMIJEUpq60EavQJtSfO1D1yNLTKEdAFiTOV3sA5OJ6LHiHDSXH8HNkk3yZUwcI8fMxw5UpEQexjn9lIDsL8kaCfjcDqGiuDp4xBEWd9T5B+uE4zuFhWx5cmiR/noQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zUe0nygNXFjO48H8bskjqupePISU7+glkSUUOTDVsg=;
 b=RFNWBMjVAtW5TlOsmK7xe5QaegXHVIXqnjUJdaZ7j/r2xnfwpXrHm78rMC6FzDl2ly1lEowGhlyNzrWzK6r6yGxW4EcZY3k9VY2bv3kAQjbRRhA4oLxPoEA+hXQFldobhZYI1g5r9jZOi7uRo7a8MpCXsxclty6AOdRp+r/QrOn7xyQTfjigVCU5WTyyW8mE7ajvOVWTqzhjd13OYFFkbZOVZZ5aTxIf2HK2zWFvShv39or2LtrYhkWM5da78TygWm2n543k2zkJuRD19hddtC8a0XyOnrA8GT06x8skw4Idsu+vHZ/Uvyo9uBo2sWY5Fkm9O842pxDW50qeHAQ3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zUe0nygNXFjO48H8bskjqupePISU7+glkSUUOTDVsg=;
 b=SRwN1EtAq/zCMKLKSTZL7bWvhY2SKugqg/sZiK+R3Tu/zpvg74bcwwRh9pfOv8jGFtaYLAIRCoNl1Y6DmIruVHaRJk0KVvY5UL81ZXFrr4bLazWRaVS4wUEY2MaOTlGD9CDR9flu4lub/WQdiB/gCfLRY0NuAFhyaT90FQ3WcaQ=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 07:00:15 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 07:00:14 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Topic: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Index: AQHa4zExnRuw1cXkP02nZh2cKZwugrIRt02AgAANeICAAByRAIAABixwgAANqwCAAAPf4A==
Date: Thu, 1 Aug 2024 07:00:14 +0000
Message-ID: <PH7PR12MB87968D8C2BEB4CE4A543C8E4B0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240731100526.32903-1-tao.zhou1@amd.com>
 <BN9PR12MB5257A5C7FA776D10A6FD540FFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB87963EAAD611DFBE5AB79AC1B0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
 <BN9PR12MB52570AEF77D511EE5B2900FBFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB8796D2E81A39D402B2871EDAB0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
 <fae5c475-ba74-4353-957a-29ccbfc147d7@amd.com>
In-Reply-To: <fae5c475-ba74-4353-957a-29ccbfc147d7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=38bd1963-5a6e-4c2e-83d4-c64ae3855c0f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T06:54:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB8920:EE_
x-ms-office365-filtering-correlation-id: 687132d5-30d8-4731-fbe4-08dcb1f79839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?enN4c3RjeXJObnlzM1l0cjc1UUU2a3B4dWFqY2l1K0hDMXRhYUNIMDZhRWN3?=
 =?utf-8?B?T0lrSk1sS3lsNnBEQnhTS2FJT2lUM0loWjNNb0x0NGlWTGUwNWF5S0gva1RX?=
 =?utf-8?B?akZmVWJhRktCWnB0TzltQlBoT29TMWZqSzhQV0NoWEhKeHI0T0syb0paUWxT?=
 =?utf-8?B?RVN1TWxRT2R4VDhoRUhYVzlRcWZrU3FSQVlIcnUxem1IemVlVVNxT3E1R0sv?=
 =?utf-8?B?Y05aeVBLeUo1bEJUVnlxRERubXZVNzNkNitLdFk3NnJzLzlxQUZ4ZW5NUnE5?=
 =?utf-8?B?VFp6R0pFSXY1bkVFL2VkbXFlQ3krTzlMWjRVOXVLMzZzWE9ITXdKT0NSME5B?=
 =?utf-8?B?YmN4biszY0xabjlRQTh4cFd6MVlSY1ozRmZtS21LZlhxTDVicitLZUp3UGlK?=
 =?utf-8?B?SGtJT21IejNveC82WHMwTU93U3F0d083Mm02SVlmbnZXUTJjcGttcHlPM09a?=
 =?utf-8?B?RW5UYlpjNk0wMlpOMzM0UjNINnJlcEVRcEc5Y3JKR3JqeWNkTHNZVVRRNDBX?=
 =?utf-8?B?cnluaHFFbE85K1VCWU92WURObVhMY3QxcHE0SFJ1UW5rRWVqaXlMdnR2ZDFp?=
 =?utf-8?B?NUxtVTBDRkR4c1E4VTR2Z2orbFJhaGdDNTg1eWdkVmNzdlBhVmI1TUw3cEUv?=
 =?utf-8?B?NnVheEV0M1NCbEZYTXhmU0FtamVwYityTUljT2RPOTZNVkh6MHJOelFBNVRX?=
 =?utf-8?B?cWtoTVNPMjBoK0dkRlZnWVg1Ujh1Z3A2MHBBL0g1U1J4UldTTXZhdEoxdFpI?=
 =?utf-8?B?ZS9UeU1tenFBQnVoL1FNY1RrM1NKNS9SaVlhYVIvMHFsOFNUS0g1d00wb2p2?=
 =?utf-8?B?d2VHWkZuc3BNdFp2dHA3WXg2b3FiMXlsbFFvV082ZVBtc2IzMDJKWHVtSExF?=
 =?utf-8?B?bUlBYm85U3pKTFRFQTZSQ3h6Q01QRHUwdnZSK3AvNzZxWjY1SGhVRGV5TjVW?=
 =?utf-8?B?b1NmSGRzUlY4NTNHK3RoL1ozanRXNHY3dy9EUDhTQ0xlMnZUQWlqMHh3TXBz?=
 =?utf-8?B?THhDbndPUVU3R3V5UW95RjNOK0dpNmtqVXF6VlN0V0c2aDQvc016T1h3UlIy?=
 =?utf-8?B?Z2R6a0VmdmR4QkVIeHJJUHhOTjdtVlZUa1RPWjJRVlZiVEJrWFA1WW45c3Uw?=
 =?utf-8?B?THdnSEF3T0UrRzA4TzZoSHpBV3Zqb1hJbzRtaThjMDBLSDJObWJjVGVYRzZD?=
 =?utf-8?B?UUxBbHZROUs5T0svMlp3a2JxaGhLSnhadmZoL3Jvd3liVzVkbVdMYjJvY0x0?=
 =?utf-8?B?SHlXVDRPVzBtb0oydTdYNi9hQlhIbTh6MTk1dE1zYlVZemxwQ0dMVDVBWkc2?=
 =?utf-8?B?cm1BaFU2bDY4MHQyV1AwVUR3cmRnS240bEU0L3plN3lQL2dCbnJOaEJ0R2p6?=
 =?utf-8?B?c1laYjh4UFBlUGszZ3BvRVEwRmQ1T2lEWjl2NGJXY0FhWU11R2JYUC9iRjFJ?=
 =?utf-8?B?ZXVoVlFhODA4Sk1xSnNuSEdKdmpuTGFTdEt0UCtKL3R6TGtiRDdVdTRYbmpS?=
 =?utf-8?B?VGN5bHpIQzVWNjRTUWpWSGFXaGlENnVvN2JMT2EyV0JIYlVUZ1lSWDRpNU5D?=
 =?utf-8?B?d1RzYWdpWWttUmxNS0twRHVZUWVsRGFyVG5oY3NnRG5EbkhBRGRWd1hvY0JR?=
 =?utf-8?B?Y0hHSHpLRmpTVUpMcHM3K3MzLzBJY3BDWTRWZ05WV1RPT05uMytpbWdIMUNC?=
 =?utf-8?B?U0tCWEwzVHE1RURoYUFaWGl3R0t0R0QyeE1FVlJTUmN3NDVPTXJTS21qdHpT?=
 =?utf-8?B?NGZwSTBHMjJnNXJjSGlzalpDdTFKbXBWYXl3dXIremdzeFhnemp6VWlsQUNk?=
 =?utf-8?B?dVpObFpLUFNQRS9CRjZ1RWlpNE8vekpvZ3BadDB5QkhXNGIveEgzZEFmSUVx?=
 =?utf-8?B?QnhQa1JQSlVuckNwMmp1YzFlYUVqVXFnTkdOZmVyV3Q4eEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkcyTjZOdTVQOFJqMEtVY0M4c2pDSitralJZdU10MmFpYXIzMlZSM2FwbUt5?=
 =?utf-8?B?NTg3MjlBUVhtZkZ0YVZLTTI5OTJoeTFzb2ZaQjVuREovVTBwT2ttRm04ajNN?=
 =?utf-8?B?azVYWk9lYUVaOStQMTBXZjlkQzNsZzJMMmhBbEpUamZYWnJGbzUzNGphd0V3?=
 =?utf-8?B?aTBKaHlSRmp3V3pzUmpTU3NmTHNmTlRMN2plY3JybWJReUwySmkwSXFudjNR?=
 =?utf-8?B?WVlwUFZobVRtZklCQk0rdldnM3dXK2hQWlVEVXY3d1ZyZVZ6MVlGbHZScHJp?=
 =?utf-8?B?TjVQMmpJOTRTbE5lZ0hwOXBlYlVTTXd1T2s5RDNWdU1yYUlybm40TllrdDFp?=
 =?utf-8?B?MmNWTWxBTHlUUmNLYTZnVVhqNFdUalNFdk9mbHdsYWpia2cvYlBIeFpYTlpv?=
 =?utf-8?B?NGlRUklEeFJMQ3lpbWlWQTREY2ZVdmRtL1ZjWFVwWDJLcUNGRmM0Y0I2cHZx?=
 =?utf-8?B?bmkvaUo5aTd3cTN4N2JuM0VEeVFacGxSK0ZFZzdoTDY1dkFIbmthUmtZVmND?=
 =?utf-8?B?Q2h0TG4yd2ViS3J1cTRYYWd4TVEzcVBSRlpFemU4L0pkZGNsV2JubHNsYUI5?=
 =?utf-8?B?MDcyUTllekV2WGM2ZC9xMEowRHFlbWw3cnlpaVZPUW9JbzBjZnRMbEdRRWdo?=
 =?utf-8?B?UUc2RjNsL3ZDVDE5OExBU2pJOGhuMHNuZ2ZmMk9JVlZTRkhEVlp3V2crbFM3?=
 =?utf-8?B?OWo0dFZBemlBN1U2T25BYnJ3QmxzZU5zY1k5aE9xQUtQR1dUNlI4RmdlQWpl?=
 =?utf-8?B?eEhWcVNldGVra2c5U21aaGNHRHM5ckJDQjZRR2x5a21TYlFteXJMY2tpYkJz?=
 =?utf-8?B?TXY3SEpTZ0N3QVlweWJ2akg5dW5lOGF5dXRuaUdmWFZVVG5LVDNnczJwd1JH?=
 =?utf-8?B?NnkxMGpHc21IYWp5anhjbmIvclVGYW9ZTCtaZDRXTWF4d2UrWHd2MnJwdEdi?=
 =?utf-8?B?a0VZVVowVndpeHFkQmRWNFNWUjV3YXNYNnF6cWRiTnJ5SUhHRm9aODJWR2kw?=
 =?utf-8?B?V2FoejdqWWhSY2svbnhOdlNsQ2VHazBna0JnSVpXU3NvYm1KUnhUMGVDSTFB?=
 =?utf-8?B?aGNnOFJrREtoaGt4dEI3YnNjSzkxZDhGcFdXTHpTc1NXUmVTSG5ETDNEYnVr?=
 =?utf-8?B?WHorQkxnRVZKQkQzVG16VXJVWm5QSExKZEwwbVlDVmhsU2htYXBGdmpNVXVN?=
 =?utf-8?B?ZS9vZkRqRlcveWcwYjB6TjlTREpDako3WFBJaUFFMU9oRmZBWVk5NThydFFw?=
 =?utf-8?B?R3VYNU1ZQkxLZDlsMDZ3OVA5T2xnd29WekZBVUN0Zk9JalY2cmNQYVZJU0Mx?=
 =?utf-8?B?N2Zld2l2WDg1d3ZKblZ6VTgrM2dkVnNsbG9lVVZ0VDN3L2RiQXRSU1NGNVQ4?=
 =?utf-8?B?MVRCc1ZaS2NNNXZpQUgyZnVTaWh5dlFXWk5UREVrSzgzbW8yTlJYYmtnWlVW?=
 =?utf-8?B?bHFHeHdHUmxIeHJCdFlRSStFMGlvWnNGZjRoQzk4N3pUUkY5UnFVLzduaHc3?=
 =?utf-8?B?MXNpdTBvaXlhMi85dlgvT2NDcUs2RGE1dmxNOWhWQ2dXQjlKM3o0YnhRbzlj?=
 =?utf-8?B?WENYWDBmV3V4ejFCajJjUGxGYkVJV0p5RmtDZE5PNUZ1bnp5YTUzQkFtUnVw?=
 =?utf-8?B?SkIvZ1NWMVRENG9UMWhFTVhpRjk0WEpQRjJwYlNnR2FjTVk0YXJSRUM5R3Rx?=
 =?utf-8?B?eDlsVlhKKzZGSW9HOHhSMUZiMTY2R1hKMGgyVXg2WjJzYnlYbW9QbXpjdVM4?=
 =?utf-8?B?Z1QxUzNScXlWekJUNTVYczZFZ08wTXY5SWRzdm0xQzlmU0c2aGFDaUowM3Nk?=
 =?utf-8?B?bHFLc2pEM25LVW12VTdCSWNSZUI3QXVRUTFvaC9sMEFOT09peFdRc0ZqVFVn?=
 =?utf-8?B?bGF1Nit2VWUxeHRPTEV4SDhDWEpxbXJVN1FRZ0JVU2xrOWJtT3p2dTdkMWJo?=
 =?utf-8?B?SXlScVB1cmo0ODlOblVxVVlWSWZFeDUwVERVQTJBNVFWY3Q0bCtGalVIdldQ?=
 =?utf-8?B?ZFZ6dTFXeGhIZHVqN28zUFYvNkx1QXJiemV4T2pJYlp0VUdjbi82SUY4d2t6?=
 =?utf-8?B?REIxZkRuTkhxZkFiMHJyalVMVVNPdi93MmtVQi9FNzdkQm9QeE5ic0EvdEMx?=
 =?utf-8?Q?AThU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687132d5-30d8-4731-fbe4-08dcb1f79839
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 07:00:14.8414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxDsKZDQRxyrcofpnIex8WGpTBdEWScZ8T69ndrXYiBqVmCmXmd6EdrAI7uRMTM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
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
Cg0KV2UgbmVlZCB0byBwZXJmb3JtIGdwdSByZXNldCBmb3IgSFcgYW5kIG9ubHkgbWFrZSB0aGUg
cmVzZXQgIGZsb3cgZmFpbGluZyBmcm9tIGRyaXZlciBwZXJzcGVjdGl2ZS4NCg0KVGFvDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6
YXJAYW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxLCAyMDI0IDI6NDEgUE0NCj4g
VG86IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcNCj4gPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHJlcG9ydCBiYWQgc3RhdHVzIGluIEdQVSBy
ZWNvdmVyeQ0KPg0KPg0KPg0KPiBPbiA4LzEvMjAyNCAxMToyOCBBTSwgWmhvdTEsIFRhbyB3cm90
ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlv
biBPbmx5XQ0KPiA+DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBE
aXN0cmlidXRpb24gT25seV0NCj4gPg0KPiA+IFllcywgdGhlIGJhZCBzdGF0dXMgbWVzc2FnZSBp
cyBwcmludGVkIHR3aWNlIHdpdGggdGhpcyBwYXRjaC4gSSB0aGluayBpdCdzIGhhcm1sZXNzDQo+
IGFuZCB0aGUgc2Vjb25kIG1lc3NhZ2UgaXMgbW9yZSBjb252ZW5pZW50IGZvciBjdXN0b21lci4N
Cj4gPg0KPiA+IEkgY2FuIGFkZCBhIHBhcmFtZXRlciBmb3IgYW1kZ3B1X3Jhc19lZXByb21fY2hl
Y2tfZXJyX3RocmVzaG9sZCB0byBkaXNhYmxlDQo+IHRoZSBmaXJzdCBtZXNzYWdlIGlmIHlvdSB0
aGluayBwcmludGluZyBtZXNzYWdlIHR3aWNlIGlzIG5vdCBhIGdvb2QgaWRlYS4NCj4gPg0KPg0K
PiBJbnN0ZWFkIG9mIHRoaXMgd2F5LCBjYW4ndCB0aGlzIGJlIGFkZGVkIHRvIGFtZGdwdV9yYXNf
ZG9fcmVjb3ZlcnkoKSBhbmQgc3RvcCBhbGwNCj4gcmVjb3ZlcnkgYWN0aW9ucz8NCj4NCj4gVGhh
bmtzLA0KPiBMaWpvDQo+DQo+ID4gVGFvDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4N
Cj4gPj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxLCAyMDI0IDE6MzAgUE0NCj4gPj4gVG86IFpo
b3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gPj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZGdwdTogcmVwb3J0IGJhZCBzdGF0
dXMgaW4gR1BVIHJlY292ZXJ5DQo+ID4+DQo+ID4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBB
TUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4+DQo+ID4+IFJpZ2h0LCBpdCdzIGZ1
bmN0aW9uYWwuIE15IGNvbmNlcm4gaXMgd2hldGhlciB0aGUga2VybmVsIG1lc3NhZ2UgaW4NCj4g
Pj4gYW1kZ3B1X3Jhc19lZXByb21fY2hlY2tfZXJyX3RocmVzaG9sZCB3aWxsIGJlIHByaW50ZWQg
dHdpY2UuIFRoaXMgaXMNCj4gPj4gdGhlIGVuZCBvZiBncHUgcmVjb3ZlcnkgKGkuZS4sIHJlcG9y
dCBncHUgcmVzZXQgZmFpbGVkIG9yIGdwdSByZXNldCBzdWNjZWVkKS4NCj4gPj4gQ2hlY2tfZXJy
X3RocmVzaG9sZCB3YXMgYWxyZWFkeSBkb25lIGJlZm9yZSByZWFjaGluZyBoZXJlLg0KPiA+Pg0K
PiA+PiBSZWdhcmRzLA0KPiA+PiBIYXdraW5nDQo+ID4+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4+IEZyb206IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPg0KPiA+
PiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDEsIDIwMjQgMTE6NDkNCj4gPj4gVG86IFpoYW5nLCBI
YXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Ow0KPiA+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiA+PiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1OiByZXBvcnQg
YmFkIHN0YXR1cyBpbiBHUFUgcmVjb3ZlcnkNCj4gPj4NCj4gPj4gW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4gPj4NCj4gPj4gSSB0aGlu
ayB0aGUgaWYgY29uZGl0aW9uIGluIGFtZGdwdV9yYXNfZWVwcm9tX2NoZWNrX2Vycl90aHJlc2hv
bGQgaXMNCj4gPj4gZ29vZCBlbm91Z2gsIG5vIG5lZWQgdG8gdXBkYXRlIGl0IHdpdGggaXNfcm1h
Lg0KPiA+Pg0KPiA+PiBUYW8NCj4gPj4NCj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4+PiBGcm9tOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiA+
Pj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxLCAyMDI0IDExOjAwIEFNDQo+ID4+PiBUbzogWmhv
dTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiA+Pj4gQ2M6IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPg0KPiA+Pj4gU3ViamVj
dDogUkU6IFtQQVRDSF0gZHJtL2FtZGdwdTogcmVwb3J0IGJhZCBzdGF0dXMgaW4gR1BVIHJlY292
ZXJ5DQo+ID4+Pg0KPiA+Pj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBE
aXN0cmlidXRpb24gT25seV0NCj4gPj4+DQo+ID4+PiBNaWdodCBjb25zaWRlciBsZXZlcmFnZSBp
c19STUEgZmxhZyBmb3IgdGhlIHNhbWUgcHVycG9zZT8NCj4gPj4+DQo+ID4+PiBSZWdhcmRzLA0K
PiA+Pj4gSGF3a2luZw0KPiA+Pj4NCj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
PiBPbiBCZWhhbGYgT2YNCj4gPj4+IFRhbyBaaG91DQo+ID4+PiBTZW50OiBXZWRuZXNkYXksIEp1
bHkgMzEsIDIwMjQgMTg6MDUNCj4gPj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiA+Pj4gQ2M6IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPg0KPiA+Pj4gU3ViamVj
dDogW1BBVENIXSBkcm0vYW1kZ3B1OiByZXBvcnQgYmFkIHN0YXR1cyBpbiBHUFUgcmVjb3ZlcnkN
Cj4gPj4+DQo+ID4+PiBJbnN0ZWFkIG9mIHByaW50aW5nIEdQVSByZXNldCBmYWlsZWQuDQo+ID4+
Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0KPiA+
Pj4gLS0tDQo+ID4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
IHwgOSArKysrKysrLS0NCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4+PiBpbmRleCAzNTVjMjQ3OGM0YjYuLmI3Yzk2Nzc3
OWI0YiAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jDQo+ID4+PiBAQCAtNTkzMyw4ICs1OTMzLDEzIEBAIGludCBhbWRncHVfZGV2aWNl
X2dwdV9yZWNvdmVyKHN0cnVjdA0KPiA+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPj4+ICAg
ICAgICAgICAgICAgICB0bXBfYWRldi0+YXNpY19yZXNldF9yZXMgPSAwOw0KPiA+Pj4NCj4gPj4+
ICAgICAgICAgICAgICAgICBpZiAocikgew0KPiA+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAg
LyogYmFkIG5ld3MsIGhvdyB0byB0ZWxsIGl0IHRvIHVzZXJzcGFjZSA/ICovDQo+ID4+PiAtICAg
ICAgICAgICAgICAgICAgICAgICBkZXZfaW5mbyh0bXBfYWRldi0+ZGV2LCAiR1BVIHJlc2V0KCVk
KSBmYWlsZWRcbiIsDQo+ID4+PiBhdG9taWNfcmVhZCgmdG1wX2FkZXYtPmdwdV9yZXNldF9jb3Vu
dGVyKSk7DQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAvKiBiYWQgbmV3cywgaG93IHRv
IHRlbGwgaXQgdG8gdXNlcnNwYWNlID8NCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAq
IGZvciByYXMgZXJyb3IsIHdlIHNob3VsZCByZXBvcnQgR1BVIGJhZCBzdGF0dXMgaW5zdGVhZCBv
Zg0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogcmVzZXQgZmFpbHVyZQ0KPiA+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICovDQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoIWFtZGdwdV9yYXNfZWVwcm9tX2NoZWNrX2Vycl90aHJlc2hvbGQodG1wX2FkZXYpKQ0K
PiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfaW5mbyh0bXBfYWRldi0+
ZGV2LCAiR1BVDQo+ID4+PiArIHJlc2V0KCVkKSBmYWlsZWRcbiIsDQo+ID4+PiArDQo+ID4+PiAr
IGF0b21pY19yZWFkKCZ0bXBfYWRldi0+Z3B1X3Jlc2V0X2NvdW50ZXIpKTsNCj4gPj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGFtZGdwdV92Zl9lcnJvcl9wdXQodG1wX2FkZXYsDQo+ID4+PiBB
TURHSU1fRVJST1JfVkZfR1BVX1JFU0VUX0ZBSUwsIDAsIHIpOw0KPiA+Pj4gICAgICAgICAgICAg
ICAgIH0gZWxzZSB7DQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfaW5mbyh0bXBf
YWRldi0+ZGV2LCAiR1BVIHJlc2V0KCVkKQ0KPiA+Pj4gc3VjY2VlZGVkIVxuIiwgYXRvbWljX3Jl
YWQoJnRtcF9hZGV2LT5ncHVfcmVzZXRfY291bnRlcikpOw0KPiA+Pj4gLS0NCj4gPj4+IDIuMzQu
MQ0KPiA+Pj4NCj4gPj4NCj4gPj4NCj4gPg0K
