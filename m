Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248E1ECAAD4
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 00:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EFA410E172;
	Wed, 31 Aug 2022 00:51:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C158710E1A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 00:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPQ/VKOePnG76vX1E9+7Y2nz54pagTx24TfJ1Uf+t4T7Njh8wENOgkUvM02rPvj6M2V7xlYdxfjAU91cd3XpYwb+aqpVfticRgkCBUb3rs3Nta8wQydG4B5bw/EEutDKKHYdAGCeZT+DahTV2cUWUhOR9pmaT6uvmT0SwQAWrWah2SDb0ePdTGgNuuT8hoo5U0pWc/wmLxklSlr6eLwssgsrKpoVVW66VjgD+Eln1Qc9+hpjXlyNtWs7qhl95+SBihRZrpN26wsdgLE5WsYTr4Hb84lGv1sWTqnv8hNXa/lQdlypdLJvEt7XfGJD5o85LM6UVmdwhBg7xp3KEtp5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7zKQ4i+qQmSncyFOiuaqYWOND2BGfmNB5l3EVozKt0=;
 b=AxUBWZbTt9vjg/96n1Hacn5spIepm2rqXlIrHnqCPMmMb+E+nd/1yifKKq1QtkSWMIexSHxkHEDFTuIk7bleOs6meeyIJk0Xd2hIcPrU52MwmfZXXN/3+r8CdrOM6ExlQc8SVGiXLgXNoAj8lLBqZsQDAo7ozITpTGKqJMWnjv4o5PML4vo6Yj41O6ZCFzNxROE4Ap8i47kh3Tdidwjo7l6RUtnBjllyPP198o7PUqwtItdaUu8qk4BzIVWftfXo/4CVzFShZpSg6uceXB/RMO5ccCEGkazhmplcjiBHG6Pz0wK5wtssPNuJuLS8MYr5Ic7PQcmfhklcPn4hxQvhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7zKQ4i+qQmSncyFOiuaqYWOND2BGfmNB5l3EVozKt0=;
 b=DjgMxlHKVuLf0yJVeFbPvW5Qd6pTx5HEg7Cu836N6d2w8ZOMVHnMgOU4VgwVD8/bc3o/3JlT7f1oT840X1cXtLfUrMwF88rYWMU+cB2ofP4EacT7BeVV7EhY2vhDVolUemAiZJ8qQ4Q9wEuXyi2BUli8skSEiPifJNKdl5ELNoQ=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 00:50:53 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1%4]) with mapi id 15.20.5504.028; Wed, 31 Aug 2022
 00:50:53 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu/mes: zero the sdma_hqd_mask of 2nd SDMA engine
 for SDMA 6.0.1
Thread-Topic: [PATCH] drm/amdgpu/mes: zero the sdma_hqd_mask of 2nd SDMA
 engine for SDMA 6.0.1
Thread-Index: AQHYvISIZo/WxSKMm0KFwMwukxJgRa3Hke4AgACcQjA=
Date: Wed, 31 Aug 2022 00:50:53 +0000
Message-ID: <CY5PR12MB6369869503127A6EE6A11B38C1789@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220830152335.3539841-1-yifan1.zhang@amd.com>
 <CADnq5_M_0T7wbJkOUtisK1QChQmRnW8QXLqfO400yD2kTyOGgQ@mail.gmail.com>
In-Reply-To: <CADnq5_M_0T7wbJkOUtisK1QChQmRnW8QXLqfO400yD2kTyOGgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-31T00:50:18Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=338a98a8-b401-4727-910d-a6d4f3e7b2d3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-08-31T00:50:50Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c9308962-805d-4f15-9e1c-7fcb83c8be8e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1054d6a7-9609-49ca-118b-08da8aeadb68
x-ms-traffictypediagnostic: CH2PR12MB4070:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oZ0X2Uf5j/buY1DsVHuHZg8itR/65V/drC77DIVqmE3B3BQmLzUwG1eDKnaFTRruXJ1JxL0PlwzQDhYb80gPP2XXLGceRE6C64PFaG56BXKRtLnDRKilSFKz/ZQ/oXs6CaaTXWhhWJak7Q/4gihkes3/ZkmDmR5IoGTqIoqxVlFwHwWBnKAyhg2AokY4Ntt3thOY9r+UywCRSitMhPpOa/b7jIS37zQQgdoPonnRLvCDBC7VMme60VY+fp59dKatR7TXbNHhNzf30WZbszzd0YbeHS2kCJo9uNBNk3ITVK2z4aCZauVdbMiK0suGaqRo8regoIWNvotz2GYVDCv5Xxqocwp9wcRHhUMhQ74HrKbEhYZNPphL3IBDpM2v5KyIjAnH6uRYNSaAHbW1BgPSLqcUDfU6ErVQe04irvUpiUrAj5jL9OR0M7ogKaw3AJgBMXxBOK6fJGWvhfkDnJq64SkY/3k8CClMDIDjk6oYa2SHwC6hCqYp6u244lOwwC2ybM62dWr+haUXW/Q5XyAClxqZKzxknEUQBtWLzeqgpsC99/UbjIopM9y9vQ6NSMtE9zYVS2SPa6lH5tHnpScpLMqb0OcQcEqcgIucuRKsOm719h1QJyxyXH/AIuv4amlevFvxgSwgeuED9WpicKdKo7bN2cl6YWarno7SaaCNIOQY5e1KLlqW+GGGC2MySEwKqlLag0kqRX2zTQfnTqcbet7mus5V0kmOzEnIiY2iWdbKMBG7qYivWGYhOXNzTmCEv2dhRAJQAvV1SrZ03hCV6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(71200400001)(478600001)(53546011)(41300700001)(83380400001)(26005)(186003)(9686003)(54906003)(5660300002)(52536014)(7696005)(6506007)(8936002)(55016003)(6916009)(2906002)(4326008)(66476007)(66946007)(64756008)(8676002)(76116006)(66446008)(38070700005)(33656002)(86362001)(122000001)(316002)(38100700002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q01FK2RkRUVZaHZKVHpkRWw1cHprUXBRaGhnWmI2cjFUTm4wVmV0Mk1GaFpi?=
 =?utf-8?B?NmdaNGR5dlhYazdYajVydlkwMU05T3FielJQcEk1RGdnQisxVG10L0cxWFNT?=
 =?utf-8?B?R1JIN3JSWm5Xcld1KzRYbll3a0hMeUlvd0FWZ29LeW9NU2tERElNMlErOHNy?=
 =?utf-8?B?ay8wN0F5Wk5hSGV1RFdrMFZiamRWU1p2ZzJCM01vOHRrOUEvcmZsY0dFdExI?=
 =?utf-8?B?QktsZnRyRFB6TGdoQ0ZmNU02UmJLdVBkODlad0Y3TmJaUW1jaGE4YWk3WXJy?=
 =?utf-8?B?OWllV2lrdWtDMjZTb1VIaWxPcnB6MjMyVVI2MnJCalVBaEhnVmtJakFhTmFw?=
 =?utf-8?B?UExpaWJ3L0FtcHpJeFMwQ1RLdStLc0xDQURabVRCMCtyK0dleldrRWFvdStY?=
 =?utf-8?B?b2FDeTBrU0RUcWg2WlBLbE16RzlGcjluWnlZOGhQMFpPWG5CL2dhdjVrNWR5?=
 =?utf-8?B?MHIvSmQxMWZxRkZwQUdiR0hzMlRmMFRXb0p6aE9EY1pmTkdZLzNrNzBPQTBQ?=
 =?utf-8?B?K1JabnlQYThXZ29Kck5RSEQ4Uk90RlJ5Mm1tUVNHelRmbnA1QXYvNHk1NC9j?=
 =?utf-8?B?TWFSMEovWXA3OVViOVZkTnZUWkRrd3NkZm54YlpwcFZqS3ZnL2tVVDR6YWU5?=
 =?utf-8?B?d0VaNVVKcHgxQXdTc0xDNU1NcUxDdmhhSTdyZFNaaFM2MVh1VHF5dThZOE5D?=
 =?utf-8?B?M3J0QmpVQjh5MVlpZ2p2RHZwMTNSR3hrQmVBVEZSOW5jb0dLeEx5azRFaUly?=
 =?utf-8?B?SXF0dEUyN1Nsc2RGY28rcmJ6MndqUTM4bkNvSFo0TUhocy9jYUMyUC9qVC8v?=
 =?utf-8?B?dDNxbGlIVms1L01ZZUtWbU92NzZYbDBSY1lkRTR2RUhCMmFZVTIzMHdpUXBB?=
 =?utf-8?B?dCt2aThFWmZPSmNkTUZUVWZtUjFUSEtMMXVieU5SeDhDUDFSVG9pSXRIcjR2?=
 =?utf-8?B?T1FrRUxFZHNMK0hCdVl0MlVtQ001OGRWdUNyUG9rZkFnSms1YTN1V01kTHNm?=
 =?utf-8?B?dzM0NzgzckNjTXNRWWV3RStZVHR5L1UyUEtHRHJ4L1c3UHJTOThlbjM0YUVa?=
 =?utf-8?B?clIvdVdmdzRQTWFFRmJubjBTRVhSZ3JaMkc4VmltcituNGx4VENncmVFN25h?=
 =?utf-8?B?a3FNS204T3hKZ0JnQ1RUOWwxb05mMzMzSkNJWTU3cG9Ccnh3ME1DRk1KUWtM?=
 =?utf-8?B?cmZxRTFBY1NLTTVqWnZ0czVQckhvbGZUYlRCM2l2a2N6T01HTzljNEh4Qmt2?=
 =?utf-8?B?cmlnb0hGOHpwYnhiV04yUUR1WERWUUhkaWFmWE1qbWNFYkV4VVM1U3dQOXh3?=
 =?utf-8?B?WklxOC9rK3UzL3JuaTA2NUx3R2E5NU04dHhucGpZK0lWaTkrMG1VSXNieFV5?=
 =?utf-8?B?Ym83MG1jT2IraXk3MTcwY01JYlB5QUVmbDI2TzVqekt5YW1hQlNGZzdEbkI5?=
 =?utf-8?B?NkRPa0pHNE4wanRmYmRvNW8rb2pKVG5PLzJtSUNBTkdvVTl6UE13dEQ1QU1q?=
 =?utf-8?B?UkttT0ZEdUVMc0FqbmtzdlFVa3QyVTBPbVUvSktaQWNhdS9sZ1NvbjVjazFw?=
 =?utf-8?B?T0ZzcmdWc01DY2Y2Mno0eXpUeEJ2ejB6dUJ5L0V6RGFmelhGNm9oSlpvbkUy?=
 =?utf-8?B?OXB4UTEvWHhpZ2NzMVZ1bkF4MDQ0NU9lYnVQOTkvdXZ5Z3N1ajFGTFZMYXdq?=
 =?utf-8?B?MTdzNG9wYzVaeklwRm96YkZSYUdFTDl3bHhrcGUzQUJjWVhRREdPdUR0K2lL?=
 =?utf-8?B?enpDbm5CNWZ0b3UvSzlQRVdlRE1FRk8vam41L0E5bW5zOTBBT1hnNFdJeTdr?=
 =?utf-8?B?TEh2dHRKQ3lyS01scTIzK0RBem1HQ3hSS3JJcjRGSE50dWtHY1lvdm02bTR5?=
 =?utf-8?B?dlhYZGVLa01SeEdsZ1VteXVrSHQ4dnpTb0NRT3Z1KzRndEJzeGNVQ1JyZnFM?=
 =?utf-8?B?OTc3M0wwZXRyclJNU05nQmhFZHRzOWVLeXNzbFViSHFlVmsraytKcitrZDZj?=
 =?utf-8?B?amlpbWMwYWJVNjAxL1Q5d0NTeElncm5teDlnc1RyWDhuVmtrNUU2ZGVLSi9n?=
 =?utf-8?B?aEVybDdtT1hYcVQ4elpqdjNZY01vS0thOFcxK1E4QVR4cXY2ODdWNnp3UUZD?=
 =?utf-8?Q?i6us=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1054d6a7-9609-49ca-118b-08da8aeadb68
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 00:50:53.4201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNECxPXGDoslUuLo6iU+dijmVrc/b912rW0Q8x0GryZEJ8/0QzTm4JiBkFKLuoaC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KT0ssIHRoYXQncyBhIGJldHRlciBzb2x1dGlvbi4gDQoNCkJlc3QgUmVnYXJk
cywNCllpZmFuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNo
ZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBBdWd1c3QgMzAsIDIw
MjIgMTE6MzEgUE0NClRvOiBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPg0KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1kLmNvbT47IFhp
YW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBh
bWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS9tZXM6IHplcm8gdGhlIHNk
bWFfaHFkX21hc2sgb2YgMm5kIFNETUEgZW5naW5lIGZvciBTRE1BIDYuMC4xDQoNCk9uIFR1ZSwg
QXVnIDMwLCAyMDIyIGF0IDExOjI0IEFNIFlpZmFuIFpoYW5nIDx5aWZhbjEuemhhbmdAYW1kLmNv
bT4gd3JvdGU6DQo+DQo+IHRoZXJlIGlzIG9ubHkgb25lIFNETUEgZW5naW5lIGluIFNETUEgNi4w
LjEsIHRoZSBzZG1hX2hxZF9tYXNrIGhhcyB0byANCj4gYmUgemVyb2VkIGZvciB0aGUgMm5kIGVu
Z2luZSwgb3RoZXJ3aXNlIE1FUyBzY2hlZHVsZXIgd2lsbCBjb25zaWRlciANCj4gMm5kIGVuZ2lu
ZSBleGlzdHMgYW5kIG1hcC91bm1hcCBTRE1BIHF1ZXVlcyB0byB0aGUgbm9uLWV4aXN0ZW50IGVu
Z2luZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuYyB8
IDggKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuYyANCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmMNCj4gaW5kZXggZmU4MmI4YjE5
YTRlLi5mODc2ZmQ2MmFiODEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9tZXMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfbWVzLmMNCj4gQEAgLTE4NSw2ICsxODUsMTQgQEAgaW50IGFtZGdwdV9tZXNfaW5pdChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgYWRldi0+
bWVzLnNkbWFfaHFkX21hc2tbaV0gPSAweGZjOw0KPiAgICAgICAgIH0NCj4NCj4gKyAgICAgICAv
KiB0aGVyZSBpcyBvbmx5IG9uZSBTRE1BIGVuZ2luZSBpbiBTRE1BIDYuMC4xLCB0aGUgc2RtYV9o
cWRfbWFzaw0KPiArICAgICAgICAqIGhhcyB0byBiZSB6ZXJvZWQgZm9yIHRoZSAybmQgZW5naW5l
LCBvdGhlcndpc2UgTUVTIHNjaGVkdWxlciB3aWxsDQo+ICsgICAgICAgICogY29uc2lkZXIgMm5k
IGVuZ2luZSBleGlzdHMgYW5kIG1hcC91bm1hcCBTRE1BIHF1ZXVlcyB0byB0aGUgbm9uLWV4aXN0
ZW50DQo+ICsgICAgICAgICogZW5naW5lLg0KPiArICAgICAgICAqLw0KPiArICAgICAgIGlmIChh
ZGV2LT5pcF92ZXJzaW9uc1tTRE1BMF9IV0lQXVswXSA9PSBJUF9WRVJTSU9OKDYsIDAsIDEpKQ0K
DQpIb3cgYWJvdXQgY2hlY2tpbmcgZm9yIHRoZSBudW1iZXIgb2YgaW5zdGFuY2VzIHJhdGhlciB0
aGFuIGEgc3BlY2lmaWMgSVAgdmVyc2lvbj8NCkUuZy4sDQppZiAoYWRldi0+c2RtYS5udW1faW5z
dGFuY2VzID09IDEpDQoNClRoaXMgbWFrZXMgdGhpbmdzIG1vcmUgZnV0dXJlIHByb29mIGZvciBu
ZXdlciBTRE1BIDYueCBJUHMuDQoNCkFsZXgNCg0KPiArICAgICAgICAgICAgICAgYWRldi0+bWVz
LnNkbWFfaHFkX21hc2tbQU1ER1BVX01FU19NQVhfU0RNQV9QSVBFUyAtIDFdIA0KPiArID0gMDsN
Cj4gKw0KPiAgICAgICAgIHIgPSBhbWRncHVfZGV2aWNlX3diX2dldChhZGV2LCAmYWRldi0+bWVz
LnNjaF9jdHhfb2Zmcyk7DQo+ICAgICAgICAgaWYgKHIpIHsNCj4gICAgICAgICAgICAgICAgIGRl
dl9lcnIoYWRldi0+ZGV2LA0KPiAtLQ0KPiAyLjM3LjENCj4NCg==
