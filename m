Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A28E77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 17:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FDA810E40B;
	Tue, 14 Jan 2025 17:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oJiRVBO2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A9910E40B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 17:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWB1fD1PUhSJUmp9faZkv76yNtKGuWvKnPOJZbheAo4QvXcb9Vo/vMaRa0wWtLoCoCIAJroG0gADi02Yh7IZlL72e1AH2MR2cDROzR/SAy00bqKf9tD0u/it+sQovIbLA4ZsjvqobcFIPL2D7QYh8BRBx1Z3U5YmmYq8Wo/mC/XG6NyYk5zGDegV2JojOvGIRsGfu6HBx8ku7lJxDCG6rTjWTijqeFo0BEbAkfAg4m3LL8/V4o59zACM/a0qEpysMxyrpjSI03Ato6UX4cgti9PHjqS6Xhmya8dbuxZbsEageZ8+bEmDRoCHfcqmb9tAGnIFzEbYbNpEi+MliHUIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF3AMD1on4/ZIF96jRt/DCVRbiuOxkupVOLQhmuXka4=;
 b=thB1jF6ZXHJnvXxvzlpWE06+Mi3/PmViUDDKVGMvFi86UjXjdgsS8TAY2UVLBgz/S2YYfxNBN7MpEjvcivMFloJt0o/lv4LMfUlm6S2gz4EZaSXQmkkH0jANYe1+1WoP8lpzaakwBMWD0mREit7l40GrmN1uxvXtdX5PcdaV94rSMjRotJMv1XOJx/iepdz3+FTL9zJqMfaJWIywEtlKh2gRJOsmLnmhPsLXSPLW37KFCU59BvpOziuBxCk5OtCsWX0IZVonSdILTdHMEYsvH9YO9OWOyA2EW2FPpBZYhbCcEDtqu0jAsN500KsgB1vYSJ5xOXgqMlQnuOlKI/ygBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF3AMD1on4/ZIF96jRt/DCVRbiuOxkupVOLQhmuXka4=;
 b=oJiRVBO2r3iYIHccSiG3miJQuSQEli3B2ab8qfhp0RoVLP/ul05rG+WNtAmX8SXN/ks1FYHth1sWNRe3CczzdL/WkNH7CaBrkGSf7L8aDMHl1z8VOaDDSSzdgw0fdpynskHSsqxnZ5k0Xl/wAjuOyv4vztRXoVdgAIIOM+VFvQI=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 17:21:23 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 17:21:23 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
Thread-Topic: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
Thread-Index: AQHbYggg7TRtauGCh02VRE8z9Mjnf7MN908AgACHIuCAAN/YAIAAy7mwgAALhACAAErsIIAAb5eAgAWbWcA=
Date: Tue, 14 Jan 2025 17:21:23 +0000
Message-ID: <CY8PR12MB7435DC1509E304F279F6145185182@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250108200121.2808908-1-jonathan.kim@amd.com>
 <0ab5d4aa-ac2c-4108-99e5-902f73f827bb@amd.com>
 <CY8PR12MB7435645F2AB787B7BC57BB0A85132@CY8PR12MB7435.namprd12.prod.outlook.com>
 <f7a71dc8-7643-431e-8c92-ade74619ef2c@amd.com>
 <CY8PR12MB743599F7DD753244994863C6851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <9600acc2-b6fc-4c22-a9d6-061250cf75e0@amd.com>
 <CY8PR12MB74358329999D20A4899DA18D851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <fe31a1d4-d137-4d0e-8a63-321a5c365512@amd.com>
In-Reply-To: <fe31a1d4-d137-4d0e-8a63-321a5c365512@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=4b0ff9f5-60a2-4a5b-8f78-a4a76f22cd00;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-14T17:20:36Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|LV8PR12MB9264:EE_
x-ms-office365-filtering-correlation-id: 6a613053-d84a-4045-77f9-08dd34bfdeb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?MXZoV2lKeTRkdnNJc0ZHSTRnc2k3bWU2K3U1T0dzM2RaWkovZnh2TjhCam95?=
 =?utf-8?B?aEIyT2hRaEF6aGdCcUxXTnlLL3hnVEVyRkcvejV0Yk5UZFpYV0wrQ2Zxdnpy?=
 =?utf-8?B?dEFCalV1eVhYdjNweDAxN1FzMW9lbDRtd1lZU010cVJ6emplOC9Yb0RyMUgw?=
 =?utf-8?B?OFdvZk5zK0RYTWVrNDhMaHFmUkd1ZkZVOHhDLytCand1MmxaVU50VG5QeXd3?=
 =?utf-8?B?ZFk1emFReFNUZk9hajRnY01xV09wdDEwNmU3MWVyYWFYUXUzK1BYa0Z4aTRJ?=
 =?utf-8?B?dEovWGdETFVBU3ZGVDQ1WVVzNGxNWEJ3b1dMdE91ZE5DZVVoY0UvQmVPVkdm?=
 =?utf-8?B?UGlJaEU3TzNsTCtSbXdwY2JrVDk1bUFLaHRweHNDK0hoUksyMC9VOGV2NWFV?=
 =?utf-8?B?ZkJ1YU04OUdBdHZDM2M5NEhzV1hJZG1iYml0N3E5dGZhcE9rTXpuemV1azlB?=
 =?utf-8?B?eHN0N2xCQXhJaEp0ZUpzb2w4VjF6OUZFM21aVFRmQWJ4eHpXdDZuNGx6VThP?=
 =?utf-8?B?M1VOd0FzQ2ZXQ1VNVzB5aklUbVJZSXcwenJSa25LMnVtMnp4UFZQY3hWTWlB?=
 =?utf-8?B?TmxaQmg0QXAvWnBiNG5tR09zOElzN21wSDJNSUJNaHdwR3p4c3Z5aXdQWHBJ?=
 =?utf-8?B?UHlSTGxuUUFkR1o4Y0ZFRFNaQXpGbzRUeGl0Y2dHNTJyTHE4azEvNkFETDZB?=
 =?utf-8?B?cWk0UU84U2dJMk1DUnNlUWU0SlFkMEVBL2l3dGN4b0hQckw1enVqcHJmQ2ZJ?=
 =?utf-8?B?UXRVblIzWFhIQU8rUUYvVXVzK282TGNLZDgyRjZ3MnpSaEdpOFg0V1A1TjdZ?=
 =?utf-8?B?YzRrY1lxdEVmYUZ3c0pqVnp5UWFNTlF2eExUbU5hbkJDQlBzWi9VRlc5SE02?=
 =?utf-8?B?bTdIbFgyY0pvcXZCMDdyUjQ0Rml3WXBtcjZ3S1Bsa3o4ZmFsWWlFaEpodzRj?=
 =?utf-8?B?ajJoVWNXTmVjNDVIKzFaK1pVMlVKWTgzZzlYTmtMcDdhYWpoRkxLZ2dzM2hq?=
 =?utf-8?B?Uys3cmVYUXJSYWhyK3FvajdqdjRIM2R0OTB4YXRibCtnWVB0OFlzb2JITnBI?=
 =?utf-8?B?ZnJRVWllZmRodkVnTG9DSVJMcW9NemZ4aExkSVFGUVRHc1M5L3ZobHNZdGM2?=
 =?utf-8?B?OFlzVTZ3VzdpMWhPMFVYYVVvNXdSMTB4S3l3REFtLzI4QnhsS2JIYXRJa0c4?=
 =?utf-8?B?Qys3OU1mQnp3Q0xLRzRZaDlSQlIzUWpPUHJyNHhucFBSV0ZGK2ZzdEUwMW1Q?=
 =?utf-8?B?R2NQOTRBZjJKbHFyQUZycFVEOGpkQi91K2lub09FdWlqZXhSelp4UWhEd1dw?=
 =?utf-8?B?d0tXNGxsckFiSDNjUU1ldXpJUUxRQkRhRmp0dFMrU1Q2MzZmcXpIMERUR1Zh?=
 =?utf-8?B?SkFqdGRKTUVsZGdqQnpUUG9ma3NYbDEwR3RuUVd1QytocUhtZ2FZMXM4dWF5?=
 =?utf-8?B?SFp2aDNJS1M5azlYcjhaenZOdklQN0pIS0w1a2Z2dDVrVWVLaHFSeHhIWTAz?=
 =?utf-8?B?NjNFd1pKYWdFYzhYSGd5VTdYOWUvaUdiVjVtMTAxR0R0QTdYZ2dOQUU3R1lT?=
 =?utf-8?B?Wk9YVHZVdlE3enVmQUE1Q21BYjdlWEttN3V2SGhxbUsvQnlWTlJyaWlSQ1hr?=
 =?utf-8?B?cy93S2d0VWtvS2owSVhUYVdiVDFCWmVqa2lmZ2FTeU5DUTdyWW9WUlRtR1lM?=
 =?utf-8?B?dHlYNVRIL1lPUmZDNTVRVStmRXZ0Ui9jVXdRYlZETE94L1pkcWhlWkp6ejZV?=
 =?utf-8?B?ekNYeVZCL3l5NGNUSElJQXhLVmk3MjU1Mm9JajF5a2dXT3hNU1NHR0FHQ0cr?=
 =?utf-8?B?Zk93Y0I0VHlrSGhFbklWUUUyam5EVSszN0pOQ1U4WmZGRjR3ZzdWOEROT3R0?=
 =?utf-8?B?dDVraEJ4THVZUWVjYXVpNjlZeXNWSEZMWTJRMGlaTExUT3VBbUI2a3k1L3VY?=
 =?utf-8?Q?/M0FWGbtpO4JgAP3K9X3N0V7YtG5yZSp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWZxd1g4NDh3TjVYS3VNK2h2cU4xYTdHUTgxaWdaclpvMDQyZnkvU2Q5d0RR?=
 =?utf-8?B?akR3VDQySlczaFUrOURQY0ZEYnQxN3NnMDA4QkhGeXZvV3FVUzZLRWhXUzRU?=
 =?utf-8?B?OTdwVkIvbFhEbGZFUEJZaWNrVk55Yzh4K2lpRHF6SCtDU0wrOGJjMlQzUlg2?=
 =?utf-8?B?Wmk4enNwdHpGcDBlUnVJS2Y0T0NNbmYwblRLeWt0VjNQdyt3UzRaVklnZXRr?=
 =?utf-8?B?Y0xDeE9MeENUVWxieXl3UEU2R3JlOSszOXhFUUlhZUszdVVGMENaN0dnVmVl?=
 =?utf-8?B?S1picmVLRGx6a1YwQ3lvekI3K3BTdjNwWEg3VDN1bkQra1d1QkVZbW1PNGt6?=
 =?utf-8?B?SzdDdTM2SDhtMVlWdmI3YXBKWmp2UmVWWWxFandvZkVud0h4b1dieFhROHN5?=
 =?utf-8?B?cVI3UGcrMmU4QlowRXFieGQ0UXpDdWJoZENYWEo0UW5Nak55eVZ1djJJaFVw?=
 =?utf-8?B?d0lXd2IxQW1JU24rYzhYNFNsWkNzUE9rL0YzanZCVTlPeDJJMkY0d1puM1JX?=
 =?utf-8?B?TE1DR2NvR2dkc0ZkbVhoZ05aakppWlFNdXVJNXVHaG4vVld5ZmlOR1lVeUNx?=
 =?utf-8?B?aTh5UzZoQ0l1Zm9rMjUvZ0c0Qy9yVWxrOTgrS1ZVaTZXQzhqc1FURi9kdXY5?=
 =?utf-8?B?V3FHV1ZDV3UxRVRZSmxiRG5IL1lXRVlMYWVNRSt4SktvdFFIT0U3Tkpkc3ZC?=
 =?utf-8?B?YU5FTjdZZlJtazBYOTA0RGpxV2p2enVmT2tZbVNkN1VzQ2ZMZ0VLalIzaUdZ?=
 =?utf-8?B?cUFjL1BJWCtJbmJLQi9VWWF6T3VLejhYWXRCZTNUR1dkN0ZlQTBTc2Y0K2U1?=
 =?utf-8?B?bDRFL2gwR1NneGdKVGt4bmVGSU51OXJwSXJBQ2RBNGxYOXpIZnhmL2dmZDZt?=
 =?utf-8?B?SjFBay9YN1grQXFYT2p2c09yNVRjSXNlNDN4MkdYZFJ2cW4xQkx6VUMvNG14?=
 =?utf-8?B?Vm91SEpmWXJaTGNlYUhwQ0NaTG0veXBTcXVVQUhnVXBXSVFONGVmdlhuZzJ3?=
 =?utf-8?B?RDJPUnIwS2xyVlVLV00rZ2ZLRW9Hc1FwbzFWbHFMWkRMVmNvNUFmbnU3cUpH?=
 =?utf-8?B?bzVuNm1rR2N2M09ReVluZ0p4WDZnOGJBUzRGOU5DZGhQTkdxaksvcjdOSUkz?=
 =?utf-8?B?VWNpYm0reVRrRVdGUUMzMHcwa2VVMThYc21HVkdEMENJb1VBUWlxQVA5amYz?=
 =?utf-8?B?Rjk1Z1RULzZXR2tsZGFFTW11UGlaUWRBdDQ4bGhwNVZZSjRNWVlGUlppeU84?=
 =?utf-8?B?bjM5S1JmemVUWkJmSW9VS2oxQ0xoUjF3QWJNS2dTaHFMK2xVR2VFaG0rYjU4?=
 =?utf-8?B?dDB6dXd3SDZmNE1BdUJXQVNKOCtrZmZuNm8wQlEwb1BpNi9HNVQ3V0ovZ1dU?=
 =?utf-8?B?bTVnWWFhdTExaU5rY29CRGNVN0UrenRseFhIczlhOXJxb0Q3cDVua0EvbEVr?=
 =?utf-8?B?dk9UdmQrYnJZanplckhTSjRiYVRyc0Z2MEdYa2JwYTJwUk5USkMwOFdjUHg5?=
 =?utf-8?B?WFhnZ2hLVERjM2F3Um9ZTWMyY00yL2dFRzczTWlXRkpqUmVnd0VGc3hwRjh5?=
 =?utf-8?B?THU1eUczeW5rY01iVUE1UEJYeENIWDA3eVh3UnRRbG8xczIxNStMOXhibS9r?=
 =?utf-8?B?Tm5lSTBHb24vMHJ0eGw2eWZ3RVZ5TisvdFhZcnFwVjNwaG15WWRYVnRpb010?=
 =?utf-8?B?eUU2Nnl5d2wwM0czcVhXc2hlc0kwR1VSN3BveG5ncHM1SG5BcGhKUXF2T3or?=
 =?utf-8?B?OXNrcHdoT0FOUmpQcWUxa2tiVjFnVjE5QUJBd0hZK29LUUpnNW5wQmptREFr?=
 =?utf-8?B?U20xMUhhM0RIa3g1eHR5eDlyQVRCT1UzQUREdVZ4UUE5OFhLZHRjMTBLdFVn?=
 =?utf-8?B?WlRwdno0L0ltMU5nYVN5Yktwc2hZWEtKUitkMnI3N1A1S2xNRkJiVVhVYXl0?=
 =?utf-8?B?VE9wVE9OYnpzdStxQTZTTmplYkwxVW5xMzFuRERaNjhGTWlnR3FCbTBBd3Q5?=
 =?utf-8?B?Rk1lRlJ6bjM2UU95SG5tZHR2cU04aGNraGVhbmxWUFRzaGNMV2lycU9yMndH?=
 =?utf-8?B?MjVBeVZtbm9uQTczWURHTm1VSlJhbjB3czdjWGRERWZNczBkb3orb1RKUTZ3?=
 =?utf-8?Q?IsxM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a613053-d84a-4045-77f9-08dd34bfdeb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 17:21:23.6237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/deoQFUcaKm7peGjqmqebZQQHt4Ntj0BJRqfW/5QALEfRUkDqNZOzy2/ElLIlj5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTAsIDIw
MjUgMTA6MzcgUE0NCj4gVG86IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEthc2l2aXN3YW5hdGhhbiwgSGFy
aXNoIDxIYXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWRncHU6IGZpeCBncHUgcmVjb3ZlcnkgZGlzYWJsZSB3aXRoIHBlciBxdWV1ZSBy
ZXNldA0KPg0KPg0KPg0KPiBPbiAxLzExLzIwMjUgMjo1MyBBTSwgS2ltLCBKb25hdGhhbiB3cm90
ZToNCj4gPiBbUHVibGljXQ0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+ID4+IFNlbnQ6IEZy
aWRheSwgSmFudWFyeSAxMCwgMjAyNSAxMToyOSBBTQ0KPiA+PiBUbzogS2ltLCBKb25hdGhhbiA8
Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+
PiBDYzogS2FzaXZpc3dhbmF0aGFuLCBIYXJpc2ggPEhhcmlzaC5LYXNpdmlzd2FuYXRoYW5AYW1k
LmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGdwdSByZWNv
dmVyeSBkaXNhYmxlIHdpdGggcGVyIHF1ZXVlIHJlc2V0DQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+
IE9uIDEvMTAvMjAyNSA5OjQzIFBNLCBLaW0sIEpvbmF0aGFuIHdyb3RlOg0KPiA+Pj4gW1B1Ymxp
Y10NCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9t
OiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiA+Pj4+IFNlbnQ6IFRodXJzZGF5
LCBKYW51YXJ5IDksIDIwMjUgMTA6MzkgUE0NCj4gPj4+PiBUbzogS2ltLCBKb25hdGhhbiA8Sm9u
YXRoYW4uS2ltQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+Pj4+
IENjOiBLYXNpdmlzd2FuYXRoYW4sIEhhcmlzaCA8SGFyaXNoLkthc2l2aXN3YW5hdGhhbkBhbWQu
Y29tPg0KPiA+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBncHUgcmVj
b3ZlcnkgZGlzYWJsZSB3aXRoIHBlciBxdWV1ZQ0KPiByZXNldA0KPiA+Pj4+DQo+ID4+Pj4NCj4g
Pj4+Pg0KPiA+Pj4+IE9uIDEvOS8yMDI1IDg6MjcgUE0sIEtpbSwgSm9uYXRoYW4gd3JvdGU6DQo+
ID4+Pj4+IFtQdWJsaWNdDQo+ID4+Pj4+DQo+ID4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+Pj4+Pj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4g
Pj4+Pj4+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDksIDIwMjUgMToxNCBBTQ0KPiA+Pj4+Pj4g
VG86IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+Pj4+PiBDYzogS2FzaXZpc3dhbmF0aGFuLCBIYXJpc2gg
PEhhcmlzaC5LYXNpdmlzd2FuYXRoYW5AYW1kLmNvbT4NCj4gPj4+Pj4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IGZpeCBncHUgcmVjb3ZlcnkgZGlzYWJsZSB3aXRoIHBlciBxdWV1
ZQ0KPiA+PiByZXNldA0KPiA+Pj4+Pj4NCj4gPj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gT24g
MS85LzIwMjUgMTozMSBBTSwgSm9uYXRoYW4gS2ltIHdyb3RlOg0KPiA+Pj4+Pj4+IFBlciBxdWV1
ZSByZXNldCBzaG91bGQgYmUgYnlwYXNzZWQgd2hlbiBncHUgcmVjb3ZlcnkgaXMgZGlzYWJsZWQN
Cj4gPj4+Pj4+PiB3aXRoIG1vZHVsZSBwYXJhbWV0ZXIuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBLaW0gPGpvbmF0aGFuLmtpbUBhbWQuY29tPg0KPiA+Pj4+
Pj4+IC0tLQ0KPiA+Pj4+Pj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkX2dmeF92OS5jIHwgNiArKysrKysNCj4gPj4+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQ0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMNCj4gPj4+Pj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYw0KPiA+Pj4+Pj4+IGlu
ZGV4IGNjNjZlYmI3YmFlMS4uNDQxNTY4MTYzZTIwIDEwMDY0NA0KPiA+Pj4+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMNCj4gPj4+Pj4+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5j
DQo+ID4+Pj4+Pj4gQEAgLTExMzEsNiArMTEzMSw5IEBAIHVpbnQ2NF90IGtnZF9nZnhfdjlfaHFk
X2dldF9wcV9hZGRyKHN0cnVjdA0KPiA+Pj4+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPj4+
Pj4+PiAgICAgdWludDMyX3QgbG93LCBoaWdoOw0KPiA+Pj4+Pj4+ICAgICB1aW50NjRfdCBxdWV1
ZV9hZGRyID0gMDsNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+ICsgICBpZiAoIWFtZGdwdV9ncHVfcmVj
b3ZlcnkpDQo+ID4+Pj4+Pj4gKyAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4+Pj4+Pj4gKw0KPiA+
Pj4+Pj4+ICAgICBrZ2RfZ2Z4X3Y5X2FjcXVpcmVfcXVldWUoYWRldiwgcGlwZV9pZCwgcXVldWVf
aWQsIGluc3QpOw0KPiA+Pj4+Pj4+ICAgICBhbWRncHVfZ2Z4X3JsY19lbnRlcl9zYWZlX21vZGUo
YWRldiwgaW5zdCk7DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBAQCAtMTE3OSw2ICsxMTgyLDkgQEAg
dWludDY0X3Qga2dkX2dmeF92OV9ocWRfcmVzZXQoc3RydWN0DQo+ID4+Pj4gYW1kZ3B1X2Rldmlj
ZQ0KPiA+Pj4+Pj4gKmFkZXYsDQo+ID4+Pj4+Pj4gICAgIHVpbnQzMl90IGxvdywgaGlnaCwgcGlw
ZV9yZXNldF9kYXRhID0gMDsNCj4gPj4+Pj4+PiAgICAgdWludDY0X3QgcXVldWVfYWRkciA9IDA7
DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiArICAgaWYgKCFhbWRncHVfZ3B1X3JlY292ZXJ5KQ0KPiA+
Pj4+Pj4+ICsgICAgICAgICAgIHJldHVybiAwOw0KPiA+Pj4+Pj4+ICsNCj4gPj4+Pj4+DQo+ID4+
Pj4+PiBJIHRoaW5rIHRoZSByaWdodCBwbGFjZSBmb3IgdGhpcyBjaGVjayBpcyBub3QgaW5zaWRl
IGNhbGxiYWNrLCBzaG91bGQgYmUNCj4gPj4+Pj4+IGZyb20gdGhlIHBsYWNlIHdoZXJlIHRoZSBj
YWxsYmFjayBnZXRzIGNhbGxlZC4NCj4gPj4+Pj4NCj4gPj4+Pj4gSSBkb24ndCB0aGluayBpdCBy
ZWFsbHkgbWF0dGVycy4gIFdlJ3JlIGdvaW5nIHRvIGhhdmUgZGlmZmVyZW50IHJlc2V0IHR5cGVz
IGluIHRoZQ0KPiA+PiBmdXR1cmUNCj4gPj4+PiB0aGF0IG15IGNvbWUgZnJvbSBkaWZmZXJlbnQg
Y2FsbGVycy4NCj4gPj4+Pj4gSXQncyBwcm9iYWJseSBlYXNpZXIgdG8gcmVtZW1iZXIgdG8gcHV0
IHRoZSBieXBhc3Mgd2hlcmUgdGhlIHJlc2V0IGlzIGFjdHVhbGx5DQo+ID4+Pj4gaGFwcGVuaW5n
Lg0KPiA+Pj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gSWYgSSB3YW50IHRvIGRlZmluZSBzb21ldGhpbmcg
bGlrZSBhbWRncHVfZ3B1X3JlY292ZXJ5PTIgKGRvbid0IGRvIHF1ZXVlDQo+ID4+Pj4gcmVzZXQg
YnV0IHBlcmZvcm0gb3RoZXIgcmVzZXRzKSwgdGhlbiBpdCBtYXR0ZXJzLg0KPiA+Pj4NCj4gPj4+
IEkgZG9uJ3QgZ2V0IHdoeSB0aGF0IG1hdHRlcnMuDQo+ID4+PiBUaGlzIGNhbGxiYWNrIGFsb25l
LCBmb3IgZXhhbXBsZSwgY2FsbHMgMiB0eXBlcyBvZiByZXNldHMgd2l0aGluIGl0c2VsZiAocXVl
dWUgdGhlbg0KPiA+PiBwaXBlKS4NCj4gPj4+IElmIHlvdSB3YW50ZWQgcGFydGlhbCByZXNldHMg
YmV0d2VlbiBxdWV1ZSBhbmQgcGlwZSBpbiB0aGlzIGNhc2UsIHlvdSdkIGhhdmUgdG8NCj4gPj4g
YnJhbmNoIHRlc3Qgd2l0aGluIHRoZSBjYWxsYmFjayBpdHNlbGYuDQo+ID4+PiBHUFUgcmVzZXQg
YnlwYXNzIGNoZWNrcyBhcmUgaW52aXNpYmxlIHRvIHRoZSBLRkQgc2VjdGlvbiBvZiB0aGUgY29k
ZSBhcyB3ZWxsLg0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+IFNpbmNlIHRoaXMgaXMgYSBjYWxsYmFj
aywga2VlcGluZyBpdCBhdCB0aGUgd3JhcHBlciBwbGFjZSBtYXkgYmUgbW9yZQ0KPiA+Pj4+IG1h
aW50YWluYWJsZSByYXRoZXIgdGhhbiBrZWVwaW5nIHRoZSBjaGVjayBmb3IgZ2Z4MTAvMTEvMTIg
ZXRjLg0KPiA+Pj4NCj4gPj4+IE1heWJlIG5vdC4gIE1FUyBpcyBwcmVlbXB0aW9uIGNoZWNrcyBh
cmUgbm90IGxpa2UgTUVDIHByZWVtcHRpb24gY2hlY2tzIGF0DQo+IGFsbC4NCj4gPj4+IEFuZCB3
ZSBwcm9iYWJseSBkb24ndCB3YW50IHRvIGphbSBvdGhlciBmdXR1cmUgSVAgcmVzZXRzIGludG8g
YSBzaW5nbGUgY2FsbGVyLg0KPiA+Pj4gSWYgeW91IGxvb2sgYXQgdGhlIGtmZDJrZ2QgY2FsbGJh
Y2tzLCBtb3N0IGFyZSBwcmV0dHkgbXVjaCBjb3B5IGFuZCBwYXN0ZSBmcm9tDQo+IG9uZQ0KPiA+
PiBnZW5lcmF0aW9uIHRvIGFub3RoZXIuDQo+ID4+PiBJIGRvbid0IHNlZSBob3cgcHV0dGluZyB0
aGUgdGVzdCBpbiB0aGUgY2FsbGJhY2sgbWFrZXMgaXQgbGVzcyBtYWludGFpbmFibGUuDQo+ID4+
Pg0KPiA+Pg0KPiA+PiBNeSB0aG91Z2h0IHByb2Nlc3Mgd2FzIHRoaXMgY291bGQgYmUgcHV0IGlu
IC0gcmVzZXRfcXVldWVzX29uX2h3c19oYW5nDQo+ID4+IGFuZCBhbnl0aGluZyBzaW1pbGFyIGhh
bmRsZXMgTUVTIGJhc2VkIHF1ZXVlIHJlc2V0cy4gV2hhdCB5b3UgYXJlIHNheWluZw0KPiA+PiB0
aGVyZSB3b24ndCBiZSBhbnl0aGluZyBsaWtlIHJlc2V0X3F1ZXVlX2J5X21lcygpIGZvciBNRVMg
YmFzZWQgcmVzZXRzLg0KPiA+PiBJcyB0aGF0IGNvcnJlY3Q/DQo+ID4NCj4gPiBObyB0aGUgb3Bw
b3NpdGUuICBCdXQgbm93IHdlJ2QgaGF2ZSB0byByZW1lbWJlciB0byBwdXQgaXQgaW4gMiBwbGFj
ZXMgd2hlcmUNCj4gdGhlcmUncyBzdGlsbCBubyB2aXNpYmxlIHRlc3QgZm9yIGdwdSByZXNldCBi
eXBhc3MgaW4gdGhlIHNhbWUgZmlsZS4NCj4gPiBTRE1BIHJlc2V0cyBhcmUgYWxzbyBiZWluZyBp
bXBsZW1lbnRlZCBhbmQgd2lsbCBwcm9iYWJseSBoYXZlIHRvIGJlIGNhbGxlZCBpbg0KPiBkaWZm
ZXJlbnQgcGxhY2VzIGluIHRoZSBLRkQgYXMgd2VsbC4NCj4gPiBXZSBjYW4gbG9vayBhdCBjb25z
b2xpZGF0aW5nIHRoaXMgbGF0ZXIgYXMgbW9yZSBkZXZpY2VzIGFuZCBJUHMgZ2V0IGRvbmUgaWYg
aXQNCj4gbWFrZXMgc2Vuc2UgdG8gYWJzdHJhY3QgdGhpcyBzdHVmZi4NCj4gPiBNeSBwb2ludCBp
cywgdGhlIGNhbGxiYWNrIGRvZXMgdGhlIHJlc2V0IGFuZCByZXR1cm5zIGEgcmVzZXQgc3RhdHVz
Lg0KPiA+IEJ5cGFzc2luZyBieSBmYWlsIHJldHVybiBzZWVtcyBlYXNpZXIgdG8gcmVtZW1iZXIg
YW5kIGxldmVyYWdlLg0KPg0KPiBPaywgd2UgaGF2ZSBTRE1BIHF1ZXVlIHJlc2V0IGNhbGxlZCBm
cm9tIGpvYiB0aW1lb3V0cy4gSWYgaXQncyBnZXR0aW5nDQo+IGNhbGxlZCBmcm9tIEtGRCB0b28s
IHdpbGwgbG9vayBhdCBjb25zb2xpZGF0aW5nIHRoYXQgb25lLg0KPg0KPiBCVFcsIGlmIHRoaXMg
aXMgcmV0dXJuaW5nIGEgZmFrZSBzdWNjZXNzLCB3b24ndCBpdCByZXN1bHQgaW4gYSBwcmludA0K
PiBsaWtlIHF1ZXVlIHJlc2V0IHN1Y2NlZWRlZCB3aGljaCBnaXZlcyB0aGUgZmFsc2UgaW1wcmVz
c2lvbiB0aGF0IHF1ZXVlDQo+IHJlc2V0IGhhcHBlbmVkPyBPciwgc2hvdWxkIGl0IHJldHVybiBh
IGRpZmZlcmVudCBlcnJvciBjb2RlIGxpa2UNCj4gJ0VDQU5DRUxFRCcgc2luY2Ugb3BlcmF0aW9u
IGlzIGludGVudGlvbmFsbHkgc2tpcHBlZCB0aHJvdWdoIG1vZHVsZSBwYXJhbQ0KDQpXZWxsIC4u
LiB0aGUgY2FsbCBpcyBzdXBwb3NlZCB0byByZXR1cm4gYW4gYWRkcmVzcyBvZiB3aGljaCBxdWV1
ZSBnb3QgcmVzZXQgd2hlcmUgYSBudWxsIHJldHVybiBpbmRpY2F0ZXMgIm5vIHF1ZXVlIGdvdCBy
ZXNldCIuDQpJJ20gdGhpbmtpbmcgdG8gbWFrZSB0aGlzIHNpbXBsZXIsIG1heWJlIHdlIGNoYW5n
ZSByZXNldF9xdWV1ZXNfb25faHdzIGludG8gYSB3cmFwcGVyIHRoYXQgdGFrZXMgaW4gYSBxdWV1
ZSB0eXBlIGlucHV0IChjb21wdXRlLCBzZG1hIGV0YykgYW5kIGJyYW5jaGVzIHRvIHRoZSByaWdo
dCByZXNldCBjYWxsIGJhc2VkIG9uIGlucHV0IHR5cGUuDQpUaGF0IHdheSB3ZSBvbmx5IG5lZWQg
MSBwbGFjZSB0byBkbyB0aGUgZ3B1X3JlY292ZXJ5IGVuYWJsZW1lbnQgY2hlY2sgaW4gdGhlIEtG
RCwgYW5kIHRoZSBLRkQgaGFzIHRoZSBmbGV4aWJpbGl0eSB0byBjYWxsIHRoaXMgd3JhcHBlciB3
aGVyZSBldmVyIGl0IHdhbnRzIHRvIHdpdGhvdXQgaGF2aW5nIHRvIHdvcnJ5IGFib3V0IHRoZSBt
b2R1bGUgcGFyYW1ldGVyIHN0YXR1cyBpbiB0aGUgZnV0dXJlLg0KDQpKb24NCg0KPg0KPiBUaGFu
a3MsDQo+IExpam8NCj4NCj4gPiBUaGF0IGJlaW5nIHNhaWQsIHB1dHRpbmcgdGhlIHRlc3QgaW4g
aHFkX2dldF9wcV9hZGRyIHdhcyBwcm9iYWJseSBvdmVya2lsbCwgYnV0IEkNCj4gZG9uJ3QgdGhp
bmsgYW55b25lIHJlYWxseSBjYXJlcyB0byB1c2UgaXQgd2l0aCBncHUgcmVjb3Zlcnkgb2ZmIG9u
IGl0cyBvd24gYXQgdGhlDQo+IG1vbWVudC4NCj4gPg0KPiA+IEpvbg0KPiA+DQo+ID4+DQo+ID4+
IFRoYW5rcywNCj4gPj4gTGlqbw0KPiA+Pg0KPiA+Pj4gSm9uDQo+ID4+Pg0KPiA+Pj4+DQo+ID4+
Pj4gVGhhbmtzLA0KPiA+Pj4+IExpam8NCj4gPj4+Pg0KPiA+Pj4+PiBKb24NCj4gPj4+Pj4NCj4g
Pj4+Pj4+DQo+ID4+Pj4+PiBUaGFua3MsDQo+ID4+Pj4+PiBMaWpvDQo+ID4+Pj4+Pg0KPiA+Pj4+
Pj4+ICAgICBrZ2RfZ2Z4X3Y5X2FjcXVpcmVfcXVldWUoYWRldiwgcGlwZV9pZCwgcXVldWVfaWQs
IGluc3QpOw0KPiA+Pj4+Pj4+ICAgICBhbWRncHVfZ2Z4X3JsY19lbnRlcl9zYWZlX21vZGUoYWRl
diwgaW5zdCk7DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4NCj4gPj4+DQo+ID4NCg0K
