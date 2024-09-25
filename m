Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C4ECF9C7A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 15:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11AE210E11B;
	Wed, 25 Sep 2024 15:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bU+tuu3j";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F3A10E11B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 15:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H22pmbLDFposKK42mo5C3netTBhIV8gTkovcWdplF3l/PfLIJBtU1Zi1aclQgkhYrbHFlqmP1P/rXCLbskQ36r2WDCExfsu3I3D3gf4HpjQfx/aeK/vWmErUClPhbxwlmHuhXr9lpwWxaRyOFSzCzzuKMv4F5G8q2RZ4La9W6WdPoWp4Yk1+NQePFfAJofJ7cVNZ8kbAYu8kX/xd1VLPQVNYD7uEVzTf0zlVbJbTC/TRHnVyPHo8xJb91AdD6jHsXB5Or1ATy/MHo8S37VbnckMrbhHB/+E4TRZHkmpglPHPcJ7Cmhdo34b+vF/Mcqw41NTrw0LQUdR5eTYPt9L04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bEVokuEtaHKffbN0vOxzsLAKol9PfeOf2eOcon9kWw=;
 b=oWljwE8F9AzybyCW+7PM2ADI3q0BmT2+zeT0EalS5Nj0H6SHAtB6UN8ncxt5c3d6g5kqJs2qEupJe7rKxvn9EL6gbEJX5DFIJUXON+sDH1ImWQisLTZGzwByigEourIvklU+QTS5tpoaCzeqXctfCmiXJ/9zDVo5exwn+7stl9edMn7UyF5yvb0lklqAxb7Ax/D85hwPoMM9Y/BP6kVdXdxQCProD+4zGRCDORjJqkGSVA5wr65gUQRgLp1fz+odbxSonKp0KDp/JqWyJvGc2vAw20eKwrXrN90euD4c8h1ph88alu0IKtrgvIGIbQsmh/O7kG0n+k/hR1DwFGMXVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bEVokuEtaHKffbN0vOxzsLAKol9PfeOf2eOcon9kWw=;
 b=bU+tuu3jHBDmJcuVdrBXDX6M8J27sg16Pvieo2M+na8mfdFzo2jlvpsXqXXaeta9ZJpaYVrHg3UObHt7v3/xUtSkY92F3434OoJZrbgU9XjtLTuSnyffr00b7FtsTL/XVvuAuJaMv5DVI3jpBlRPyEUXcorBsDmPzh+XZWjoFhQ=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Wed, 25 Sep
 2024 15:07:08 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 15:07:07 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Errabolu, Ramesh"
 <Ramesh.Errabolu@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix kdoc entry for 'get_wave_count()'
 function parameters
Thread-Topic: [PATCH] drm/amdkfd: Fix kdoc entry for 'get_wave_count()'
 function parameters
Thread-Index: AQHbD1ulwIjaOBC2M0CTmOd3ac5l4bJomawA
Date: Wed, 25 Sep 2024 15:07:07 +0000
Message-ID: <BL3PR12MB6425425501C3CF6AB7628146EE692@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240925145948.3329234-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240925145948.3329234-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e20c9146-6963-4c69-b4c4-33ac486e076a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-25T15:04:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SJ1PR12MB6073:EE_
x-ms-office365-filtering-correlation-id: e0c2621b-b5b9-4bd2-47a3-08dcdd73b8f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y0Izc1ZaYW5tbUwybi9Zc1ByRVFuZHhyVU81WVRkVkt0UksyblVqV29iaGIy?=
 =?utf-8?B?czlqTVZUazlCZzdCUk9NcGtOL0tXTGNNM200TUNuVkhtYWowR05tMkk5akZ3?=
 =?utf-8?B?Q3BvU25HMndRRWlPZVlYbVI4WE9PTWJGa3JXdTF5UGNrKzJ1UzRpMEk2Nlpz?=
 =?utf-8?B?ZXk0bDJJY0RuUXlSVXR5S294dDN0eHI5c2hRaEYxSzNwZUEzYnBFczlKS2NY?=
 =?utf-8?B?bzNTU0dYcmY2NVBud2cyWEVjSjlzdzFQNmd3SEtZTyt3dWxWWXJIVjBYZktq?=
 =?utf-8?B?SGJXcTdrRUJpY1A2ejZyK2owdkZSMGtndEFOSk9TT0U3VStGV1ZuNTdOQXRu?=
 =?utf-8?B?SjBDV2tCdGJwUEtOQ21LM1BWNzh2QVU5a0xiMGdNWHZCV0FnWldEaFlhRnVI?=
 =?utf-8?B?NHJoRXhFWHI1ME1aS0FTSDB1Q2ZYczZ1SE5ORUdCYVhXN2lBR0F0QU9YZC92?=
 =?utf-8?B?enRuNGZsQURONm1KWE92dG9KbFpoZHpOTE5VRHhnZ1lNRGplLzZMUFVGMVBv?=
 =?utf-8?B?UWtlWmdDN2JOTW5MVWE3by9tRFVCTE05VE5JS0V3NEFHbFQrSWNxem1VS3pq?=
 =?utf-8?B?Q1RxV2t3bGVnQXZSWUhZS3pBclBPNkpDWlZGQ1c2QVlxaW4rUVBjdVJJNC9V?=
 =?utf-8?B?WEpNWkVqZVc2ckRJYW9FT2w2NE82amNqd0x0bWNycHlVb1hmWUQxSWFTUks2?=
 =?utf-8?B?b1M2UGNGY0xZZnFFVk02UFdXbzFtZ0l0dW1TaWovQ3BiMzdxRzRhemhRYW9T?=
 =?utf-8?B?OTZkZ1lERzdNUnByWHFYa3REVWU2VFpmTlJnd3R3dHRybUI1OE5XS0tZMjdK?=
 =?utf-8?B?N3V4cmpEbGsxTmxWQmNuMGdDVTRSTlQrdlphYXpmK0d4UHJ5ZDUwNnRoQ1dN?=
 =?utf-8?B?cWE5KzNNNGR2MGdTOUp1N29OUGVzZytVL3FlcDVNZmJYdEhFVVJyK2J1dm1q?=
 =?utf-8?B?V2JCK1ZZcjFZWSs5SktLR29Sbi9TOHVBUUg0RWV1MmRNZWozTHlCLy9uTmli?=
 =?utf-8?B?YjBxQU13eTJEQzBEaWVmS25NWGxmQUdyUjIzT3NJcUw2endqOEh4SEdPdDRJ?=
 =?utf-8?B?bEtCZ05sZEpHZFFZdzhKOW9wZExWY0NFT3RhcjhoWVY1bDVycCtoTzg2S09m?=
 =?utf-8?B?ZWNkZmpYdkw0QXBUYWRETmJXM0pIVlUwUVgwWEs0dHM5SnZXMHN4Z0xET0ho?=
 =?utf-8?B?YWg3dk80ejNNYnFGNmZ0TWtPM2l5L2dBMkNRdkNSaUIzMXdvZnVGcWhWQStH?=
 =?utf-8?B?Q0U3UFR1SDY2bWRhSEc0cGwyNi9zNnBvbmc1Z0ZUUUxZOTB2dGZkTFZaS2cr?=
 =?utf-8?B?aXk0bW5Ja0JIOThpVkg2U0Z6a0dlY2dpRGoydkt4Q1B6dW9NZlRGR2xhNTNM?=
 =?utf-8?B?d0c5MHZFL2RzeGJHRVFZL1dlQ1lBbzhVRTlaOTVvamRCOUVtclhvL1JLRW41?=
 =?utf-8?B?SEVMaGgvVjU4NFRCLzF3UGh0OThiZ1FMYm9hZTRHM0VGbXAvcGFFM3dTVE9q?=
 =?utf-8?B?bFJTaGQ2Ymx1UVVDT2dsM0hmVGh4eXUydDhSNWVMa0lBakxqUEZwczUxMWpx?=
 =?utf-8?B?bmUyNmY1Zjcxck1XUEZUdHhKd1M1WllFUldReUt5eWFEbzlwK0FSeHRuMnI3?=
 =?utf-8?B?V0NwU0Y2U0VoeVdjR3hEWEtkTnB1WlBXZ3JnVjc5YmFNODMrQ0t0WnFoNkNO?=
 =?utf-8?B?YzJrdGk2RHB5T0o1dU0rRGduMnlSWVd3cEdoSWVKaEdWVW80a2c5UVl3a096?=
 =?utf-8?B?dXFuVGxMdklOdThZb2tCNGpIWFRGWlQ1UFRSRG9BRysydjBvQ2JLbkIrd2po?=
 =?utf-8?B?REhOZGtJOWxmRHAzejJWZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkJNZlZPZFZhQXltUFF2UWsvTE5JelNnQ1UyS3BEZGtENXBFUks2U0NQS3Rt?=
 =?utf-8?B?OU5MZXdidStlZ2ZTOTZBRUNIeUhLMCtNalVwTjdMUFlZUSt1TThjMEU4WllR?=
 =?utf-8?B?S0NlWE5NcE1oSDJQTXYwRTk3Sk9LNGhXUGxObkp4Tmo4UythZEphOTl4NkFx?=
 =?utf-8?B?N1hUamRwcHFMcmlzZlZvYW51bmJkaDhXdzBOcDUwSWR3SmdXd2pBdmMwT2Mx?=
 =?utf-8?B?ejZ6b2ZQUGFGTllKVkt4L0JRVkpsV0MraFhqakpOR0F4NXo4OUZjT0daakt1?=
 =?utf-8?B?Mm1JN1BZOFRvcnREWllnUkgvQXllS0w1eXVRRDBGQXAwTXZnTnFRUVYxZG9V?=
 =?utf-8?B?NHpISk1ITUkzeEp6Yi9RUUdLa2ZBR3F0dnpHWUxBVE1HN09tZVE3eWlEdlFa?=
 =?utf-8?B?Z2t4M1QzWlhCRXFVelRINVdBWThBdlBFblRtWmFtQWRrd0NiMTVmM1pCV0h1?=
 =?utf-8?B?aDFQN1BVc05UdUxpZTNndFZ1VEk3NXUvYUJzM0s5R0xGcmNJOEJEN2xSbWZp?=
 =?utf-8?B?emdUY1pMTlhabEZpRGFwTWJSOHY3MFkrMU80WTl0VUh4dHQrLzd0Uis3NEpB?=
 =?utf-8?B?SDQ3Qklyd3FSdEU3WE5wMEl4bitDOXI0WU1ISmNHYVlCTEdBMG9kL21uaGZU?=
 =?utf-8?B?NHIzeEUreWVvWFF0NENGUXo0SFNuV3VrWG5QaEJXMGwyb2dnWW9VZS9FOTd5?=
 =?utf-8?B?WGkzUVU1ZnVJUTFEeFpOYkRmTURPTEJiWnR1bkk4R1NMbk5LTWNsM29sREx2?=
 =?utf-8?B?eDJnQitERFpNT0hOWFRzcy93Nm5rV0E5dDRuYUxWS1hUU1cwTUt3eDdIT0Ny?=
 =?utf-8?B?b1NIWERKcWtaOEFNaHF6K3pNendnenc0WWdlL2FNbUp6RDNMOEFUU3RiSWw3?=
 =?utf-8?B?NURacXFmVHdObWc0dlBVazdsZ08vVUZ6WWJiL3pkRGNwR2tMY3JFWkNoc2NI?=
 =?utf-8?B?dm9NTnNGb3ZQK0lYYmdVVlpBOWhpbXgxTy83anphSlc4dzA5QUZNNjRtR1E3?=
 =?utf-8?B?VTE4UU9IL2NoTk5uUGdGZnRCb1p4UHcxSHR4UE1hbDNIR1NlTnlpMUJ1ZlMv?=
 =?utf-8?B?bEg2U290UmZMamkzRk1obml0ckVEUzJhUnJMQVdTMzg2S3htUVFjT0hkNVhX?=
 =?utf-8?B?ZVYxWWNvTWRTY3RaTmtoZzN4cVUxamFWSGVzZlowSHExSFRhemhOMlBLbFAr?=
 =?utf-8?B?akNReXlmY1F0bzF5TWc3ZjVWdGlPbldER0p5NitYNEFFVE9BSXFtcmI3aGpz?=
 =?utf-8?B?TklJeGo0a3RSSk5sVHk4Zk1aVFFsMWlTeFhpZlA5ZTB0WFZBZHJHSmRWdTlB?=
 =?utf-8?B?SWdUR0tWaUJlRTZGdU1RZXQ5c09tQ2xoZmpuK0hTYWgwa3BoQ1EvYlhQb0tL?=
 =?utf-8?B?cUJxTWpEM1lYc3hZTUtVVXhBNkdwZmlqcHRITXhjb3oxcjVtdVdUZGVGWmg3?=
 =?utf-8?B?NmNTVHk1QmJDZWxmQVVKbzV5ZFMzOHNVRGxJaklRS0J5M1REWitXWEcyemYw?=
 =?utf-8?B?WC9Zanh5NEpkL0czQ2wrQmdhOGhUNEpGQ2MxV256QVk5bGtUM0xITVVqZ1Vi?=
 =?utf-8?B?Wkh6WENVc01nRjlKMmxiWWtRUVgzZHNKNnVTNzQrOTN6Zk1XRjNoZkQvbFlP?=
 =?utf-8?B?azZLdDgvWktTWndvNDBqRkQ3MGgxNmJsUmxqUG8zdmtVMWpKM3lYV2xPUlZD?=
 =?utf-8?B?Qm0yYUhGQjErRTFscTFPUE02OGtKOE8zUnA1MHpEb1JzVExyN0hXSFZYdUNW?=
 =?utf-8?B?Nkl5WXJzeThWbFcxckVCZStGTTBsWkFyWWd1OE5lcTJpNnNGR2pYUWFxK2FR?=
 =?utf-8?B?WjIrVnZIU3lDYW9sNVZFYnd0U1l1ZnpES0w3bVpPR2tOZWN6L0RQd2d4NmN3?=
 =?utf-8?B?STJJWjE5Vlp0ckJiS0pNSllxanJrNFRZQmdVLzZVUFhGUXlxdnA3OFMwZUtr?=
 =?utf-8?B?YWhDZlhwVWlMMnNDQWc5WG9ranJFU2xKZW1VQ3ZhL3ZURUtTVTRsYW9VNity?=
 =?utf-8?B?ZXNWdHpoeGo1UmU2SEQrZVptUlA1YnBrYTA0YUhpeXF6S3hqQklndE1DWjAx?=
 =?utf-8?B?bXN3NGpGVEd3NE1zUzZ3cnJobE50SlZpSkd1Tm5BK2l0UEhTQWhyY29UeEx3?=
 =?utf-8?Q?o/t0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c2621b-b5b9-4bd2-47a3-08dcdd73b8f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 15:07:07.2997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2THWR7UDY48reBCMmx3cp22iFlSEf/Cqifv42VtA1si5MLaVUO0Wl004+81z1DsvNMOKWEoIXjPcr7QmzOfhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073
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
Cg0KV2l0aCB0aGUgZGVzY3JpcHRpb24gdXBkYXRlZCBiZWxvdywgdGhpcyBwYXRjaCBpcw0KUmV2
aWV3ZWQtYnk6IE11a3VsIEpvc2hpIDxtdWt1bC5qb3NoaUBhbWQuY29tPg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0
cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBTcmluaXZhc2FuIFNoYW5tdWdhbQ0K
PiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNSwgMjAyNCAxMTowMCBBTQ0KPiBUbzogS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhh
bmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hB
Tk1VR0FNQGFtZC5jb20+OyBFcnJhYm9sdSwgUmFtZXNoDQo+IDxSYW1lc2guRXJyYWJvbHVAYW1k
LmNvbT47IEthc2l2aXN3YW5hdGhhbiwgSGFyaXNoDQo+IDxIYXJpc2guS2FzaXZpc3dhbmF0aGFu
QGFtZC5jb20+OyBLdWVobGluZywgRmVsaXgNCj4gPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGtmZDogRml4IGtkb2MgZW50cnkgZm9yICdnZXRfd2F2
ZV9jb3VudCgpJyBmdW5jdGlvbg0KPiBwYXJhbWV0ZXJzDQo+DQo+IENhdXRpb246IFRoaXMgbWVz
c2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRp
b24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9u
ZGluZy4NCj4NCj4NCj4gVXBkYXRlIGtkb2MgZW50cmllcyB0byByZWZsZWN0IHRoZSBmdW5jdGlv
bidzIHBhcmFtZXRlcnMuIFRoZSBkZXNjcmlwdG9yIGZvcg0KPiB0aGUgJ3F1ZXVlX2NudCcgcGFy
YW1ldGVyIGhhcyBiZWVuIGFkZGVkLCBhbmQgdGhlIGluY29ycmVjdCBtZW50aW9ucyBvZg0KPiAn
d2F2ZV9jbnQnIGFuZCAndm1pZCcsIHdoaWNoIGFyZSBub3QgcGFyYW1ldGVycyBidXQgbG9jYWwg
dmFyaWFibGVzLCBoYXZlIGJlZW4NCj4gcmVtb3ZlZC4NCj4NCj4gRml4ZXMgdGhlIGJlbG93IHdp
dGggZ2NjIFc9MToNCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
ZnhfdjkuYzo5NTQ6IHdhcm5pbmc6DQo+IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBzdHJ1Y3QgbWVt
YmVyICdxdWV1ZV9jbnQnIG5vdCBkZXNjcmliZWQgaW4NCj4gJ2dldF93YXZlX2NvdW50Jw0KPiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jOjk1NDogd2Fy
bmluZzoNCj4gRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnd2F2ZV9jbnQnIGRlc2NyaXB0aW9u
IGluICdnZXRfd2F2ZV9jb3VudCcNCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9nZnhfdjkuYzo5NTQ6IHdhcm5pbmc6DQo+IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0
ZXIgJ3ZtaWQnIGRlc2NyaXB0aW9uIGluICdnZXRfd2F2ZV9jb3VudCcNCj4NCj4gQ2M6IFJhbWVz
aCBFcnJhYm9sdSA8UmFtZXNoLkVycmFib2x1QGFtZC5jb20+DQo+IENjOiBIYXJpc2ggS2FzaXZp
c3dhbmF0aGFuIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+DQo+IENjOiBGZWxpeCBL
dWVobGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4NCj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0g
PHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYyB8IDQgKy0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMNCj4gaW5kZXgg
M2JjMGNiZjQ1YmM1Li41ZGJiMDQyZDEwZTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYw0KPiBAQCAtOTQ0LDkgKzk0NCw3
IEBAIHN0YXRpYyB2b2lkIHVubG9ja19zcGlfY3NxX211dGV4ZXMoc3RydWN0DQo+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQo+ICAgKg0KPiAgICogQGFkZXY6IEhhbmRsZSBvZiBkZXZpY2Ugd2hvc2Ug
cmVnaXN0ZXJzIGFyZSB0byBiZSByZWFkDQo+ICAgKiBAcXVldWVfaWR4OiBJbmRleCBvZiBxdWV1
ZSBpbiB0aGUgcXVldWUtbWFwIGJpdC1maWVsZA0KPiAtICogQHdhdmVfY250OiBPdXRwdXQgcGFy
YW1ldGVyIHVwZGF0ZWQgd2l0aCBudW1iZXIgb2Ygd2F2ZXMgaW4gZmxpZ2h0DQo+IC0gKiBAdm1p
ZDogT3V0cHV0IHBhcmFtZXRlciB1cGRhdGVkIHdpdGggVk1JRCBvZiBxdWV1ZSB3aG9zZSB3YXZl
DQo+IGNvdW50DQo+IC0gKiAgICAgICAgaXMgYmVpbmcgY29sbGVjdGVkDQo+ICsgKiBAcXVldWVf
Y250OiBTdG9yZXMgdGhlIGNvdW50IG9mIGFjdGl2ZSB3YXZlcyBhbmQgdXNhZ2UgZGF0YQ0KDQpQ
cm9iYWJseSBiZXR0ZXIgdG8gcmVwaHJhc2UgaXQgYXM6ICJTdG9yZXMgdGhlIHdhdmUgY291bnQg
YW5kIGRvb3JiZWxsIG9mZnNldCBmb3IgYW4gYWN0aXZlIHF1ZXVlLiINCg0KVGhhbmtzLA0KTXVr
dWwNCg0KPiAgICogQGluc3Q6IHhjYydzIGluc3RhbmNlIG51bWJlciBvbiBhIG11bHRpLVhDQyBz
ZXR1cA0KPiAgICovDQo+ICBzdGF0aWMgdm9pZCBnZXRfd2F2ZV9jb3VudChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwgaW50IHF1ZXVlX2lkeCwNCj4gLS0NCj4gMi4zNC4xDQoNCg==
