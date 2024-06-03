Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28790C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 18:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D8710E249;
	Mon,  3 Jun 2024 18:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ovQq43VU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE4510E249
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 18:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeRQoNz8p3Tp8QC2xvzU1T7IyxO44y1cGh+SeELQE7L1eMghn1yWQgEJpLeTNJRwpoxgjTPEND/V/+9kpJ02JE8PcMg43rCDz19Vscb/o1+eTga3qivU7fhJUgRBl7vQyHTb8hoQkLhuDvTlReIKxSdqs+ggbxbMaKnxi17E1osBq8UnJ16d1AeDhDE1/eGRp3CzYEMBmkfKT2sHGz9YctGLj+pbY3Wc53Z1degympguU6Jmr87OqET6hYNjgvmyNm7yr70gZkq6IMVpXWMH3blJZtOVrROVskjJDatltdhi07lYDQx6BV+E1x4guTs/rxqJetsON/KwWFVgdw/6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vOHKv4FKdYRWkrrOOOlk2SLn9+LXe0Vm3PW3lG/zg4=;
 b=i24ABNnak8aTxFFlazEzuYzbssy28IVIkTMBJ+J3twDh7D9P61AFr8pczOwhR2/Fd1V+a0gCozrczOhecVpkJzEIMmTFpQnNFn+mpMGkoteI7PxiHvUQw7QmM0lK2bzFAifkAOx2v3yeKhVTcBpc/CHkkKQm4sJi7hNfEG7nAGvmiUuE1z2wOfKYu5Gd54HT+o+b0XjmNmYJJ4ZUdWx/f+GdlydkowkcaCoAZMzTfn9waMsVliThnz+QStMiXDYG9Gyqx2eSsD91/l1aSaGviaPQ8TGvqMonnh79VKqQHJIUACXSkZtnjnuMzHbfoDVu/XzcriwSR8qPQHH9QSzfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vOHKv4FKdYRWkrrOOOlk2SLn9+LXe0Vm3PW3lG/zg4=;
 b=ovQq43VUpzqBXzOJD+hjKEVC+xtn1XmR1qfynkBu+lmTslaiOFh5xk5cjjoIyLtBwZ/Uf6sSRUJ2ps2ES3944iYQ3f10oEpjVTQch9Q/qm5fi9ItwnCiRhZDDlGu5HphcytB7IZEeItpIsBLdvoLqxJoFyMD+PxkrlOspZzXGR8=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 18:28:17 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 18:28:17 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>, "Li, 
 Yunxiang (Teddy)" <Yunxiang.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Xiao, Hua" <Hua.Xiao@amd.com>
Subject: RE: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Thread-Topic: [PATCH v2 03/10] drm/amdgpu: abort fence poll if reset is started
Thread-Index: AQHasSPntTWyQJHFuU6/8azfL5MK/LGtw2cAgABwxYCAAAKugIAAA6MAgAADGYCAAAnmgIAAAQgAgAADwoCAAAiaAIAAHlhwgAd0f4CAAF1lgA==
Date: Mon, 3 Jun 2024 18:28:17 +0000
Message-ID: <CH0PR12MB53721EB64869BF3260CE095DF4FF2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-4-Yunxiang.Li@amd.com>
 <32ab9756-ca28-4ec0-919a-1d1df950aee7@amd.com>
 <SA1PR12MB8599F850C7BD44B5F66D80E8EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <a1e40066-f980-4490-a0b9-d8f3be34ad8f@amd.com>
 <SA1PR12MB85996538350B30F80330C0EAEDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b646408e-9b50-4e2a-b2b1-ab1ff9f4b366@amd.com>
 <SA1PR12MB859960F8F2B9B22E726EF6D2EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <b35b5556-9919-4806-bea7-f7ed94844a04@amd.com>
 <SA1PR12MB8599AB4284E5B4415D92FF14EDF22@SA1PR12MB8599.namprd12.prod.outlook.com>
 <ab92ab3e-b96b-480e-8089-b3949f453bd3@gmail.com>
 <CH0PR12MB53721A7C3403982035E48639F4FC2@CH0PR12MB5372.namprd12.prod.outlook.com>
 <380c4bd1-ab50-4f42-bb50-69dc0fbd28fe@amd.com>
In-Reply-To: <380c4bd1-ab50-4f42-bb50-69dc0fbd28fe@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5e2f16f3-3a03-4868-8b3b-f730ea186ce5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-03T16:32:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DS7PR12MB8273:EE_
x-ms-office365-filtering-correlation-id: 8683a0bd-dec9-445a-582f-08dc83faf030
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|366007|376005|921011|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?YU5HbzVZNXovdmtsRy9zVDBJMUsyMkwzb2NNZVg0OHpQSVpGU1Z5VlNEV01v?=
 =?utf-8?B?ZFhxS3Z0MlJwbklqb3o1M2RGdXg2NCtTbzFaMjdmTGxaQ3NVSStUekRmS0FP?=
 =?utf-8?B?OXhISzNBS0ZmZGdVNnE2U0x3amVUOHBsYjVFNEZvczVoQW5Ga2dKaThicGw5?=
 =?utf-8?B?OWFxeCthaXFnYitCV296N2s5UnB2eFhERUlRd2pUclNKWGtycndZeVF1OE85?=
 =?utf-8?B?dHJEQ1JJdk5vM2U3Uk9LdERtMmdzeHdrd0F0NVc0ZnArc2hUcHRTWUFQNGdw?=
 =?utf-8?B?dVRnL1Q2R1R6eHNFSGpBT1ZWR242SzBncGRLM251RjRvNDdzZk5IWCtsR1lR?=
 =?utf-8?B?d3FFeWt4TXZrZ1F2dUhNUlBQYVNDTHcvNkkzK3YwTURpSXY1ZDIrOG5lTHRJ?=
 =?utf-8?B?NXkvRlNMWmZOL0IyVnJNWElZcXlBeUttMW42S3ZUTG5VS0NNcCtiQ1VLS2xP?=
 =?utf-8?B?ZkNDS0EvRHEzV09VQ0EwaWZmK2huSVg1NGJzWHJaOUVkN1VQVHY3MVd0SzU1?=
 =?utf-8?B?VUpERkxpZElyMGJ4d3ozKzQrdU1RSEhYWlFqTGR5c29yaDdnekZldE1QVHhY?=
 =?utf-8?B?SXVEamwyc25UMmkrQ0R4eFgyWExHM1pnUUZnOUpzc29oYkxJc3lnSXRxd0FV?=
 =?utf-8?B?b1BVT1lHOUdFdXFoTHNhSWhVZVRrT0ZIUks2SmxUeXp0RXpJaFpKbkhxTWVI?=
 =?utf-8?B?bVhpZkpJa1ZXZDcxTHk1ekQ3bk56YitmdG1GYldCY3Byei9uMEppTWZlNmJQ?=
 =?utf-8?B?S2ExeWFxUGhwd2gwTUxkSG5mQmw4Z1k5Wm8ybXJmMnBHS3VTZHZJT1Vkclpa?=
 =?utf-8?B?Z3puZm9LWDhNenJSM3AzckQ3bVY2TE4yNXp1bWtheGtIdHFra2wwdjYxN0xS?=
 =?utf-8?B?dVVySlFGYll2aVljWGZvRnYzRFJYalJCcFlDRmoyYU02VWxUOWw1R3lhekpl?=
 =?utf-8?B?emR5Zm1hWk8zbUtxbzAwcktHN2VsRVA4blFHU0p5TStDTll4UW5PYnB1WEgr?=
 =?utf-8?B?QkFJK0xTWStDSVRNMGpNZnEvQnJjYUZFdUhveXdiZUI0SWQrS1ptWkpJYkdm?=
 =?utf-8?B?WE9INGVUd0cyZDZtU2tpMTZUT0tlV3hncmJSS2xlZjNLNW5OcXRSTGtOK0hw?=
 =?utf-8?B?OUZFMXk5Ump6K0tSMEVWSXBDOTloOGFTeEd1N1BBWWdhOXNVQTNqUmZCdE12?=
 =?utf-8?B?ZHQ1WE9JeENLWmt3ZnlpZk1uTFUrK2JFM0RVNjRNY09nT0loTUJIa1ExZG9E?=
 =?utf-8?B?NFN3RUhidG1SaDZ1dGNUMjVpeTZqdjZnczBVZ29oSDUxSWRtdGhxNHpYOWRU?=
 =?utf-8?B?YzQxNG5oVUxiNlFUVUVxZTFhcHEySlZ4MHlucndFSXYwckRHS0pMQkFGb3Bo?=
 =?utf-8?B?TmhpSWtMejJpWXpBbHdDZTBIR0xWeHRuTW1CVXdNVzNJZVNFdlgwMEFFNDkr?=
 =?utf-8?B?Q0FudzBGRnhtSnVBTFFEc0pFYWc4bThWL2ppZE11K09aZDlzaWFmRlY5cDZj?=
 =?utf-8?B?emlSSmdnbktHRUlSSVhIWXNCVEkrSENXWENmbVJnbTJ3VnV2c1UrNUFJMmZz?=
 =?utf-8?B?R3dQaCtDYTllNEhVeHFaSGM3UTQ2SlA1Z2pINXIrUUxNWHNOS2VBYzhNSmJF?=
 =?utf-8?B?RUpJVTNWb09qQUxGZCtnNGVVbzRyVnJQS1drejV4cElTckl1b1QzRUh5ZFha?=
 =?utf-8?B?MmpvdnR2ZHNKRzg4dDFuMXA1eWxXYlZCRVN3TGZVTVVLM3RuNWt3ODFzRFdI?=
 =?utf-8?B?UWttT3FSREs2eGgyNXRHM1ZiNXVnUG5NU29NdThCN1J2Y1JqTEYweW9BNEd5?=
 =?utf-8?Q?G2St9UxTO8O1UPUtu4q4qpBB8+F1J9o4oxmXs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(921011)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWV2ZEYzSytXZWNTUTJLL0ZOL3Rya0dkWmhGSlRrQmdmNEFjaGhYWERxOXk5?=
 =?utf-8?B?RWVCUzkvbGlVcGZTMFFkZzM3ZUYzQk8vV05DMThocUxWbkl1TkhMTENpZkZq?=
 =?utf-8?B?Yi80anFuQ2hHY0VXRXZOMy96M0tUMGw0OGZzZ2Vsbzg0M2orNVNPOU5vRWhY?=
 =?utf-8?B?NDJBc2M5ZmJiT2dXbjJja051MURNK1VwQ2MyUEM5dHdXYThnSi9pM2V0L0o1?=
 =?utf-8?B?dFhnSUxyK0VWM3BRNjlaa29vSks2eUtSL2RrQTF6eWpMVVkrOXZYcTdGZzdP?=
 =?utf-8?B?N0kvQmRHNFU3RnMrUTI5V2pWNjF4cWdBU1g3QjJVZXlLMnVuak91MXIxVDlF?=
 =?utf-8?B?QXExd1dMK3NGL0JiQjVpOXc5Z0xJZjNyVHczSVNPWS9wODFFb2RLZnpEaGwx?=
 =?utf-8?B?SnhiYjlDUEx5b0JJL1RaZHdlTXp0U0d1WGFwL3pqZmZCYWJuTTd6TE0vM2NR?=
 =?utf-8?B?Nkw5Z1BselZpcWJEdnJsc0h1RDFEYmlLbHJQZEVKZ1hPMGhFMHdNQk95R0tW?=
 =?utf-8?B?ZlJLRXR3QzNLS0JSSmNWWTNLekF3RlBBRWgyMldhY1g2Z2lxVGhYOHUrY1Qr?=
 =?utf-8?B?YTJ6eU5tQnB1VHBBdG4wM3FRZlhadVRjblVoTS9zT2J5WjNvRTFMVW5xTTI3?=
 =?utf-8?B?Y3FHdjU2Q3QzRjhmdDhwU29MYitRMFlIc053RXFlZ0NFeEZuVXNDY1FNenRI?=
 =?utf-8?B?Y1M3MVFMWEozZnJmcTJ5a3VTVnZaRzE2QjE5TElMNGlIZkpFbHVwbjd5dWtM?=
 =?utf-8?B?cnZzYlpQYWZJRnNnZ3FQanVOWXF0ZjNEUlp4ZktoYWNvNTBoWlNNWm8zeTU0?=
 =?utf-8?B?REhOSVpWcGYzeDN1M1BiUjNzbkZxQ0JNZGFNejJnVDFEY2ZxcDRGa0hDeWpt?=
 =?utf-8?B?cVlxS2pGLytLa0JwOUJhT2N6NFM0amZ1MkE0SGxLRzQxcEhhMFpodnl4THNO?=
 =?utf-8?B?RThFTTIvQTJDeTBNak41aW1nU0VSUEpvNlY2YVR0N1NYVzNjbE9kVG1QeTVT?=
 =?utf-8?B?ODdBSzN0Mk5SWHhXVWlSK2UrbUQxZUZHNUpvUGlPQXdaTDhVYmVnN0IvN2pN?=
 =?utf-8?B?NTRtaG9pUjRlRkZxWGZydVQzNElMYytUd2NISXFrNzFhRDdkYXV4eUdBN1Fz?=
 =?utf-8?B?ejBHTEpISUp5bE9vdzBUZ2JzL2ZCVDY2anR1WlRweVlNcHZtZkkyUXdBclho?=
 =?utf-8?B?OGMvMVQzbTVwN0NIeUZnOTQ1QnlFK25CMVdEWkxyOUEwOE9MdFk4WklZU2Y0?=
 =?utf-8?B?dEszanlLNDJqeDZIWmdOdEZlQ0ZZTjNqTWd1cXQ1c1JYUk9ORmNva3ZMdlY4?=
 =?utf-8?B?ektUelc1UDZ0QUJLN3pqZWFoYjZYc1ZxeFFncW56YmY1enpDcWVlZnlHa0VR?=
 =?utf-8?B?UC9ZNHpOaTFhSWxyVFh3UG5HZERReUdpelpycW9ZRm9IL2VXQkZjVG1UMDBS?=
 =?utf-8?B?ZFFxRzE2dkI4WFYzWHZXU1luaXZWM0tpK1M4K1dEdWg3Y2JBWXRUSmxrWEtz?=
 =?utf-8?B?RGVYaG9UVnF1WlN0Nk5xaWxDYllPUHNjdWxOS0NuZ1F5QUtsb2RUMjdmaWNx?=
 =?utf-8?B?dnU0bDJMMVFVNHpsemRyVlNVSDRQTzVjdTZqMlhpTm1TNk1tTlo0cm1zNzhm?=
 =?utf-8?B?bkF6dXk3OTJ3TkZpRk9LZWxWYWRTVHR4Z0hlbzR3dWNKdFU0QVVJV2kyTEJW?=
 =?utf-8?B?VS85Ymttd0RtSEtxK3IrNXVHanpHbElmK0lJTUtKRUQ5U3A0cTJUNlFjbE0x?=
 =?utf-8?B?MDhmYXpPNWdZN3JaelZnbWszYUMvaVpQa1Aya2szOFFidHFrSkpoQ2VCYTA2?=
 =?utf-8?B?dXpQaTMzZWRHb252MUw1ODJUL2JraGNDREJ0UGg1RDRYOG1NMWlLRTB4OU1t?=
 =?utf-8?B?MVI3VVRVcVlma2g0eE9jZk9ZaHd0OGgwcnZYWHozQWlqZjZDeE51Y2tZS3k2?=
 =?utf-8?B?cjlPcVFwV0huWW9iUTJlcThWQ3RxMXVzSVd0QmFyTFZvSDVFMmpKZ2d2bTFH?=
 =?utf-8?B?SjRGOGRtYjN0a0FVb2U2aXFkRXY2NkRHR2RoNGdMZ25aVncySHlaUUJlUVN2?=
 =?utf-8?B?aGppaU55cFU2N3F0aVZIT1hrVE1aZG5SdTFhdmF1V1lUQllITUJqVHFtZTR0?=
 =?utf-8?Q?MyLg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8683a0bd-dec9-445a-582f-08dc83faf030
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 18:28:17.4061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoT/CuBmmrW5FYno9GCVMTAyJsAPTDdBJCD3w7GYgEvxvMPXWbiFSxKAKw4KvSBplZl/A2JcNX8oOu5Q3rwGaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273
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
Cg0KVGhhbmtzIENocmlzdGlhbiBmb3IgdGhlIGRldGFpbCBleHBsYW5hdGlvbi4NCkkgY2hlY2tl
ZCB5b3VyIHBhdGNoICwgeW91IHRyeSB0byB1c2UgcXVlcnlfc2NoZWR1bGVyX3N0YXR1cyBwYWNr
YWdlICB0byBjaGVjayB0aGUgY29tbWFuZCBjb21wbGV0aW9uIC4gSXQgIG1heSBub3Qgd29yayBh
cyBleHBlY3RlZCBzaW5jZSB0aGlzIEFQSSBxdWVyeSB0aGUgc3RhdHVzIGlzIGZvciBNRVMgaXRz
ZWxmICwgc28gbWVzIGNhbiB1cGRhdGUgdGhlIGZlbmNlIGFkZHJlc3Mgd2l0aCAgdGhlIGV4cGVj
dGVkIHNlcSB2YWx1ZSwgYnV0IHRoZSAgY29tbWFuZCAgaXRzZWxmIChleCAucmVtb3ZlX3F1ZXVl
IGZvciBtZXMgYW5kICB0aGVuICBtZXMgc2VuZCB0aGUgIHVubWFwX3F1ZXVlIHRvIGtpcSBpbnRl
cm5hbGx5KSAgc3RpbGwgZmFpbHMuDQpGb3IgbWVzICwgZHJpdmVyIGFsd2F5cyBwb2xsIGZvciB0
aGUgY29tbWFuZCBjb21wbGV0aW9uICwgIGRvIHlvdSB0aGluayBpdCdzIGFuIGFjY2VwdGFibGUg
c29sdXRpb24gdGhhdCBNRVMgc2V0IGEgc3BlY2lmaWMgZmFpbHVyZSB2YWx1ZShleCAsIC0xKSAg
aW4gdGhlIGZlbmNlIGFkZHJlc3MgdG8gaW5kaWNhdGUgdGhlIGZhaWx1cmUgb2YgdGhlICBvcGVy
YXRpb24gPyAgQnV0IHRoYXQgc2hvdWxkIGJlIHNpbWlsYXIgdG8gbGV0IGRyaXZlciBwb2xsIHRo
ZSBjb21wbGV0aW9uIHRpbGwgdGltZW91dCAuICBNRVMgaW50ZXJuYWxseSBhbHNvIG5lZWQgdG8g
d2FpdCBmb3IgYSB0aW1lb3V0IG9uIHNvbWUgIGNvbW1hbmQgdGhhdCBpdCBzZW50ICB0byBDUCAo
ZXguICAyIHNlY29uZHMgZm9yIHVubWFwX3F1ZXVlIGNvbW1hbmQpLiAgSSdtIGFjdHVhbGx5IGEg
bGl0dGxlIGJpdCBjb25mdXNlZCBoZXJlICwgaGFzIGRyaXZlciB1c2UgdGhlIGxvY2sgdG8gZW5z
dXJlIHRoZXJlIGlzIG9ubHkgb25lIHN1Ym1pc3Npb24gaW50byBNRVMgYXQgYW55IHRpbWUgPw0K
IE1FUyBjYW4gYWxzbyB0cmlnZ2VyIHRoZSBpbnRlcnJ1cHQgb24gdGhlIGZhaWx1cmUgaWYgZHJp
dmVyIHNpZGUgcmVxdWlyZSB1cyB0byBkbyBzbyAsIHRoZSAgcGF5bG9hZCB3aWxsIGhhdmUgdGhl
IHNlcSBudW1iZXIgdG8gaW5kaWNhdGUgd2hpY2ggc3VibWlzc2lvbiBjYXVzZSB0aGUgZmFpbHVy
ZSAsIHRoYXQgbWlnaHQgcmVxdWlyZXMgbW9yZSBjb2RlIGNoYW5nZSBmcm9tICAgZHJpdmVyIHNp
ZGUgLlBsZWFzZSBsZXQgbWUgd2hhdCdzIHByZWZlcnJlZCBmcm9tIGRyaXZlciBzaWRlLg0KDQpS
ZWdhcmRzDQpTaGFveXVuLmxpdQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
S29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IE1vbmRh
eSwgSnVuZSAzLCAyMDI0IDY6NTkgQU0NClRvOiBMaXUsIFNoYW95dW4gPFNoYW95dW4uTGl1QGFt
ZC5jb20+OyBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNv
bT47IExpLCBZdW54aWFuZyAoVGVkZHkpIDxZdW54aWFuZy5MaUBhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IFhpYW8sIEh1YSA8SHVhLlhpYW9AYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMDMvMTBdIGRybS9hbWRncHU6IGFib3J0IGZlbmNlIHBvbGwgaWYgcmVzZXQgaXMg
c3RhcnRlZA0KDQpIaSBTaGFveXVuLA0KDQp5ZXMgbXkgdGhpbmtpbmcgZ29lcyBpbnRvIHRoZSBz
YW1lIGRpcmVjdGlvbi4gVGhlIGJhc2ljIHByb2JsZW0gaGVyZSBpcyB0aGF0IHdlIGFyZSB0cnlp
bmcgdG8gc3R1ZmYgdHdvIGRpZmZlcmVudCBpbmZvcm1hdGlvbiBpbnRvIHRoZSBzYW1lIHZhcmlh
YmxlLg0KDQpUaGUgZmlyc3QgaW5mb3JtYXRpb24gaXMgaWYgdGhlIGNvbW1hbmRzIGhhdmVuIGJl
ZW4gcmVhZCBieSB0aGUgTUVTIGZyb20gdGhlIHJpbmcgYnVmZmVyLiBUaGlzIGluZm9ybWF0aW9u
IGlzIG5lY2Vzc2FyeSBmb3IgdGhlIG5vcm1hbCByaW5nIGJ1ZmZlciBhbmQgcmVzZXQgaGFuZGxp
bmcsIGUuZy4gcHJldmVudHMgcmluZyBidWZmZXIgb3ZlcmZsb3csIG9yZGVyaW5nIG9mIGNvbW1h
bmQsIGxvY2t1cHMgZHVyaW5nIHJlc2V0IGV0Yy4uLg0KDQpUaGUgc2Vjb25kIGluZm9ybWF0aW9u
IGlzIGlmIGEgY2VydGFpbiBvcGVyYXRpb24gd2FzIHN1Y2Nlc3NmdWxseSBvciBub3QuIEZvciBl
eGFtcGxlIHRoaXMgaXMgbmVjZXNzYXJ5IHRvIGdldCBzaWduYWxlZCBiYWNrIGlmIHkgcXVldWUg
bWFwL3VubWFwIG9wZXJhdGlvbiBoYXMgYmVlbiBzdWNjZXNzZnVsbHkgb3IgaWYgdGhlIENQIG5v
dCByZXNwb25kaW5nIG9yIGFueSBvdGhlciBlcnJvciBoYXMgaGFwcGVuZWQgZXRjLi4uDQoNCkFu
b3RoZXIgaXNzdWUgaXMgdGhhdCB3aGlsZSBpdCBpcyBpbiBnZW5lcmFsIGEgZ29vZCBpZGVhIHRv
IGhhdmUgdGhlIGZpcm13YXJlIHdvcmsgaW4gYSB3YXkgd2hlcmUgZXJyb3JzIGFyZSByZXBvcnRl
ZCBpbnN0ZWFkIG9mIGNvbXBsZXRlbHkgc3RvcHBpbmcgYWxsIHByb2Nlc3NpbmcsIGhlcmUgd2Ug
cnVuIGludG8gdHJvdWJsZSBiZWNhdXNlIHRoZSBkcml2ZXIgdXN1YWxseSBhc3N1bWVzIHRoYXQg
d29yayBjYW4gYmUgc2NoZWR1bGVkIG9uIHRoZSByaW5nIGJ1ZmZlciBhbmQgYSBzdWJzZXF1ZW50
IHdvcmsgaXMgcHJvY2Vzc2VkIG9ubHkgd2hlbiBldmVyeXRoaW5nIHByZXZpb3VzbHkgc3VibWl0
dGVkIGhhcyBjb21wbGV0ZWQgc3VjY2Vzc2Z1bGx5Lg0KDQpTbyBhcyBpbml0aWFsIGZpeCBmb3Ig
dGhlIGlzc3VlIHdlIHNlZSBJJ3ZlIHNlbmQgQWxleCBhIHBhdGNoIG9uIEZyaWRheSB0byBwYXJ0
aWFsbHkgcmV2ZXJ0IGhpcyBjaGFuZ2UgdG8gdXNlIGFuIGluZGl2aWR1YWwgd3JpdGViYWNrIGZv
ciBlYWNoIHN1Ym1pc3Npb24uIEluc3RlYWQgd2Ugd2lsbCBzdWJtaXQgYW4gYWRkaXRpb24gUVVF
UllfU1RBVFVTIGNvbW1hbmQgYWZ0ZXIgdGhlIHJlYWwgY29tbWFuZCBhbmQgbGV0IHRoYXQgb25l
IHdyaXRlIGZlbmNlIHZhbHVlLiBUaGlzIHdheSB0aGUgZmVuY2UgdmFsdWUgaXMgYWx3YXlzIHdy
aXR0ZW4sIGluZGVwZW5kZW50IG9mIHRoZSByZXN1bHQgb2YgdGhlIG9wZXJhdGlvbi4NCg0KQWRk
aXRpb25hbCB0byB0aGF0IHdlIG5lZWQgdG8gaW5zZXJ0IHNvbWV0aGluZyBsaWtlIGEgZGVwZW5k
ZW5jeSBiZXR3ZWVuIHN1Ym1pc3Npb25zLCBlLmcuIHdoZW4geW91IGhhdmUgY29tbWFuZHMgQSwg
QiBhbmQgQyBvbiB0aGUgcmluZyBhbmQgQyBjYW4gb25seSBleGVjdXRlIHdoZW4gQSB3YXMgc3Vj
Y2Vzc2Z1bGx5IHRoZW4gd2UgbmVlZCB0byBzb21laG93IHRlbGwgdGhhdCB0aGUgTUVTLiBPbmx5
IG90aGVyIGFsdGVybmF0aXZlIGlzIHRvIG5vdCBzY2hlZHVsZXIgY29tbWFuZHMgYmVoaW5kIGVh
Y2ggb3RoZXIgb24gdGhlIHJpbmcgYW5kIHRoYXQgaW4gdHVybiBpcyBhIGJhZCBpZGVhIGZyb20g
dGhlIHBlcmZvcm1hbmNlIHBvaW50IG9mIHZpZXcuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoN
CkFtIDMxLjA1LjI0IHVtIDE2OjQ0IHNjaHJpZWIgTGl1LCBTaGFveXVuOg0KPiBbQU1EIE9mZmlj
aWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPg0KPiBIaSwg
Q2hyaXN0aWFuDQo+DQo+IEkgdGhpbmsgd2UgaGF2ZSBhIGRpc2N1c3Npb24gYWJvdXQgdGhpcyBi
ZWZvcmUgLiBBbGV4IGFsc28gaGF2ZSBhIGNoYW5nZSB0aGF0IGFsbG93IGRyaXZlciB0byB1c2Ug
ZGlmZmVyZW50IHdyaXRlIGJhY2sgYWRkcmVzcyBmb3IgdGhlIGZlbmNlIGZvciBlYWNoIHN1Ym1p
c3Npb24gZm9yIHRoZSAgb3JpZ2luYWwgaXNzdWUgLg0KPiAgRnJvbSBNRVMgIHBvaW50IG9mIHZp
ZXcgLCAgTUVTIHdpbGwgdXBkYXRlIHRoZSBmZW5jZSB3aGVuIHRoZSBBUEkgY2FuIGJlIGNvbXBs
ZXRlIHN1Y2Nlc3NmdWxseSwgc28gaWYgdGhlICBBUEkgKGV4IC4gcmVtb3ZlX3F1ZXVlKSBmYWls
cyAgZHVlIHRvICBvdGhlciBjb21wb25lbnQgaXNzdWUgKGV4ICwgQ1AgaGFuZyksIHRoZSAgTUVT
IHdpbGwgbm90IHVwZGF0ZSB0aGUgZmVuY2UgSW4gdGhpcyBzaXR1YXRpb24gLCBidXQgIE1FUyBp
dHNlbGYgc3RpbGwgd29ya3MgYW5kIGNhbiByZXNwb25kIHRvIG90aGVyIGNvbW1hbmRzIChleCAs
LHJlYWRfcmVnKSAgLiAgQWxleCdzIGNoYW5nZSBhbGxvdyBkcml2ZXIgdG8gY2hlY2sgdGhlIGZl
bmNlIGZvciBlYWNoIEFQSSB3aXRob3V0IG1lc3MgYXJvdW5kIHRoZW0gIC4gIElmIHlvdSBleHBl
Y3QgTUVTIHRvIHN0b3AgcmVzcG9uZGluZyAgdG8gZnVydGhlciBjb21tYW5kcyAgYWZ0ZXIgb25l
IEFQSSBmYWlscyAsIHRoYXQgd2lsbCBpbnRyb2R1Y2UgY29tYmFiaWxpdHkgaXNzdWUgc2luY2Ug
dGhpcyBkZXNpZ24gYWxyZWFkeSBleGlzdCBvbiBwcm9kdWN0cyBmb3IgY3VzdG9tZXIgYW5kIE1F
UyBhbHNvIG5lZWQgdG8gd29ya3MgZm9yIHdpbmRvd3MgLiAgQWxzbyBNRVMgIGFsd2F5cyBuZWVk
IHRvIHJlc3BvbmQgdG8gIHNvbWUgY29tbWFuZHMgbGlrZSAgUkVTRVQgIGV0YyAgdGhhdCBtaWdo
dCBtYWtlIHRoaW5ncyB3b3JzZSBpZiB3ZSBuZWVkIHRvIGNoYW5nZSB0aGUgbG9naWMgLg0KPg0K
PiBPbmUgcG9zc2libGUgc29sdXRpb24gaXMgTUVTIGNhbiAgdHJpZ2dlciBhbiBJbnRlcnJ1cHQg
IHRvIGluZGljYXRlIHdoaWNoIHN1Ym1pc3Npb24gaGFzIGZhaWxlZCB3aXRoIHRoZSBzZXEgbnVt
YmVyIC4gSW4gdGhpcyBjYXNlIGRyaXZlciBjYW4gZ2V0IHRoZSAgZmFpbHVyZSBvZiB0aGUgIHN1
Ym1pc3Npb24gdG8gTUVTIGluIHRpbWUgYW5kICBtYWtlIGl0cyBvd24gZGVjaXNpb24gZm9yIHdo
YXQgdG8gZG8gbmV4dCAsIFdoYXQgZG8geW91IHRoaW5rIGFib3V0IHRoaXMgPw0KPg0KPiBSZWdh
cmRzDQo+IFNoYW95dW4ubGl1DQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJl
aGFsZiBPZg0KPiBDaHJpc3RpYW4gS8O2bmlnDQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDI5LCAy
MDI0IDExOjE5IEFNDQo+IFRvOiBMaSwgWXVueGlhbmcgKFRlZGR5KSA8WXVueGlhbmcuTGlAYW1k
LmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAz
LzEwXSBkcm0vYW1kZ3B1OiBhYm9ydCBmZW5jZSBwb2xsIGlmIHJlc2V0IGlzDQo+IHN0YXJ0ZWQN
Cj4NCj4gQW0gMjkuMDUuMjQgdW0gMTY6NDggc2NocmllYiBMaSwgWXVueGlhbmcgKFRlZGR5KToN
Cj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9u
bHldDQo+Pg0KPj4+IFllYWgsIEkga25vdy4gVGhhdCdzIG9uZSBvZiB0aGUgcmVhc29uIEkndmUg
cG9pbnRlZCBvdXQgb24gdGhlIHBhdGNoDQo+Pj4gYWRkaW5nIHRoYXQgdGhhdCB0aGlzIGJlaGF2
aW9yIGlzIGFjdHVhbGx5IGNvbXBsZXRlbHkgYnJva2VuLg0KPj4+DQo+Pj4gSWYgeW91IHJ1biBp
bnRvIGlzc3VlcyB3aXRoIHRoZSBNRVMgYmVjYXVzZSBvZiB0aGlzIHRoZW4gcGxlYXNlDQo+Pj4g
c3VnZ2VzdCBhIHJldmVydCBvZiB0aGF0IHBhdGNoLg0KPj4gSSB0aGluayBpdCBqdXN0IG5lZWQg
dG8gYmUgaW1wcm92ZWQgdG8gYWxsb3cgdGhpcyBmb3JjZS1zaWduYWwgYmVoYXZpb3IuIFRoZSBj
dXJyZW50IGJlaGF2aW9yIGlzIHNsb3cvaW5jb252ZW5pZW50LCBidXQgdGhlIG9sZCBiZWhhdmlv
ciBpcyB3cm9uZy4gU2luY2UgTUVTIHdpbGwgY29udGludWUgcHJvY2VzcyBzdWJtaXNzaW9ucyBl
dmVuIHdoZW4gb25lIHN1Ym1pc3Npb24gZmFpbGVkLiBTbyB3aXRoIGp1c3Qgb25lIGZlbmNlIGxv
Y2F0aW9uIHRoZXJlJ3Mgbm8gd2F5IHRvIHRlbGwgaWYgYSBjb21tYW5kIGZhaWxlZCBvciBub3Qu
DQo+IE5vIHRoZSBNRVMgYmVoYXZpb3IgaXMgYnJva2VuLiBXaGVuIGEgc3VibWlzc2lvbiBmYWls
ZWQgaXQgc2hvdWxkIHN0b3AgcHJvY2Vzc2luZyBvciBzaWduYWwgdGhhdCB0aGUgb3BlcmF0aW9u
IGRpZG4ndCBjb21wbGV0ZWQgdGhyb3VnaCBzb21lIG90aGVyIG1lY2hhbmlzbS4NCj4NCj4gSnVz
dCBub3Qgd3JpdGluZyB0aGUgZmVuY2UgYW5kIGNvbnRpbnVpbmcgcmVzdWx0cyBpbiB0b25zIG9m
IHByb2JsZW1zLCBmcm9tIHRoZSBUTEIgZmVuY2UgYWxsIHRoZSB3YXkgdG8gdGhlIHJpbmcgYnVm
ZmVyIGFuZCByZXNldCBoYW5kbGluZy4NCj4NCj4gVGhpcyBpcyBhIGhhcmQgcmVxdWlyZW1lbnQg
YW5kIHJlYWxseSBjYW4ndCBiZSBjaGFuZ2VkLg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4u
DQoNCg==
