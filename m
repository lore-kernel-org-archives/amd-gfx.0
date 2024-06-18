Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63218C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 09:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7E1B10E167;
	Tue, 18 Jun 2024 09:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O00Y6VwX";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D83E710E167
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 09:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzkHP5qFlj4fqPdBeOZlDTMwJI6SgiA/Sa0m5jNEQ59ReS4L/9581d8xw8t21gGYZCg2BMEWaSQJ0KVC6ESzTHOkPLqhq9z33vng9gBoWwz8sU0eqRZyJ7rZqgLcUWaOuLQQ7/D0e9YiXdI0RvGvP15V7lklaXItJZl5zr5bYqKBWdo+B90r+fmXGe92Aw1lSqkUeCm5mM/hUIiOw9AROGbVhDKc8EHJRK6UZOxa4wFibR8MvQ9BKqIf4QM4w93D5VRPomrc9lT2p45WMx31i38g/xbnKORhzFhFAIeNj6Q56QwRN5WUwYKoKjmP+fTUVCXxgjgb5WmF6R+Udf8GSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7K/4Lx+ZrCMBaaxUJlKYTD7liTG0AdZcwEyMWt0nT60=;
 b=byRfgqTY67bK4CZcPz5aDl8bBXhgws0AQDDOhlNTsKTyeNplkjv3/uTr5s0e+802Ho0cxwmPqXW8osBt3BcdFBGoFR4o1MxQyeZi1Mqhr+UDQeI7BWU4H48XgiLkvu2XiUJv6JFqJ/cbnwv5Jvv7ur/VBnsPwv2FPow8j//2GmLzo9dRQ9Ojtn0WRibTzFBJsivblMR1uWt37iasTCGWYLyWElFMuCgeeoXvXcQcGCMQ58lzhmk4isg/yNx3UJoTBjEC82r4tQ9gXQB3FaU3o1PFrMwVXeMIVAotHcwNJnpKqgoeInm+lFsIYyEaMVA9DZ8q9swS9UYdEcMjaLnACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7K/4Lx+ZrCMBaaxUJlKYTD7liTG0AdZcwEyMWt0nT60=;
 b=O00Y6VwXcRdcluolZIKwx2lw/FzUCqaLDBq3hFP1WMkea3y9bnGl7B1Do2ESWVNtfTH2sEBpkkPAuSzTzEGsKkEuPsbUQpI98uBhsXw96UgartAsfCvs0ZlQGwnjGoyTun337M4+xWAOjkWFEGIIutQAkxuL3EvGFbHIb+WynHw=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 09:07:18 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7677.019; Tue, 18 Jun 2024
 09:07:18 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: add gpu reset check and exception handling
Thread-Topic: [PATCH 5/5] drm/amdgpu: add gpu reset check and exception
 handling
Thread-Index: AQHawUmaTTeQgN/JqkKV5/9a13V+57HNHOQAgAAcJMA=
Date: Tue, 18 Jun 2024 09:07:18 +0000
Message-ID: <CH2PR12MB4215B374B5DA852372128007FCCE2@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240618063359.304293-1-YiPeng.Chai@amd.com>
 <20240618063359.304293-5-YiPeng.Chai@amd.com>
 <PH7PR12MB59977DF0F022392C22D51EEB82CE2@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59977DF0F022392C22D51EEB82CE2@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0ce0fad0-fa6f-4cf1-8005-c6e3cecb8847;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T08:59:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|BL3PR12MB6546:EE_
x-ms-office365-filtering-correlation-id: edfdde74-75ac-4c6a-e734-08dc8f760dec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?aFEvZnEwS3RiZW1qdnFjUU5Ybmt4eXNDMTRoaTlLNEFXWFpHaUlPVjJFakIr?=
 =?utf-8?B?MzFlMHcxb090YUd6MnJreHV1R2pSbUNHR2sweXZoNnhMMWRVSjd1S0JTM29u?=
 =?utf-8?B?eXltY3dwQ1NmT3l0WHZjeStwb0tZT2s4aE1Va1VTZ2xvSFJ2QUtkY1ZTVlhU?=
 =?utf-8?B?TjJhekpRcDlnejdwQVZrMzNVd1dkQjhQZ2p2dm8veU0vUkxYNlR0cGlqcktC?=
 =?utf-8?B?MkRLV0NOWUpkZXlNOHplR1VjdEZ6aGV6QmVnSnRBckFVUzA2aTd0aGdYLzd2?=
 =?utf-8?B?RVZoZkNZTCtDTnhCZ05WUlMyYm9TRitEK0s1NWVDRlEzcTAyajR2Nmc3SFBC?=
 =?utf-8?B?cTY5U09HeUdNUHJqQ2ZwcFB2TGIrRC8yQlF1bFNrZEYvdFQwRzRXb1JpcUds?=
 =?utf-8?B?cklNVDhORWRCbTJRUU8wUklIL2FVSDRmRk9KMnh1ckhOWS9RTHFyTEs2akM2?=
 =?utf-8?B?T0JvejNlQVNwNDBaYURUK3F0NlZza2pPcHo3WThQa2VFb1h2QWlWZ3g1MXU5?=
 =?utf-8?B?Tnh4OElmVk9Ic0M5bEI1cFRncWhVb2Z4MWFqV2g0Z1VRWmFEM3FkM094SzBx?=
 =?utf-8?B?dWc2ZUxuWkRsVEpMNzVaN2tYZWQ5WmFoeXkxWlBKQVFNMkR4d295ZXJPUzYz?=
 =?utf-8?B?elZtNE5EOHpGQzN5TEtVaFlKbVEzWHpTT3ZESmxPU3E0N1I2MjQveUJsUkww?=
 =?utf-8?B?VUllekhIYzlCeEtSR0hsVm11YnFuYmtRY2RpZ0xpcytpQUp3ME9XZDBqWlhw?=
 =?utf-8?B?dE9MdnErL0lKeTFWRk5DMEM1NUJCcHBaYzRSaHYvMkd0d3ZRRUF3N1JOVjVO?=
 =?utf-8?B?K0ZkcFM5VmlKd3VtU24zR2ZTeVJwUEJhWGdoaWhqOUVwWGFuaEs3bVo3eTYy?=
 =?utf-8?B?SzE1ekFUYjRhWXJnSDQ0MUZZRWtIQ3g4aVBYcXZvK2plS0VhZXpQTjZmV2lD?=
 =?utf-8?B?cWRncHZoUUdLNkVPSUE1czRXVEJvSG1rV1hqMUw4RkFXbkJaQjNwMWYxZEcx?=
 =?utf-8?B?QnFoK2I4TWRhT1k4WkUzeGFjempPdkcwNi9rYUNqaytXMzQrMTdjQzNmMlpU?=
 =?utf-8?B?Zy9iaDhOZDhmUEV0Zlp6UEZjbXptMStKN20wMlYvZjlFQkc5cTVKN3VtYTg3?=
 =?utf-8?B?bWNVREZXQllFaUF6a3hPd0lzUlFtd0VQN1BRZzJJakI4NklheTk1RFYxSDJF?=
 =?utf-8?B?Zm9UcU1KSFMzUG9UN0JkZFJ3OFdIM3h5aFN1VE93ODJidG5qdHRPNkJVc2Mw?=
 =?utf-8?B?aEpiOXJMZjdFRzRxVXczam93eWJDOXFZNGlZR1ZiMWs0L09GUlkwY2ZzbkI5?=
 =?utf-8?B?emNVZS9DeEVYZUdWSGtoTWRXMURkczB6c2htaWloOStUeEJYbC9MNjY2d3Jr?=
 =?utf-8?B?ZlV6WHF1NWh3RUhLQzBIY0NmR2pidXNwVHBrdkcvY05CcFk1L0pIc3FRV2du?=
 =?utf-8?B?RlI2NGtZUTU3dWZjUlgzTml5dzdBOUl2WVZsaUJmMllULytMRlZZdjB2d1FB?=
 =?utf-8?B?WmNWekVkY1Y2ejdQc3R4Y3VwYVVqYnF2ZkpoYjVHQkdUMTdvSkNleXpLMVhx?=
 =?utf-8?B?RnhlajlwNU55OUY2aytueWZwc1N4ZUp5ZWh0NjNhY0JUTjZyMlVXZlk5N3JF?=
 =?utf-8?B?SmI3SzA4bWNQT2dKdktQeVNQVnlVbnVzNFNHN2FhdUkyVkhYMnRwVGZNVjdr?=
 =?utf-8?B?OUJyZDhiYUZXNG1COWRwWGVlUC9ZRno1MzNJTzlBcTEzbFJPL0syK0g2S1Ba?=
 =?utf-8?B?clFnSGZUMjh1b1VvelNWNkEySmJyeERxM1BvUVo3NmVBTE9ZNkcyOXc0V0xC?=
 =?utf-8?Q?PYJnnzqoPZSG0M5m02udBQ+XJIQ7XC2dJFSz4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akhkdEtUd0o2Vmw1VWdIOE5RNERucGNaQnZqWmxPcnFPeVRpS25NNXJKVXFu?=
 =?utf-8?B?VnpISjhhbHlIYWQ1R1lSdjRqWEdRUEttV0VmQ2Qxd1RnM2swVFl2RzZINy9S?=
 =?utf-8?B?bGJ1VE03UWlHOXF5N0h1UUp6RXlaRTdkWjZEeFpYbk5FSHpmeWZMT1JieHo3?=
 =?utf-8?B?RDVFREFZOVNjeDRJcjl1TVEvUHNlSVZVYUhSSkRXQll3WExLY25hUHdkVitn?=
 =?utf-8?B?bThEVVVUTm9MUC9zRGt4TXVZNWNIRS91d0pxeVQvOUk2aHZpd2dQL2hocENN?=
 =?utf-8?B?WW1vUGw0eksxQ3N2OUhMVGpBMGp4TXkyU2FWNkwrSWpMV0VxdnhjQ045ZHF2?=
 =?utf-8?B?UmJ0N1htblV5RFgwUTkxaC9GbkYyQmVZMUhQUEhkR1JJSzh4SFVSWkY5cENj?=
 =?utf-8?B?a0ZYcE5KWUNabUZGSklKdXlUbEh1VlBkVnIxSThaWGxRK1dVU1ZrRThRcEFK?=
 =?utf-8?B?UjRzSzMxdFBxNmJ6K2d6R0g0RlhSdHFuY0xZMFBGTUJ1RngwYWhSVTAyR3BC?=
 =?utf-8?B?T1EreUlqMGN2dC9RWHBUTWJNbmFsYTF1QkRjR1FBSVJxNDdhejhaSVVsRy9M?=
 =?utf-8?B?ckJ5NFdNN2h4MzVqeVVJUmNGelVuNzBReC9ZdDFDY0ZlRForcm80b2xFbE5S?=
 =?utf-8?B?ZFhHMGdyS09vam9hbjB3ei9SRThJd3BNT1g1aGlvK1lBcjhvSGFKN3AvVWkz?=
 =?utf-8?B?NlJtV2YwTWNTR3BqMStidzhaYi9iRWU4RFE3UWZ6UU5rczVycjg1ekVjTW5E?=
 =?utf-8?B?VUtpMnRIcDcvYitrZVZHcHR3NmtUd3BpQjZPWWNXZHhna1IwN0xQRmpMRFll?=
 =?utf-8?B?aStWY3REMzIyVUk2WHBnaW9oRldtejloYkNCQVR5OHM3SUZZZU1vT2FlRjdX?=
 =?utf-8?B?QjJRZWtVRVBCNmkrS0pFZndNNjFLR1BidS9taHd2bG41a2NPT21JdlorQVNK?=
 =?utf-8?B?azRMalNTNXlCZ2prK0hvbmlsYVdST3VvM2ZUMUhXMjFsTTVCYTZablRER1ZN?=
 =?utf-8?B?TmFVdVZ0TnlFWGlBbzkxYUxHWmdVRTZrazJJYTk4b2hVbDg0TDVsZU9hVm1Z?=
 =?utf-8?B?ZDdiUXJMT08xSFNtdlVWWTFycVZVdlFOZ2l6K0J3ZGZrRmNJSG9sTFpnV1gw?=
 =?utf-8?B?WnNQdThmWVhNZFpCc2F3V0ZPK1lxR3RObnNZajg5QkhrMVBCWmR2ZEtwVXNB?=
 =?utf-8?B?dSs3UEhHZWVmS1hnUGdRWVlyUlVDd3htc3F3ZVdhWTFxVm9ROGpKbkZKb0c4?=
 =?utf-8?B?SW9RRzI2bVNXanFQODdNOThCZXc5R2dLNmNEYkVKdUt4Qm1RSnNtMzZ2MkQ0?=
 =?utf-8?B?dXQ5dUh3aklTRFRpYkJiM1ByWHN3N1FnekMzRCtUM1Jtc1puUkE5cEtpWm8y?=
 =?utf-8?B?c2xxdWV4M2RKMG9tK3IwZCtHRTRmdkR0VzFLQUZDVnZKOGpZamRoNjRaaVJ0?=
 =?utf-8?B?MGpZTW9iRW5BRTBscnpYKy8zTkk3Vlp2c3plbXpUYXZKZmpwT09uc09BT2lF?=
 =?utf-8?B?ZnBJVTRlam1ZN2VRVDNEUlcrUmVvQlkrTFl4dWszZlpybkt4Qm1qbE16NElr?=
 =?utf-8?B?eG1Nbkk0WkZiVDVIWGkvOUhqanhmUEg2QjQ2NjN0NVNOeExaL2ZNZ3dYVzhV?=
 =?utf-8?B?eE9YZEJXSXRLN2F3YmI3aG5EL1REWkh5c01qaTAvNURKTkY1U2xwWUhYclll?=
 =?utf-8?B?d2M3V0JaUGlYK0Yvc3Q1MSt4aUdvRURGUENXbkZ4T2hidDBYeU80WmZEVEZa?=
 =?utf-8?B?K2kzMGVBL3ZpQVJJMFg3TjNxUzlOYjllSlNsUFJyUEphNFMzWDBQWHBCMThN?=
 =?utf-8?B?OTMzM0tOeXcvVWEybm12U29GTU9jaXp1YTBoMjBueVFseDBmeTV6YkhKMlcr?=
 =?utf-8?B?U0RORmhHWlEybVJQSU1zRU5QcklORlQzVTJVTG83ekJUMlJqbjAybVUzdC9D?=
 =?utf-8?B?SFN5TTUrMFlpQldXUVlraFZDVW9EcWgreFVLbnRnV3RBYmVXK0c5bXN1NHhs?=
 =?utf-8?B?VTJaZi96dlhhaG9XN3prd25VK3NJeUlkMVd2cFUvZ3hJbFN0SVBucnNKVmN6?=
 =?utf-8?B?N2RPaDNaaTlDTUlHMERnVDg3MXRUeFhaUDg4bWhnbXlWdG82QTEzRVdiLzFk?=
 =?utf-8?Q?wn/8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfdde74-75ac-4c6a-e734-08dc8f760dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 09:07:18.1807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9Gr76vanIgDd2J9jYR1Rhh30n/zFtZ7+GkwM9eNdxVGCaxmu4euICBzafi50bd/JxVo29I/PudbdkDy7s1RnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
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
Cg0KLS0tLS0tLS0tLS0tLS0tLS0NCkJlc3QgUmVnYXJkcywNClRob21hcw0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5n
QGFtZC5jb20+DQpTZW50OiBUdWVzZGF5LCBKdW5lIDE4LCAyMDI0IDM6MTkgUE0NClRvOiBDaGFp
LCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBaaG91MSwg
VGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+
OyBZYW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJFOiBbUEFU
Q0ggNS81XSBkcm0vYW1kZ3B1OiBhZGQgZ3B1IHJlc2V0IGNoZWNrIGFuZCBleGNlcHRpb24gaGFu
ZGxpbmcNCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaGFpLCBUaG9t
YXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQpTZW50OiAyMDI05bm0NuaciDE45pelIDE0OjM0DQpU
bzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBMaSwg
Q2FuZGljZSA8Q2FuZGljZS5MaUBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFu
Zy5XYW5nQGFtZC5jb20+OyBZYW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT47IENo
YWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSCA1LzVdIGRy
bS9hbWRncHU6IGFkZCBncHUgcmVzZXQgY2hlY2sgYW5kIGV4Y2VwdGlvbiBoYW5kbGluZw0KDQpB
ZGQgZ3B1IHJlc2V0IGNoZWNrIGFuZCBleGNlcHRpb24gaGFuZGxpbmcgZm9yIHBhZ2UgcmV0aXJl
bWVudC4NCg0KU2lnbmVkLW9mZi1ieTogWWlQZW5nIENoYWkgPFlpUGVuZy5DaGFpQGFtZC5jb20+
DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCA0MyArKysr
KysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKykN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KaW5kZXggN2Y4ZTZjYTA3
OTU3Li42MzVkYzg2ZGJmZDggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYw0KQEAgLTEzODYsMTAgKzEzODYsMTUgQEAgaW50IGFtZGdwdV9yYXNfcXVlcnlfZXJyb3Jf
c3RhdHVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgcmFzX3F1ZXJ5X2kNCiAg
ICAgICAgbWVtc2V0KCZxY3R4LCAwLCBzaXplb2YocWN0eCkpOw0KICAgICAgICBxY3R4LmV2ZW50
X2lkID0gYW1kZ3B1X3Jhc19hY3F1aXJlX2V2ZW50X2lkKGFkZXYsIGFtZGdwdV9yYXNfaW50cl90
cmlnZ2VyZWQoKSA/DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBSQVNfRVZFTlRfVFlQRV9JU1IgOiBSQVNfRVZFTlRfVFlQRV9JTlZBTElEKTsNCisN
CisgICAgICAgaWYgKCFkb3duX3JlYWRfdHJ5bG9jaygmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0p
KQ0KKyAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KKw0KICAgICAgICByZXQgPSBhbWRncHVf
cmFzX3F1ZXJ5X2Vycm9yX3N0YXR1c19oZWxwZXIoYWRldiwgaW5mbywNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJfZGF0YSwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZxY3R4LA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJyb3JfcXVlcnlf
bW9kZSk7DQorICAgICAgIHVwX3JlYWQoJmFkZXYtPnJlc2V0X2RvbWFpbi0+c2VtKTsNCiAgICAg
ICAgaWYgKHJldCkNCiAgICAgICAgICAgICAgICBnb3RvIG91dF9maW5pX2Vycl9kYXRhOw0KDQpA
QCAtMjg4NCw2ICsyODg5LDE0IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19wb2lzb25fY3JlYXRp
b25faGFuZGxlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAgICAgICAgcmV0dXJuIDA7
DQogfQ0KDQorc3RhdGljIHZvaWQgYW1kZ3B1X3Jhc19jbGVhcl9wb2lzb25fZmlmbyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikgew0KKyAgICAgICBzdHJ1Y3QgYW1kZ3B1X3JhcyAqY29uID0g
YW1kZ3B1X3Jhc19nZXRfY29udGV4dChhZGV2KTsNCisgICAgICAgc3RydWN0IHJhc19wb2lzb25f
bXNnIG1zZzsNCisNCisgICAgICAgd2hpbGUgKGtmaWZvX2dldCgmY29uLT5wb2lzb25fZmlmbywg
Jm1zZykpOyB9DQorDQogc3RhdGljIGludCBhbWRncHVfcmFzX3BvaXNvbl9jb25zdW1wdGlvbl9o
YW5kbGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDMyX3QgbXNnX2NvdW50LCB1aW50MzJfdCAqZ3B1X3Jlc2V0KSAgeyBAQCAtMjkxMyw2
ICsyOTI2LDExIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19wb2lzb25fY29uc3VtcHRpb25faGFu
ZGxlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAgICAgICAgICAgICAgICBlbHNlDQog
ICAgICAgICAgICAgICAgICAgICAgICByZXNldCA9IHJlc2V0X2ZsYWdzOw0KDQorICAgICAgICAg
ICAgICAgLyogQ2hlY2sgaWYgZ3B1IGlzIGluIHJlc2V0IHN0YXRlICovDQorICAgICAgICAgICAg
ICAgaWYgKCFkb3duX3JlYWRfdHJ5bG9jaygmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pKQ0KKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87DQorICAgICAgICAgICAgICAgdXBfcmVh
ZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOw0KDQo+IFtLZXZpbl06DQo+IEknbSBjb25mdXNl
ZCB0aGF0IHdoeSBub3QgdXNpbmcgJ2FtZGdwdV9pbl9yZXNldCgpJyBoZWxwZXIgZnVuY3Rpb24g
dG8gY2hlY2sgcmVzZXQgc3RhdGU/DQoNCj5CZXN0IFJlZ2FyZHMsDQo+IEtldmluDQoNCltUaG9t
YXNdIFRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIGluIHBhZ2UgcmV0aXJlbWVudCB0aHJlYWQuDQog
ICAgICAgICAgICAgICAgIEFjY29yZGluZyB0byBDaHJpc3RpYW4gS8O2bmlnJ3MgcHJldmlvdXMg
ZW1haWwgc3VnZ2VzdGlvbnMgIHRoYXQgIkl0J3MgaWxsZWdhbCB0byBjYWxsIGFtZGdwdV9pbl9y
ZXNldCgpIGZyb20gb3V0c2lkZSBvZiB0aGUgaHcgc3BlY2lmaWMgYmFja2VuZHMuIg0KDQorDQog
ICAgICAgICAgICAgICAgZmx1c2hfZGVsYXllZF93b3JrKCZjb24tPnBhZ2VfcmV0aXJlbWVudF9k
d29yayk7DQoNCiAgICAgICAgICAgICAgICByZWluaXRfY29tcGxldGlvbigmY29uLT5yYXNfcmVj
b3ZlcnlfY29tcGxldGlvbik7DQpAQCAtMjk3Nyw2ICsyOTk1LDMxIEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3Jhc19wYWdlX3JldGlyZW1lbnRfdGhyZWFkKHZvaWQgKnBhcmFtKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgIH0NCg0KKyAgICAgICAgICAgICAgIGlmICgo
cmV0ID09IC1FSU8pIHx8IChncHVfcmVzZXQgPT0gQU1ER1BVX1JBU19HUFVfUkVTRVRfTU9ERTFf
UkVTRVQpKSB7DQorICAgICAgICAgICAgICAgICAgICAgICAvKiBncHUgaXMgaW4gbW9kZS0xIHJl
c2V0IHN0YXRlICovDQorICAgICAgICAgICAgICAgICAgICAgICAvKiBDbGVhciBwb2lzb24gY3Jl
YXRpb24gcmVxdWVzdCAqLw0KKyAgICAgICAgICAgICAgICAgICAgICAgd2hpbGUgKGF0b21pY19y
ZWFkKCZjb24tPnBvaXNvbl9jcmVhdGlvbl9jb3VudCkpDQorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGF0b21pY19kZWMoJmNvbi0+cG9pc29uX2NyZWF0aW9uX2NvdW50KTsNCltLZXZp
bl06DQoNCkFoYSEgSXQgaXMgYmV0dGVyIHRvIHVzZSBhdG9taWNfc2V0KCkgdG8gaW5zdGVhZCBv
ZiBpdC4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCisNCisgICAgICAgICAgICAgICAgICAgICAg
IC8qIENsZWFyIHBvaXNvbiBjb25zdW1wdGlvbiBmaWZvICovDQorICAgICAgICAgICAgICAgICAg
ICAgICBhbWRncHVfcmFzX2NsZWFyX3BvaXNvbl9maWZvKGFkZXYpOw0KKw0KKyAgICAgICAgICAg
ICAgICAgICAgICAgd2hpbGUgKGF0b21pY19yZWFkKCZjb24tPnBhZ2VfcmV0aXJlbWVudF9yZXFf
Y250KSkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXRvbWljX2RlYygmY29uLT5w
YWdlX3JldGlyZW1lbnRfcmVxX2NudCk7DQorDQorICAgICAgICAgICAgICAgICAgICAgICBpZiAo
cmV0ID09IC1FSU8pIHsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogV2FpdCBm
b3IgbW9kZS0xIHJlc2V0IHRvIGNvbXBsZXRlICovDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGRvd25fcmVhZCgmYWRldi0+cmVzZXRfZG9tYWluLT5zZW0pOw0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1cF9yZWFkKCZhZGV2LT5yZXNldF9kb21haW4tPnNlbSk7DQor
ICAgICAgICAgICAgICAgICAgICAgICB9DQorDQorICAgICAgICAgICAgICAgICAgICAgICAvKiBX
YWtlIHVwIHdvcmsgcXVldWUgdG8gc2F2ZSBiYWQgcGFnZXMgdG8gZWVwcm9tICovDQorICAgICAg
ICAgICAgICAgICAgICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmNvbi0+cGFnZV9yZXRpcmVt
ZW50X2R3b3JrLCAwKTsNCisgICAgICAgICAgICAgICB9IGVsc2UgaWYgKGdwdV9yZXNldCkgew0K
KyAgICAgICAgICAgICAgICAgICAgICAgLyogZ3B1IGlzIGluIG1vZGUtMiByZXNldCBvciBvdGhl
ciByZXNldCBzdGF0ZSAqLw0KKyAgICAgICAgICAgICAgICAgICAgICAgLyogV2FrZSB1cCB3b3Jr
IHF1ZXVlIHRvIHNhdmUgYmFkIHBhZ2VzIHRvIGVlcHJvbSAqLw0KKyAgICAgICAgICAgICAgICAg
ICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZjb24tPnBhZ2VfcmV0aXJlbWVudF9kd29yaywg
MCk7DQorICAgICAgICAgICAgICAgfQ0KICNlbHNlDQogICAgICAgICBkZXZfaW5mbyhhZGV2LT5k
ZXYsICJTdGFydCBwcm9jZXNzaW5nIHBhZ2UgcmV0aXJlbWVudC4gcmVxdWVzdDolZFxuIiwNCiAg
ICAgICAgICAgICAgICAgICAgIGF0b21pY19yZWFkKCZjb24tPnBhZ2VfcmV0aXJlbWVudF9yZXFf
Y250KSk7DQotLQ0KMi4zNC4xDQoNCg==
