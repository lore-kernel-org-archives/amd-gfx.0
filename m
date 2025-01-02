Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC7DE77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 08:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE26B10E3AE;
	Thu,  2 Jan 2025 08:04:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FlXynPrz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B731D10E3BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 08:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUWdTpmVLLwCFsmjPjoSRGX82K7dE1EjoAJ4ZONjve2t+5dQxdCrEbdXr2tWcLVPfCJMA8o9mooYgOONU3edyRRz1FjO5H5MLthaDJFJiJqaZvfvpzeudN8ZVONYzrvUCQFyVX2MHhNhT8CDRt72setlqacU/5IL/b5ECv0ueDljMqxNLnQlHyoVtZikvXtgfgVAX4YCDZzCEUHrLuII1NUOMdyyy4TpV5NprGJ232MjY0LsM+wYOWHyuAk8ap2TxRorvKoceu9Gcl4mhVdKz5HOEOxuhe6neawN0oGYjP9cG84G07y42F2BmQH2fNJO5n5aOq2AxB2p4wSudtqjIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZG37dnXQWsPFMJcQxrGsy0V+3UyV+jaxL3DXcVaQfQ=;
 b=ZXFlZDtFLrzAl0vk1FagFTAQRVOQeA1x/91DIhvmuiP7WWpdjK9GAAQJ4U5cINuQJ9q1oYSkA2t2fONkjMNYhcWkAoy3pGlgaXF3TVOZQXxy/WZoBT/eHCWSjTBS8atu5qspxj7v+xdd7tCnKDg9hE67SsqHnGPDMbftfoRRyufpav/PW+ixpEOHwWou6rDVnKWlmhAclj/EAXLTKmJ7ylvuRTI/jFL5fA69lK+0mCBDiu8ub3HUjb8/SWEGbJA2okJpOcbdMGnd4DEHOfCaF7Hq+jUZU3Trnn7lQtNJEcqKcD7uhI6KXr0DHG1FHEK0dbV383s352eNFsy25elmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZG37dnXQWsPFMJcQxrGsy0V+3UyV+jaxL3DXcVaQfQ=;
 b=FlXynPrz634IGdFKD5E+6l2To6w7OMKNwr4ODh6YgqFABu4nXg5moCfPW9HLapHbHDoX3bgv1frJAcMaC47okor4r6C/EaqGj4oxghuC+0Qvp+FodV1C7x4L9YfMfDDvblc4GK3xK07n1U7DHxyo3YGnGb/nV7+6xbq62cEOxG0=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.13; Thu, 2 Jan 2025 08:04:26 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%5]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 08:04:26 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhu, Lingshan" <Lingshan.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: test release process eviction fence before
 signal
Thread-Topic: [PATCH] drm/amdkfd: test release process eviction fence before
 signal
Thread-Index: AQHbXN/ruBn92mZa0UGE6UUi7WSSJrMDEbWAgAAIabA=
Date: Thu, 2 Jan 2025 08:04:26 +0000
Message-ID: <DS7PR12MB600585C2E1414074D1B480D9FB142@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250102063059.2221560-1-Prike.Liang@amd.com>
 <66d90655-b070-45e7-9222-28e65007e50b@amd.com>
In-Reply-To: <66d90655-b070-45e7-9222-28e65007e50b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=14c9a7f0-7f03-44f3-8632-ad03d8607659;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-02T07:42:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SN7PR12MB6713:EE_
x-ms-office365-filtering-correlation-id: 99a8d715-f0a9-461b-a925-08dd2b0413be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?S2pGcVY0S00wMXNpdWQ2YUowWVZIUEZDMjM5NnFtUGtnYnZWT3NOOW9EZVVy?=
 =?utf-8?B?NlRoYlA1b0JHcHp6Skw5NmxhQUZ3dmRGaVZaNmE1R09VQ1JMZm03QVZkTkp4?=
 =?utf-8?B?OWhCT2VaWWJpRStDTnQyZXRJRzN3aXVlMUtCaHFYU3hNTnRpb1pHWFFtMTk1?=
 =?utf-8?B?dWdhbzFiemY1RzNZZU9rTS9Fa2NSVU5DQmJjaDdGVi91NjdnMHJTZHFodWJo?=
 =?utf-8?B?STJYREhkeGs0NW1jN09qTnFYYkR5YktrdWh5WHZ0SzBLZVBMY2UxTVZVYVZm?=
 =?utf-8?B?TjB4ZS82eURsL3hQUHJtZWQwYzc4MVNESkF6RTg2b0NzNit4LytpWmNER2Z1?=
 =?utf-8?B?OHF3US9zaUU0Nm5xSkQrRTlpcmV6U3lMcGFlVEtPUktERTN1RUJtWjFWTytp?=
 =?utf-8?B?Y0ErMGlMWFNocHpoQlFhN0RsRXBoSmVwc2cwZk9BSkY3Sit6ZXp2cHlKKzdD?=
 =?utf-8?B?UHAyQmxvR09iVFdGaGlYYlg2QUc1QXBGYzVOWTB5MTFCcDlBVnoxSHNzdEw2?=
 =?utf-8?B?ZjAyUjNjTEdMRW5XTHh1WktMZUZwdTZYb0NLV2VHNXBkWHBhU0xSZEJqMXZu?=
 =?utf-8?B?dEhzWjhkSHBCbDRuejEzTno0UFFTNFZESXlWK2k1RmRSdlIzT3JVelh4VDEr?=
 =?utf-8?B?OVEvWXY0MXdWWFpmKzIxOGg0ejMyVWxOSXFaREV2YzllVlFwTUFObXRWWE5n?=
 =?utf-8?B?LzNSYTMrRytZclFueFhMK1dmcWw2M00rUUxJWXFEd2tLb0FNb1g1eVNTei9R?=
 =?utf-8?B?RXRiajNGT1MwdjB5TU81L09nbVRKSU1IWnliSWNEL1FyOCtUeHVhdEd3bkRT?=
 =?utf-8?B?d2hvK0o4WnoyRDJZK1NjR3lWVjhZZ2E1SzAwSWw0bWVieG5mTlBQN2pMQURw?=
 =?utf-8?B?YTRBOG5OcjBLbkFEbVRNQ2EzaGE0dWZsS3o0SDdRQUszU3dIekQrYXZzWUdT?=
 =?utf-8?B?MmtMWGkyQlAzUVVncGFVS200YTBHQzlFUUs3ZmRBZGJkelV0d1gxZEVZSlln?=
 =?utf-8?B?T2dmSjJOU3hSUktJNjFTOThsQksvRjllTGNRR0V0cGI0SmU5NmM0NHdsM1NG?=
 =?utf-8?B?Vk5XUk1NenU3QXRxbEVOTmJ6TE41VW94ZEFzaEdzaW1DYURhRFNxMElUNnVU?=
 =?utf-8?B?VUJUcVg2ditHdS9OdFBZOVhBZnY2VE9mYkxqMTA1c0ExeCswaWhybTg0M2Fk?=
 =?utf-8?B?MGRhL2NxZG5TT0hBUXg5STI1MmREemRGNXErRTAwSFRVdmZoOFlFdDYzdUQ1?=
 =?utf-8?B?MlhEVEl3NTBkenBpTVJWWE9qZ1RUWmYwamNwMS9iWm5lMUw1VXBWTWlVaENM?=
 =?utf-8?B?UWlGUXdjazR3QmZWZTByM2hwdmlySmtRcnF1UWs1bmRrR3E5MFM5MGdVdUV2?=
 =?utf-8?B?eitLTUZpbHNYcWpac1p1Mm13R3BJS3FCQjNJWVp6Z2pjUWFSbmJkdm02ajZy?=
 =?utf-8?B?MXFpZnB6WTliVndreDFsSUdsOTVKME9qMUNvb0dkNEE3Vkp6emZoVkg0eTBW?=
 =?utf-8?B?ZVV5TFFhUm8wdjB0a0pkRnd4Y3dwZkZUTlE3VWRjWnl0ZGRISk1oUjBnN1Za?=
 =?utf-8?B?OUQ0SUNuY1V5cmNJRXZwMTAwTEJ0ZlNQajhSSW96VnB4QlNYTmVQNWc4T2FL?=
 =?utf-8?B?aWhHSjUwOTVNMFFSbW5XYjJsSHFRZ3M0TFpyOS9EallGVWRMaGpZNkFpbE9q?=
 =?utf-8?B?NndWczJsb21pV2RNb3RyRFZQVUxWTDJ6VTZBSGF3UmMydi8yUDcxNGtTemVr?=
 =?utf-8?B?cUxZNWkzVzdycktsbHNRK2NOSTFNazUrd0FVZjcvN3lhQUJSbDJtYkxNK1ly?=
 =?utf-8?B?NDBDdnZCRUF6N2RWcC80Tkt3Y0o5WDYwZHMra3lLcVZuUU9xMUVEZXN1ajF1?=
 =?utf-8?B?QWJqelRuajJZVUdQK0pUSzA5NUNucDdBK1dNZGhNekdOVlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXJNY1BJVE9YYm94ZW1YeWlwZC9sMzRMSWxGWDFyKzNZdHdJdGFOdVBHMWxP?=
 =?utf-8?B?MEhVL0xvNHpzK29QTkJlVkEvWG1sMFY2R3o4TWpMUEZWZUlyY0ZGMU15Q2d1?=
 =?utf-8?B?VDhVTk53cjZKQ0pwMFd4aldkSW9FZWQxVDUzNkl4VTJud05CVXhCL3dScEda?=
 =?utf-8?B?WUhscUdxdzZEcHNMaC9zcnowSGo0ZThZbHdBRlllV0hicjdlSXJqTTNmUXJt?=
 =?utf-8?B?MjUvRXRrRHVXTjhCR0pLYjJqa2Y0a1FVaHdFaXNIZGd5ZkJMcERmT0xKamVN?=
 =?utf-8?B?ZnQydzRxZmx4Uk5vTnJGRVBXNGRFZGV6d3hZeDNLRGhGQnJBcit3dnVueGpw?=
 =?utf-8?B?TGN2KzNHUlB5MEsydEZpYXpDeVh4WmcwdElSR2VGV2ZhTEtBcDJYdFNzRVlx?=
 =?utf-8?B?Zk84cWFyd3FudTUxYXJhejdZVnVVQUkyKzRCRXNkYit1eEFjQzNpd0NwUlN2?=
 =?utf-8?B?WWpUNWNqNTdmekFNOFhCbWhjUWxndmV2MFJrRnlkSlhGZnVuUWUvdDhFYU5U?=
 =?utf-8?B?RDQ2RFAzRkg4WDJnd0ZWeDRwOVM1TmtlbnFRbncxem5JZUFPR0dOMjNIUUVi?=
 =?utf-8?B?WFg0ZzZrbk1xcHJjdXg1V0g4bE1YL1AwR1lJcHpocllJUDhGUHRyTkYvSWlG?=
 =?utf-8?B?blhuNGNxOERXTkRFVWVZaWxWRTI1bzlwYVRrdXJGK0VmRnFDOFg3K2dsaFc3?=
 =?utf-8?B?VjNpSHJIeVU3cE1tK2k3aEprRTRod0RYRXpicHZIYkZIZDBJZGdhV0ZycWhk?=
 =?utf-8?B?YTFvSEN2QjdFemMranF2eENkbkYvSW5ibk5pSEFSbkFZUVVqOHY5NEhaWDFw?=
 =?utf-8?B?MWJSNHJsVFdVVWdHR0pqK2IxV1dJUk5LUmc1VEliaGtyWUZQQ3RvaWpJbVF2?=
 =?utf-8?B?b28xWXBDL3hzd1ZNUENOS0FsWVdDaFpLTXJZUjNGMHV2emxpK0JWZTI5WWRF?=
 =?utf-8?B?RWNZcDM2Sy95L0FwM0d5SFY4VG5NUXpSZ285Tml1QUtybEZ6cTN6Z1NsbkZW?=
 =?utf-8?B?SUFZOHNFellJZS9KdHdaazhiaklDU1owMlo0SHpWajB3YzVSeGhFY0laM3Y3?=
 =?utf-8?B?dVM0WHZyQzYvNVQ2SFhpeW1TM0gvcDBUNlpCQTQ1UG1nandVa0Ryb2FoK2dI?=
 =?utf-8?B?ZmMzWUxHV2JDdlo2bHhoU3dqTXhSZ2YzeXA1UGpiQldHN3lFaDBIaXl3SHpC?=
 =?utf-8?B?UTI4RWFFS2hrUjZsSVAvRHUzT1dRRzluQ2UrTW45dG9yOW1va2tJTFBMK05T?=
 =?utf-8?B?SVFlbmIzZDZkbys2aFN6UlkvelZBMFRpRzcrSWpOZ2IrYWd3WUFmZ3JZNnc2?=
 =?utf-8?B?MzIzZUdIaXVTbXlGZ2VjS2Z2S3l2cVdCdU1HOG55N2VWb0VsSVJUY2R2VVpw?=
 =?utf-8?B?VkF5R1B4elZZRnBBTUxvaEI1WkFhb3lidWRIeHUvRHBHRUhmR3dVZnovOHgw?=
 =?utf-8?B?TEpaUlo3Z012SU5zS1dCM3Q5U2duSE0xYWlFajYyVllTN1htTW1LdW9Vcmph?=
 =?utf-8?B?ZUI1U2VuMmptdW85K1RGTnJ1TmZPdGpSdGxCU2dYMUlpQ2hpQkxkQTNtNCtx?=
 =?utf-8?B?cDByTlhLMzlXMXZuOUZ1NFBDZy9FVm9uSGR2YlRWNFU3MERKLzhGdW9jR2Mx?=
 =?utf-8?B?eUxTdk03RkVraU1VU0xPYzROOWdER2Y2MWdNaVRaZktpS2FmbHQyZ1NNZTlF?=
 =?utf-8?B?TFovaEM3WndTQ3hOSDFOR3BjTUFtbjZzeXFPRFhoUUhuSFJnckFNT1ZjMEhx?=
 =?utf-8?B?NW9DTXZNZXB1NXQ4UlQ0ZGUvdWw4b3RHVUtUSDFQNFBxcG5rNDlhZGl2eTlE?=
 =?utf-8?B?cmF4aFVmUVhURXRRUkdSMDZhUnlGRTVPbFBTZk5aSVIwWmZ5VGFnZkNmQWlX?=
 =?utf-8?B?dUt0MHV5MUU2T0RGL1hkUGU5K2xzNlIwTHdMekx5V083S21BcnIweUZaZlRG?=
 =?utf-8?B?STJmSU5pbGJJYjk4YkU0WFcya0ZuRjBZZnJaYzM4aUh2Q0JySXo3WVpabTVl?=
 =?utf-8?B?TlIyQkJyeG4yVnNNSHU1eTg4N3QxTzloQUhEU0ZCNGdMbmNGZ1dqR3l4MGly?=
 =?utf-8?B?MzBENExEQ2xnSnN1QUlpUzBXcTMrQWJKQjRCR1ZXVkVQY0kzNmpLVUlId2pp?=
 =?utf-8?Q?gjWs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a8d715-f0a9-461b-a925-08dd2b0413be
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 08:04:26.7240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSeGowpntHfEfRVTllmQD2LwwScKHcRUyTlSDpHe/h0sUnPsxJsYQM5GhEDDyXrh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
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
Cg0KVGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24uIEkgZHJhZnQgdGhpcyBwYXRjaCB0byByZXNv
bHZlIHRoZSBISVAgc3RyZWFtIHRlc3QgdGhhdCBjb21wbGFpbmVkIGFib3V0IHRoZSBLRkQgcHJv
Y2VzcyBzaWduYWxzIGFuIGludmFsaWRhdGUgZmVuY2Ugb24gdGhlIGxhdGVzdCBkcm0tbmV4dCBi
cmFuY2guIEJUVywgaXQgbG9va3MgbGlrZSB5b3VyIHBhdGNoIHN0aWxsIGhhc24ndCBsYW5kZWQg
aW4gdGhlIGRybS1uZXh0IGJyYW5jaC4NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8TGluZ3NoYW4u
Wmh1QGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDIsIDIwMjUgMzoxMyBQTQ0K
PiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEt1ZWhsaW5nLCBGZWxpeA0KPiA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47
IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+Ow0KPiBLYXNpdmlz
d2FuYXRoYW4sIEhhcmlzaCA8SGFyaXNoLkthc2l2aXN3YW5hdGhhbkBhbWQuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiB0ZXN0IHJlbGVhc2UgcHJvY2VzcyBldmljdGlv
biBmZW5jZSBiZWZvcmUgc2lnbmFsDQo+DQo+IEhlbGxvIFByaWtlDQo+DQo+IFRoaXMgaXNzdWUg
aGFzIGFscmVhZHkgYmVlbiBmaXhlZCwgcGxlYXNlIHNlZToNCj4gaHR0cHM6Ly93d3cuc3Bpbmlj
cy5uZXQvbGlzdHMvYW1kLWdmeC9tc2cxMTcwNzEuaHRtbA0KPg0KPiBUaGFua3MNCj4gTGluZ3No
YW4NCj4gT24gMS8yLzIwMjUgMjozMCBQTSwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4gSXQgcmVx
dWlyZXMgdG8gdmFsaWRhdGUgdGhlIHJlbGVhc2UgcHJvY2VzcyBldmljdGlvbiBmZW5jZSBiZWZv
cmUNCj4gPiBzaWduYWwgdGhlIGZlbmNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2Ug
TGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMgfCAzICsrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiA+IGluZGV4IDA5NzZiNWIwZThlOC4uMDgz
ZjgzYzk0NTMxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcm9jZXNzLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJv
Y2Vzcy5jDQo+ID4gQEAgLTExNjAsNyArMTE2MCw4IEBAIHN0YXRpYyB2b2lkIGtmZF9wcm9jZXNz
X3dxX3JlbGVhc2Uoc3RydWN0IHdvcmtfc3RydWN0DQo+ICp3b3JrKQ0KPiA+ICAgICAgKi8NCj4g
PiAgICAgc3luY2hyb25pemVfcmN1KCk7DQo+ID4gICAgIGVmID0gcmN1X2FjY2Vzc19wb2ludGVy
KHAtPmVmKTsNCj4gPiAtICAgZG1hX2ZlbmNlX3NpZ25hbChlZik7DQo+ID4gKyAgIGlmIChlZikN
Cj4gPiArICAgICAgICAgICBkbWFfZmVuY2Vfc2lnbmFsKGVmKTsNCj4gPg0KPiA+ICAgICBrZmRf
cHJvY2Vzc19yZW1vdmVfc3lzZnMocCk7DQo+ID4NCg0K
