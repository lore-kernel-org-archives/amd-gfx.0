Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59C9C3DA47
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 12:45:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86ECE10E53C;
	Tue,  9 Jul 2024 12:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QdZmsOIo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E275810E53C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 12:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHtXdE9yZRB83Ptk6RLIVtiZv6OYzw+7vJcbFmvNEOM/HVz5C8vmGUqI5vNSk6RyzAetygCsZaD6xbkgwM+3hDXJ5lparaiWvOFABN1GhcogfCnoA5mrWaoDCaJ9dCDtcbEawKye2jx82Uu96bsM3Nu5ZRhQHZ8SOp0QsrKqrVn4X/2SCwMJcq2VwO0+Oux1bJE132045gE3bhcWgPMgb/HEj/toCrOT+B92vwTCn2401tD+gqP2cRV1LjG4rzDT/ryYgrRbkC/x+9HqBQvHlT9/lFYN3CESnON+ahJLoVknP1Ng2fP+C1Y/w3PojkTz2gsn1lvfBYP9DRtpJbqXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsUThg7Co58CD9oLFH3rwd7vXA4MQIS9NMxapO4JZHg=;
 b=aNl7AQu5pfMd+mhC7zK11c2FIyeDDyMfQ7ye5T5PlQ60zlIVOr5KJc7rq3fmrIkg6f4MSKdhQqEijOayusRWDG/5uGhmo/NWk+kFe/o50mfJUu5C13nxCQvYJ+2lEWjd02PtigGw9XuTwyAxfzoX6Tsouh/fyRh5iRV3ogwCWumBCvM2ZgyJuTFv7adGVkjMU35z7ySiq7RHcbb1E1OZHbhV0nWjW4HjIJxFfLa/33n7oXeXttCPjZJ7Zu0gKHCZy9iO5xGrUVOYGWrCAqjIHf9Z3dfF/4+QM5lehs0FOEhEL/Xr9jASmh407XVDTobPaXXNLh7JBQeLJsMPslCdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsUThg7Co58CD9oLFH3rwd7vXA4MQIS9NMxapO4JZHg=;
 b=QdZmsOIonUqjy0a0J/++1fAIdfCje7+iTnZO5OwdMJuuUDsCi5uSmEtcccTJOEJTY6ZJDnPf1ai4i+hoNxWJlZSnhgeeUrTwwj1J4Yo1C73mFNr4+UyoeL2/CYCfiXCC3rCULwc95nPM1ltk1PTgkNTV/SJ1QC0Q2fz4m2PebVQ=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Tue, 9 Jul 2024 12:45:31 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%6]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 12:45:31 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Slivka, Danijel"
 <Danijel.Slivka@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Ignore initial value in smu response
 register
Thread-Topic: [PATCH v2] drm/amd/pm: Ignore initial value in smu response
 register
Thread-Index: AQHa0TnLt4yjbiQR3kyjP0tM0zR6sLHuI4yAgAA1tMA=
Date: Tue, 9 Jul 2024 12:45:31 +0000
Message-ID: <DS7PR12MB60716A03AE2FC2EA6F4AC66D8EDB2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240708133106.36933-1-danijel.slivka@amd.com>
 <e89d821f-aefe-40a0-a03c-3c610377b24e@amd.com>
In-Reply-To: <e89d821f-aefe-40a0-a03c-3c610377b24e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e9b8ceb1-e3b2-4ab8-84c3-4de5b473a7f0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-09T12:45:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DM4PR12MB6376:EE_
x-ms-office365-filtering-correlation-id: d04440a2-694b-466c-e900-08dca01504d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aGVmSnp6M1lKUXdKdFBlWDV3Z2ZCbEZlYTB3OWluRWlSemI0MHNzaTZ1SXpS?=
 =?utf-8?B?b3FYOFpNU3YyL2dDZjBiNkhGai9PVDBNMlhIZTFCcU1vN2FkdSthaklXRzA1?=
 =?utf-8?B?dEpKdXNCbHFxK2phamUwakh6OVduNW5RQS9KRDR4N01jeE5EaGNpdS85VGZz?=
 =?utf-8?B?MFYyWkJCcnZBZVBFd2lJLzJyaUJoUDUrbXlFVDdweWZOaGRZUEtEbHRpb01y?=
 =?utf-8?B?c3NRZit3aTRia095K1l2Qk9QYldMbnNKZWxXTmNDMzM2a1RkTE1MK0tWMENJ?=
 =?utf-8?B?enRUZGZFMHM3VWNMVmd1dCtSenorMGNOSlhMcXl1QlJwSTUrNGZDL1RxWTJW?=
 =?utf-8?B?T1ZCK3V6OTRjUjg2UjNJcGZRZzY0bFdXZExSQmwzd3BkVTI4Q1FGYlFYSmpM?=
 =?utf-8?B?eG1tQmRVRHJaUUpxVm9LZ2NnK09IMGhCRGdJcHRYUUllMTIxUkRCREcrMTMz?=
 =?utf-8?B?KzhvcStiTFBBYjIxUDRGQVpHSk5kNThJZk1xYUtxb01zR2xSNHJFbFh1VDZs?=
 =?utf-8?B?Q0txNlhWNG9kbUlqQVJXODdKUTVHRzZFY1RmV0xKMzU2YnpONTRkd3hRNWRu?=
 =?utf-8?B?TnpuRXVCdk1DU1I4bW1wbHB3ZTc2NTF0aHZMeUU2azFlMWRROTdxdVAwd3ZZ?=
 =?utf-8?B?T2t4WG1aWjFrTzBTdFRsMFpaK0VSN2U4bFlpTHlYV3VpMTRSVU16OXBYUGlk?=
 =?utf-8?B?V3p2eUNhZWtyYXFBZUwwQlJzRm1MeEdmYVBGYzhQcERrN2JCUXBVVnl4SDBI?=
 =?utf-8?B?V3dqdDVWOW5jR01qZS9DYjlzaDJXVVZPWFB0SEp4ZFNOdG52c1FSZlBJbDEr?=
 =?utf-8?B?emhkWU9YQmNLd0NiSXJMUFZ0MUxVZytqQzdYQy9zcWNHM3d1OG9GM2Q1YXR1?=
 =?utf-8?B?M3JDUjVmTVpkMStHT2xQNlQwTGREVDR6dWFRaGZJZGN5b0c4bkkxNHRGR0ts?=
 =?utf-8?B?NGZ6bzZGNUhOWHdSMCtzZE5UWUxKSklubWFQWXdQMnFPcHQxTjNtR1FsZWxI?=
 =?utf-8?B?dTNrOW83bDczeFhBVTBRWHhDVUFlSi9CT3prMXI0QWwyZzRWSDBicDUraTg3?=
 =?utf-8?B?MHRHU0NNblRiUTFFRlFQYlBYcWZsQUVKS3RJUzVXRzFmbExIUm1jYm9zcGxw?=
 =?utf-8?B?ckwyL2NGR1pYWllXN3NDdEVPaDM5OWJoSlR6MWJRNVo1SVVvS2NKZDdCb2tr?=
 =?utf-8?B?NEc2aU9PYys0Y2YvL1FjQmlrVVZKbVRINDhNNlF3RXpiMXlvbGd2TExDZ1F4?=
 =?utf-8?B?UGs3djNsNGFpZHNSTHFIWDVTQjRLZk1nQ1BvN1lqVUoyQWkveXh5b1BDS2VW?=
 =?utf-8?B?T2NkQVlZS0hpR3I0czNwYm5JRG9IZzM3VWVaWnp4bkJiR01WUC9TTkxmbENq?=
 =?utf-8?B?eHAwWUZaYm9USDFNTjBvc2JFZ1hmb0xwVUlHWkM3K3prYzZKTDNRMG14RW16?=
 =?utf-8?B?UlZzSWN4WVJadGJnK0I4ZFEyZWNvSmQ1ZEpySUhKbzljbnRzalR2MERTN0R0?=
 =?utf-8?B?NTRTTFlqczBjT1ZLWjhCcFlRVnJUcHNTa09hQzEwSVJLaGE2WEZIZ09LQnJS?=
 =?utf-8?B?cGxDTEpsUXAyVGNFRlFEVVM1aE5lblhjNUxRakZtOVpmTmxtSGZoY3RRdkho?=
 =?utf-8?B?QnNTQ3hDRWUydmgybWZSMFBtNmFtT09rUFkySTNZbHloM3lRK085ZkpIckJE?=
 =?utf-8?B?TXRoU0tBRUY3TDBkVDRjV0h6cFYweVB3ckR5T3dCckp6aEk4RFdWa2RQNGMw?=
 =?utf-8?B?RHhsZFlFaGEyKzRDNFI1YlNVMTFBVm0wczlBdkpiMVloUVlLcVpSSlB1ZEtt?=
 =?utf-8?B?K2ROKzdWVkxjRURQbTI4aFVXSHlQMkN4amN1WExYSmIrbHAzd0FBdWZlM2U4?=
 =?utf-8?B?b1JDZytHSEtyK0hNeHpVQ3JsVW1RdEREZ3hHeHZxdXBZT0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1RNZFBObWtzaWVqbXBoM3p3MURoOFd0bWI3RHozNW5vTjhLK0ZNenl1QjNt?=
 =?utf-8?B?MmxVaDZJZGlLWk1GRmx0VXM2VUVKd0wySEV3Y0RKbkVCcWJ0elhhaU1PRXhY?=
 =?utf-8?B?cUNNYnJlOU5QS3dhbklYRmN0WGxqbkNpUWhMVnRQYW8xdFp4bVgzV00zNGVp?=
 =?utf-8?B?MlV2MlVDS0hKVGZ2U0pIRStXUFVBdW9wY2kyR00rSmU1aVZWQnBqeThuUUox?=
 =?utf-8?B?Nk03eXcvQUNVeU1Cc0Z6K0Q3VUJrN015MHl6dGRlOGFrMW9GRUJ3UFNLajRY?=
 =?utf-8?B?RXMvS3FXcVF1d0JDZno2VmNjQVBTakljNU5ydk9BUnJUQVd0bmQra1UrMC8w?=
 =?utf-8?B?WmVObU9aUTMwWVhVU1dwRUVHeksxNUxqZkgvcCsvTm81d2E2RjZEcTVURGdB?=
 =?utf-8?B?dUJmN1FadFJVamt1cVd5eVFFZjFRMDgvcVdjdEZKY3Vkc0lVZkNPc1M3SDJV?=
 =?utf-8?B?d3M1UnBsMXgzS0RKRHVXZGFDb2ZKaHl4bEdHZGxXNUhqdGVIOVZNczR0bnRj?=
 =?utf-8?B?M05uTUFSdCtqZEVNaXF4RnA4V2xaQnBSaWhKa20reCt0YjlDSSs0NTZ4cjho?=
 =?utf-8?B?SVRxZHlrS3BkZEtEWk8zdXRxSGtEOWFxbUw2OURTNXJYRkdCRHQvQVcrVERQ?=
 =?utf-8?B?YlhzOHVVM05Vc2Z2ekhtSHFEcU9YZjlka0ozOTBzZFp0d1lSekkwV3FjOGRG?=
 =?utf-8?B?RHZXR3oxWm5LZlp4U081bHp1TTd0SGRHVGUyQ290by9aZVUvWVo2Y0JrNXJC?=
 =?utf-8?B?RzAvS0JNZ3d5OUdIZkpaL0F0V011eS8wUkhnMVU1bHZ5RGIxZFV6Qi8xajZK?=
 =?utf-8?B?a04zM3RjN00rVkJSMzdhVXRIbVVVS1llb2RDd2ZsR2dTV0hBazNrdlNkRmJq?=
 =?utf-8?B?UE91eFpIVUpiUG11Z2dyUkh1NWY0d0N0VmJsVmhBa282Z05pVW9TOG9MQmhk?=
 =?utf-8?B?T2NEd2VpWnhtdk5vVTlPN0pXSWhjRUhNSDk5YXVCdzQyY1paekJDaVdDNmhP?=
 =?utf-8?B?aC8rS1AxSlRkcVVYaHdKQlZVMlR6L2tiMFVoTmVuM1RUM3BocHpWSm1EOWo2?=
 =?utf-8?B?cndCZ3hIdmsrNWp4MmN5TWlKd3ROQ3RkZ29CTzQ3TjBIOGhDTFFSNjZyODRB?=
 =?utf-8?B?OTFjcVJ2WHFFV05sd0U2NDBLU0tCbHZPSUoyd0RRU2M4Q0NibC85L0p5a2g4?=
 =?utf-8?B?UTI4RVdKVExPNGtXR2xOMjd1L2k1Z3doYzhKcGUwMGRJd0d6T3ladldGVXJn?=
 =?utf-8?B?WGErQlJOVjhhVVdoRlJ6ekNTWGQ3OUxaQ0IxTVlEN1hTcGJFbWpEWXRUdjQw?=
 =?utf-8?B?TjI2N2x2T3k2UWJRTktnL2w3TTVvVUpUc2pmYTB3SUZ4NStRWFJwK2hySkY5?=
 =?utf-8?B?TGQvckJVcTl3QXNsRWw1QkJOU0VnbTUxd1ZIMFQ4dkhaZTN3Y29LVTJkbDNW?=
 =?utf-8?B?L2I4a2U5TGlBRzF5YlUyQVVYRStpeXBJbDBBK1U2N2UwVnh4S1ZFZlRScGN0?=
 =?utf-8?B?MlhHdy9XbWRJVjZBZkVGb3QvWGZ3dDVNcW1CNEM2NkJhR1k1bllJSklvcXpS?=
 =?utf-8?B?SUQ3dlhtcEZkSm9vMG8vSXB5NVA5dDdsc1NGM2djT3J1VXpEYnYzalRlbTYy?=
 =?utf-8?B?ZmRXSkdYNlFxUGJEZitCeEhuYW53REpla0dlMk9YT0dxWnpxZWVRQlgrZXpz?=
 =?utf-8?B?NjU5VnhpNkxJUlhkeUh4dkErNmdvbWdHcVdCcWVCdkpXUEdWTzRqWWpucVVV?=
 =?utf-8?B?aSsvU1dQa0RpRzZHT3JJNjlFZTYvaExpTmkzS3ZtK3RZV3NtaU1MWmFhMndS?=
 =?utf-8?B?QW0rbnI2L2ZVQkhJWEU4ZDZtWWVyV0NNNWRISEMzOXQ2YS9NRG9GNktJc0hF?=
 =?utf-8?B?eVZMVVJxTHBoWWpjb3ZIWCsrSzdNSjdpVkpZdkc2Zkxkd2lWOFdmZGZDbjVI?=
 =?utf-8?B?V29hSmFpOG5yNDNwa2xWaThUcjZZU21FZW05VG5VNDRiSEExN25neGJvbjQv?=
 =?utf-8?B?Z0JvalVYVUdnLy9CSlFjV1l4RmRObG95eHg2cWpXZlc5Q0F3ZkVna2ZvM0Jw?=
 =?utf-8?B?ZnBEdzFwWWphc0VIMzMyQTFQUDRDUUUxeWx0Y3JXQXVTZ29pQTRqUThudTRK?=
 =?utf-8?Q?UL/A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04440a2-694b-466c-e900-08dca01504d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 12:45:31.5081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZP9yK5bW4BZ6hoGUBmjZdeeici+Am3RUpu/08Z6PKpljXl2T9w+b1csjO2SGc6tiDHhLzLirJgoGXVsZHFkYLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
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
Cg0KUmV2aWV3ZWQtYnk6IEFzYWQgS2FtYWwgPGFzYWQua2FtYWxAYW1kLmNvbT4NCg0KVGhhbmtz
ICYgUmVnYXJkcw0KQXNhZA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IExhemFyLCBMaWpvDQpTZW50OiBUdWVzZGF5LCBKdWx5IDksIDIwMjQgMzowMyBQTQ0KVG86IFNs
aXZrYSwgRGFuaWplbCA8RGFuaWplbC5TbGl2a2FAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQpDYzogV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5j
b20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjJdIGRybS9hbWQvcG06IElnbm9yZSBpbml0aWFsIHZhbHVlIGluIHNtdSByZXNwb25z
ZSByZWdpc3Rlcg0KDQoNCg0KT24gNy84LzIwMjQgNzowMSBQTSwgRGFuaWplbCBTbGl2a2Egd3Jv
dGU6DQo+IFdoeToNCj4gSWYgdGhlIHJlZyBtbU1QMV9TTU5fQzJQTVNHXzkwIGlzIGJlaW5nIHdy
aXR0ZW4gdG8gZHVyaW5nIGFtZGdwdQ0KPiBkcml2ZXIgbG9hZCBvciBkcml2ZXIgdW5sb2FkLCBz
dWJzZXF1ZW50IGFtZGdwdSBkcml2ZXIgbG9hZCB3aWxsIGZhaWwNCj4gYXQgc211X2h3X2luaXQu
IFRoZSBkZWZhdWx0IG9mIG1tTVAxX1NNTl9DMlBNU0dfOTAgcmVnaXN0ZXIgYXQgYSBjbGVhbg0K
PiBlbnZpcm9ubWVudCBpcyAweDEgYW5kIGlmIHZhbHVlIGRpZmZlcnMgZnJvbSBleHBlY3RlZCwg
YW1kZ3B1IGRyaXZlcg0KPiBsb2FkIHdpbGwgZmFpbC4NCj4NCj4gSG93IHRvIGZpeDoNCj4gSWdu
b3JlIHRoZSBpbml0aWFsIHZhbHVlIGluIHNtdSByZXNwb25zZSByZWdpc3RlciBiZWZvcmUgdGhl
IGZpcnN0IHNtdQ0KPiBtZXNzYWdlIGlzIHNlbnQsaWYgc21jIGluIFNNVV9GV19JTklUIHN0YXRl
LCBqdXN0IHByb2NlZWQgZnVydGhlciB0bw0KPiBzZW5kIHRoZSBtZXNzYWdlLiBJZiByZWdpc3Rl
ciBob2xkcyBhbiB1bmV4cGVjdGVkIHZhbHVlIGFmdGVyIHNtdQ0KPiBtZXNzYWdlIHdhcyBzZW50
IHNldCwgc21jX3N0YXRlIHRvIFNNVV9GV19IQU5HIHN0YXRlIGFuZCBubyBmdXJ0aGVyDQo+IHNt
dSBtZXNzYWdlcyB3aWxsIGJlIHNlbnQuDQo+DQo+IHYyOg0KPiBTZXQgU01VX0ZXX0lOSVQgc3Rh
dGUgYXQgdGhlIHN0YXJ0IG9mIHNtdSBod19pbml0L3Jlc3VtZS4NCj4gQ2hlY2sgc21jX2Z3X3N0
YXRlIGJlZm9yZSBzZW5kaW5nIHNtdSBtZXNzYWdlIGlmIGluIGhhbmcgc3RhdGUgc2tpcA0KPiBz
ZW5kaW5nIG1lc3NhZ2UuDQo+IFNldCBTTVVfRldfSEFORyBvbmx5IGluIGNhc2UgdW5leHBlY3Rl
ZCB2YWx1ZSBpcyBkZXRlY3RlZA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pamVsIFNsaXZrYSA8
ZGFuaWplbC5zbGl2a2FAYW1kLmNvbT4NCg0KUGF0Y2ggbG9va3MgZ29vZCB0byBtZQ0KDQogICAg
ICAgIFJldmlld2VkLWJ5OiBMaWpvIExhemFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQoNCkNvcHlp
bmcgS2VubmV0aC9LZXZpbiBhcyB3ZWxsLg0KDQpUaGFua3MsDQpMaWpvDQoNCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYyAgICAgfCAgMiArKw0KPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5oIHwgIDcgKysrKw0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMgICAgICAgIHwgMzQgKysr
KysrKysrKysrKysrKy0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9hbWRncHVfc211LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdw
dV9zbXUuYw0KPiBpbmRleCBkNzliZGIxZThjZGYuLmZiODY0M2QyNWQxYiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gQEAgLTE3NTUsNiArMTc1
NSw4IEBAIHN0YXRpYyBpbnQgc211X3N0YXJ0X3NtY19lbmdpbmUoc3RydWN0IHNtdV9jb250ZXh0
ICpzbXUpDQo+ICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gc211LT5hZGV2Ow0K
PiAgICAgICBpbnQgcmV0ID0gMDsNCj4NCj4gKyAgICAgc211LT5zbWNfZndfc3RhdGUgPSBTTVVf
RldfSU5JVDsNCj4gKw0KPiAgICAgICBpZiAoYWRldi0+ZmlybXdhcmUubG9hZF90eXBlICE9IEFN
REdQVV9GV19MT0FEX1BTUCkgew0KPiAgICAgICAgICAgICAgIGlmIChhbWRncHVfaXBfdmVyc2lv
bihhZGV2LCBNUDFfSFdJUCwgMCkgPCBJUF9WRVJTSU9OKDExLCAwLCAwKSkgew0KPiAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKHNtdS0+cHB0X2Z1bmNzLT5sb2FkX21pY3JvY29kZSkgeyBkaWZm
IC0tZ2l0DQo+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5o
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5oDQo+IGlu
ZGV4IGEzNGM4MDJmNTJiZS4uYjQ0YTE4NWQwN2U4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3N3c211L2luYy9hbWRncHVfc211LmgNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5oDQo+IEBAIC00OTUsNiArNDk1LDEyIEBA
IHN0cnVjdCBzdGJfY29udGV4dCB7DQo+ICAgICAgIHNwaW5sb2NrX3QgbG9jazsNCj4gIH07DQo+
DQo+ICtlbnVtIHNtdV9md19zdGF0dXMgew0KPiArICAgICBTTVVfRldfSU5JVCA9IDAsDQo+ICsg
ICAgIFNNVV9GV19SVU5USU1FLA0KPiArICAgICBTTVVfRldfSEFORywNCj4gK307DQo+ICsNCj4g
ICNkZWZpbmUgV09SS0xPQURfUE9MSUNZX01BWCA3DQo+DQo+ICAvKg0KPiBAQCAtNTYyLDYgKzU2
OCw3IEBAIHN0cnVjdCBzbXVfY29udGV4dCB7DQo+ICAgICAgIHVpbnQzMl90IHNtY19md19pZl92
ZXJzaW9uOw0KPiAgICAgICB1aW50MzJfdCBzbWNfZndfdmVyc2lvbjsNCj4gICAgICAgdWludDMy
X3Qgc21jX2Z3X2NhcHM7DQo+ICsgICAgIHVpbnQ4X3Qgc21jX2Z3X3N0YXRlOw0KPg0KPiAgICAg
ICBib29sIHVwbG9hZGluZ19jdXN0b21fcHBfdGFibGU7DQo+ICAgICAgIGJvb2wgZGNfY29udHJv
bGxlZF9ieV9ncGlvOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXVfY21uLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYw0K
PiBpbmRleCA1NTkyZmQ4MjVhYTMuLmQ3Yzk4M2ExZjNmNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4gQEAgLTMxNSwxMSArMzE1LDIwIEBAIGludCBzbXVf
Y21uX3NlbmRfbXNnX3dpdGhvdXRfd2FpdGluZyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4g
ICAgICAgaWYgKGFkZXYtPm5vX2h3X2FjY2VzcykNCj4gICAgICAgICAgICAgICByZXR1cm4gMDsN
Cj4NCj4gLSAgICAgcmVnID0gX19zbXVfY21uX3BvbGxfc3RhdChzbXUpOw0KPiAtICAgICByZXMg
PSBfX3NtdV9jbW5fcmVnMmVycm5vKHNtdSwgcmVnKTsNCj4gLSAgICAgaWYgKHJlZyA9PSBTTVVf
UkVTUF9OT05FIHx8DQo+IC0gICAgICAgICByZXMgPT0gLUVSRU1PVEVJTykNCj4gKyAgICAgaWYg
KHNtdS0+c21jX2Z3X3N0YXRlID09IFNNVV9GV19IQU5HKSB7DQo+ICsgICAgICAgICAgICAgZGV2
X2VycihhZGV2LT5kZXYsICJTTVUgaXMgaW4gaGFuZ2VkIHN0YXRlLCBmYWlsZWQgdG8gc2VuZCBz
bXUNCj4gK21lc3NhZ2UhXG4iKTsNCj4gICAgICAgICAgICAgICBnb3RvIE91dDsNCj4gKyAgICAg
fQ0KPiArDQo+ICsgICAgIGlmIChzbXUtPnNtY19md19zdGF0ZSA9PSBTTVVfRldfSU5JVCkgew0K
PiArICAgICAgICAgICAgIHNtdS0+c21jX2Z3X3N0YXRlID0gU01VX0ZXX1JVTlRJTUU7DQo+ICsg
ICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICAgcmVnID0gX19zbXVfY21uX3BvbGxfc3RhdChz
bXUpOw0KPiArICAgICAgICAgICAgIHJlcyA9IF9fc211X2Ntbl9yZWcyZXJybm8oc211LCByZWcp
Ow0KPiArICAgICAgICAgICAgIGlmIChyZWcgPT0gU01VX1JFU1BfTk9ORSB8fCByZXMgPT0gLUVS
RU1PVEVJTykNCj4gKyAgICAgICAgICAgICAgICAgICAgIGdvdG8gT3V0Ow0KPiArICAgICB9DQo+
ICsNCj4gICAgICAgX19zbXVfY21uX3NlbmRfbXNnKHNtdSwgbXNnX2luZGV4LCBwYXJhbSk7DQo+
ICAgICAgIHJlcyA9IDA7DQo+ICBPdXQ6DQo+IEBAIC0zNTAsNiArMzU5LDkgQEAgaW50IHNtdV9j
bW5fd2FpdF9mb3JfcmVzcG9uc2Uoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQo+ICAgICAgIHJl
ZyA9IF9fc211X2Ntbl9wb2xsX3N0YXQoc211KTsNCj4gICAgICAgcmVzID0gX19zbXVfY21uX3Jl
ZzJlcnJubyhzbXUsIHJlZyk7DQo+DQo+ICsgICAgIGlmIChyZXMgPT0gLUVSRU1PVEVJTykNCj4g
KyAgICAgICAgICAgICBzbXUtPnNtY19md19zdGF0ZSA9IFNNVV9GV19IQU5HOw0KPiArDQo+ICAg
ICAgIGlmICh1bmxpa2VseShzbXUtPmFkZXYtPnBtLnNtdV9kZWJ1Z19tYXNrICYgU01VX0RFQlVH
X0hBTFRfT05fRVJST1IpICYmDQo+ICAgICAgICAgICByZXMgJiYgKHJlcyAhPSAtRVRJTUUpKSB7
DQo+ICAgICAgICAgICAgICAgYW1kZ3B1X2RldmljZV9oYWx0KHNtdS0+YWRldik7DQo+IEBAIC00
MTgsNiArNDMwLDE1IEBAIGludCBzbXVfY21uX3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHN0cnVj
dCBzbXVfY29udGV4dCAqc211LA0KPiAgICAgICAgICAgICAgICAgICAgICAgZ290byBPdXQ7DQo+
ICAgICAgIH0NCj4NCj4gKyAgICAgaWYgKHNtdS0+c21jX2Z3X3N0YXRlID09IFNNVV9GV19IQU5H
KSB7DQo+ICsgICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJTTVUgaXMgaW4gaGFuZ2Vk
IHN0YXRlLCBmYWlsZWQgdG8gc2VuZCBzbXUgbWVzc2FnZSFcbiIpOw0KPiArICAgICAgICAgICAg
IGdvdG8gT3V0Ow0KPiArICAgICB9IGVsc2UgaWYgKHNtdS0+c21jX2Z3X3N0YXRlID09IFNNVV9G
V19JTklUKSB7DQo+ICsgICAgICAgICAgICAgLyogSWdub3JlIGluaXRpYWwgc211IHJlc3BvbnNl
IHJlZ2lzdGVyIHZhbHVlICovDQo+ICsgICAgICAgICAgICAgcG9sbCA9IGZhbHNlOw0KPiArICAg
ICAgICAgICAgIHNtdS0+c21jX2Z3X3N0YXRlID0gU01VX0ZXX1JVTlRJTUU7DQo+ICsgICAgIH0N
Cj4gKw0KPiAgICAgICBpZiAocG9sbCkgew0KPiAgICAgICAgICAgICAgIHJlZyA9IF9fc211X2Nt
bl9wb2xsX3N0YXQoc211KTsNCj4gICAgICAgICAgICAgICByZXMgPSBfX3NtdV9jbW5fcmVnMmVy
cm5vKHNtdSwgcmVnKTsgQEAgLTQyOSw4ICs0NTAsMTEgQEAgaW50DQo+IHNtdV9jbW5fc2VuZF9z
bWNfbXNnX3dpdGhfcGFyYW0oc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAgICAgIF9fc211
X2Ntbl9zZW5kX21zZyhzbXUsICh1aW50MTZfdCkgaW5kZXgsIHBhcmFtKTsNCj4gICAgICAgcmVn
ID0gX19zbXVfY21uX3BvbGxfc3RhdChzbXUpOw0KPiAgICAgICByZXMgPSBfX3NtdV9jbW5fcmVn
MmVycm5vKHNtdSwgcmVnKTsNCj4gLSAgICAgaWYgKHJlcyAhPSAwKQ0KPiArICAgICBpZiAocmVz
ICE9IDApIHsNCj4gKyAgICAgICAgICAgICBpZiAocmVzID09IC1FUkVNT1RFSU8pDQo+ICsgICAg
ICAgICAgICAgICAgICAgICBzbXUtPnNtY19md19zdGF0ZSA9IFNNVV9GV19IQU5HOw0KPiAgICAg
ICAgICAgICAgIF9fc211X2Ntbl9yZWdfcHJpbnRfZXJyb3Ioc211LCByZWcsIGluZGV4LCBwYXJh
bSwgbXNnKTsNCj4gKyAgICAgfQ0KPiAgICAgICBpZiAocmVhZF9hcmcpIHsNCj4gICAgICAgICAg
ICAgICBzbXVfY21uX3JlYWRfYXJnKHNtdSwgcmVhZF9hcmcpOw0KPiAgICAgICAgICAgICAgIGRl
dl9kYmcoYWRldi0+ZGV2LCAic211IHNlbmQgbWVzc2FnZTogJXMoJWQpIHBhcmFtOiAweCUwOHgs
IHJlc3A6DQo+IDB4JTA4eCxcDQo=
