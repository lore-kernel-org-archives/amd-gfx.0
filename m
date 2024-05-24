Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37324C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 14:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EF9E10E0D5;
	Fri, 24 May 2024 14:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4mGiPEWx";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A76910E0D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 14:38:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ulk0LaH/2HKlNEJfTyr+7qOvr/CysZfAwdqi90amENXRwgTLUkrFI04zchlYTBFYhJ6bXZ6JeGRfLvRptamddrFCF0e/VNmQSYGzLzAw4eCRG/LbIDeQzbJzehcoZPvG7P1KcIvmEiFHp96ZlO+rcCUeSjNB4786coS/AiGlCXbE7c65CPlOZCKK6X9/sEzn6FUpoRfUzpRIrYFduWLDEY1OrS/xSMXogLsX9x2S2OR056gTa5onFp2K3R3NmHlTv1kBbkTjPiBLr52yShu3KqxauBSzUfoTB4pEh76n8ViPReHOYZrMo697Tzb/ZYp2P9IDLITwE7WoqfmlvyVUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOrx6gfoYRiV2lK9ZDlXCwKdww/xwtcAZMudVqH21XE=;
 b=SAuLiZGgONPGwCZ189ByQHIMOgRS8cfaq1NqbGd6zagTw5y2TAIF+wDENOqgIgZaPXP50aIlAvTF68/L2PEzUraVGqI9rMv0kqByq/gvs2uNF/u2HwGKWyaTNiXRlPPZDUlEFC0YPGkGKVvRZ+CFEh9vhGx3CIAgr6ZUUz/0O8Pgx+q09GQODifsiSOY8nPctQXe5N3DGzfZPS9I0eq9OAHj7wouLvapUhw7wTQD0E168OyityIESVXth0hvNciZd0if0SqKhfVCWX24DNOqEQ+/LXW3UIV4qdTg3LuLSMXEAYReVrk2MWmkA9yT60S2e24n4Eg+HbYJLFmoKxZ4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOrx6gfoYRiV2lK9ZDlXCwKdww/xwtcAZMudVqH21XE=;
 b=4mGiPEWx0xZTUZhjknRclfODBwyYnt1R431kKER/OMc0LhgSW8cUT1QmX4b+LmHj+xW5qEerdYCtn8dijUbJd4coUjKd2yaN3TN3BGJzweg1EmhZ6mDksvTeIZScFqUzccSAWoJhxjSaJv8RArE/xLEw48rQ1f6q6noQR/v60Io=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 14:38:23 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 14:38:23 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
Thread-Topic: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
Thread-Index: AQHarG1nW5oS5CkfwUKJjHmhvnayr7GkaWCAgABFTCCAADpRgIAAA26AgAEYaICAAF+8sIAADxcAgAABjqA=
Date: Fri, 24 May 2024 14:38:23 +0000
Message-ID: <SA1PR12MB8599830B542D3CA02B726571EDF52@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240522172721.14085-1-Yunxiang.Li@amd.com>
 <20240522172721.14085-4-Yunxiang.Li@amd.com>
 <5025dc06-8471-4f74-affc-1070fc7e6dca@amd.com>
 <SA1PR12MB8599116F019C2EFFF427C50AEDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
 <38598dc3-c815-4328-afa5-6eaa9997c755@amd.com>
 <SA1PR12MB8599A25B022AE47DFD501021EDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
 <5e4b57b0-441c-4207-96c6-63d54ee62f29@amd.com>
 <SA1PR12MB8599A254DFF05857C8F59669EDF52@SA1PR12MB8599.namprd12.prod.outlook.com>
 <412eda12-94b0-4aa6-ab78-9e3b5a6a0a39@amd.com>
In-Reply-To: <412eda12-94b0-4aa6-ab78-9e3b5a6a0a39@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3f77c841-27ec-412c-8450-0abb3c5ef8f2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-24T14:31:14Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|SN7PR12MB6692:EE_
x-ms-office365-filtering-correlation-id: 64a10dcc-67e6-4d20-52f6-08dc7bff2a0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TU5FUTZlVHhMMUVoVTFaQ053U3E4Yml6VGJrWFV3Vkt4ajZGU1lIc3M1NUMv?=
 =?utf-8?B?bkRmRk80SjZiM29OMXRZMVEwSURKWk5Ya1gxQTR2ZHFSbmg4dm1xMWNraWgy?=
 =?utf-8?B?MmUwOHdWUUxPSm9YdC9pV0pwdWU5djVFQUpsVVRqSUs0dWtvNVZ4cHIxdkZ1?=
 =?utf-8?B?TWtvMVpoTy9qUkpST0diVlQ5QURNL2p5bytUdGhqMi9vQi8yeS9mZnN5UHMx?=
 =?utf-8?B?YWtVcExPK2x5Z0hYUlN3L0RHeks0UytHQ2dwZGpqeEFLV0l5ZHBxSlRuOGI2?=
 =?utf-8?B?MHpxZzhCUkRmVngyY3luV21Md2hhdUhoMDdQampjQzNQTWV2TXlienpMNlpU?=
 =?utf-8?B?eHE4cnoxRnRRWnlEL0paYWxNNzNHb3dpSmRpdDVUZnpJNGNGOGZUeGJ1aEhj?=
 =?utf-8?B?Y2Y1SGEzNlR0a1o1WVQ3bGNOQlUrcUtNcDc1K1hNeEtGU3g1aFJsRFQ3VUtZ?=
 =?utf-8?B?K0RoTXJRWWE4NUVKZkxwa3diMGZ0d3FSejd2SVVSblhMNHJnNG5EY002UFRH?=
 =?utf-8?B?aDJrTXZlNlpNRm8wMmVhdklaMG5iNTgwUnlJOWhkUG1MWEZRVVdRM1c3UEhl?=
 =?utf-8?B?SEpkREFGRUxCZzgwampSSWtGYXVMMEg5YUd4KzRPaU1SL296S2ZWM21OT2Qw?=
 =?utf-8?B?OEt2TittVStjbkZaSCtjTUNIMlY0UkNYUWhLdEpxZ3ZyYVJTK3MxQk9ZeTU4?=
 =?utf-8?B?bHUyK2NNU296SCtObTM2WWFWRXZaZFNzckxFaGV2Tk94OXRIb2orbTlBZWgv?=
 =?utf-8?B?RzdVaFhJVTI3VGUzV0JIZTJxajVBZVY3WU9EU1V1L2RhQi9zckE5YlRJWVZh?=
 =?utf-8?B?RWNiL3NzY0VabTJEVHFIUG1DWExqdk1IQU0raEZBUWNrY243eG5aRlp3N1J5?=
 =?utf-8?B?M0RSUHRLNjU3aUNXZVdRSndqeC9iaVVhZEhZZGhVT2lsVFZlaXAraFpEOUJh?=
 =?utf-8?B?Nys2MGxCbFo2d2NCNDNoandjdnc0cjQ2QXlZS1lSMnNUbEYzNEY2bGFFdmxi?=
 =?utf-8?B?c2hsODFING1SSG9RTUJNTUFhUDVsUS93aUxQSE9DS21ySFNteDhqaUY0c3Nm?=
 =?utf-8?B?RGlXSHprZjRFbitQa0NqZGxPUjUvbFJxM21YT2k2MHFIMVRNVWNSY2d0MS9y?=
 =?utf-8?B?b2ZvWGgwSURWUk0rejlwSDJiaXg4NVJaVHJ5Qlp5d0VSRlRjb3ROK2IvYlhu?=
 =?utf-8?B?T3VaL3RmNnFKRm9GeWdacnVaSS84dVkvTnlUNTlHdnpkMnMzaWxVZ3JQWUZO?=
 =?utf-8?B?UFNkVU4wT2txUVJrYzB0Sy9TTFdrcmhRVUFoTE5rU3hROFZMSFA1MzNpM2pL?=
 =?utf-8?B?bzZ3YXB4SnR6MWtQcUdNeFhXYk9SdVg0amVSUzlPV2pock1zS3YxMTVSQXRR?=
 =?utf-8?B?MGovVzdhM2F5MENlMm04QjZOYk9mem5veUFicG9mMWtjRDNGNnpqeVRsWHdh?=
 =?utf-8?B?ZHZOdUxEOHhpMFRjSGFaT0d6NlpkOXgwYmpWYzB0VmkwVGI5UmYvL29lSDk0?=
 =?utf-8?B?VEFkNW9UY0Z1VHJmdlIrQk81T0dJc2FJOW1EaXdmTkttb1RtMkdYaXJqUnRM?=
 =?utf-8?B?WXRJaWRpcjMrSmtwRGZUYWlTdnpRWG9Mb3ZWbHFnNExCbm4rdjlFbEExakZ4?=
 =?utf-8?B?VkVuRVRkRUpVdEhtbitLM1pPam1qcmhZWi9rUjNJNEU1cEpJdXNNTmN5UXV4?=
 =?utf-8?B?cEJVWktyUHJvNG9WSm16OGc2VkFxOXdSOFVoc1A5SUxBYWVrMFpnVXBEMkp0?=
 =?utf-8?B?S0RKSWVuOThFMzlGN0pjZHNQbktpcnBWWUFqQ25wWmR4QVM5TFNrSGYwNW1u?=
 =?utf-8?B?NytCdzliQ1FsWTJzc3BDdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWpWL0RCcE5VT2FYMGY5ckIyL21acEJoa1kyckthd3J6dzUwaGk1aUhRNURv?=
 =?utf-8?B?QVl1dVBkM2xuMlNqbnRGU2JSRkNhYysyanErdUk0N0hxakRYNXRZZE15elRy?=
 =?utf-8?B?U0Y1VEZaMG1aSWgxdjlhRDh6dmhZUElwWkQ2M0o5SzM2VER5djg4UG1MY3or?=
 =?utf-8?B?bklhN0tlSnZGNkxEYkh3QzJqVE5tcWZvcjZ5czRoVmNzQ3RrdzVsWG9kbHJw?=
 =?utf-8?B?M0dDaVJQRVFWaHNTYzRPdjlSQlEwbnB4ZjNzL254R3VDTGM1RDB0c2Jaakpj?=
 =?utf-8?B?UVU4ODA5YTlIdXA0OWR0QzdjWkhpSTBxSTN5eVRLTDQxQ0x2R1cxL1Bjblhk?=
 =?utf-8?B?c3U4eWdTRXBxOEc0RHhRRjVPV3RGVE5UYUdQT1pCaWJLeGQzd0c1RDVPZkw3?=
 =?utf-8?B?V3pCbzBGZVd3cytMcWlhZWl0ZnUxWUFFRk1VeEZhTndyVHdSM3RjZWh1eTQ0?=
 =?utf-8?B?TFhScmNrdDl4RFBsWFgwYWNUSGxHN2xsOUxlRzNjWGp3VWlweEd5QjRFR0FR?=
 =?utf-8?B?ZUpqUGxvNWhGV1JMTVF1NDE2VUN4OWhaSDhrVldaQWtRUXhXUnJuSm14YUVN?=
 =?utf-8?B?YzBoREdBR2ZIQjZvVEZqTzh1OWxweXJJRGFHV1VzZGt6VHhmN21uRXhGU1dp?=
 =?utf-8?B?Nm5Xc1BWYnYrMWw3Ym5QaFhPcEJvNVY3WXo3c0l0cExic0k1U3hrdm5tKzRG?=
 =?utf-8?B?eEEvclJrMTNqOTJ2bzRNbm5NVEVPRDVySEErRVNDK1d0bG1UTXAvVHorek90?=
 =?utf-8?B?TmxFb0dtTkxiOWpUZmVWVllDR05GSHA0dnpMTFBvaDFtTmVrUUllUER3TEsx?=
 =?utf-8?B?bzRobk9QNG9oeTZpdmFoZnFWWGZ6NUh6eWoxVTJmQVB0ZTRSSkEwQ0c1RCtU?=
 =?utf-8?B?bFpGQVhQcTVRbHB3NDUxVmV5UzlzenZhNVZZUnVJS1NQemp5M1F4Nmh2TVNQ?=
 =?utf-8?B?VVAzem40bVJkdk9kMEpFS0k0azVqZnRkSGJEdzVvZDliZGNsY0pnUlAvbEFC?=
 =?utf-8?B?aWRPWTFDM2Fmd2lrQ2wzbVpsakI0R2s1VUZPbW5XeVdCOEZnL01ydVdPUEdj?=
 =?utf-8?B?RTFCMlZpdldySExmOEZEYlhReTljZXNUbXlLaUhsV0pseFFYSnRMOG9RNkNQ?=
 =?utf-8?B?TUxxSnhyNXViWmNORVBCUytDbVROQ2JUTDB2NEM1U29jUmRMb2VTRVFNOHVk?=
 =?utf-8?B?ZHByWnJscTFsOEFlNjUrT21uTUJZNG8zMTIwVUNNaVJRY2E5eHJqSUdTS0xu?=
 =?utf-8?B?YW8weXlVNlh4SWNRd1VCYXZDZm91SzFjU0ljb0V4ZnpYVzFLTjAzaEhFSnh2?=
 =?utf-8?B?a3dRcUZqUUY1eG5RN0wrU3Vvc3RqVERMTFRXc21kT3NaMlhGSE9WQnRtSTZU?=
 =?utf-8?B?TDZXMllRT09mV2dtNnhOS2Y3bXFhTnVMUzBUTUtBQVBWNnF3RERnMDErUmoz?=
 =?utf-8?B?ZHlBUlIxSVVxYUl3MVd5bjdhdTBUaS9UUU5oM2I5QU9yczQ1MElWdWZBRCt0?=
 =?utf-8?B?cmI2OEN6TDBTcEQxbENoZ0Q1SnlKWHFkNWtPcmMyQnBGbEVpOHp1VWEwcVBK?=
 =?utf-8?B?UEE2N3FNNGFwTFRoUmx3Rm4xUVJRVS80S01BazVWMlBoc1JrWEdxZEd5ZlRj?=
 =?utf-8?B?YVUxbHk1VHNhUVc0K3M5VzVvVjFxRFNKNWx4Rm9jMjdIRm85dVlPRE1FRUJX?=
 =?utf-8?B?VU1yMHpWcDZ0OVZsbUhZNkVyUTJZcmVrTUR2eTV0MW9vNENFMHkxbjM0emV4?=
 =?utf-8?B?cFY4dm0vUGROd2ZVNnozayt2bVF5QWxXbWJQaWJqdWorYUU1bGg2bFVSTE1x?=
 =?utf-8?B?TTVJRjJQQ0haTDAxekZ6elhEYjVQVis1ZUh0SHhTTDBqK05KM3NOekxwNEV1?=
 =?utf-8?B?eWhUcEY0UUE5alRlSS9ycG5FK2tUT3dGZC90WHFYUmtjaWZGSTVPMkhuNDdS?=
 =?utf-8?B?RjFFZnlRZE43d29RQ2JUUmJXemJsbGNoMW5GWk9HelZkeWhkVDVHNmprbitw?=
 =?utf-8?B?ajVMOFVZRXRDMXY2SEx6STlxRi95TW45aWJxTHlSWWRlRGpXV3BXY2NTZ0FS?=
 =?utf-8?B?NDV2TTloN29DNjFvcHNzYnhUaXBac2ozL0FRSEVhUGZtUlJFeEJHdHNLRW0z?=
 =?utf-8?Q?GvU4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a10dcc-67e6-4d20-52f6-08dc7bff2a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 14:38:23.1733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76Kj7FZGAd1B46R/gPrAfXK6b0sUULJ23pVXnFbP9Lv5wKNOZ4dlSGKFmI5rPzJHFB7c08J17bijRcHMuZkvMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692
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
Cg0KWWVzLCB0aGUgdHdvIHBsYWNlcyBhcmUgMS4gSW4gZGVidWdmcyBhbmQgMi4gSW4gTUkxMDAn
cyBlbi9kaXNhYmxlX2RlYnVnX3RyYXAsIGFuZCBldmlkZW50bHkgc29tZW9uZSBpcyB0ZXN0aW5n
IHRoZSBkZWJ1Z2ZzIGludGVyZmFjZSBiZWNhdXNlIHRoZXJlJ3MgYSBidWcgZml4IGZvciBhIHJh
Y2UgY29uZGl0aW9uIG9mIGl0Lg0KDQpUZWRkeQ0K
