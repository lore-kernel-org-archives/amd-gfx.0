Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1330FD0C5EC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 09:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A020710E2B1;
	Fri, 25 Oct 2024 09:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AhSBVm9k";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD5A110E2B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 09:20:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHAs25YWvY9hhAWolIz1Te5epGJT5Y3ZiLpXYypNfYKubQMdQOAfVakkTv6/xA0x5kVzKnUcABK69xAT10QVGWRvJXCq6zsu1HtY/XS8zwAvZsqVy+WDqDgyVarZy/9JrtA4nEV13c/TXq50Oh12tHsNoLOPsugX2Mxv8kuJ6fw0vJS3LpS0zsy4Y6o4evGItFo6uU4rkWKWxx0uLpWbhRsclt4LxMvZfuu8XFDtTeamuC3/47qqzohRBm9V6At9PeyWp3ea36HqZPr24fh2kbwcOUtfwjQcx336KcBvcCMZ8gADQv/FRwUkuIFhL7vfsITq76N+8ZEOHjPtDgaaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jWNbpShHu/cns6sCbgPD1WxuvPsZOgIh1XaOfXAStQ=;
 b=Z/PrwbUmCo1vRCiq0A+SXV/8j31wXd6sVoAOoriwhKTJ85KkRIkpqajut9/jeMDPCWaWl0rIwCyDWqVFTcCxmGJOFwa3oRx6tRY3DkONHrK/OkNFEToJCeFVRWr5C7Aiz+BvTJBAnY2EmK1AH1ifQ9iSDAlEU5MJBaT+sNXuwXvAYFGdAMdxR3UrKFGdgaiCrcNSrXqUjx8UHaM3GaCS/I+7YsxIu33Bx/2cfhI5QFoq0evmE4fsQd1icfjYEx20q+NzEiaJPGuFAohdHc6yDMONN6EhvMenhP4CoQYXTin4BaeGeP7GCRf1jRoAAlSjUwJqHye+w+mNKuOwBASwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jWNbpShHu/cns6sCbgPD1WxuvPsZOgIh1XaOfXAStQ=;
 b=AhSBVm9kHnWbbjoiAXSGTTOL636sLst2umU2DBNxFD2YBMGHO9R7XL/7wbY0/0W1KiSCSoBSaXiKIK9HN5FG0D9Xk5ruVT7XnpVpBkS1TYO5JOZ8ASj2qfZQglhPS9KZurSXLF4ghmoDyl8FdeGxeaz7Qvzf+u62igBW/mtfBv0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 09:19:55 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 09:19:55 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: optimize ACA log print
Thread-Topic: [PATCH] drm/amdgpu: optimize ACA log print
Thread-Index: AQHbJq429bp1LgoK80GKW1wS5+6ay7KXEJcAgAAf1GA=
Date: Fri, 25 Oct 2024 09:19:55 +0000
Message-ID: <PH7PR12MB59972E180584F42E756D7D35824F2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241025071922.95979-1-kevinyang.wang@amd.com>
 <fc9e60c6-2796-4ff9-b1c3-f023b07fca85@amd.com>
In-Reply-To: <fc9e60c6-2796-4ff9-b1c3-f023b07fca85@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=89770688-4582-4cb7-bb22-6ff302e918e6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-25T09:18:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA1PR12MB6821:EE_
x-ms-office365-filtering-correlation-id: f1b92bdd-b192-4f0b-8361-08dcf4d63051
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?azEzYkpzV1RrTWJBVGVSM3BMUzVvdm5kMGxnOFdmcWVFVUY5dU8xYS9ZS0Zh?=
 =?utf-8?B?a3NST2dPazhSMjEzeVdkcS9FTFpLNXlnR1FVQmw0dkVnV0ZoODFMTTFZcCtj?=
 =?utf-8?B?Y3JobUpPN2lZUXdBTElUUWxza29nQ2Y2TnphL1Nkb1V5V0xzS3NmbXhlY0lu?=
 =?utf-8?B?QTB4UGMzRW9HMDRoSklWOFlFOWQ5T0ROdDBkenJBREc2NmYzUmFRbWM1Nzha?=
 =?utf-8?B?SEp4L2Z0VWYrNVd3a1MvZWtwaHBaTERhRkV3RnlCTHl0THdVOUNuOUxvZVlq?=
 =?utf-8?B?SFlZdnJ4NEswcGVXVjY5cE1wRE54eDFNUVJBa0lsTkNKbFFpUWdxQzVpbFF1?=
 =?utf-8?B?RWs4RDZFUGJ5V0RxM3lYOENyWGdvcHFxb2UzYWJkTjZvUUs3OU9temZ1Q01L?=
 =?utf-8?B?UU16MW5KaWo4UFJnSDU5bVNoSkNFOEJyMUFEM2ZYY0RsdG9FdDBMS2VneFFP?=
 =?utf-8?B?UnNkSlBVZDNSdS9qK1pTV21vcytlRDJUZ2hlbytSTWNHNUJrZXpxcjhGWkF3?=
 =?utf-8?B?cUdzTzhNc2srajlZaXZUMlJOYUhOUHFHcnFvWUFZY1RQVTlCeHpwdWxPM05B?=
 =?utf-8?B?Ukp5OXkrSjdqT3ltZWFLL3k0dDRoVW85UHB0UG1rQWF4Q085UERMTFI1Szlu?=
 =?utf-8?B?TVFWdzFMQllOS1FPWExqRnNYY3NHOWNGbWJyR0dpVksvT0JrejB0Q3lmWGk5?=
 =?utf-8?B?RXlPNmIyblFmdmQzNVNMMEw2V2FFZ1ROVVJONWdBaEVFSlZUaTJSVWlqdVlv?=
 =?utf-8?B?bFpRbnN3WFZKZDQzdVFiVktoY0dKTjQrall0czY2Tk5CMG8xSEM0QzVnYm53?=
 =?utf-8?B?Wkd5TjdEekUvM2txTzI5emVwcGJPSWVlZlloVkJwSHUwSW1BaUNrN2NrU01D?=
 =?utf-8?B?OWtYYmRveUVaYzR3QmJCUmxuYVd5VllBdXVnM2RVSW44VW9MbjRxcHlUYjdP?=
 =?utf-8?B?aHBKOXhmM005SmdRUmVEaC9Vc2p5M1RSR1VDZUw5aGhnViswdFIrejVOamhs?=
 =?utf-8?B?a2Nta1RpZUZPZVZlOHVBTXNjT1Z2S245ZXgzbFhFREtwVEhpSU02cXNSc2Zv?=
 =?utf-8?B?WU9mYVI1L3ZSTkFBTHJvN3k3WXNYYW5Ha0xtYmd6WDI2KzhqaDczazAvYnBw?=
 =?utf-8?B?cHRwRHdMdi90cnFMMkFvdlk4UDBEMURLOTVENmVOV3crajY3ZFdabmV3anRy?=
 =?utf-8?B?UnYrWFp4d3dGQ1Z3UXczRFRCZW4wQlRQNG5IdDlNMHRuWlhIRm8vWkt6d3d1?=
 =?utf-8?B?N1JpNkVvNzgxSUxHN3QxTjRoMXVzWU93QlVvWkUyZVNxUEFOTkRaazVadUk1?=
 =?utf-8?B?QnZuQWVqdGFMbTNpSkNOL1lJV2FrdWVUMzdJZFVIN3FFeTNJait2ODZiZ2J2?=
 =?utf-8?B?TlIxbUorRHlGMnRNY1JETFltdTd1ME56WDlQM1Y1d2R1d2poSllpNVZXa3NX?=
 =?utf-8?B?dVJQTnhSdWk1S2FBYjdvVUdLbXJISGdCcUhTaXZVREFqeXU3VFFwcldBS0d4?=
 =?utf-8?B?SXg4LzdBbFcvN1lLTjRqR3ZsOG11eGxCTU1uQVpLUDVIeHRydm9BMW1CTThN?=
 =?utf-8?B?TDJRTlRxOGkwWXBuZkZqVXJOaFpUUnlwNkFqWGp0T2k5ZGtieVRLZUxsbHNH?=
 =?utf-8?B?a3EweXk0dmV2bmsvWnhtTnNZUWFjSTJSVEZ3bUpMbHQ3UlZHNEJNRkV5WFhw?=
 =?utf-8?B?M1M5elhBWmI3RFZxWEZvTzFwWWJEL2x4VGNtNFQ1aTJLQlNCVzVuWkJiRms4?=
 =?utf-8?B?bUJLRkJUYWI0VDdhTXZSNWRUUnd6M0tDMUhPVzZSVE1zYnFQR2VJU0FuSTMv?=
 =?utf-8?Q?urimPmcDSPuZ6SArkt28NCoClVTMBtU/Y8G0w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzREcUpOY1ZrNmFwRDM0YVg5ZFlZSHBtdjZFZXZzdHhrUEgwNHRoenAxTXg3?=
 =?utf-8?B?MEswYk1lcFlYZCtBWDZqUW8rZ0tBYk9BcGtZTktYdS9LeFlwN2RzQURVdjlF?=
 =?utf-8?B?N29zRGVzK0pXbkVad1NJYVNOaGJ5a0FLdXJRcVdDM2d2VGJrYkpuZUE3SW53?=
 =?utf-8?B?YlY0d0pjWGdwOEtJdUhycWJtRWFRTW9wUEJla0h2Q3pDN0hwajA3Y0t1NWoy?=
 =?utf-8?B?dXU5Uks3aEdUTmE1Rmk2aVhPVUEwUG1IQjlTL1R5RmlBbmlSK2w5M1VIS3Rw?=
 =?utf-8?B?QVhSQmlJWW9CSUs5anIzMXl4NWRuYnpWbHRpOFd6MUZ0bm5INjFHRlNkcjdw?=
 =?utf-8?B?cVpsT2ZzcjNqWU5LeTBkQjZxQjNxcExwZ2tUWERQbXlEdnVxcXViV2RMWHAx?=
 =?utf-8?B?NDlkcEt4MjRRWEZOcWFKc1NCNk9mV0d1Y2EwbkxSVEZ2cHNFZVd5OC9WRzB2?=
 =?utf-8?B?MHkxbDY0dzJFZ09MMGlpcFY2T3ZjYWN4R3N4RDIxaGdsL1hVWEZtK25xTzk1?=
 =?utf-8?B?bXlaa2U0SkNXbkNXL1ZmbG0vNWJnTS9QUFZ3WHNjU0pNRUpjbXRrZkd1Z1p3?=
 =?utf-8?B?ZGErWDNpZVZwZ1k0OUE2a1VUQktnR3l4L1owMktpTUJodm5ydkVySDF1amVr?=
 =?utf-8?B?czZrUFpBLzdMYmgrSXhPNHlDTHM4YkdqVGJTSnpyZUpNNDAzSENwbjByNThy?=
 =?utf-8?B?Y3dNYVNjY3VCSVorcjNONitPQWx4MXhXUkp1VTd0SUpPQlVwbnlsVXBEQnR0?=
 =?utf-8?B?QWJOekM5QzZCa0pKTytQaUhGdm5IRzdpWWtHVk5RcUNBdzgvWTg4SlNYRnJs?=
 =?utf-8?B?V1lGWjllUE8wZWsxK0tjZ0JLK3l3LzJqRk5CWmRadnViUGkrMWR1R1dZUE52?=
 =?utf-8?B?aWNTamVaT0pXMUpjTDhpNk9PT0ErajlCS3JGQVBSS1duRDNMZnpzbEVCMlpx?=
 =?utf-8?B?WUJoVU0weisrMkkvSklhSFpwcCtldU1pbk04U2IwWTlFakN6VlB6d01sRG9G?=
 =?utf-8?B?QS9vMWYwNWNHN3hOa2pKUnF1eEdMeERSZWtJNEpwTGhobzVabW5PSUJnbHdt?=
 =?utf-8?B?MXBrN3VuRElkcGR2V0dtQVk0emVZRTg3V2NvMWZOcmpGcDBVQVBNZnpSRW1Q?=
 =?utf-8?B?WG1aT3RFREVoL05PTnh3VVhickVUZ25IaGVzKzVoZER0UzJUL1hyczNSYTF2?=
 =?utf-8?B?M05ETUZScnlaejRZaDRveEZJeVdHZ2pBQjJpRjdMcXhLakFEa3BQQTBNS0JM?=
 =?utf-8?B?Y2pLZ1pLNW5PMUJKZFMzcTZLc2krYmVmMUZJdUhyR01nVmxuaWVOcVIrRjhy?=
 =?utf-8?B?a0pPQzNkalZpNjkrQkNUTy9NUGFoU0R5ZlJLU21jcFpUaTFUMzdGaE9ZNDhG?=
 =?utf-8?B?NzdaQm1iWDJvZjZ5RXc3ZEszVWs0NUM0eVl6Slo5b3dZRkJ2OVFMZkM0OUcv?=
 =?utf-8?B?NUJra0lpNjduZXpyV29mbGNUVXpsblJKbmVac09KbFpOQ2g5Mkh5UjRIS2VJ?=
 =?utf-8?B?bzJ3dkRJYU95aFF2TEpzejJpemlSa1VCY1NtZm9CdGQ2UXU0ejdqc0h1dTZE?=
 =?utf-8?B?ZTFuVnoyQmZkdWczRElIVzhnbUlmdmxKTmV6cnF3T0hsYjBCSE5IbDBBb0Js?=
 =?utf-8?B?TUIxcnhseFc4Q2RrVkd0MHVWVU5jWlNtenJFNXFlbm9uTks5TWhHL0NTRFBJ?=
 =?utf-8?B?QUpLVkhEK0xNd2FSVGtFZzdiOGVwcmVrS2RFcmh5cDZsdU9hOXFnaGZGY1E0?=
 =?utf-8?B?Z0dNeGQrdW1qMllVWERKK21pekM3Snp5TUVacFVoMk9Mc0FmNHdDVTV4eTVa?=
 =?utf-8?B?cCtOaFo1Wmhpc1owbUczQnhndGVvS0FrSVhrY2J0V3JOQmZ1OWVCUG5LUXh0?=
 =?utf-8?B?L2FjcS9CWHNTRVJvZTVtVmZ3MERTRU1pYU5DS2dmTit6Q1VsdHFWR1NDM0VH?=
 =?utf-8?B?L2ZvZ3lxUG4yWVpla2FJWFovWXRjRnQvd0pZcGJKT2hScHJ3MHBKODlFN0Rz?=
 =?utf-8?B?ai8vM2ZhdkpKVzhlOFR1eS9MRjhpTzNWeEVJcGpjQm5QN3k2THBCUXV6Z0Vx?=
 =?utf-8?B?VGxoQmNwc1I2MElWNm56ZHVWc2YxVXR5UXNaYnRoeEtPSTladVFXOFBQYUtD?=
 =?utf-8?Q?N7U0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b92bdd-b192-4f0b-8361-08dcf4d63051
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 09:19:55.0301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7KMeiM4sQGIouE/eGvdP/E36sHR3144wiz22k4NzEXa9s/Snbtsv1/um+eOGkG/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+DQpTZW50OiBGcmlkYXksIE9jdG9iZXIgMjUsIDIwMjQgMzoyNSBQTQ0KVG86
IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQu
Y29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBvcHRpbWl6ZSBBQ0EgbG9nIHByaW50DQoNCg0KDQpPbiAxMC8yNS8yMDI0
IDEyOjQ5IFBNLCBZYW5nIFdhbmcgd3JvdGU6DQo+IC0gc2tpcCB0byBwcmludCBDRSBBQ0EgbG9n
Lg0KPiAtIG9wdGltaXplIEFDQSBsb2cgcHJpbnQgZm9yIE1DQS4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tY2EuYyB8IDIxICsrKysrKysrKysrKysrKysrKysr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tY2EuYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tY2EuYw0KPiBpbmRleCAxOGVl
NjAzNzg3MjcuLjNjYTAzYjVlMGY5MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X21jYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9tY2EuYw0KPiBAQCAtMzQ4LDYgKzM0OCwyNCBAQCBzdGF0aWMgYm9vbCBhbWRncHVf
bWNhX2Jhbmtfc2hvdWxkX3VwZGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgZW51bSBh
bWRncA0KPiAgICAgICByZXR1cm4gcmV0Ow0KPiAgfQ0KPg0KPiArc3RhdGljIGJvb2wgYW1kZ3B1
X21jYV9iYW5rX3Nob3VsZF9kdW1wKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBlbnVtIGFt
ZGdwdV9tY2FfZXJyb3JfdHlwZSB0eXBlLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBtY2FfYmFua19lbnRyeSAqZW50cnkpDQo+ICt7DQo+ICsgICAgIGJv
b2wgcmV0Ow0KPiArDQo+ICsgICAgIHN3aXRjaCAodHlwZSkgew0KPiArICAgICBjYXNlIEFNREdQ
VV9NQ0FfRVJST1JfVFlQRV9DRToNCj4gKyAgICAgICAgICAgICByZXQgPSBhbWRncHVfbWNhX2lz
X2RlZmVycmVkX2Vycm9yKGFkZXYsDQo+ICtlbnRyeS0+cmVnc1tNQ0FfUkVHX0lEWF9TVEFUVVNd
KTsNCg0KQUZBSUssIGRlZmVycmVkIGVycm9ycyBhcmUgbm90IGNvcnJlY3RhYmxlLiBTaG91bGRu
J3QgaXQgYmUgY2hlY2tlZCBhZ2FpbnN0IEFNREdQVV9NQ0FfRVJST1JfVFlQRV9ERT8NCg0KVGhh
bmtzLA0KTGlqbw0KDQpba2V2aW5dOg0KDQpJbiB0aGlzIGNhc2UsIHRoZSB0eXBlIGlzIHVzZWQg
dG8gaW5kaWNhdGUgdGhlIFNNVSBiYW5rIGNoYW5uZWwsIG9ubHkgQ0UvREUgYmFuayBjaGFubmVs
IGlzIGF2YWlsYWJsZS4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCg0KPiArICAgICAgICAgICAg
IGJyZWFrOw0KPiArICAgICBjYXNlIEFNREdQVV9NQ0FfRVJST1JfVFlQRV9VRToNCj4gKyAgICAg
ZGVmYXVsdDoNCj4gKyAgICAgICAgICAgICByZXQgPSB0cnVlOw0KPiArICAgICAgICAgICAgIGJy
ZWFrOw0KPiArICAgICB9DQo+ICsNCj4gKyAgICAgcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAg
c3RhdGljIGludCBhbWRncHVfbWNhX3NtdV9nZXRfbWNhX3NldChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgZW51bSBhbWRncHVfbWNhX2Vycm9yX3R5cGUgdHlwZSwgc3RydWN0IG1jYV9iYW5r
X3NldCAqbWNhX3NldCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHJhc19xdWVyeV9jb250ZXh0ICpxY3R4KSAgeyBAQCAtMzczLDcgKzM5MSw4IEBADQo+IHN0
YXRpYyBpbnQgYW1kZ3B1X21jYV9zbXVfZ2V0X21jYV9zZXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIGVudW0NCj4gYW1kZ3B1X21jDQo+DQo+ICAgICAgICAgICAgICAgYW1kZ3B1X21jYV9i
YW5rX3NldF9hZGRfZW50cnkobWNhX3NldCwgJmVudHJ5KTsNCj4NCj4gLSAgICAgICAgICAgICBh
bWRncHVfbWNhX3NtdV9tY2FfYmFua19kdW1wKGFkZXYsIGksICZlbnRyeSwgcWN0eCk7DQo+ICsg
ICAgICAgICAgICAgaWYgKGFtZGdwdV9tY2FfYmFua19zaG91bGRfZHVtcChhZGV2LCB0eXBlLCAm
ZW50cnkpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X21jYV9zbXVfbWNhX2Jhbmtf
ZHVtcChhZGV2LCBpLCAmZW50cnksIHFjdHgpOw0KPiAgICAgICB9DQo+DQo+ICAgICAgIHJldHVy
biAwOw0K
