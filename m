Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78099C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 14:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2146F10E2F9;
	Tue,  1 Mar 2022 14:18:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492D710E2F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 14:18:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llZWUvcRIudqpgqVCmr58mlRZztw2I5Oqan14oGcDOfGR0nPUeASPtn7duBJENoMvO+e6QzqcqSgtA+Krv/+C0j2Soeo2r/JUAeajOSiskCRpzIO94y+UMhGJQFL809qHi+iaB4S0sRVki/mjQWaBGSfAb4ZLUjnz4SHve3N+MKydAC5/S6Smwjblr5qRkH/nEAd0gGVwUt0mX+3wBn5+OT3je0ePx3US2getTDrRn5PKGObsdzwT0XOvj7ukdw/KpIMP2qqiRp02kfQ+FnDFpxAViAl07MwK86ZVydo0ZfAJ0zxZr/iE5l4WswaTbiAEbGWj2AZ+ARRiMZVCS1Uyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etSetl4IAACv8BfITJhXzW6TuWAgqjH1G2enuREkKvY=;
 b=Pes04du3KWFRsdeGdA9zAFwZcrIDWo16nOXN1ITPy+bWkS0dGT+u744kPzI6N7ngMooYhH/Z/xifW3BvM47NJGzRCYS11HI2KIQS23ARoASo9Ot3F60tuOveLrW9dwrAlp4nCkJ3oDKdD7Haij5CeVRHfa/aaIxxOcw6EOtr35kxzBxwtjbBiMC8yiQ9V2LxO1+rw8/f5QkxDxHE5JoNIyZwO4hbhRLXnvFJoalfEaSvN354M3uxZeb99dd44//luYf7oUZIRG3A5Dx5QiACaLXYACwHxK4SynLyftntShdqBauE2a6aXPF3z9GwD2agHCqf3lnhpdxkaftLbKu/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etSetl4IAACv8BfITJhXzW6TuWAgqjH1G2enuREkKvY=;
 b=aqkvqSr68W05muH62g2YL8CKP11RbucnENroOamdrGd1nIxRGYH6lLbRYoiPq1uIkE1Agc/i3IOmZoCJDIYZpLlPvJXWwJoOqMAd/lb2zlUMAeoL8nsmXyw4EXsJBwiYPpwT2dtikHgJsHcDeJv1jBWAuPnABLI4BDOCyPnW8WE=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 1 Mar
 2022 14:18:51 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::245e:645a:38d6:ead8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::245e:645a:38d6:ead8%6]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 14:18:51 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?s7e72DogW1BBVENIXSBkcm0vYW1kZ3B1OiBNb3ZlIGNvbW1vbiBpbml0aWFs?=
 =?gb2312?B?aXphdGlvbiBvcGVyYXRpb25zIG9mIGVhY2ggcmFzIGJsb2NrIHRvIG9uZSBm?=
 =?gb2312?Q?unction?=
Thread-Topic: [PATCH] drm/amdgpu: Move common initialization operations of
 each ras block to one function
Thread-Index: AQHYLXdG9GI9zjDpYkqE9/TWRudCRQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Tue, 1 Mar 2022 14:18:51 +0000
Message-ID: <BL1PR12MB5334F00920D9D4C060DE06539A029@BL1PR12MB5334.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dac8d94-bbda-4732-f70f-08d9fb8e68c6
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_
x-microsoft-antispam-prvs: <BN9PR12MB50688EE2EB19A18B431974B19A029@BN9PR12MB5068.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJIwTJnioTVQ+XMrE4ICwzWLic6M1L9MPY0QgBRvrSPegZM0A3uIuDfSvkm+LbAsMJWyHKF1NDbIM0aBoClFhx9SasuvYqmS06JYEjF0tOfmXEp5yUwHZ/M0tO9P/AQ+GEHvr1jqkhM9NWpTXsUuFxJDGasnPamvDm13kVP2qYAru0Bqt5zDa2PDEcDs1FcIATdjAeRFm2s72F+whyYPEkBMSVSGz5M7lsHFX5pF5xrRniprJI0VDJ6jO0bitPh7bUJdyBnTHQlBkx9P1XN9hzDdiv0o78DWE8piEAaqDm5t3yu169KFy5qyRyugyXRSf2giJsvMq7QP7LsiislGewc0e57DtWAkJPsYTC0kAcWPNt9oS2Cl14yayI8JQrcnRnj9QIV6hbKPGfuIfzvr6vrkxHgse8Lq1VvNKzx2kRBWrTYYrJSeCVuA8xG32Ojt1vv0O//yU5Y5Ih7CNv/NYq86071t9JSkpn/MMJF3k0ZzvqsUug5adLZMB2pnNhv4OQ0uL41u+5LHqxJrgI4JFRWYXWkoXSPHztZ6mgGuRa9kMmmvyXXG60FZbIooJW2CI8C4pad1BZdMJOHf/1gZpP1KgUmUdyvrIQJi8MNIBPxOb24WoHJbHLHCJdZrt1yr1pAl5M+t+VHIvUgM6V9BBYnqiU4fd149ugdaqRqEJR73XvPjMa4/a356qjfHEKMEuOQFofodmBWisttl8NYEIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(122000001)(26005)(508600001)(83380400001)(558084003)(86362001)(110136005)(55016003)(54906003)(316002)(38070700005)(7696005)(9686003)(8936002)(6506007)(33656002)(71200400001)(224303003)(66556008)(66476007)(66446008)(64756008)(52536014)(4326008)(76116006)(38100700002)(2906002)(5660300002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UXlQNlNNTjFpYVBIOGJ4UTFFSWVZZzA0K3E5VEFLZ2R2aGRnUkZkczFvcHhY?=
 =?gb2312?B?WXVLMlUzSWlKT0ViM3ZkN1crMGpEME5uMU8zdjFOYWlTd0xHTmg4cmRiVVpi?=
 =?gb2312?B?ZXI2TkNWbmduSXpYR1h6SDVvSHdEQndRSDJId25XT3B0dStuWUhkeXZnWVY3?=
 =?gb2312?B?ZGhEcm9ES3NHTHdzaW9KdlorME01ajBnNkZkN2NoSWtKcHlYU1JiZThsREkz?=
 =?gb2312?B?Zno2b1BSN090OWJDd3I1TGV3eDdOMkNmWW5sRm5uWTJWd1BtUTduTzBmOTdm?=
 =?gb2312?B?QVRRY0R4eWQzb1pQTnlTWmhEeVB6SFN1d0F5TFRDbi9DOGI0by96eHczZVF0?=
 =?gb2312?B?VmJqbHZrd1hBeTRNL0J3cDhVWWtXVm1wVGZOUEhRajhTQjVXeWtqdlU1NWtM?=
 =?gb2312?B?Q2VmbDBrbUZYMk5lemU5emJRVDhJOEMrazlvZS9EQ1hPcUNiQjhuNml1MEE3?=
 =?gb2312?B?bktJaEJwQ2dwK0Z1TnNMdVg0ckE2NVdQMUtUT2szWXRwa21TWnRIWHBTcHJD?=
 =?gb2312?B?ZnZFMktTdW9VLzJQdlgzbFQyaUluL3B0NGl2SHFiQUdjS3BWWDVNdDliVThD?=
 =?gb2312?B?TFBreFVMb1MxN2ZZSWtQMEE2TlMvOWRrV3dhcldTazB6eXBxVzNnZG1rVkJp?=
 =?gb2312?B?Z2FQZ3BoSEtSUWx3M1NoNHJoSGd5L09oWkliS3pkUHdVdzIyNUtVNjl3TVRu?=
 =?gb2312?B?cFBsWi9XVlA4NFFLZWdTc3o1bTNYai9HYmY1MldST2pzMGNtT1dDeHplVlhR?=
 =?gb2312?B?WWhvcm0wd2tBWUFhSklVdlV5b1ZhVXRMWW44cVlSWjN0WnErR3YxbENjdGpS?=
 =?gb2312?B?WGt6S3pvVGh6aWdyV3RkS3UwcDNWOHovOVA0Yjc5bUNmN3E4d200LytrRVE4?=
 =?gb2312?B?NVJvRTRNSXVzVSttc2d2QWdkK1JmOE9PQUtPN0NIcDkyZG9od09rTXM5a1lo?=
 =?gb2312?B?dU5nVGpKelZNWElFaVRyaU81TTlwYkZ3Um5GUXFHZ0ROSzVDQnR6MGZRN0xQ?=
 =?gb2312?B?cHEyckhtMnFjdkhCUnp6bXcxY1Z6ZE4wSDFtdUF5UnJqVDNrOWY5b3IyOEQ5?=
 =?gb2312?B?UXZDSFc0Y2dJZmdybXNIQ2xlTjlUQlRhUkxmcWZlOG5xandrRHFkTDdpcDB3?=
 =?gb2312?B?R2dyTkxGOWdMR2NWRnR5UHdHMml3NDVpWTVjb0hZbWZOV01xb0wyYVpuQTFN?=
 =?gb2312?B?Z1hIamdKV09mSkhRTlpJZWdoWXhTM2hZK2RhR0R2a1dVS25Vc0owTlJLOXFI?=
 =?gb2312?B?cEdzZXpYS2xjbnFUU0k4Lzhid1lsQkFhTEZTNmxCVnY1MytPcVlOaVZIUG15?=
 =?gb2312?B?enN4YnBlZTZscDFqMjJ3REo4Rm0rcDdIZmxtZDYxd1Zua0VmckRJKzNwV0Zm?=
 =?gb2312?B?WWFuK1VyN0VjZmVJcVFCU0E2enhpTjRQQkpWb1V2YnhaZC85K0JFTTRiT2F4?=
 =?gb2312?B?bndCUXp6eGFNeVE3SzRQbnVxUXJrUG1Vekg5V043eFZaYlY4UGRTVG9wVU91?=
 =?gb2312?B?UTg1eGZKM1BpRTE0OGY0cFZMVzd2TUh3RnRCbUJkQjlrN0VDbTRmeDFkeE9I?=
 =?gb2312?B?T2NHVzFRVHl0Ky8xL2ZVRXByWEpObkJkb3RrOTVtdGZpUmZMY3RDeEZDUnlI?=
 =?gb2312?B?bTduVWlGcVJmaTRiVnpsc3M4bkhRWVlCd2ZPT2NCQXRuNkRFQ1NoSFIzZXpk?=
 =?gb2312?B?aGs4RUVQRnlYNHJ5bVJIK2FNVnRPUHBIZiszeko5eGIralhMbkVtSUFNODlY?=
 =?gb2312?B?RXhUVW1STGRlM3VNVkNyVFA1YXRUWXdOUlc0UTF6dkJzS2g5TnNUK2xjV2Qw?=
 =?gb2312?B?ME9tSUQwQmNkM1FjcDloQ1UrcFcralR1TkRiS25hWUdJdWxJSmJOZm9YVTh4?=
 =?gb2312?B?ODdjQVUvaGxwV3ZicjArK29qWktTSkxIRXAwaG1lZkhsUDVmMDh0RFhVdmJY?=
 =?gb2312?B?U20ySTVnTmRNM3ZyMzNibjVCUlB2Y0NES2xNR1lia2NUYmhJb0VlbS9WdGph?=
 =?gb2312?B?RlZFdERjVEluNDhob0MyYVJrYUtwczBhQTdzK2htUlYvR3Z2Qno5VXBhV0Zz?=
 =?gb2312?B?bzFXQlhQd0dXTEVwRFhpa1pUZUo2ZjlwTitwTzkvcVppZUdhZTUrSFhEeVJi?=
 =?gb2312?B?bVZ6VVRUWEFiUVNRWk5oSXpsU1ZtSFU4YTRNRGIvazRCaWRFbVdnOElIVC9G?=
 =?gb2312?Q?GPUHWn0cuial08Q3gdLFUHM=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dac8d94-bbda-4732-f70f-08d9fb8e68c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 14:18:51.0340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpOL7bTh90q0ndk1n4XaIqyBuWbkrVVX5AkdL1zYk1cUxnyTIEwwhOCOtqzJSCThQ7uzSbwxMfShQZmvZkW2IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WWFuZywgU3RhbmxleSC9q7O3u9jTyrz+obBbUEFUQ0hdIGRybS9hbWRncHU6IE1vdmUgY29tbW9u
IGluaXRpYWxpemF0aW9uIG9wZXJhdGlvbnMgb2YgZWFjaCByYXMgYmxvY2sgdG8gb25lIGZ1bmN0
aW9uobGhow==
