Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E477C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 04:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE5D10E45C;
	Thu,  8 Dec 2022 04:35:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B196610E457;
 Thu,  8 Dec 2022 04:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qnjq2MNwCD56fZaGctUzCOmLb9jtm4nK3lm6eyjNJmPT3qj9zqMnQCPyvMiM5AzKvRAx31SG2o9Q+IQxxVa5PJ9tmxIJN4oK022+86d9+W6CzZ8b6eYlMXN2Txjl6k12MkiSHw4RCCwNgqDPx5FFZbRmYM3HtFXCUncKpbgRMRUxJRAMLA6asSTt+CigVrm119M7gae8/aUqurnF91dDSyh5FhrcvYRuNa9NDlwBKHpJV1OC8XW+kw1EBdZ8PC/Zj3lzQjOk+lMvrBitgNkPWQkrJbMj3F/FFZvsgPVi42vUOtbKo2l3N5qYXzcTkGRp0GxOwQhF5rOPVMNVRdqD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSOA/iG4YRiZqoItcI6gJzp6a+Ccvxq7GzNTuZEAxF0=;
 b=nJdDvuZtk1namj++nN6pN795TS+DTPJhPUcoos8ah26ovWVtgchfcetHKmCSKNTDKWMs+9QguDEp8WKIynn37D3DEEyfaFPw+ep5SyLK2+wOvZMKi1h6BYuATOBxohe7hX8z0JEjNPBrKIVy2BNW2YNa4M1lShYOMw+G83gyfw8uIHRj33rU+XlaQMUMLyP6o63z5fQsAyXVTXDKtHsy7SYOvASQkBMqwGpxXpDgZ0Ah89dJ5htQUtepoH/xufhtfknaU3y7DHE9Jqs680xoHw0g6cxAfLgCe7LfD0lUxWxkC0gtcBn9Wj4NCQRgGujSpJBf2NxQtjp1d/DECoNcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSOA/iG4YRiZqoItcI6gJzp6a+Ccvxq7GzNTuZEAxF0=;
 b=FfbkQdPuaDD0kKJZyfGsw17ycn54XlLM9EsRoHgzLYBIXb+7Qh4AtFGzFcbSxG5T/6+71FlJtOdWoFMXC2FIEd/7BYK787NJ0eXdV3F/vZU1uH9zj0nKZo8FKf1M42yYUHpz0Z79lbSdZWvcB0iSAOz04Bb3ZIAj+U8oHjosjS8=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 04:35:23 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::863a:8b00:6eae:5276]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::863a:8b00:6eae:5276%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 04:35:23 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
Thread-Topic: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer
 failed
Thread-Index: AdkKDSDFxSlpkC5gTnSZE4zebcKC0wAQPv2AAABvKoAAAIkXgAAAfQYAAACNQwAAABRqgAAAW36AABiUhGAAAH4DgAAAGGBQ
Date: Thu, 8 Dec 2022 04:35:23 +0000
Message-ID: <CY5PR12MB63699C93015F77F4C6AD5BDBC11D9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
 <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
 <CADnq5_PShNRZUwvnsTawW1OaCOjK73rdKTxxQhA=Znf2gqbJ=Q@mail.gmail.com>
 <ce75ecb5-1d07-d8a6-2722-59da84c22c10@gmail.com>
 <CADnq5_Mo_hmc7SCYJxQHc-TgdzXS7+YD-SUt9aF-Gx2AovriRw@mail.gmail.com>
 <581403d1-f5f3-72a6-5447-6deef4405d47@gmail.com>
 <CADnq5_OtFeSYKKjniNXuXUmX4WgXw1+hN-3YoRpBh-Ytjosv5g@mail.gmail.com>
 <CY5PR12MB6369519F1EABAE9A86957850C11D9@CY5PR12MB6369.namprd12.prod.outlook.com>
 <CADnq5_PR+7s=FPY71j3XqUA4C62j8zE8FRKq+Oty=nNjSN=Rzw@mail.gmail.com>
In-Reply-To: <CADnq5_PR+7s=FPY71j3XqUA4C62j8zE8FRKq+Oty=nNjSN=Rzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-08T04:21:40Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=697fdcdd-bb41-4d0a-89d5-b5222f162402;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-08T04:35:21Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 64065d3a-1e0c-4287-bc22-98aa63939b0c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SN7PR12MB7023:EE_
x-ms-office365-filtering-correlation-id: e0e8e846-3d9e-4a04-e9bf-08dad8d59edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qaJTyuSoLqDycBrI60ejWEJKtMcUYX/looyiwQARA2sJv7K9js57B8J+11MHAUHjbrQ7FQvD+qJm4g6EujJs/qYt1nqyl2OoV39T0Fun/CI+uYpT0eSHVROMmfDnmofEtDrYTXAI2gkPFbl8HK2oXLYqo/XNM/iiu700X+sHrTzn1JEZ4ULAY3kh79bLLPv8eCZwZxNmZqr5MuyJeLZaKuwHVaolEqGDvDcJQ9umLJJ6oaod1R+sb/5TlpWGCDqK+ama7Jb4XJhJg3wW0UxY6DjaxWNSosO2PWHYKsgrxfrSlYBZFm2XYkzuEJFnv2JE4/cNELi0sYaDx/aKpga0jDip5vTiKASLWA+KvhlIHMAJ1XOpuAWbM7PyZE1M582nMTygQQMjZSipfTN/isdcgXhEc9h2YxfHre2j1Pip66WGjdxF53BSvKoSe+9PDw5h9cHbLFdPDacLh/04oPDGEMp9QPwu/Tp0yl9qvmbKLEODwu0FMXoMiL4AgeQFBhfQS/fEptwqI+RNM7xgeSd3oPYXWrWrLQG92jEH3nsEYCixiNes/ARg32dDKywP9qpIsQfG1wJj1LANxCSdlSCU6st4aFBEBLNZEpA0Fj/5m5ZwIBwXqqrM92NuQjzmjEwR8HnB8JBU/zCjXwB9DPsaKKMF2gtDXyYN/CBvdhlR3JwMp8+joQA4czPyNFob+UrSOo/fkLMVkOe85SjrzvTF+WUEfUoBqxx1kbxyDNXQ/Y0MZJm2Lcu9zlmova9t+BjN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(186003)(316002)(86362001)(478600001)(6916009)(54906003)(71200400001)(38070700005)(33656002)(55016003)(7696005)(83380400001)(9686003)(6506007)(66574015)(53546011)(38100700002)(122000001)(26005)(2906002)(5660300002)(4326008)(64756008)(66946007)(66476007)(52536014)(76116006)(8936002)(66446008)(8676002)(41300700001)(66556008)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVB4aWQ2MnRQWWFUWmREZjFmVllXWXlqcG91eTRxenBYNW4vYW9sTGhhOUQy?=
 =?utf-8?B?Q01GTlRKRnpTb1c4SXRwYmRlR3l1b00xSzlrWXJCbStvQ25EcEV6T0JhU2JX?=
 =?utf-8?B?aVhlN3JabEs5bDUxdmZ3aW5GUzQ2L2FvTHY5Y1VMUU8wS1JFaEszWXU0SUEr?=
 =?utf-8?B?YkplNEZ5NjNLUXUvdkxIWmE1b2xsN3pEQnhReTBpUmF4NTNIaWY1bVM4bHBm?=
 =?utf-8?B?OTE2ZDg1UHF1bUJKMWd2cnVBcmsrVjdkTlFoZWUrV0M3OWRLN1QwNUdiUTlJ?=
 =?utf-8?B?MHBuMldxd0Q2clpFWXpZcGY2VlVVaCsyWXd3ck5OREZOc2xFeGdYQmRZUnpU?=
 =?utf-8?B?dDNqUWphUDhKNGc0QmVhMmZObUVHTS9vR1JUc2lMblVNVHhIaXVUUlIxTGR2?=
 =?utf-8?B?eFd1NTRSS0M4bldmZldSbC80cWxSYTBpVUxlZXJlb3pLbnE4OHBTK2dXaWZx?=
 =?utf-8?B?YjNqd0tpdmtTaHRwZWJtckoyMUpJRS9FdXJObDRoY3JIWTFxTExKOFVoMVZN?=
 =?utf-8?B?UkZ2N1BvVDJueU15ZDlUR2RqdDdOTGxOUnZ0Wlpia01zYVdKajB6Q3VDMnpC?=
 =?utf-8?B?RmR6VDVteXZPeE5lWkEzN1FHblRvVUdpUUhGSUpTSy84UHVmQUtnOWt3NzFa?=
 =?utf-8?B?bnZsY1RNcitJSktsdmdrS3VBdnVZalQ5MDExdlhFZmMxY2dwN2VucU01VStn?=
 =?utf-8?B?eldzenMvcVkrdGtVQ1p1WWM5aU1ET3QveHN4Wjh0eGVqejJTYjVWUytYWlNv?=
 =?utf-8?B?Tzk1d2hnVlFLaER0ajZpbXlUUTR0ekZXVjBxRGRJUGwvelc0L3IzcTJQZmQ4?=
 =?utf-8?B?MW15S2RJV0UxMkg4R3FHeWxobktxZW95UDg2bExLVjF2dlA4MWV3Q2dGdUJH?=
 =?utf-8?B?TjB5TGU0dWRqN09acmphS1g4dERsZnh2TDVQWHJBaFR5RzBmTXBEYmdPd2Zn?=
 =?utf-8?B?WTNqbElpYkdCVFBMWVVLR2d3MEhzOFYrNXhxSmlFS0R3T3ZvRVJwVlRLcVRC?=
 =?utf-8?B?ajd6c2dUK2Z0S1BtWDlmNWZKTmVjM1pZS2NXUjIwNUw3Nmt5cGxodXdkL2tP?=
 =?utf-8?B?MHljRWtMMjhQeDZqaHZVeVA4T1crRHQvaW5mOGVkc0dHTzZOU2diajZISDJX?=
 =?utf-8?B?V2swdjNBMW1pMjNiMjFZNE9POGZrdDBQa2hBTTJTcStuOUtwU2toUXBLSUdv?=
 =?utf-8?B?Y1JkcXNmYm1NWGdkb3dWUUEzcWVTU1VIbS9XRTk5MkpUTURoM1lkT04rdUhO?=
 =?utf-8?B?TUk2cVd1cHNmbzJQYkdwYThyNm9LcVlicUwxRTh0Y2UxU0trWDFoVVhqQ2du?=
 =?utf-8?B?eTl5bWI1M3JOeE1LMHdkR21mV1VKaExac1FvNUFnVG1abVFXMUtFOWhkTmFS?=
 =?utf-8?B?THNrMndiMFdiUXhqdlhzRDdORXRYZXhRRjhuZ3dYT0dZQlNyWVIzNkJsa3Z4?=
 =?utf-8?B?a3VzZGNZQUZzQ0FxL2plZnFKcXk5b3ViTWQ2RVg4citQM2taSmgwdU95azZB?=
 =?utf-8?B?dVN1Wk5WVmx2cytKZHdaVk9qY2xSdVVTcWtwSVdmYzhYWXhQNVdMdmJQamEv?=
 =?utf-8?B?ZDVNdmVmeGhqck5ZajRUdE9ETDZ1anVKSU5oOUZwNWtVdUQrbVlEdWg3TklO?=
 =?utf-8?B?alVvd0MyOHhYKzl4WEtnZ3VWYlBOTlo0V29UTVdkY1M5eDd0bDFCNWU4M0kx?=
 =?utf-8?B?TXNSOXVtL0ExbHEwaGNMS2VNdHZPVTdJM1IzTE1DK2t0K3FPSS91WXplSjN3?=
 =?utf-8?B?cDlVb2F1cFJtdGZsblJ3ZWZockRQRFVkU3pnbXpwWHBPUk9teGNDVVBNQXBE?=
 =?utf-8?B?NlBDVWNNL3VNRjRqNzJMNk80bHBsK2l6ZDdtcFRHT0dJYWp1ckFRMFR3cG5D?=
 =?utf-8?B?SXUzSEpRNS94SHZIOGRFckthYjIvU0x1ZzFYa0pnTXUrZ2hiRlM0M05QOWs1?=
 =?utf-8?B?ZnB5QzJHZERkdkVVODhuRE9JbHRTMEZRa1d0VEtXdEN3eURwOTJxQ2dDWnNV?=
 =?utf-8?B?aitPempoT0I2bGlZTGxwUUFxbUZrQ0dnQW5nZXYrZzdteFFzS3BqN3pVQ3dB?=
 =?utf-8?B?T0xyM045d0xOMXRpcTVhalI0U29oRE8yUG5ZSmlqQzJDSHVqS3AyWkNCb0VT?=
 =?utf-8?Q?e6/o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e8e846-3d9e-4a04-e9bf-08dad8d59edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 04:35:23.0829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srgWiqBtXulGw2z/yZFyHzK33BlnjUTnhaQxGkuQ7O151hEl+hnVfhy267Q+MZRr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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
Cc: amd-gfx <amd-gfx-bounces@lists.freedesktop.org>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCldlIGVuY291bnRlcmVkIHNvbWUg
aXNzdWVzIGluIHJlY2VudCBBUFVzIHdoZW4gdHJpZWQgdG8gcGluIGEgbGFyZ2UgZnJhbWVidWZm
ZXIgKGUuZy4gNjRNQiB3LyBkdWFsIDRLIGRpc3BsYXkpLCBzd2l0Y2ggdG8gZGlzcGxheSBTRyBj
b3VsZCByZXNvbHZlIHN1Y2ggaXNzdWUuICBBY3R1YWxseSB3ZSByZWNlaXZlZCB2YXJpb3VzIGtp
bmRzIG9mIFZSQU0gc2hvcnRhZ2UgaXNzdWVzIHJlY2VudGx5LCB0aGVyZSBpcyBtb3JlIGFuZCBt
b3JlIHByZXNzdXJlIG9uIEFQVSA1MTJNQiBWUkFNIGFzIEZXcyByZXNlcnZlIG1vcmUgbWVtb3J5
LCBidWRkeSBzeXN0ZW0gaW4gNS4xOSBjcmVhdGVzIG1vcmUgZnJhZ21lbnQgYW5kIG11bHRpcGxl
IDRrIGRpc3BsYXkgc2NlbmFyaW8gaXMgdXNlZCAgbW9yZSBvZnRlbi4uIFNpbmNlIHRoZXJlIGlz
IG5vIGRpZmZlcmVuY2UgYi93IGFjY2VzcyBWUkFNIGFuZCBTeXN0ZW0gbWVtb3J5IGluIEFQVXMg
ZnJvbSBIVyBwZXJzcGVjdGl2ZSwgSSB0aGluayB3ZSBjYW4gc3dpdGNoIHNvbWUgb2YgZnJhbWVi
dWZmZXJzIHRvIHN5c3RlbSBtZW1vcnkgdG8gbWl0aWdhdGUgVlJBTSBwcmVzc3VyZS4NCg0KWyAg
IDUyLjc5ODcwNV0gW1RUTV0gRmFpbGVkIHRvIGZpbmQgbWVtb3J5IHNwYWNlIGZvciBidWZmZXIg
MHgwMDAwMDAwMDgzM2E0YzU5IGV2aWN0aW9uDQpbICAgNTIuNzk4NzA3XSBbVFRNXSAgTm8gc3Bh
Y2UgZm9yIDAwMDAwMDAwODMzYTRjNTkgKDE2NDcwIHBhZ2VzLCA2NTg4MEssIDY0TSkNClsgICA1
Mi43OTg3ODhdIGFtZGdwdSAwMDAwOmUyOjAwLjA6IGFtZGdwdTogMDAwMDAwMDAzZGJmMzEzZSBw
aW4gZmFpbGVkDQpbICAgNTIuNzk4NzkwXSBbZHJtOmRtX3BsYW5lX2hlbHBlcl9wcmVwYXJlX2Zi
IFthbWRncHVdXSAqRVJST1IqIEZhaWxlZCB0byBwaW4gZnJhbWVidWZmZXIgd2l0aCBlcnJvciAt
MTINCg0KQmVzdCBSZWdhcmRzLA0KWWlmYW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiANClNlbnQ6IFRodXJz
ZGF5LCBEZWNlbWJlciA4LCAyMDIyIDEyOjE5IFBNDQpUbzogWmhhbmcsIFlpZmFuIDxZaWZhbjEu
WmhhbmdAYW1kLmNvbT4NCkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVy
a2VuQGdtYWlsLmNvbT47IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPjsg
YW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz47IFBhbmVlciBT
ZWx2YW0sIEFydW5wcmF2aW4gPEFydW5wcmF2aW4uUGFuZWVyU2VsdmFtQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHRyeSBhbGxvd2VkIGRvbWFp
biB3aGVuIHBpbiBmcmFtZWJ1ZmZlciBmYWlsZWQNCg0KT24gV2VkLCBEZWMgNywgMjAyMiBhdCAx
MToxMCBQTSBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPiB3cm90ZToNCj4NCj4g
W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+DQo+IEhpIEFsZXgsDQo+DQo+IFdl
IG5lZWQgdG8gYWRqdXN0IHRoZSBBTURHUFVfU0dfVEhSRVNIT0xEIGFzIHdlbGwgc2luY2UgcmVj
ZW50IEFQVXMgYXJlIGNvbmZpZ3VyZWQgdy8gNTEyTUIgVlJBTS4gUGxzIGNoZWNrIGF0dGFjaGVk
IHBhdGNoLg0KDQpXaHkgZG8gd2UgbmVlZCB0byBpbmNyZWFzZSB0aGlzIHRocmVzaG9sZD8gIFRo
ZSBjb25kaXRpb24gb25seSBhcHBsaWVzIHRvIENaIGFuZCBTVCwgbm90IG1vcmUgcmVjZW50IEFQ
VXMuDQoNCkFsZXgNCg0KPg0KPiBCZXN0IFJlZ2FyZHMsDQo+IFlpZmFuDQo+DQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21h
aWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgOCwgMjAyMiAxMjoyMSBBTQ0KPiBU
bzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+
IENjOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47IFpoYW5nLCBZaWZh
biANCj4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsgYW1kLWdmeCANCj4gPGFtZC1nZngtYm91bmNl
c0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBQYW5lZXIgU2VsdmFtLCBBcnVucHJhdmluIA0KPiA8
QXJ1bnByYXZpbi5QYW5lZXJTZWx2YW1AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyANCj4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgS29lbmlnLCBDaHJpc3RpYW4gDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHRyeSBhbGxvd2VkIGRvbWFpbiB3aGVuIHBp
biANCj4gZnJhbWVidWZmZXIgZmFpbGVkDQo+DQo+IE9uIFdlZCwgRGVjIDcsIDIwMjIgYXQgMTE6
MTAgQU0gQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+IEFtIDA3LjEyLjIyIHVtIDE3OjA4IHNjaHJpZWIg
QWxleCBEZXVjaGVyOg0KPiA+ID4gT24gV2VkLCBEZWMgNywgMjAyMiBhdCAxMDo1MiBBTSBDaHJp
c3RpYW4gS8O2bmlnIA0KPiA+ID4gPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3
cm90ZToNCj4gPiA+PiBBbSAwNy4xMi4yMiB1bSAxNjozOCBzY2hyaWViIEFsZXggRGV1Y2hlcjoN
Cj4gPiA+Pj4gT24gV2VkLCBEZWMgNywgMjAyMiBhdCAxMDoyMyBBTSBDaHJpc3RpYW4gS8O2bmln
IA0KPiA+ID4+PiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+
ID4+Pj4gSSB3b3VsZCBnbyBhIHN0ZXAgZnVydGhlciBhbmQganVzdCBhbGxvdyBHVFQgZG9tYWlu
IG9uIEFTSUNzICE9IA0KPiA+ID4+Pj4gQ0FSUklaTw0KPiA+ID4+Pj4gfCBTVE9ORVkuDQo+ID4g
Pj4+Pg0KPiA+ID4+Pj4gSSBjYW4ndCBzZWUgYSBnb29kIHJlYXNvbiB3ZSBzaG91bGQgc3RpbGwg
aGF2ZSBhbnkgbGltaXRhdGlvbiANCj4gPiA+Pj4+IGhlcmUsIFZSQU0gZG9lc24ndCBoYXZlIGFu
eSBhZHZhbnRhZ2UgYW55IG1vcmUgYXMgZmFyIGFzIEkga25vdy4NCj4gPiA+Pj4gV2VsbCwgaWYg
VlJBTSBpcyBhdmFpbGFibGUgd2Ugd2FudCB0byBtYWtlIHN1cmUgc29tZW9uZSB1c2VzIGl0IA0K
PiA+ID4+PiBvdGhlcndpc2UgaXQncyBqdXN0IHdhc3RlZC4NCj4gPiA+PiBXZWxsIGl0IHN0aWxs
IGdldHMgdXNlZCB3aGVuIGl0J3MgZnJlZS4gU28gbm93IHByb2JsZW0gYXQgYWxsIGhlcmUuDQo+
ID4gPj4NCj4gPiA+PiBXZSBzaG91bGQganVzdCBub3QgZm9yY2UgYW55dGhpbmcgaW50byBWUkFN
IG9yIEdUVCBhbnkgbW9yZSBpZiANCj4gPiA+PiBpdCdzIHRlY2huaWNhbGx5IG5vdCBuZWNlc3Nh
cnkuDQo+ID4gPiBTbyBqdXN0IHRoaXM/DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+ID4gaW5kZXggOTE5YmJlYTJlM2FjLi44ZThm
MDdmYTdhOTMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfb2JqZWN0LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9vYmplY3QuYw0KPiA+ID4gQEAgLTE1MDYsNyArMTUwNiw3IEBAIHU2NCBhbWRncHVfYm9f
Z3B1X29mZnNldF9ub19jaGVjayhzdHJ1Y3QgYW1kZ3B1X2JvICpibykNCj4gPiA+ICAgdWludDMy
X3QgYW1kZ3B1X2JvX2dldF9wcmVmZXJyZWRfZG9tYWluKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDMyX3QgZG9tYWluKQ0KPiA+ID4gICB7DQo+ID4gPiAtICAgICAgIGlmIChkb21haW4gPT0g
KEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0gfCBBTURHUFVfR0VNX0RPTUFJTl9HVFQpKSB7DQo+ID4N
Cj4gPiBXZSBzdGlsbCBuZWVkIHRvIGtlZXAgdGhpcyBjaGVjayB0byBhdm9pZCB0cnlpbmcgdG8g
YWRqdXN0IFZSQU0gb25seSANCj4gPiBhbGxvY2F0aW9ucyAodGhlIGN1cnNvciBzdGlsbCBuZWVk
cyB0aGlzIElJUkMpLg0KPiA+DQo+ID4gQXBhcnQgZnJvbSB0aGF0IEkgdGhpbmsgdGhhdCBzaG91
bGQgd29yay4NCj4NCj4gQXR0YWNoZWQuICBUaGFua3MsDQo+DQo+IEFsZXgNCj4NCj4gPg0KPiA+
IENocmlzdGlhbi4NCj4gPg0KPiA+ID4gKyAgICAgICBpZiAoKGFkZXYtPmFzaWNfdHlwZSA9PSBD
SElQX0NBUlJJWk8pIHx8IChhZGV2LT5hc2ljX3R5cGUgDQo+ID4gPiArID09DQo+ID4gPiBDSElQ
X1NUT05FWSkpIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgZG9tYWluID0gQU1ER1BVX0dFTV9E
T01BSU5fVlJBTTsNCj4gPiA+ICAgICAgICAgICAgICAgICAgaWYgKGFkZXYtPmdtYy5yZWFsX3Zy
YW1fc2l6ZSA8PSBBTURHUFVfU0dfVEhSRVNIT0xEKQ0KPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgIGRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsNCj4gPiA+DQo+ID4gPg0KPiA+
ID4NCj4gPiA+PiBDaHJpc3RpYW4uDQo+ID4gPj4NCj4gPiA+Pj4gQWxleA0KPiA+ID4+Pg0KPiA+
ID4+Pg0KPiA+ID4+Pj4gQ2hyaXN0aWFuLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IEFtIDA3LjEyLjIy
IHVtIDE2OjEwIHNjaHJpZWIgQWxleCBEZXVjaGVyOg0KPiA+ID4+Pj4+IERvZXMgdGhpcyBwYXRj
aCBmaXggdGhlIHByb2JsZW0/DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBBbGV4DQo+ID4gPj4+Pj4N
Cj4gPiA+Pj4+PiBPbiBXZWQsIERlYyA3LCAyMDIyIGF0IDI6MjcgQU0gWmhhbmcsIEplc3NlKEpp
ZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+ID4+Pj4+PiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4g
ICAgICAgIGRybS9hbWRncHU6IHRyeSBhbGxvd2VkIGRvbWFpbiB3aGVuIHBpbiBmcmFtZWJ1ZmZl
ciBmYWlsZWQuDQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+
ICAgICAgICBbV0hZJkhPV10NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4NCj4g
PiA+Pj4+Pj4gICAgICAgIGluIHNvbWUgc2NlbmFyaW9zLCB0aGUgYWxsb2NhdGUgbWVtb3J5IG9m
dGVuIGZhaWxlZC4gc3VjaCBhcyBkbyBob3QgcGx1ZyBvciBwbGF5IGdhbWVzLg0KPiA+ID4+Pj4+
Pg0KPiA+ID4+Pj4+PiAgICAgICAgc28gd2UgY2FuIHRyeSBhbGxvd2VkIGRvbWFpbiwgaWYgdGhl
IHByZWZlcnJlZCBkb21haW4gY2Fubm90IGFsbG9jYXRlIG1lbW9yeS4NCj4gPiA+Pj4+Pj4NCj4g
PiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4gICAgICAgIFNpZ25lZC1vZmYtYnk6IGpp
ZTF6aGFuIGplc3NlLnpoYW5nQGFtZC5jb20NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4gICAgICAg
IENoYW5nZS1JZDogSTRiNjJlMmZmMDcyZDAyYzUxNWY5MDEwMDBhNTc4OTMzOWQ0ODEyNzMNCj4g
PiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+ID4+Pj4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+ID4+Pj4+Pg0K
PiA+ID4+Pj4+PiBpbmRleCAxYWUwYzg3MjMzNDguLjA1ZmNhZjdmOWQ5MiAxMDA2NDQNCj4gPiA+
Pj4+Pj4NCj4gPiA+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jDQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYw0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiBAQCAtMzks
NiArMzksNyBAQA0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiAjaW5jbHVkZSAiYW1kZ3B1LmgiDQo+
ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+ICNpbmNsdWRlICJhbWRncHVfdHJhY2UuaCINCj4gPiA+Pj4+
Pj4NCj4gPiA+Pj4+Pj4gI2luY2x1ZGUgImFtZGdwdV9hbWRrZmQuaCINCj4gPiA+Pj4+Pj4NCj4g
PiA+Pj4+Pj4gKyNpbmNsdWRlICJhbWRncHVfZGlzcGxheS5oIg0KPiA+ID4+Pj4+Pg0KPiA+ID4+
Pj4+Pg0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiAvKioNCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4g
ICAgICAqIERPQzogYW1kZ3B1X29iamVjdA0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiBAQCAtOTQy
LDggKzk0MywxNCBAQCBpbnQgYW1kZ3B1X2JvX3Bpbl9yZXN0cmljdGVkKHN0cnVjdCANCj4gPiA+
Pj4+Pj4gYW1kZ3B1X2JvICpibywgdTMyIGRvbWFpbiwNCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYm8tPnBsYWNlbWVudHNbaV0ubHBmbiA9IGxwZm47
DQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+ICAgICAgICAgICAgfQ0KPiA+ID4+Pj4+Pg0KPiA+ID4+
Pj4+Pg0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiArICAgICAgIHJldHJ5Og0KPiA+ID4+Pj4+Pg0K
PiA+ID4+Pj4+PiAgICAgICAgICAgIHIgPSB0dG1fYm9fdmFsaWRhdGUoJmJvLT50Ym8sICZiby0+
cGxhY2VtZW50LCANCj4gPiA+Pj4+Pj4gJmN0eCk7DQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+ICAg
ICAgICAgICAgaWYgKHVubGlrZWx5KHIpKSB7DQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+ICsgICAg
ICAgICAgICAgICAvL3RyeSBhbGxvd2VkIGRvbWFpbiB3aGVuIHBpbiBmYWlsZWQuIGp1c3QgYSB3
b3JrYXJvdW5kLg0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiArICAgICAgICAgICAgICAgaWYgKHVu
bGlrZWx5KHIgPT0gLUVOT01FTSkgJiYgZG9tYWluICE9DQo+ID4gPj4+Pj4+ICsgYm8tPmFsbG93
ZWRfZG9tYWlucykgew0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiArICAgICAgICAgICAgICAgICAg
ICAgICBhbWRncHVfYm9fcGxhY2VtZW50X2Zyb21fZG9tYWluKGJvLA0KPiA+ID4+Pj4+PiArIGJv
LT5hbGxvd2VkX2RvbWFpbnMpOw0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICBnb3RvIHJldHJ5Ow0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiArICAgICAgICAg
ICAgICAgfQ0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiAgICAgICAgICAgICAgICAgICAgZGV2X2Vy
cihhZGV2LT5kZXYsICIlcCBwaW4gZmFpbGVkXG4iLCBibyk7DQo+ID4gPj4+Pj4+DQo+ID4gPj4+
Pj4+ICAgICAgICAgICAgICAgICAgICBnb3RvIGVycm9yOw0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+
PiAgICAgICAgICAgIH0NCj4gPg0K
