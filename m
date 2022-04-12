Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1D9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 07:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8BE10EA21;
	Tue, 12 Apr 2022 07:53:27 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4064A10E53B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 07:53:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddfKfI+Nis//KlDAHMaS1pbEjo7LAkHV0UixM+OwhNQtUp7epMZ6X/789Z/6iiDg0NaU1x8/y0G/08z4yPBfSh/OR7ePfmZNsj2CFy0eL4zrEMAKW0SzpnK7tp9Fe7+H3RQmsSXHly2pqt810tnkLoD3VBCdwtd7HmfPb6WgxwAY7OAndSo2CLTpgkR1LJ4tJA5O8alnajEzn2H0UEaqsXvns8wnubRty9+D2c0SD9hrozOsIAbQIh4Y2OUo/mV7K/QYa9BDZ0mBCXWDGGsQs19iaW/fwOYMNYyUXTI7Fb6NI+9xOzFdD34ChPHn6b0Vg600/fPtPdeB3Of3ZV7rCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgTrSIKuUVAS/YAIG/nib37wBjTEWXAVn9soKOJDtdA=;
 b=Ipl8FVHOMgvLa4tla2UARLULXkJ/o/Xx+ZhbQgWFs6Sl5fvAofHOMfHJFWgKBEgyqToSh3zNliuDSza/2z+bAGFa+dzSZPxK0lqzv3g6L1P6iO4o1wdnFSPZZXUhyqmT+vX20xyeC4u/cBixgqVzLaA1fV/FWIGMFsVkUiybThsCNPjOKc4nOg/c10G5DH3+q52MkSkiZCXNy8CrBHFtKOrsI+gXJMpRKF9D/YEqIFUJ4udbm0s4A8JR8mtuf4b/UfwORxixAFKDDEBL4zU+t0F59ec5pGchuXx2YLVl76niRO5jhQywdvTOelUBdZPBAWlfUzRk3+470WkqyrJ21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgTrSIKuUVAS/YAIG/nib37wBjTEWXAVn9soKOJDtdA=;
 b=Ag/ouMOUGzMDkh/x6Qwo/ZSVhzukiR1dtayOwrzRSbW8oConYocnVhXdm/zWEZJ6/tRwTD5K4dh/pUQLGMlzlsQV8wg/rpRqQPmJqrS5ZaFwOgDHtbNvqZdwa/UAWol9+tREpo3H1CFdU4/F3OzJTjy+5htgiSijcFs6HNOUdkA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BN8PR12MB3377.namprd12.prod.outlook.com (2603:10b6:408:46::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:53:23 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::610b:3e61:665b:cdc4]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::610b:3e61:665b:cdc4%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 07:53:23 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH ] drm/amdgpu: fix discovery ip failed
Thread-Topic: [PATCH ] drm/amdgpu: fix discovery ip failed
Thread-Index: AQHYTbe1etcmhYF/6kOujyyr27oLtKzrgykAgAAU9ACAAFDoMA==
Date: Tue, 12 Apr 2022 07:53:22 +0000
Message-ID: <DM4PR12MB5152F13663D875E81327B397E3ED9@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <DM4PR12MB51525F878057240AE5C91F14E3EA9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <bbd6939b-227c-f197-5d10-ba9194fd2b76@molgen.mpg.de>
 <DM4PR12MB51529669CBDA773CD36D420FE3ED9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <ef75f61e-e763-c257-2b2f-c32c2e6c0086@amd.com>
In-Reply-To: <ef75f61e-e763-c257-2b2f-c32c2e6c0086@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-12T07:53:19Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f56e4b89-4d7a-48eb-82c1-70578ec8bf68;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-12T07:53:19Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d20799be-b020-465b-bf0e-9374bd014597
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a66f46d-01ce-4f76-557e-08da1c5984b4
x-ms-traffictypediagnostic: BN8PR12MB3377:EE_
x-microsoft-antispam-prvs: <BN8PR12MB33774FF0B172E4187D4CBACAE3ED9@BN8PR12MB3377.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u9751RU5yHy6OYhmvswkwEgtUO3RxUQfUVd8+C7u7qeSf36L2ZXmubFuNS6g3BHO0YEHM3OQdXSC3jRZs3wwKUt87pLHVjWabXswUs0rtZnlVjut1OC05uk2HkusSz2Lmvb5LCqxebQVnN8zgpgis0MUHlQUb4wya1OMPSEQ6TIwYBQhJss2T5rgpcRSO9xLVkL07Qs1J+UTWd/uQKzD4Pqv0j/eToS8kyVWXdD1QNX5yUmmLP5G1KH349ZPKaS1B8BtnfOW0ceWiga/PXceZ0sz9EEltq2xwnNHNdQs9OScmK3ZX9EBp0GEcBKMon7Jqm+W7veQQ+XZONTekFlfpoEakYCItWs0oR3jim+Lfk1RITGXuDmTMgA7sbqXwtjLvdX5GOC8eEkrldjkPMPGXGbbD72G6kj7tg4RGFaTYt4eZVlhTjUyXfOXdSXQURgrE7eBqEfwFfoEKCMOFTrPz3RqA2v7hg3k2bfku1kdnvOfaNWhfMRIXDeaOgDM9+fZSyysf1eDQR2ixNoPGYC2KIhhGXl6+dlrFSIv8lgUKoejkPgoRujiliY5QPSLc0DdEjo5OTTZlQm0cbLfXZvJCXBG5MGn6v4KUpx/ONCc67qvokuI7GMSJCyWw4Ui3AAbfMD7wujej3XxAbehVg1Sy0vZ3UlwnUSBvbiIWrPNl8rSpZR2wf4I1qBsk5RSjXwMPl/T4CLYRGz+MAcac9yabw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(38100700002)(9686003)(52536014)(66446008)(64756008)(66946007)(4326008)(8676002)(66556008)(66476007)(83380400001)(508600001)(122000001)(8936002)(7696005)(53546011)(6506007)(5660300002)(76116006)(86362001)(54906003)(55016003)(110136005)(316002)(26005)(186003)(2906002)(33656002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU5DcStVSXpkQjlZcVhMZHRVOGU3N0RCR2dzakpJcHFDTHpERVl5RWF1dk9k?=
 =?utf-8?B?SGp2ZHpPMnU0cUFIUlFac2tBdWFKRmVZSTJydHEycTAxYXlqSjRpYWpTRy9r?=
 =?utf-8?B?ZXZma3NMZ2NVWHkyc29VUmZ4SEJ2UWFIaFYvMmtqa0h0enpsNXpDSDRvbWFk?=
 =?utf-8?B?SllpdktBNG45NGNjWHJlZWxON09QSk1TTExMMXB6Yk9aT2M3VDdBdzZITXFG?=
 =?utf-8?B?VkxXSElhclhJUXVvMEFxVzAvWFgwZWFoVUdhTHM2T3RVOE1vZnFmeGVqNGJh?=
 =?utf-8?B?bnJUYkUvN25uWUM0Z28yQy85KzZWR2hScXFrbjMrWkJTQys3UDdUUFpPcnFz?=
 =?utf-8?B?a3BRRkdNdXppNkdyeW0xM2M5b3ZoYk9XUnNya1JJZ05SQjRoOWNCU0NoME1G?=
 =?utf-8?B?YUdwWWFaTVF2RnczYVdGWHJxaWZaZ1pTMzJTQWhSRmVBU0pLTUZGTWtMOWo3?=
 =?utf-8?B?akFCRnBzZ0RORWFOYzNzdXpuNGFZL1J6ZGdtQmIrbHllODdrL0czdUUyRjZ3?=
 =?utf-8?B?aUV3b2wvRHNEaEJHMnlISTNDckVVdnBPQ1VrdnhIQUJKbndxaDkyaU9UV3E3?=
 =?utf-8?B?MGFtOHhHaGlTempMeGg3Yi9MSzFCRlVKMjNMZjlIOTRVWVZtOVVXSU1KVzJi?=
 =?utf-8?B?NmI0WTJWMDZmQTJabXBBRFhvRWxud2R1blJoYkNZTWFwWmRlNGk2WUEvQWlZ?=
 =?utf-8?B?dGpXeTVHN1RjUnMyc2dCWFhmWTY5V0l2RjZIRlI4R2lFMWwrWktvU01YdmRs?=
 =?utf-8?B?YS9GUXlGTHVaZ2dkcjZOczgzbVhQQks4K1ZpZkh1cFdwdnJNS2NQaWlicmY5?=
 =?utf-8?B?Uk9qenRiSlV6RDZXa3BPOG1GbEMwYktpV0Nxckc5TlZKMFU2MVlKVWlUeTl3?=
 =?utf-8?B?V1FFdXdEWEJzN05Ddndqb3RjVUFpVWxOOER0YkF4ellqWmZsUWFHMml2ZGh6?=
 =?utf-8?B?TWxvT3d1THlYQXF6UHB3SWI0VDI4TFd5WEZ1dFRLSTFJVmRxckhJUy91VWpJ?=
 =?utf-8?B?Z3hab20zNFphK3NGcGR1Z01rQ29NTWlJL3FMQ1F6T3phTG5PS1FrMnNGd3Zv?=
 =?utf-8?B?aU5wL25qclVQK3k1dXk5eTlzeS9Gd3Ivd1VndUdZdXNaRXpiemtab0plOE1F?=
 =?utf-8?B?c1RCQkRROFRwSG05RVFVeHZjaWtYSzhIUlhjekFHeERNRWFuSkQ4Z09DdGtj?=
 =?utf-8?B?WFBoVVcwMEtpaC9vdDlINDFJendoZ1dRamNtQ2h1TjhqMXhrY2NGc0V6Vmlj?=
 =?utf-8?B?NEc5VjhLRUhRZms3QWdaelRneTdWZVVwQjZ3OTdNWHM1SWVoNDNma2JVVWYw?=
 =?utf-8?B?MnZpMVhnSzJxd3F4d2djQmY2QjJFbERFb01zVENteWFwUVNKYUNjZTM0bTNU?=
 =?utf-8?B?TVJmZkFaL3RHNUF6cGNqS2V6OUt2TGNVRXpwUFNyNG5QMkJQZjFMWjZyWHN0?=
 =?utf-8?B?N0locWh1OGZWTldGUVVjUkUrRWIxQlVMVStEaXJGeVdTTzlDNUF2aEJsUm1h?=
 =?utf-8?B?cE5ISzlxZzVqY0RlVlAxanM2cVFyL3pHWE92TmRLeDVma3hibnpJRHM1VlVh?=
 =?utf-8?B?NUR1UFFaSnNGZ0dRV2dvOWxNUDhWY1o2NDVvaHFEWVRJOFNndlRRSnRWOEVh?=
 =?utf-8?B?SVBJa0JLMjhxWFJncFdyTHFBeFZOSDF5Y2U5L2lUejFTQmZadk9TT2kzY2Nr?=
 =?utf-8?B?Q2o1bjh3T1FTU05GTjdhMlBLM2hRQTFqUFRHbC9MRU90Y1pBQWUyVzVZd0JE?=
 =?utf-8?B?Mzh4a2lpN29nQmNOMTdpcHowNXpVWGVxdHp5Vkl0UFIzWGVNMC96VmorOXFG?=
 =?utf-8?B?aml0cnFNNm0yK2U4S1FhbWppem1SQUpIWnZqM0w5a2FHNG1NNkprVHhjd1Vm?=
 =?utf-8?B?VjQ4OGkvbGk0c1dZZ0ZQdlhVOS9SL212cnpqR011SE1LVERITk9YRms4THRz?=
 =?utf-8?B?Nng4cG9idzhiRWZWV09KZXVzWVVUUllWK2Y1dThMejIrWGFOSGxJRUtKM2Q4?=
 =?utf-8?B?Z3RZODdaeWNGVVpHdTJhYThldFFYU0czSmE4OUpoaHdoS2NGeHdxU0xrRXhF?=
 =?utf-8?B?N2xid2pOenVjRUpIQW1GYjllZzdLRDNrendDUEp4eS9qMk1sVHdUUndKdDNZ?=
 =?utf-8?B?RWd3cFZqRXE4TlRQMVdnS29BSTZBbzh5SEFscXFzNTBta3R5TFN1RFl3TjRq?=
 =?utf-8?B?M2JGTGx2M0xRZTMxQlpJL0k0RjY4WUtmaW5UME14RVRLT0tVUGlkS2laRmYy?=
 =?utf-8?B?RnllMkVWaTlUUU00TG5BNm84ZEc3SlJadlNINHB3MzhsUFZ3V2pwMkN0UjFE?=
 =?utf-8?B?akVuYmZMdzVVSFRqbWNzRUJjVytmY0tLd3EzTDlVODJVNzVneEZtQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a66f46d-01ce-4f76-557e-08da1c5984b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 07:53:22.9174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnjytmEZo1gDoMT+4WYSrnEietaEKSsA2PcYYo4TD1iRFNJgmfO72QOonYkgKo9ZHcUZt1ZRy5Kjn+7lzxEzpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3377
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhhbmtzIExpam8uDQpHb3QgaXQuDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQu
Y29tPiANClNlbnQ6IFR1ZXNkYXksIDEyIEFwcmlsIDIwMjIgMTE6MDMgYW0NClRvOiBaaGFuZywg
SmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47IFBhdWwgTWVuemVsIDxwbWVuemVsQG1v
bGdlbi5tcGcuZGU+DQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT47IEh1YW5nLCBSYXkg
PFJheS5IdWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggXSBkcm0vYW1kZ3B1OiBmaXggZGlzY292ZXJ5IGlwIGZhaWxlZA0KDQoN
ClRoYW5rcyBKZXNzZS4NCg0KUGxlYXNlIGFsc28gYWRkIGJlbG93IGJlZm9yZSB5b3UgY29tbWl0
Lg0KDQoJRml4ZXM6IDFlZjYwMTkxYjI1OSAoImRybS9hbWRncHU6IFVzZSBmbGV4aWJsZSBhcnJh
eSBtZW1iZXIiKQ0KDQpSZXZpZXdlZC1ieTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29t
Pg0KDQoNClRoYW5rcywNCkxpam8NCg0KT24gNC8xMi8yMDIyIDc6MjIgQU0sIFpoYW5nLCBKZXNz
ZShKaWUpIHdyb3RlOg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPiANCj4gVGhhbmtzICBQ
YXVsIE1lbnplbA0KPiBBdHRhY2ggIHRoZSBwYXRjaCBmaWxlIC4NCj4gDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcu
ZGU+DQo+IFNlbnQ6IE1vbmRheSwgMTEgQXByaWwgMjAyMiAxMToyMSBwbQ0KPiBUbzogWmhhbmcs
IEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT47IEh1YW5n
LCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIF0gZHJtL2Ft
ZGdwdTogZml4IGRpc2NvdmVyeSBpcCBmYWlsZWQNCj4gDQo+IFtDQVVUSU9OOiBFeHRlcm5hbCBF
bWFpbF0NCj4gDQo+IERlYXIgSmllLA0KPiANCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRj
aC4NCj4gDQo+IA0KPiBBbSAxMS4wNC4yMiB1bSAxNzoxNSBzY2hyaWViIFpoYW5nLCBKZXNzZShK
aWUpOg0KPiANCj4gWW91IG1pZ2h0IHdhbnQgdG8gYWRkIGEgc3BhY2UgYmVmb3JlIHRoZSAoLg0K
PiANCj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+IA0KPiBQbGVhc2Ugc2VuZCBhIHBhdGNo
IHdpdGggYGdpdCBmb3JtYXQtcGF0Y2hgIG9yIHNpbWlsYXIuDQo+IA0KPj4gRml4IGRpc2NvdmVy
eSBpcCBmYWlsZWQsIGFuZCB0aGUgbG9nOg0KPiANCj4gT24gd2hhdCBzeXN0ZW0/DQo+IA0KPj4g
ICAgICA1Ni4xMjk1NDldIFtkcm06YW1kZ3B1X2Rpc2NvdmVyeV92YWxpZGF0ZV9pcCBbYW1kZ3B1
XV0gKkVSUk9SKiBVbmV4cGVjdGVkIG51bWJlcl9pbnN0YW5jZSAoNjQpIGZyb20gaXAgZGlzY292
ZXJ5IGJsb2INCj4+IFsgICA1Ni4xMzAxMjldIFtkcm06YW1kZ3B1X2Rpc2NvdmVyeV92YWxpZGF0
ZV9pcCBbYW1kZ3B1XV0gKkVSUk9SKiBVbmV4cGVjdGVkIGh3X2lkICg0NTA1NikgZnJvbSBpcCBk
aXNjb3ZlcnkgYmxvYg0KPj4gWyAgIDU2LjEzMDcwMV0gW2RybTphbWRncHVfZGlzY292ZXJ5X3Zh
bGlkYXRlX2lwIFthbWRncHVdXSAqRVJST1IqIFVuZXhwZWN0ZWQgbnVtYmVyX2luc3RhbmNlICg2
NikgZnJvbSBpcCBkaXNjb3ZlcnkgYmxvYg0KPj4gWyAgIDU2LjEzMTI4M10gW2RybTphbWRncHVf
ZGlzY292ZXJ5X3ZhbGlkYXRlX2lwIFthbWRncHVdXSAqRVJST1IqIFVuZXhwZWN0ZWQgaHdfaWQg
KDQ1NTY4KSBmcm9tIGlwIGRpc2NvdmVyeSBibG9iDQo+PiBbICAgNTYuMTMxODU1XSBbZHJtOmFt
ZGdwdV9kaXNjb3ZlcnlfdmFsaWRhdGVfaXAgW2FtZGdwdV1dICpFUlJPUiogVW5leHBlY3RlZCBu
dW1iZXJfaW5zdGFuY2UgKDY2KSBmcm9tIGlwIGRpc2NvdmVyeSBibG9iDQo+PiBbICAgNTYuMTMy
NDM2XSBbZHJtOmFtZGdwdV9kaXNjb3ZlcnlfdmFsaWRhdGVfaXAgW2FtZGdwdV1dICpFUlJPUiog
VW5leHBlY3RlZCBod19pZCAoNDgwKSBmcm9tIGlwIGRpc2NvdmVyeSBibG9iDQo+PiBbICAgNTYu
MTMzMDUzXSBbZHJtOmFtZGdwdV9kaXNjb3ZlcnlfdmFsaWRhdGVfaXAgW2FtZGdwdV1dICpFUlJP
UiogVW5leHBlY3RlZCBod19pZCAoNjA4KSBmcm9tIGlwIGRpc2NvdmVyeSBibG9iDQo+PiBbICAg
NTYuMTMzNjI2XSBbZHJtOmFtZGdwdV9kaXNjb3ZlcnlfdmFsaWRhdGVfaXAgW2FtZGdwdV1dICpF
UlJPUiogVW5leHBlY3RlZCBod19pZCAoNjQwKSBmcm9tIGlwIGRpc2NvdmVyeSBibG9iDQo+PiBb
ICAgNTYuMTM0MjA3XSBbZHJtOmFtZGdwdV9kaXNjb3ZlcnlfdmFsaWRhdGVfaXAgW2FtZGdwdV1d
ICpFUlJPUiogVW5leHBlY3RlZCBudW1iZXJfaW5zdGFuY2UgKDY0KSBmcm9tIGlwIGRpc2NvdmVy
eSBibG9iDQo+PiBbICAgNTYuMTM0NzgwXSBbZHJtOmFtZGdwdV9kaXNjb3ZlcnlfdmFsaWRhdGVf
aXAgW2FtZGdwdV1dICpFUlJPUiogVW5leHBlY3RlZCBudW1iZXJfaW5zdGFuY2UgKDY0KSBmcm9t
IGlwIGRpc2NvdmVyeSBibG9iDQo+PiBbICAgNTYuMTM1MzYwXSBbZHJtOmFtZGdwdV9kaXNjb3Zl
cnlfdmFsaWRhdGVfaXAgW2FtZGdwdV1dICpFUlJPUiogVW5leHBlY3RlZCBod19pZCAoMjg2NzIp
IGZyb20gaXAgZGlzY292ZXJ5IGJsb2INCj4gDQo+IFBsZWFzZSBkZXNjcmliZSB0aGUgcmVhc29u
IGZvciB0aGUgZmFpbHVyZSwgYW5kIHlvdXIgZml4Lg0KPiANCj4gQSBTaWduZWQtb2ZmLWJ5IGxp
bmUgaXMgbWlzc2luZy4NCj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rpc2NvdmVyeS5jDQo+PiBpbmRleCA3NjYwMDZhMDc1ZWMuLmE3NzhiMDM5MmU5ZiAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3Zlcnku
Yw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5j
DQo+PiBAQCAtNzk4LDcgKzc5OCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9zeXNm
c19pcHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJlcyA9IGtvYmplY3RfYWRkKCZpcF9od19pbnN0YW5jZS0+a29iaiwgTlVMTCwNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIiVkIiwgaXBfaHdf
aW5zdGFuY2UtPm51bV9pbnN0YW5jZSk7DQo+PiBuZXh0X2lwOg0KPj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgaXBfb2Zmc2V0ICs9IHNpemVvZigqaXApICsgNCAqIChpcC0+bnVtX2Jhc2VfYWRk
cmVzcyAtIDEpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgaXBfb2Zmc2V0ICs9IHN0cnVj
dF9zaXplKGlwLCBiYXNlX2FkZHJlc3MsIGlwLT5udW1fYmFzZV9hZGRyZXNzKTsNCj4+ICAgICAg
ICAgICAgICAgICAgIH0NCj4+ICAgICAgICAgICB9DQo+Pg0KPj4gQEAgLTEwNjMsNyArMTA2Myw3
IEBAIGludCBhbWRncHVfZGlzY292ZXJ5X3JlZ19iYXNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4+DQo+PiBuZXh0X2lw
Og0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgaXBfb2Zmc2V0ICs9IHNpemVvZigqaXApICsg
NCAqIChpcC0+bnVtX2Jhc2VfYWRkcmVzcyAtIDEpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgaXBfb2Zmc2V0ICs9IHN0cnVjdF9zaXplKGlwLCBiYXNlX2FkZHJlc3MsIGlwLT5udW1fYmFz
ZV9hZGRyZXNzKTsNCj4+ICAgICAgICAgICAgICAgICAgIH0NCj4+ICAgICAgICAgICB9DQo+Pg0K
Pj4gQEAgLTExMTMsNyArMTExMyw3IEBAIGludCBhbWRncHVfZGlzY292ZXJ5X2dldF9pcF92ZXJz
aW9uKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgaHdfaWQsIGludCBuDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqcmV2aXNpb24gPSBpcC0+cmV2
aXNpb247DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4+IC0gICAgICAgICAgICAgICAgICAgICAg
IGlwX29mZnNldCArPSBzaXplb2YoKmlwKSArIDQgKiAoaXAtPm51bV9iYXNlX2FkZHJlc3MgLSAx
KTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGlwX29mZnNldCArPSBzdHJ1Y3Rfc2l6ZShp
cCwgYmFzZV9hZGRyZXNzLCBpcC0+bnVtX2Jhc2VfYWRkcmVzcyk7DQo+PiAgICAgICAgICAgICAg
ICAgICB9DQo+PiAgICAgICAgICAgfQ0KPj4NCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBh
dWwNCj4gDQo=
