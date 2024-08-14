Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F859C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 06:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADFAD10E388;
	Wed, 14 Aug 2024 06:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xiZjKPMP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA3CE10E070
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 06:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWsae7mt4d2fbAg7rOQI4fffzb9LPUkDSH3XQTqiwhCf80aDGX8uknaDO6bJxLssvKUHAybzi0z6EdAK8ROxw7bSxK3QRu4VMbrLdrzaPCu/RlowXIiI4li85WNTlrVUvdqYQmInGPxVr27I24dubJSenoB8wf9RBa4OhOzN9YSzEJRYqEa+zjA6ZhMcropwzku/sk84i8mpETpDc04v9QcSfwpZ7m/Rf4sJBnS1ebL9M8U0Ezl6FhJaCvcbigezR58Yo/n5wPzGIRhmvdkuyd5KeTMVEDKH5buqXFjzpHnggIg2o0dhYmqFcJgw74vnweQJrq27vCgfP7jrYNKiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbCOAaBRngKKFLPQ4woqjoyTuqHxETUrknGzLhXUe3M=;
 b=RmatpNhj8NMwJ2SuZxTe6Ld/aUEJ9JbzE5L2fVKaDIAMr1KJH685yC5LUQMMIdCYK/ydD2VN8sdke5B+Oeo+EoVQLey2iptauzj6wOTQDM+Bb4jTxEpI1ozlJQo5fSuNb54CtYXqmrK2AMn1CyAeBTaDXVwhL3D1mJqWTm1PZEFoqw0Q7nVd39AuSmYHDYfUoHzk8YTaNDFhfsR+FM/5sXVM21jik9fT5RJFmsUnPKkyuC43oj08WqDdbpNjFGx0ZzXOXtcUsDyhwCnWCcl3Mbo1heTaaxWg1IIrfN82arWdXn9lQmkxORlXkEFaquWdIgaNjSYitZqy5VU+GDiu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbCOAaBRngKKFLPQ4woqjoyTuqHxETUrknGzLhXUe3M=;
 b=xiZjKPMP13X8hjRjoh5ggpXR1klbdchZ1Afn3EQ9CtXWABP4EtsP9KJO1g3VZaXMI27FOCBMECDVXBBKtol/6xmDPF+NKwY39xmp2j2Q7CtRpIM90E+diSUPLdi+1OUTLeR92TXRs88SiJe7oKhmxVSh5x34eqlz7HH3oA4qNsM=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 06:35:55 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 06:35:55 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Christopher Snowhill <chris@kode54.net>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
Thread-Topic: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
Thread-Index: AQHa6W881OX1vpnp0U6vbxJOQG6+0LIdcF4AgADz69CAATLeAIADSLpwgAMmhICAAAJQgIAARk9g
Date: Wed, 14 Aug 2024 06:35:55 +0000
Message-ID: <CY5PR12MB6369351BE6C7835F591DBCD2C1872@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <7e40e8c2-d6a7-4e10-b71c-c4f869e825ab@amd.com>
 <E3D1CFD8-93E9-4B38-BC02-7432B94432E8@kode54.net>
In-Reply-To: <E3D1CFD8-93E9-4B38-BC02-7432B94432E8@kode54.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a94adfa2-4183-461e-b63e-1cd91bea2a3a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-14T06:12:29Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|MW5PR12MB5650:EE_
x-ms-office365-filtering-correlation-id: b8fa04f5-23e5-49bc-1164-08dcbc2b59cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SjRVQUVkR0ZuY0JsT09nYkxBVHJUZ1BEcS9UMlJydlVpWXlBdFNIcGl6dWxU?=
 =?utf-8?B?ZE9PUXh6Mk5KZk5DNUZkTUhsMjF4RldWVGZGS2h4MVVyYXlSWkZBT05Ka3dz?=
 =?utf-8?B?dmtrOXRDdm4vNmJlcy85ejBYYjFCTEdUOG8wWHBUanU0SDlvTmdDWlljYVQ3?=
 =?utf-8?B?UEtRMlVTOVBQK3FpZDNGU2xqeTZqdUVKUUgyUk1iRnk3WEcwSmN4ZGtFemti?=
 =?utf-8?B?TVFCMXlnK1RkVVR6K3NFR2JQQXhkREVMdEZQUlpOZVBWVUhsUGMxV2VuckFt?=
 =?utf-8?B?L1VsU2tOT3BFOU5LbHIzQkdJdVM1VzFZb1dlbm85WXdFWDY0bjNrMkxCL3RW?=
 =?utf-8?B?V3lrTHdTc0szOFBOV2J0WDNFenB2bm8yV1MvZnRVR1NFazhPTVJLSFFaU0NX?=
 =?utf-8?B?UjJWMWZockk2NFl1WkU0QUx5Z3FPVEIxYWtnMkZKYit4Q1RheUR4TjI5eU9p?=
 =?utf-8?B?R2l0cW53Ky9JK3VhSW94Sks5NFg5Rm1XNU91dVkyczdoUlJwdVJQTmRnMGtm?=
 =?utf-8?B?RncyL2dteVY1cUthZGh0amR1WXBKMTlSTnFDVFV4R1RYVzYvTEJOcnBVNWVz?=
 =?utf-8?B?RVJyR2VSdzBpTVpRYUJjTWpweHZlNE51ZHptS3ZhZElpbzlsdWREUFdqaTJB?=
 =?utf-8?B?Nm5BWTMzcnl0dWY5RHptV014QjdLazVCS1pYWDZBYkllS2s1VnU4SUJlblBm?=
 =?utf-8?B?SDJJYmptdzFNQUhmUkxlUFU3VjhoaHhZdmQ2c2VOL09pWTJWd1ZUSnZINGRv?=
 =?utf-8?B?N2NqMkk4TW9LN3liNE1lTnFvQ0FNRVBjSEtrdHZZOXIybnlGNEZxa0Q1dm9O?=
 =?utf-8?B?RE4weU01c1dZdXVFM2JmVkcyOVJxZ0ZSK2hXQmdtZDhGTjBtOEd2UldlTjE2?=
 =?utf-8?B?ZGxJanRuaGRQcUdXbGVFWm0xVjBtbWhIeFB6TXQ3STFYNGRpbjlWM3Y2TGRw?=
 =?utf-8?B?dkhRNEpGTVoyZ3VjUnJreS96MFJHdTk1a2lJMnNKWGcyMjY4QkRTOVNRV2tF?=
 =?utf-8?B?TEJmMUNrOWlpbnU1T0Z3SFJLbm9PRStFa3hidndMdmZOazNKdnNLd2QvY3hZ?=
 =?utf-8?B?eHFJN3JWSXZmTnlBZzBoOXJwbzJFWk5KK08wZkZTeW0za2N4SGRieUhwSGlu?=
 =?utf-8?B?ZTFmSHU3MUJXOXRJc2dHRnY0eE5meVdZR0ZWYVFIbzFXN0MwK0piV25aYUgz?=
 =?utf-8?B?ZnAzdFcwRjk4ZDJ0clRIbVVyVXRSdjVSZ1piK3ZvUk9XK1huNDFjNVFMaTdO?=
 =?utf-8?B?c1FlVE1wRmwyVzY1aGN3WmJnejl5bTRUdndLd0pZMHFZWWRCS0ZjTnJvUzFV?=
 =?utf-8?B?a2hJdUorY2xCSHFzQ1JIQW9NMUs0VGt5VWdIOGtQTitSZnYyazJoVzZkaHVR?=
 =?utf-8?B?OVpOcHRobG9XM3M4aEo5ZjVXa3prR3hwWWlnS1F4RGVma2xCM3krWnl1dHAx?=
 =?utf-8?B?b2ovRElwSzAxZHV4RG55NVI5VENmTFljSHpIRDVsSi9iYjUxeFUxeXE4SjhO?=
 =?utf-8?B?NGVWSmhuMEFwbmRSd2Eya2Z4cFhCSjlVMlMyN2F5eWRqV281ZFBHaTFiUFcr?=
 =?utf-8?B?QjNvUmk1U3hDeitEcnRBR21MRVhSdnZqRzNNdnFFOWY2VXdOUFBDZ29MTnpH?=
 =?utf-8?B?bFNWbWJnUVB0ek8zVUxRT0hsc0V4b0ZDb3Riem51c3BJazVqakpaSGVLQWNy?=
 =?utf-8?B?eU1sb0FiVkNGZFhITFJtb1RMcnhNVDF1aTgxRVRmc3JjOHkyRFVyYzRVdUhP?=
 =?utf-8?B?UWF0U09iSnNKR3pvZHBlaXpGbVVTbWUzdnR2WkVxTFZ5RWs5Umt4OHdMeFd3?=
 =?utf-8?Q?xQO9AHDjrzAVaKeKEgVmnH08qpA7lyHsTN/p0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1Fkc0lWa3ZVL3NxSlY5N28yOHFlTExYTWNyOVVoUVRzTVl2ZXdYRVFFVGZu?=
 =?utf-8?B?QWxPL3AwYVpNQitZQXZuUUhEZDFpU3c4U2h5c2I3TmYyMlQzbDB1c08zK09s?=
 =?utf-8?B?OG5DUXRCTWx3QUllSmhBZFRBVzg3NVJwLzlabDk0cnpxcmd4QUwva2VueCtC?=
 =?utf-8?B?M1pYMWFiU1MzNkNkTlJyZkJyNWIzZ1FwQnpNNlM5U3kwNGk3cjE3RURHSnVC?=
 =?utf-8?B?MjlTQWJpc0JRZDFrS0t3UGh4M3Q4N2tTczVKVGs0SDNkaVhmTVVZNGMvTkhB?=
 =?utf-8?B?dFZnWkl1N3g2ampXRWpjaTgyaGcwUEphZ3l5bHAzZlBrTkZ0VmpFZzlVbjVv?=
 =?utf-8?B?NHFkMXoxeE9SS1NURGpYVkJDdVFKb1g0NnNmeFEzREoxMW1QT3ZYTm5TSWl3?=
 =?utf-8?B?SHhURnplTHNIVkh1YUp0YXdEVWhzOTV1V2VEUjNnMU50SG93ZjBJb0ZveTU5?=
 =?utf-8?B?RXA4MWgzWGZmSDc3QzFlazZ1WThYSytBamV6cjlLNDRjUkZBcXN2ZEJvTTFS?=
 =?utf-8?B?Skw3d3k3VEJUb2xpUlBuMFVKUzdaZlJELzJuMXd2ZzRkQWRqeklyZXB5a21m?=
 =?utf-8?B?ekNwSzJVS1JWVSsxQjVWT2VQYmp4cFNSMHZCV3NPZytyRXR4M0ZESjVyeGY1?=
 =?utf-8?B?TkpFZ09tYmc3OGpFSEVEVHNIY1JZYVFIMjRnN1l4WnNXaW1YSmpnQlpUalBu?=
 =?utf-8?B?MS8yYndSWFRmQ3dJcHNrdDZsTUZYV0JsNENVR1F5OEFOekFiQ051U1BJZGRo?=
 =?utf-8?B?ak5QK1RwMkxNZ1dGY1pjYjBrRU9pZ3pCNzBOWW5HOGkvYTBUTnNhampjdTd3?=
 =?utf-8?B?cHdXcVZwckF1c0htYXpQaCt3RmhmV2E1Y09oMWd4M2JmTXpVa0N5eDQ0L2Z0?=
 =?utf-8?B?M2JCYTFwdWJqMFZvQStNK1FuQmE1TkFoUW1rVENmY1pTVnRGL3VjWUNvRklm?=
 =?utf-8?B?SDlLSXZjbW1EYm9WMlNJY1laSks4Si9JL01jbmpWWXh6YzJBbzJJd20zaTVQ?=
 =?utf-8?B?SFhqWXpiekd6VkhjQkdRMkordnhualhySlA5NTd0YndCMTRVeUN2NHhOeEtk?=
 =?utf-8?B?dE1TYUtWMnFpd3h3cjNlT0o1ZGlvdzlNS1lUK0JkUDczeWxtMHNTUzBzRmJv?=
 =?utf-8?B?ZDV6amhjbWpWQWU5MHFNempaLzFMRGFQOHc3ZnA4NmlxUTRvZkZoQlJHbXFp?=
 =?utf-8?B?QjhTS1h1Yy80VEFjeU1GRm1XUW1IQkxiaGJtcHlkMmpNUTJiQS82VG90TDZo?=
 =?utf-8?B?RGJYWHlEWi9idWhkanVsdGZlTENkLzZFUHhNck5BUDQ2SU5kMVpBL2VISlVI?=
 =?utf-8?B?VUNLUE1BN29EVHY4TzI2aXJEdGN2RDdOUXJzTjkxWDdIeFowWUgxdUs2a3FW?=
 =?utf-8?B?Rk1uY3FMNUE1WllldUNvSEZOaythUlhvck5nVzdZeGJUak1kU1AzN1hQYVkr?=
 =?utf-8?B?VndYd0xSdmJYSlR2OHEyMWRqQjhwNk92ay80eXpoS0lla2dYL2g2L2VRYkUw?=
 =?utf-8?B?bzQxb2IxVjk4a3hhb1BmQ1AvZEs3V1lodFROd1B2Q1VvMGZyZC9mWHVEdWNS?=
 =?utf-8?B?Y3JDek1Wb3czVXBrREliWmJMR1E2TzRYSUtzZ3JHQnNPTlhtWEVJQnUva21C?=
 =?utf-8?B?UWZJU2FHaW1ja0FBL3lYYTY2TDA5SHFtSzZBNUtOVERiUHlKTDk1T0ZBRWRw?=
 =?utf-8?B?TS9aelRIM1M3dGJWVkhCZlcyUzRyVkdQVFFrQXNSZTlJZFJwZVZYZlcrY1Vl?=
 =?utf-8?B?elZPQWVPckMvVkNMcmxNd3o0Z3RDK3VQU3VQRjVEWnNLWEZJUEJZbXJURmhE?=
 =?utf-8?B?UmFCazZQMkZPcXl6OWtSUGNGamtxbHZUY2ZJOTBOYkJUSHIzQUV1ZFFpWnZs?=
 =?utf-8?B?QUNqNjZVWFdHM3FiQmU1RDFudEc0MEFMOTJxODVYM2tlSWZGaitQSmxSVXpB?=
 =?utf-8?B?TkNYU0xKNDYyMkFiVFgxRDdidUhsUWhud2VnallCVk16YXdHVGtvbG1KZGtv?=
 =?utf-8?B?RUhkS0Z3RWVyYjdoU2orcGROczRtVWpQTysrM0xCeXdqRFNzY1FlTkxKWmIv?=
 =?utf-8?B?VDUvWEQ2QmpwSWx1V2RMeGRBLzVYQUh4dFBnZE8xUE41dWV6cjlYdVhYK1dP?=
 =?utf-8?Q?cjm0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fa04f5-23e5-49bc-1164-08dcbc2b59cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 06:35:55.5505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/t5tRzXbEmnFzc5n/5Xjm97yXByuj70GG3oqcC8pF3IvwUemBBtxxyfBk/X6gHz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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
Cg0KQUZBSUssIGZvciBsb3cgbGV2ZWwgbGlicmFyaWVzLCBlLmcuIExMVk0sIFJPQ3IsIEhpcC9P
cGVuQ0wgcnVudGltZXMsIGFsbCBHUFVzIGFyZSBzdXBwb3J0ZWQuIEJ1dCBmb3IgdGhlIG1hdGhs
aWJzIGFuZCBmcmFtZXdvcmtzLCBvbmx5IGxpbWl0ZWQgR1BVcyBhcmUgc3VwcG9ydGVkLiBFLmcu
IDoNCg0KaHR0cHM6Ly9naXRodWIuY29tL1JPQ20vcm9jQkxBUy9ibG9iLzI4ODc3ZTVlMTM0YTE1
N2I3ZWE1NmI4OGExYTEyYmE1NTFkNTNjYmYvQ01ha2VMaXN0cy50eHQjTDExMQ0KDQpzZXQoIFRB
UkdFVF9MSVNUX1JPQ01fNi4zICJnZng5MDA7Z2Z4OTA2OnhuYWNrLTtnZng5MDg6eG5hY2stO2dm
eDkwYTtnZng5NDA7Z2Z4OTQxO2dmeDk0MjtnZngxMDEwO2dmeDEwMTI7Z2Z4MTAzMDtnZngxMTAw
O2dmeDExMDE7Z2Z4MTEwMjtnZngxMjAwO2dmeDEyMDEiKQ0KDQpPbiB0aGUgdW5zdXBwb3J0ZWQg
R1BVcywgSFNBX09WRVJSSURFX0dGWF9WRVJTSU9OIGN1cnJlbnRseSB3b3JrcyBhcyBhIHdvcmth
cm91bmQuDQoNCg0KQmVzdCBSZWdhcmRzLA0KWWlmYW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IENocmlzdG9waGVyIFNub3doaWxsIDxjaHJpc0Brb2RlNTQubmV0Pg0KU2Vu
dDogV2VkbmVzZGF5LCBBdWd1c3QgMTQsIDIwMjQgMTA6MDEgQU0NClRvOiBLdWVobGluZywgRmVs
aXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQpDYzogWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhh
bmdAYW1kLmNvbT47IEthc2l2aXN3YW5hdGhhbiwgSGFyaXNoIDxIYXJpc2guS2FzaXZpc3dhbmF0
aGFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWWFuZywgUGhpbGlw
IDxQaGlsaXAuWWFuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDog
a2VlcCBjcmVhdGUgcXVldWUgc3VjY2VzcyBpZiBjd3NyIHNhdmUgYXJlYSBkb2Vzbid0IG1hdGNo
DQoNCg0KDQo+IE9uIEF1ZyAxMywgMjAyNCwgYXQgNjo1MuKAr1BNLCBGZWxpeCBLdWVobGluZyA8
ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IO+7v0hhbmcgb24gYSBzZWNvbmQu
IElmIHRoZXJlIGFyZSBwcm9kdWN0aW9uIEdQVXMgdGhhdCBvbmx5IHdvcmsgd2l0aCBIU0FfT1ZF
UlJJREVfR0ZYX1ZFUlNJT04gcmlnaHQgbm93LCB0aGVuIHdlIHNob3VsZCBtYWtlIHRob3NlIEdQ
VXMgcHJvcGVybHkgc3VwcG9ydGVkLiBJIHRob3VnaHQgdGhpcyB3YXMgb25seSB1c2VkIGludGVy
bmFsbHkgZm9yIGJyaW5nLXVwIG9yIG1heWJlIGV4dGVybmFsbHkgYXMgYSBzaG9ydC10ZXJtIHNv
bHV0aW9uIGJlZm9yZSB3ZSB1cHN0cmVhbSBwcm9wZXIgc3VwcG9ydCBmb3IgbmV3IEdQVXMuDQoN
CkZvciBpbnN0YW5jZSwgZm9yIGEgYnVuY2ggb2YgY29tcHV0ZSB0aGluZ3MsIEkgaGF2ZSB0byBv
dmVycmlkZSAxMC4zLjAgZm9yIG15IDEwLjMuMSBHUFUsIGEgNjcwMCBYVCwgYmVjYXVzZSBub2Jv
ZHkgYnVpbGRzIG9yIHBhY2thZ2VzIHRoZSBrZXJuZWxzIGZvciAxMC4zLjEuDQoNCj4NCj4gUmVn
YXJkcywNCj4gIEZlbGl4DQo+DQo+DQo+PiBPbiAyMDI0LTA4LTExIDIyOjEwLCBaaGFuZywgWWlm
YW4gd3JvdGU6DQo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3Ry
aWJ1dGlvbiBPbmx5XQ0KPj4NCj4+IEkgYWdyZWUgdGhhdCBhZGRpbmcgZXhwX2h3X3N1cHBvcnQg
aXMgYSBzYWZlciBhcHByb2FjaC4gTXkgY29uY2VybiBpcyB0aGF0IEhTQV9PVkVSUklERV9HRlhf
VkVSU0lPTiBoYXMgYmVlbiB1c2VkIGZvciBhIHdoaWxlIGFuZCBoYXMgYmVjb21lIGEgc3RhdHVz
IHF1byBmb3IgcnVubmluZyBST0NtIG9uIHVuc3VwcG9ydGVkIEFQVXMuIEknbSBub3Qgc3VyZSBp
ZiB0aGlzIGFwcHJvYWNoIHdpbGwgYmUgYSBidXJkZW4gZm9yIEFQVSBlbmQgdXNlcnMuIEFkZGlu
ZyBkcml2ZXIgbG9hZCBwYXJhbWV0ZXJzIGlzIG1vcmUgY29tcGxpY2F0ZWQgdGhhbiBzaW1wbHkg
YWRkaW5nIGFuIGVudmlyb25tZW50IHZhcmlhYmxlIG9uIGNvbnN1bWVyIFBDcy4NCj4+DQo+PiBC
ZXN0IFJlZ2FyZHMsDQo+PiBZaWZhbg0KPj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+PiBGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+PiBT
ZW50OiBTYXR1cmRheSwgQXVndXN0IDEwLCAyMDI0IDc6MzcgQU0NCj4+IFRvOiBaaGFuZywgWWlm
YW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsgS2FzaXZpc3dhbmF0aGFuLCBIYXJpc2gNCj4+IDxI
YXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPj4gQ2M6IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT4NCj4+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IGtlZXAgY3JlYXRlIHF1ZXVlIHN1Y2Nlc3MgaWYg
Y3dzcg0KPj4gc2F2ZSBhcmVhIGRvZXNuJ3QgbWF0Y2gNCj4+DQo+PiBNYXliZSB3ZSBjYW4gdHVy
biB0aGlzIGNoZWNrIGludG8gYSB3YXJuaW5ncyBpZiwgYW5kIG9ubHkgaWYgdGhlIGV4cF9od19z
dXBwb3J0IG1vZHVsZSBwYXJhbSBpcyBzZXQuIFRoYXQgd2F5IHdlIGRvbid0IHdhdGVyIGRvd24g
dGhlIGNoZWNrcyBvbiB0aGUgcHJvZHVjdGlvbiBjb2RlIHBhdGggYnV0IGFsbG93IGV4cGVyaW1l
bnRhbCBzZXR1cHMgdG8gcnVuIHdpdGhvdXQgYSBzZWF0IGJlbHQuDQo+Pg0KPj4gUmVnYXJkcywN
Cj4+ICAgRmVsaXgNCj4+DQo+Pg0KPj4+IE9uIDIwMjQtMDgtMDkgMDE6MzksIFpoYW5nLCBZaWZh
biB3cm90ZToNCj4+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3Ry
aWJ1dGlvbiBPbmx5XQ0KPj4+DQo+Pj4gWWVzLCBJIHRoaW5rIHdlIG5lZWQgdGhhdCBjaGFuZ2Ug
Zm9yIGEgbm9ybWFsIGNvZGUgcGF0aCwgYnV0IHRoaXMgY2FzZSBpcyBpbnRyb2R1Y2VkIG9ubHkg
d2l0aCB0aGUgSFNBX09WRVJSSURFX0dGWF9WRVJTSU9OIGVudmlyb25tZW50IHNldHRpbmcsIHdo
aWNoIGltcGxpZXMgdGhhdCAidGhlIG92ZXJyaWRlIEFTSUMgaXMgY29tcGF0aWJsZSB3aXRoIHRo
ZSByZWFsIEFTSUMuIiBJdCBpcyBpbnRlbmRlZCBmb3IgZXhwZXJpbWVudGFsIHB1cnBvc2VzLiBX
aGVuIGEgdXNlciBpcyB1c2luZyBIU0FfT1ZFUlJJREVfR0ZYX1ZFUlNJT04sIHRoZXkgc2hvdWxk
IGJlIGF3YXJlIG9mIHRoZSBwb3RlbnRpYWwgcmlza3MgaXQgbWF5IGJyaW5nLiBVc3VhbGx5LCBI
U0FfT1ZFUlJJREVfR0ZYX1ZFUlNJT04gaXMgdXNlZCB0byBmb3JjZSBhbiB1bnN1cHBvcnRlZCBB
UFUgdG8gYmUgcmVjb2duaXplZCBhcyBhIFJPQ20tc3VwcG9ydGVkIGhpZ2gtZW5kIGRHUFUsIHdo
aWNoIGhhcyBhIGxhcmdlIGN3c3Igc2F2ZSBhcmVhLCBtYWtpbmcgdGhlIG9wZXJhdGlvbiBzYWZl
LiBUaGlzIGNoZWNrIHdhcyBhZGRlZCB0byBLRkQgdHdvIHdlZWtzIGFnbywgdGhlIEhTQV9PVkVS
UklERV9HRlhfVkVSU0lPTiBlbnZpcm9ubWVudCBoYWQgYmVlbiB3b3JraW5nIGZpbmUgYmVmb3Jl
IHRoYXQuDQo+Pj4NCj4+PiBCZXN0IFJlZ2FyZHMsDQo+Pj4gWWlmYW4NCj4+Pg0KPj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogS2FzaXZpc3dhbmF0aGFuLCBIYXJpc2gg
PEhhcmlzaC5LYXNpdmlzd2FuYXRoYW5AYW1kLmNvbT4NCj4+PiBTZW50OiBUaHVyc2RheSwgQXVn
dXN0IDgsIDIwMjQgMTA6NDYgUE0NCj4+PiBUbzogWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdA
YW1kLmNvbT47DQo+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+PiBDYzogS3Vl
aGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgWWFuZywgUGhpbGlwDQo+Pj4g
PFBoaWxpcC5ZYW5nQGFtZC5jb20+OyBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29t
Pg0KPj4+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IGtlZXAgY3JlYXRlIHF1ZXVl
IHN1Y2Nlc3MgaWYgY3dzcg0KPj4+IHNhdmUgYXJlYSBkb2Vzbid0IG1hdGNoDQo+Pj4NCj4+PiBb
QU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0K
Pj4+DQo+Pj4gSW4gdGhpcyBjYXNlLCBzaG91bGRuJ3QgbGFyZ2VyIG9mIHR3byBzaXplcyBiZSB1
c2VkLiBBbHNvLCB3ZSBzaG91bGQgaGF2ZSBhbiB1cHBlciBib3VuZCBjaGVjay4NCj4+Pg0KPj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1i
b3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+Pj4gWWlmYW4gWmhh
bmcNCj4+PiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDgsIDIwMjQgNDo0NCBBTQ0KPj4+IFRvOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4+IENjOiBLdWVobGluZywgRmVsaXggPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBZYW5nLCBQaGlsaXANCj4+PiA8UGhpbGlwLllhbmdAYW1k
LmNvbT47IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+DQo+Pj4gU3ViamVjdDog
W1BBVENIXSBkcm0vYW1ka2ZkOiBrZWVwIGNyZWF0ZSBxdWV1ZSBzdWNjZXNzIGlmIGN3c3Igc2F2
ZQ0KPj4+IGFyZWEgZG9lc24ndCBtYXRjaA0KPj4+DQo+Pj4gSWYgSFNBX09WRVJSSURFX0dGWF9W
RVJTSU9OIGlzIHVzZWQgaW4gUk9DbSB3b3JrbG9hZCwgdXNlciBzcGFjZSBhbmQga2VybmVsIHVz
ZSBkaWZmZXJlbnQgc3BlYyB0byBjYWxjdWxhdGUgY3dzciBzYXZlIGFyZWEsIGN1cnJlbnQgY2hl
Y2sgbWF5IGZhaWwgY3JlYXRlIHF1ZXVlIGlvY3RsLiBDaGFuZ2UgZXJyb3IgdG8gd2FybiB0byBt
YWtlIGNyZWF0ZSBxdWV1ZSBzdWNjZWVkIGluIHRoYXQgY2FzZS4NCj4+Pg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IFlpZmFuIFpoYW5nIDx5aWZhbjEuemhhbmdAYW1kLmNvbT4NCj4+PiAtLS0NCj4+PiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3F1ZXVlLmMgfCA0ICstLS0NCj4+PiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9xdWV1ZS5jDQo+Pj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcXVldWUuYw0KPj4+IGluZGV4IGUwYTA3M2Fl
NGE0OS4uOWYyODNhZmYwNTdhIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9xdWV1ZS5jDQo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3F1ZXVlLmMNCj4+PiBAQCAtMjk1LDExICsyOTUsOSBAQCBpbnQga2ZkX3F1ZXVlX2FjcXVp
cmVfYnVmZmVycyhzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQsIHN0cnVjdCBxdWV1ZV9w
cm9wZQ0KPj4+ICAgICAgICAgfQ0KPj4+DQo+Pj4gICAgICAgICBpZiAocHJvcGVydGllcy0+Y3R4
X3NhdmVfcmVzdG9yZV9hcmVhX3NpemUgIT0gdG9wb19kZXYtPm5vZGVfcHJvcHMuY3dzcl9zaXpl
KSB7DQo+Pj4gLSAgICAgICAgICAgICAgIHByX2RlYnVnKCJxdWV1ZSBjd3NyIHNpemUgMHgleCBu
b3QgZXF1YWwgdG8gbm9kZSBjd3NyIHNpemUgMHgleFxuIiwNCj4+PiArICAgICAgICAgICAgICAg
cHJfd2FybigicXVldWUgY3dzciBzaXplIDB4JXggbm90IGVxdWFsIHRvIG5vZGUgY3dzcg0KPj4+
ICsgc2l6ZSAweCV4XG4iLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgIHByb3BlcnRpZXMt
PmN0eF9zYXZlX3Jlc3RvcmVfYXJlYV9zaXplLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAg
IHRvcG9fZGV2LT5ub2RlX3Byb3BzLmN3c3Jfc2l6ZSk7DQo+Pj4gLSAgICAgICAgICAgICAgIGVy
ciA9IC1FSU5WQUw7DQo+Pj4gLSAgICAgICAgICAgICAgIGdvdG8gb3V0X2Vycl91bnJlc2VydmU7
DQo+Pj4gICAgICAgICB9DQo+Pj4NCj4+PiAgICAgICAgIHRvdGFsX2N3c3Jfc2l6ZSA9ICh0b3Bv
X2Rldi0+bm9kZV9wcm9wcy5jd3NyX3NpemUgKw0KPj4+IHRvcG9fZGV2LT5ub2RlX3Byb3BzLmRl
YnVnX21lbW9yeV9zaXplKQ0KPj4+IC0tDQo+Pj4gMi4zNy4zDQo+Pj4NCj4+Pg0K
