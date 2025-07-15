Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A251C83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 08:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F0610E551;
	Tue, 15 Jul 2025 08:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fEDDdwfI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A6210E551
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 08:07:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOXsBr7cIA2bCkcI16ZX0GE7eAgKHYayQp4fPQHVVvpsQw1u0Wh9VOse64NpdKPa1j+hNFDY43Vg9lJv/SsVAK2hnAwn0Upftndw752dXv7rAeVaRPlSMzFaBFXNvfzUNTxSK5UWL7TLktt7UeLF/6juF0GE7UEBsUfNb2/LuARYBQRmLj780PgYs0QKDgdlnJ0bA5H8U0zlZekbkSXebL6NBRVN4GF33JUZMsgKMHiuNEYCXi3mov6/+V4V2Xf3pu7nHbpwa8wHJHSXbS08gmOvbXvJ4fsEQBjGUIk8R7VeAN8TLyMILWtk4NsamD73Mr13H1S33eDKQtsx/Oy3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnFSirvgD/bNuNcwmxHa+leQTBAq7xOIDj5qN3sJwng=;
 b=k/5U30pJNhQnKDiR5qpjwo9UTOEN1Ti/FDmKcBQyE0b3Emh/k3EBR9e4xhEVgq4HaOM5KpcG9eScZHWhKYrqO6cVBvKmR9wKNA+S8xReepe+9mTFuZYdLGFoZ4bY7Ot/7KLVvlQoWSyENCGwGWlVy2VOb/OMB7XFQJ0vlYACmsM43ZaKDpldN9Ip2O61PiLkmHtKuRlO+kLN74hUFRKxLLh5uqJ7qQHEmzQWd/lBnhaJPXFYazT6gVMVjH6dDDAVyiyEg4sGhvl3Vy8QbJQ32Q5UpITXhyg749Kv6MUGjLfr/hMqb14VikysXX1mjDEXXS/zH2i73BGxsa7afSY2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnFSirvgD/bNuNcwmxHa+leQTBAq7xOIDj5qN3sJwng=;
 b=fEDDdwfIzitE1ivkINlu4DErAtYU8NFRu2+MtgwNti9TlonBcqvSbFYv73P1TbGQrzDOHMPdb0XnvQ5zwF7m5VCEtXzRlnFT+JYFPJ56WHE6yD/t6nGcEyKdfHG63sebzD0DxVWJ/VBZoPV7uW+Yij51c5iJZ0bvVKNFDVpiLD8=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 08:07:22 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.034; Tue, 15 Jul 2025
 08:07:21 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v6 03/11] drm/amdgpu: rework the userq doorbell object
 destroy
Thread-Topic: [PATCH v6 03/11] drm/amdgpu: rework the userq doorbell object
 destroy
Thread-Index: AQHb8ke+LNPd1RCi8UmlHVo7bOaKHrQs0kmAgAS300A=
Date: Tue, 15 Jul 2025 08:07:20 +0000
Message-ID: <DS7PR12MB600518AE6EC29FDD741B825DFB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-3-Prike.Liang@amd.com>
 <064e192d-feb5-4772-b947-d1557f83a7a2@amd.com>
In-Reply-To: <064e192d-feb5-4772-b947-d1557f83a7a2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-14T12:03:46.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN2PR12MB4255:EE_
x-ms-office365-filtering-correlation-id: b70be05b-1d8b-4766-af65-08ddc3769fbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?UERwZzRpNGRvNFU2MlpZNUJMRzRKVFRwbmJUeW8wVC9NdkdwUk9tUWlRYTZQ?=
 =?utf-8?B?RDNSZXZNUG8vRlBRaTl5bjBlSGdrcUREWU52NFNDcEp3d1pFeCtFQzgvZ1N0?=
 =?utf-8?B?dkJHaGtEaG50Tml1RkNrVWlRaDh4S1Y1WnZJUU0waEFNSTZwTStvVGEwbll4?=
 =?utf-8?B?TGFhZ2FDTllzMDZiVHJzRmFUUW1UWWVSaTEwK1BnREk0NFNOVms0M2ZmRndx?=
 =?utf-8?B?Qkd3djBtQm9uRUUvaDdkbStyNHhFN1daSjJvaWlKZC9GTXJBYU0yYWNtK2NV?=
 =?utf-8?B?TlJHSzVKdUdMcDFISzZwbCtDNkI1bmpMS3lEdUJDYlhNd1djUVdrdlpSOGRw?=
 =?utf-8?B?WTV1N004S002M0ZUelFUcjYzcERzeFJqVUM0bXU3ZGpWQ0NJMzg4bzQwblNa?=
 =?utf-8?B?RW1MVHM5V2huVkpLWnBHbmw1aVYzYk8xRHhVbjJndUFXRm5ycVdrK2c2dkMv?=
 =?utf-8?B?QnZZVU5XTk8zK0Z2eHVGMGhWWTZMNUVZQjVTVWxaa2svOUZGTmpZcXIyMnJH?=
 =?utf-8?B?WU9KanIzRlczL2xFQTFyR3hEUnhZZEJVUkF2SFVSYml2T0U4TWtGTmhsMVp3?=
 =?utf-8?B?VlloQkZYbzNOSkxEUjhaelVTckJXRm84dE0yTEIvVDJ4QXJOTXhwWEZsckdz?=
 =?utf-8?B?VSs1NHJtSnVjWkVZMFAyOWtadlFpZ1JjVHk5L0RBa1libVFaNEZPRkFRSmpx?=
 =?utf-8?B?Skp0SWdleUREUjdMMWFDc0xTcFNxMEpnTnIyRzdUemxxNGg3VTVlc0lub2E4?=
 =?utf-8?B?Z1pKNTRPbmF5WWp4dU9xa29SY2krajlhUzRySTlhYTYreUJNcVM4LytKTks2?=
 =?utf-8?B?TUJtTTBVbjh5UHBhSms3VHROOTlVb2hFRTVyaHNnMmRDSFVZcDV5WUg0T1g5?=
 =?utf-8?B?VFZ1d3htckNsQWdsUzJsWXF6VWo0QmwrdzlKNWJnNkoybVdDdlRGc05RS0ti?=
 =?utf-8?B?VWMzVkE0NmRTeHlMUHJKNzBWWWhuL1JMUHJBdWxvNVBIMlNhQ0hwbWo1MUlz?=
 =?utf-8?B?b3RDcnJueU83TmpjWnNjR1N1dEVvbHgxU1lWNHFZaklTSFF4TlZlUTJwckRn?=
 =?utf-8?B?WTZvbjNqZmZPcjN0YmpXK0xmd0NKbEhlQWMrbnlPOWRyc2JEWkNFWHI5WEls?=
 =?utf-8?B?d3dMSkxGWUpFVDFIRWdXVVY1ZmtDcWdScHYwRk5ndXNSMU96bjhIdkVFZXl5?=
 =?utf-8?B?N1RmNmNiM09BMGhPRDZtT25hU0VpZVZDeVRJamdaVFRmcVR3NnVpeEdldDFy?=
 =?utf-8?B?S0ZrTmR6bGFkNktvTkJqaytvYXc5NGU0ZWxLZEsvZnlHZmtUc2NpeUJyNkxl?=
 =?utf-8?B?aXlPTWpnVEtFTG4rQ3V6eUlVcG5lRU4vMkZOSHp4ZEZvSTBQRTBtNXdzWFdQ?=
 =?utf-8?B?WkJpaEM4UEFlcFlBczQvTVBTMzM3UXh0RkJ1OU91ZXlIYlRHM0Nmam96U2hL?=
 =?utf-8?B?YXFDK2lBaHNZR1BaeGlrN0Q1TmVwUWlDNkE5RFZXNk9namM4Y1RVSHA3bkhN?=
 =?utf-8?B?SXhGR05hN21oeGJnM3hwZXdCRmRFbEo0SDRjUUlsWFJiUlRkWmZOV3k4b2pF?=
 =?utf-8?B?ZG5tUzJiVjR1L1d1ZFY4SjZZakxRWllQOXE2ZTVjT0Y0NkNsbUZVT0lLVnNv?=
 =?utf-8?B?TENmcnplYUZLRmk4SEVtcUlrSmY2Wk1MRWk4bElQYmMyZmJ6MGpoMjR2bXM2?=
 =?utf-8?B?ZXU1VVo2MHhHYUl0eXdROGpWV2lrUTRwRXBMTmtjOHhBd3o0TXc0cS92ZWk5?=
 =?utf-8?B?Vk9OdVNOdU55V1FyWVhvOVZ6dUFKWUU5Nk9SZzk1RGE2bzV6d0tjbHd3emdQ?=
 =?utf-8?B?UVM5bXJUcHgyQzJXdHovc09GZlZ1YTdMNU1pQjgrZ25Vb2duV3lwcVZld0NQ?=
 =?utf-8?B?b0lDQWhWZkVpZDI5b2xCOVlrRUc2a3FqbDhrZVFwMWgrYmdMdjFNV2tzVSs1?=
 =?utf-8?B?blVoMXI5YlpZaEJhL0E3Qnh6WjBkWnZjUVBBbm9OcXdwNTY1L1FwNDBnZEJj?=
 =?utf-8?B?TVg1bmk5bHBBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXE5NGVBS2Y2ckIxYzlldEg1TXN2MjZMYU1NRVMrZlY5OGlJWWRDcDFaYnFh?=
 =?utf-8?B?cHhMa3dmNzlNMVlVWVIvWndnQTJaZmF1enRnOE5XRW42emNOSXpQbUtvQUZJ?=
 =?utf-8?B?S2tTRVQ2RnVWNTZ3WmRYZkgzYU9vUkZVWVdzQjdJODgxTEY2dzRrWlNGQ3Zp?=
 =?utf-8?B?NSs3dGxaWWNvM2dYeU5vM1dNc1BVbmlNR3piTExpV2dybjNnR3pDV3ZxR3E0?=
 =?utf-8?B?OVBDTWdmNm1BNGRyZHBKSjB4Q1JrWDh2eU16dlQ4ZldmY1JGOWF5ZndnVjRV?=
 =?utf-8?B?WlFDOGZUTE8ySG4rM0xRaHc2bHRCenNiYjBRMUlkZTJGeG51YXJpTjNCcVlj?=
 =?utf-8?B?bGdYUStMUWV4UEdHdm4yYitGL0hULysvZjhvdURRdG14dkhiNmNFSXQyNGNW?=
 =?utf-8?B?aUpKcEZtbzJ1VEU0QnlLbFBsdkVwb1lSTG12b2xpZDdaMyt6bXpocFpzVTR3?=
 =?utf-8?B?eWtnS2JMeHdFVnJZb29ORm1zcnRwRkNKVWc3SXExVjJwUmtTWk5ibHlVNkU1?=
 =?utf-8?B?YnN0cTdDWDdHNEtSRk1WeTh4QjA5UXFMTmFvaCtPZzZXbTVUNnZaYVVFamM1?=
 =?utf-8?B?TW9WOTUya284QlM3cjliQ3VxM0R2NVN4WGhCQ1FyZlZhV21wcTY1cmRLbkJj?=
 =?utf-8?B?OFlHSnBKdnNITFNlMXF3azRRK2RiRkl4eHNxRVdhVEwvVXBoTHFLUTFQc0JC?=
 =?utf-8?B?RGJkdjNqYlJ6RTNsTTRJdEN1V0FFaktPKzJCditIK0p4SG5xSCtsT0xHMlJ0?=
 =?utf-8?B?VG9ZbmJRaDJiQ2tJdGt5cUVyY2NDMlp4RVcvM2dRNEovby9PL09VQWRJaDJ2?=
 =?utf-8?B?dzByaGFtV0trZXlVWjBHNXJLYlhvNHcyNVJOYVdMSFhoZVRVRk1qVjdXSmJK?=
 =?utf-8?B?cHdOaDJudlRMU3lQL0NSU3BlRkRHWGNyYkxRMTZwS2k0OXU4SjA5dkVpY3oy?=
 =?utf-8?B?SUEyVkVLUDlCeDdEQ0ltMXhUUWtGdVRXOU92aDFmR0JuQlhEallmTThwYVRp?=
 =?utf-8?B?QTllYlEyZE05Nm9uUW9LSVc3cHpIMURvVEFUM1BkUzQvallkNGw0ZUJWcCtq?=
 =?utf-8?B?OUNMNUEreFFOYWpMNTZFRTJ4dDl4RVk5SkIrY2pJSy9qWWgzZzBhWlNPcVhB?=
 =?utf-8?B?SjZaSWVJOE9DbnBUUG1rRHNBTTBGN2dPaHJDN1NDc0RiZ05DcFNlSXhZcnZ2?=
 =?utf-8?B?d0FpY3h6VVVHcnNPRmErMTRreUVKS0FrOVZ5aHA3QVI4UkR4ck9lWEdCcjVQ?=
 =?utf-8?B?NThXMW5aSDVLL3Z4M1VOQUhZaGRONlRadGt5OWpjaGp2bDdaUTBuRjg0YWFV?=
 =?utf-8?B?WWs5cFVrb2xlS1lYemVSRG1iWERaeHNDaEtTa3pSdkV4RDJDc3o0RkdYWjdu?=
 =?utf-8?B?QXhCZlI1bEJmTEE3V3FaOU9FaGl6V0pITTVsRS9hZENPTW9FTU5uS3NSempv?=
 =?utf-8?B?djhzOG8vNTcyNTc1ck1DUStocGM3eWJ1WFBibmNiNGZJKzE0L0x4MXkvQTNm?=
 =?utf-8?B?U3ZPdXJCSE5NVG8rbWlMZDFkYnhGckZNeEorc1ZPQ0ZuRE80emkyOEMvc3Nw?=
 =?utf-8?B?SWlObFVHdXRUOXcySXBwUHNVRC9JK2F4MS9hN0dXc0RTTWh4eFZvZEtvYlBB?=
 =?utf-8?B?TWVFQzU4Z3c5eWJvaHJ2QlZyQ01Za090c2J5cUowRXBUcTl3bFJIcHRpZ2E4?=
 =?utf-8?B?YVB3SzhydDJaamRTOTVOd051M0JudCt3RGxNYjdCbkh1U3lqcWhxRy93azBu?=
 =?utf-8?B?TlMyYTJPL3FNRmE0TnYrdXlpZ2cwem4weHRUUTlpeXJDRDFLYUJ2Y3o2L2hQ?=
 =?utf-8?B?alY3a1VKUTFobUxMY1R0SGtWdmNSTHduZThRcW96SmZVT2hOWERTUENEV0Jw?=
 =?utf-8?B?Z1pRREQrdnRXUVJmREJhanhNSDVReC9EMUtESUpYOWVyYkhwVU4yd2tjdjB6?=
 =?utf-8?B?Rml4YStVMjQ5Q3REU1VSeUkzV29NN1Y4eDdKSEx1Q0lTbk5LSHNFZHNSU1Q5?=
 =?utf-8?B?NXEwYllUTU9jdHNvOVZpOEsycFFpVERtSW8zaTJjcks3R28vUWFpMXI4enJP?=
 =?utf-8?B?QmZQRG5iRFMwMkpROFlxVFNlb296dUlDdkZETEJNdGNrdy9EeXRGNFJRdUcz?=
 =?utf-8?Q?6B/I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70be05b-1d8b-4766-af65-08ddc3769fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 08:07:20.9857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2naFWO1stRzaxHnW9fDMdTQvRE+zePovdRDU6dYzcQy0lrFtvZUcVQ/fiquTS8D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogRnJpZGF5LCBKdWx5IDExLCAyMDI1IDg6MDEgUE0NCj4gVG86IExpYW5n
LCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDMvMTFdIGRybS9hbWRncHU6IHJld29yayB0aGUg
dXNlcnEgZG9vcmJlbGwgb2JqZWN0DQo+IGRlc3Ryb3kNCj4NCj4gT24gMTEuMDcuMjUgMTE6Mzks
IFByaWtlIExpYW5nIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWltcyB0byB1bmlmeSBhbmQgZGVz
dHJveSB0aGUgdXNlcnEgZG9vcmJlbGwgb2JqZWN0cyBhdA0KPiA+IG1lc191c2VycV9tcWRfZGVz
dHJveSgpLCBhbmQgdGhpcyBjaGFuZ2Ugd2lsbCBhbHNvIGhlbHAgd2l0aCB1bnBpbm5pbmcNCj4g
PiBhbmQgZGVzdHJveWluZyB0aGUgdXNlcnEgZG9vcmJlbGwgb2JqZWN0cyBmb3IgYW1kZ3B1X3Vz
ZXJxX21ncl9maW5pKCkNCj4gPiBkdXJpbmcgcmVsZWFzaW5nIHRoZSBkcm0gZmlsZXMuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4g
PiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyAg
fCA2IC0tLS0tLQ0KPiA+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUu
YyB8IDcgKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3VzZXJxLmMNCj4gPiBpbmRleCAzZDJhN2Y4OTQ2Y2YuLjE1ZTgzM2IxYjNlMyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gQEAg
LTMxMiwxMiArMzEyLDYgQEAgYW1kZ3B1X3VzZXJxX2Rlc3Ryb3koc3RydWN0IGRybV9maWxlICpm
aWxwLCBpbnQNCj4gcXVldWVfaWQpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+
ID4gICAgIH0NCj4gPiAgICAgYW1kZ3B1X3VzZXJxX3dhaXRfZm9yX2xhc3RfZmVuY2UodXFfbWdy
LCBxdWV1ZSk7DQo+ID4gLSAgIHIgPSBhbWRncHVfYm9fcmVzZXJ2ZShxdWV1ZS0+ZGJfb2JqLm9i
aiwgdHJ1ZSk7DQo+ID4gLSAgIGlmICghcikgew0KPiA+IC0gICAgICAgICAgIGFtZGdwdV9ib191
bnBpbihxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+ID4gLSAgICAgICAgICAgYW1kZ3B1X2JvX3VucmVz
ZXJ2ZShxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+ID4gLSAgIH0NCj4gPiAtICAgYW1kZ3B1X2JvX3Vu
cmVmKCZxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+ID4gICAgIHIgPSBhbWRncHVfdXNlcnFfdW5tYXBf
aGVscGVyKHVxX21nciwgcXVldWUpOw0KPiA+ICAgICAvKlRPRE86IEl0IHJlcXVpcmVzIGEgcmVz
ZXQgZm9yIHVzZXJxIGh3IHVubWFwIGVycm9yKi8NCj4gPiAgICAgaWYgKHVubGlrZWx5KHIgIT0g
QU1ER1BVX1VTRVJRX1NUQVRFX1VOTUFQUEVEKSkgeyBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+IGluZGV4IDE0NTdmYjQ5YTc5NC4uMTVh
YTFjYTY3YTExIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21l
c191c2VycXVldWUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191
c2VycXVldWUuYw0KPiA+IEBAIC0zMzYsNiArMzM2LDEzIEBAIG1lc191c2VycV9tcWRfZGVzdHJv
eShzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21ncg0KPiAqdXFfbWdyLA0KPiA+ICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnF1ZXVlKSAgew0KPiA+ICAgICBhbWRn
cHVfdXNlcnFfZGVzdHJveV9vYmplY3QodXFfbWdyLCAmcXVldWUtPmZ3X29iaik7DQo+ID4gKw0K
PiA+ICsgICBpZiAoIWFtZGdwdV9ib19yZXNlcnZlKHF1ZXVlLT5kYl9vYmoub2JqLCB0cnVlKSkg
ew0KPiA+ICsgICAgICAgICAgIGFtZGdwdV9ib191bnBpbihxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+
ID4gKyAgICAgICAgICAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+
ID4gKyAgICAgICAgICAgYW1kZ3B1X3VzZXJxX2Rlc3Ryb3lfb2JqZWN0KHVxX21nciwgJnF1ZXVl
LT5kYl9vYmopOw0KPiA+ICsgICB9DQo+ID4gKw0KPg0KPiBUaGF0IG1ha2VzIG5vIHNlbnNlIHRv
IGRvIGhlcmUuIFRoZSBwaW5uaW5nIGlzbid0IGRvbmUgaW4gbWVzX3VzZXJxX21xZF9jcmVhdGUo
KQ0KPiBlaXRoZXIuDQpZZXMsIGJ1dCB0aGUgZG9vcmJlbGwgQk8gaXMgcGlubmVkIGJ5IGFtZGdw
dV91c2VycV9nZXRfZG9vcmJlbGxfaW5kZXgoKSwgd2hpY2ggaXMgc3RpbGwNCkludm9rZWQgZHVy
aW5nIHVzZXJxIEJPcyBjcmVhdGlvbiBwaGFzZS4gVGhpcyBwYXRjaCB3YW50cyB0byBmcmVlIHRo
ZSBkb29yYmVsbCBvYmplY3QgbGlrZSBzb21lDQpvdGhlciB1c2VycSBvYmplY3RzIGF0IHRoZSB1
bmlmaWVkIHBsYWNlIG9mIG1lc191c2VycV9tcWRfZGVzdHJveSgpLg0KDQo+IEluIGdlbmVyYWwg
d2Ugc2hvdWxkIGF2b2lkIHBpbm5pbmcgdGhlIE1RRCBpbiB0aGUgZmlyc3QgcGxhY2UsIHRoYXQg
YnVmZmVyIG5lZWRzIHRvIGJlDQo+IGZlbmNlcyBpbnN0ZWFkLg0KSWYgaGVyZSBub3QgcGluIHRo
ZSB1c2VycSBkb29yYmVsbCBCTywgdGhlbiB3aWxsIHRoZSBkb29yYmVsbCBpbmRleCBiZSBjaGFu
Z2VkIHdoZW4gdGhlIGRvb3JiZWxsDQpCTyBpcyBtb3ZlZD8NCg0KPiBSZWdhcmRzLA0KPiBDaHJp
c3RpYW4uDQo+DQo+ID4gICAgIGtmcmVlKHF1ZXVlLT51c2VycV9wcm9wKTsNCj4gPiAgICAgYW1k
Z3B1X3VzZXJxX2Rlc3Ryb3lfb2JqZWN0KHVxX21nciwgJnF1ZXVlLT5tcWQpOyAgfQ0KDQo=
