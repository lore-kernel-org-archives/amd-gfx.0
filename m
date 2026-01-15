Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9B3D3CCA0
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 02:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D593A10E07F;
	Thu, 15 Jan 2026 02:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RIgUSKp8";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C9F10E07F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 02:14:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIGv4k0aZNAXVPEIYo5DM0gHxAE2Xfe+OvWvcLsa/75nxaKpx0UGLAvyQ1kEyckxnVOMOjJ5wMo/9yHIUojWSkJXvVoneL/GV1e8glCbpCwwEj7A33W4dyrgEH0zLxIZoX4WpSuaSo4+9na7rptrFg5GSt0xN8M+vgyZWvCfzR8S61dyImwJ8Y+aALRsD/72EZiea4fplVC0SOXctqL/lcOowPmB7CHvrglqeEVBVjc0RbxOMwv7qksBd0/4JyafxlkuGAclsHWcrKGKmB1ZHG62Qx2Zbq9zAnlS8vxWaDUtuRmzcqQM/Bg5/Fx+dPLFbbiewi6c7Z1cfHUfy5xYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAeCM7mxGpJSYfsF+dkAGL0DKEoc/yEqzUlRKmMpORY=;
 b=NJC3HXz/y1VjlcHzBp3z6SbaUsxMHWZvykdE41wm9U7itp4awxJutQZavxbEzgMMMjJ3fB22NFtUYECQo5yzdRZ8zq7eAU4meH1PaZo8rnJTApOzFiMYLfzkNAM1sQMLV3aX1mj+QGtUBYKPHB77t7ABBJ1wk883ziT6LdFPn8CiItpN6hX47e04yR4Ntz9sEhNiVuBzgwylUB1oa5/t6R7rqJZUz4Hc18tCEnzF669JMxTjcOmKqh+2fectaWu8kNtgQVkosxYMns4UyFMavkRtE9Qr5CfTUy5MbMKyNuY/9x46Wn6z93VnFr11TeRuJAtYLh+21t2hKGjHwj8Kbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAeCM7mxGpJSYfsF+dkAGL0DKEoc/yEqzUlRKmMpORY=;
 b=RIgUSKp8k1i4mgwssdQWBhCe0d+Cg6TKskQtvLKLaZ6kK0SoaZjoXcIIW4FjQduNT50gA31xWJQIMDW7pEr5+dwvgCJQWJUPD4kcyMIzjLUlLIgmjnoE4IpkL26Qognl05CRBbySIql+aNa2+V5RSbk6vh4BmSHqJ05P6dbjFDs=
Received: from PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 02:14:30 +0000
Received: from PH7PR12MB5854.namprd12.prod.outlook.com
 ([fe80::db49:1b4e:3dda:ae88]) by PH7PR12MB5854.namprd12.prod.outlook.com
 ([fe80::db49:1b4e:3dda:ae88%4]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 02:14:30 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: free hw_vm_fence when fail in
 amdgpu_job_alloc
Thread-Topic: [PATCH 1/1] drm/amdgpu: free hw_vm_fence when fail in
 amdgpu_job_alloc
Thread-Index: AQHchT8UKddLZx3dz0a6C/EMXfbryLVRfUgAgAGHYIA=
Date: Thu, 15 Jan 2026 02:14:30 +0000
Message-ID: <PH7PR12MB5854357F500677690D6E1946E78CA@PH7PR12MB5854.namprd12.prod.outlook.com>
References: <20260114101741.445524-1-Jiqian.Chen@amd.com>
 <d0f9a75c-6e9a-4548-9702-56f69e249501@amd.com>
In-Reply-To: <d0f9a75c-6e9a-4548-9702-56f69e249501@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: PH7PR12MB5854.namprd12.prod.outlook.com
 (15.20.9499.005)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5854:EE_|PH7PR12MB6718:EE_
x-ms-office365-filtering-correlation-id: 4819b284-0ccd-4905-30ce-08de53dbd122
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dUE5ai9sd2xhYWJQdDdsOGRDZi9uTExabVliSjIwSEJVS1FmekJFZ1ZNbWRW?=
 =?utf-8?B?UlJGekNlMjFTWmVXWDY1ZHhNc3ZLRU16YlRYQkcwVG5FQ1NkRytVZWtTSS9X?=
 =?utf-8?B?U3dVeXA3TWRUcHB6elBLaUd3cXNGSUI4dmVUNHBIbmh3ZFovMjBqUFlMTjJn?=
 =?utf-8?B?L01yU0pDSi9tbDR3azFINWVrRkNMRmI2WThuOG1ZYXY4UVh2R3lFZnI4aWNm?=
 =?utf-8?B?TVFYeEwra2ZvZmljeXF6aExaQXNObVY3YjVhTktYMXpCNm9pMXc5aHRLcHZy?=
 =?utf-8?B?cFlGWHRCT3R2alhHdEs4RVBobThLQkZPc0JtMDd6eDRwNEFOTnZnZko0dU0v?=
 =?utf-8?B?eWZqdlA1YnZ2cU05ZVVyd3V1aEN4ZnhGV05YTXM1bG4xcWM2M3ZnR1N4UEh1?=
 =?utf-8?B?TEhRSXZqTVdId2xzTU5kU0JJYkRFQjJRSmJEMXpnZmgzZU9oVG1YQUlTaWU4?=
 =?utf-8?B?YTZsWVhGbnMyeFptYjM2UktmMWE2dFFIeEZxV0x3RnROcUlWNmx2UGJXb0hD?=
 =?utf-8?B?RHFkMUlzdWQ4bGZNcUxCaW1KaGJjTEg1eUJwQUVXczdjbkVEUlRYMXhvU3lh?=
 =?utf-8?B?THFhUTB0TFo5eXJKSlcrdEhTN2VLMzRhZVBnK2JPREZUelZsZHN2ZFBlUEFa?=
 =?utf-8?B?RlFwanZyaDJKczR4aFNBZnB0OXBHSmgxeXdIYnBwZkRiQ2tiYjJFMTBJUURw?=
 =?utf-8?B?VWJiamQyQlpCTG45ZFcvdUt1ajY5OWoyV1B5NmZKY0hKQ0lJaVZhZ3RiSElT?=
 =?utf-8?B?RlNsMVM0bk1vSDYrK1lOVWtWSHJMdVBSNWR4OXd0YXc4UURseCt0RVU4dk9C?=
 =?utf-8?B?enJlb1MrUmRGOGxUanMwQTllK3FETzhLZVZPVFN1cGNjeE9kblByMlZoNWNi?=
 =?utf-8?B?TFpLK1FtQ3ZmRHpNRmR6b2w2QUkvNkxPY3V0UWpZVUE0MGtFclRoS3BqRXU3?=
 =?utf-8?B?emtUQkJ6L29wT2VTSmFsdjljZWVVaWhIMmcvQUpsanZIbGdoOGQxeXdVRlVm?=
 =?utf-8?B?OU1mb2I0S2xHYnV6em45WU5COVVFWUNRTndwOElOY2wwUVJjMEJTWW1zTGJ2?=
 =?utf-8?B?VFdmcHExVjVobElxUW0yMTN4QXMxb2NXclNMSGluYUhmdHU2RDdDZlNCNDBo?=
 =?utf-8?B?eEp1N2p4T0hnTjRsYUtaR0RobnF1MmhJZVpQN3dYYlVZN20rL0ZOVzBWaHNS?=
 =?utf-8?B?ekJReUtZQWk4WjZiVDVXemFsa0xsUG9BR05ZNS9oaUtzRzNhUWNrdHIrLzNa?=
 =?utf-8?B?SXRNai9ZdXBCcFhlN0E2cU9vdGZlV3RuMkpxaFF5WDR3UnZ4MXUrQkNLcWpW?=
 =?utf-8?B?aE5yWDA4ZHBYcENLam5xVm92dmdYRVQ0My9kU2VnRGxnSVk0SGMyTGdLV09n?=
 =?utf-8?B?aDExb01DaUhMRjdIS1BKaGwrcFNMelcwOHF5SGxKdSsrakM3amFRK2RRcGp1?=
 =?utf-8?B?aGVlT29qd29uS2VyZ0RhSWdMTVFIekY5MGhTQStOVXlUa1d5eUJwelJyRXBF?=
 =?utf-8?B?dGhUeC9wd2FuQUs3aHNkdXlvZlVJbWkwaGJmUCtzSzNDRGJJS0tkMkc4NkR6?=
 =?utf-8?B?ZkNaWXJzRVhoT1RlL05DMXo1aHdmaW9kbytZL0dBVm9DYStQWm9NSExXTnNR?=
 =?utf-8?B?M1RmNG9NUnljZDZLb1plc0NFWnFYa3M3YWxKakhuSlQ0d3hwVXVmcEFacjhO?=
 =?utf-8?B?TTg3TW5NRXgxd3h5bWxNMnkxRUlVZW9RdGFiaTlFbDd5aUtTNjg1UVNzeU9l?=
 =?utf-8?B?Rld4UWY3OWlmSTVzaHFyaU5vaVpLeEZEdTlUVjB1U09LQlBsQWxKL0JmMlhj?=
 =?utf-8?B?dFdQRXRvMTRCWlU5cXFyZ1cvQjNSamdmeEI2RG13emp2cE1iaS82aXNYd1dY?=
 =?utf-8?B?OE5EOWY1ZDZLWXVqeU90bW9JMklwVVN6YnlGUmRPdkNZU3l2eWRuaXc4aUw2?=
 =?utf-8?B?L2NnZnQ0anNMc0xmeXVJZmw0SXNuMCtXUmQxYURyZDhIa0xCZGpLeXMxVXcr?=
 =?utf-8?B?dGc4eTZScktkZkJwNEdsS2dXclJNNzVqRmVSTXN3NnBTcU9DWTZJY2ttSk9F?=
 =?utf-8?B?WEVWdGJNeFNjUGlUS1l0NDBBUExUaUdDOHpVQzdpSEhiZkEvc2FwbUJTNWs0?=
 =?utf-8?B?WWkzK0hyV2srR09ONjFPODhjYndDTzF2Tk1uZ3g3VWJPT1dPWWVrdWRwNU9K?=
 =?utf-8?Q?zchDaNO2ARKzFEXKvtPo6fA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUNidkxKZXR6NTU0cFBodWxjamF5c3dCaGhIL0VUeUxDTW1ZanBLT21HUWhh?=
 =?utf-8?B?bHA2Q3NmRnRPSXIvcTZPOWZLU2lMSmVBdHNycEVNVzNJYktqczAxa3kwamFL?=
 =?utf-8?B?UUR0SXdjWTdLZkdsYnJkZFhyT09zc0RacU5odHQ3bjNmS3BNaWhVdml0bjNF?=
 =?utf-8?B?R3NWN1BRQW03ZDhVQXA1dDhObk9WU2phcDRkb3dDSkt0aUFGZE9pNjVUQ3ZT?=
 =?utf-8?B?YkRzdFlSOVBldmgxRDc1UU52YmhJeU1Oc0VjZGJHME9MOEdzMGlIWklzbWxx?=
 =?utf-8?B?RVE2bHZzUzA4TGx3N0VNQTFBNlVudDV1d25na0NyYThpZlIzSGgvSmFXZW0z?=
 =?utf-8?B?di9ja3BGRDB4dlkweThlcEtzRCt1OGNLNEtyWTVWYk5WbmRsS1BGT0FTTzJT?=
 =?utf-8?B?Z1VLS25rb2lSZjJsL1ZaWmV1c0puZ254eXVsQ01pcmNLSkNrMTRCOENwcEN6?=
 =?utf-8?B?MDMwS2tsSmFFUFZDaWlXUlpyeEdCeEF2ODQ5S2FyTzhpTTBJbUxPQnZmOWhn?=
 =?utf-8?B?VmxGNUg5VG85RlVQZy9pczRSSmtFeDZOL3h0KytxeU5ncGYvdjExWVAweXlq?=
 =?utf-8?B?aDh4S3FzaklXSlF3emtZTGNTMVZjTHlKZ0E3OUh0ZmJuSCtzU2NBZWJoZC9k?=
 =?utf-8?B?RldLUG0zaUtwamJ3ZDYzbWx2NFkwUUswcUU2RUh0aHFQRXI5R1UyZGt3dWF1?=
 =?utf-8?B?eDdzQnF2UEJxaGtlVHpvWHBPSGJwb0w5RUQvNGczdTFPNkU2UHJlbURiUC9p?=
 =?utf-8?B?R3ZjRktXQzF6ZXQyWWFuYkFHMGEyVGczQjZ4N2NNUDhpYnROQVhQNlZ4SkpT?=
 =?utf-8?B?NldTd1pTQ2hiL01nTzg3dWpzcy9HbmxmOGRKUVprdWVYN3NKR2pOVWNjdFV4?=
 =?utf-8?B?cGZCZmoybEhsN25GblBZaTR4R3RQY2pCYVdNQmVtTVFFeU1MSXJ0RmI0MWRP?=
 =?utf-8?B?UXJDQ0dWVjZQcW9YOXJDWEFPSklYekQzV3FYZHF2VitHK2VvQ0JWd1VDQ1BB?=
 =?utf-8?B?ZkcyZk84dmpIbXVNbEM5cFRRQlFxcDQ5NzQzK3AwZkIyWDIxa3MyekRycUN3?=
 =?utf-8?B?ZDJjNlA1YXR1R1BoNVQ2aXdHN1FacGRRbUhNM0lvUHU0czFOQ0dmOHBmSHJ3?=
 =?utf-8?B?cTBiUXFOVlREVDdzaXNIdGVlZHpXMVpRNklreEpOT3dhbGx1ZEJYYlI4TFcw?=
 =?utf-8?B?dUV0NlY0ZjkvandzMDl3ajJwTUp6aEdkd0h4cStMRkcwVURKTldPTS9pVHd5?=
 =?utf-8?B?aDN6emlZRTNFRmRiWTcrZFhXcUhXcTB6RDhuclN2K09Fc3Nid2tCcllKUUZV?=
 =?utf-8?B?SGtMM05oV2dRbFI3MENSdmgrNVhORWhWc1duTWxXZ2dSeVJzT21KNkdjY2NC?=
 =?utf-8?B?WjhTNUdkbS9DN1RlaGp6bk5sUGNDOXlFcUhhVGs3azJ1ZnM2WlNWWStZZVht?=
 =?utf-8?B?UmtYK2prTnJCRnMvUjd1Q1piMG5sVFJtSUhkS0F2Skgvazd4dUxMNjFqWjZ4?=
 =?utf-8?B?NWllM25IUnhwTWoveVovd09iaDFZWUNiazl2MmpGU3lGZGV4b21OeTAxeVNL?=
 =?utf-8?B?aXRvVUZpNWVNdVIxczdPejd5elNOMEJvZ3k5QnY1eW5DenF6bEl4RmNWeXFH?=
 =?utf-8?B?SVl1SVIrSjJmREtmRnNaOFNZSXlERUhhc1VlVmJaWUgzZ2lnTzZlNUtteFgz?=
 =?utf-8?B?blMvYnU3TUZUVkNRU1FIek93clpEc2lKZVF5V3doV2NMaFZTajM0SWNhK3RK?=
 =?utf-8?B?MDdvSFBWNHBCNUVBZnNDUCtxOXBGTnlKTllUbkphb0FuaDZQZjFVZHNTUWI3?=
 =?utf-8?B?dDRzREJ3SmJkb1RHeGE2WjZnSFZXZGdnUjNvVXJCUUFqUEkrUGxkeVVhQTIz?=
 =?utf-8?B?UXFPbHJqSUZMaXk1b0t2M2tNeU0vbUZQTWg5QUJQK0xmMzhIRXphVGgxaXh1?=
 =?utf-8?B?KzBYRFhYaFBadzFONUwyVThIVFcxbU1iOThhSWl3enlzUVFseDdUTzBKYU9J?=
 =?utf-8?B?bmpVb0dnQlZCNHo3MlRveGovQlZieGUycklKb3pJTDZmV1phK3RJZGM3V0Nz?=
 =?utf-8?B?VHlMZzhIZnNIa0FOTERWTFlSWFFIRXk4K2JpQzNJNVc0ZHpiT3J0WVRvRVpK?=
 =?utf-8?B?cWhhWmZKdjdaQXF6QVhSclNnbUdtMkZUS2FvVkJBWXB0cmNNd09JQ0VzMUV0?=
 =?utf-8?B?R05jZHhkNWM0eWpWaS9hU09ZeTZtdiszS1duMEE4ajZTcU5lZ1Z0dkNGYkVD?=
 =?utf-8?B?RmhGN0l4MlRHNkZTY0VJR0lXcDJwUy9qTjhoVkpOUFZvS3JPOE5VdE94M3RK?=
 =?utf-8?Q?Hdl3K6umRIhtiGsZvr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5191331BFB7D6E46B9817A9DF44850A1@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4819b284-0ccd-4905-30ce-08de53dbd122
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 02:14:30.4470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZt6rwe7wvds0KSDCohxb5MrxdoqatMEOfL4n6br2CI4+5JEY+a+i2BIH0ALqt512YS4ooWX8d8oZbBDL+so7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
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

T24gMjAyNi8xLzE0IDE4OjUyLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiANCj4gDQo+IE9u
IDEvMTQvMjYgMTE6MTcsIEppcWlhbiBDaGVuIHdyb3RlOg0KPj4gSWYgZHJtX3NjaGVkX2pvYl9p
bml0IGZhaWxzLCBod192bV9mZW5jZSBpcyBub3QgZnJlZWQgY3VycmVudGx5LA0KPj4gdGhlbiBj
YXVzZSBtZW1vcnkgbGVhay4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKaXFpYW4gQ2hlbiA8Smlx
aWFuLkNoZW5AYW1kLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9qb2IuYyB8IDYgKysrLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2pvYi5jDQo+PiBpbmRleCA3ZjVkMDExNjQ4OTcuLmE1ZDNiMzUzNTNkYSAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYw0KPj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jDQo+PiBAQCAtMjE2LDExICsy
MTYsMTEgQEAgaW50IGFtZGdwdV9qb2JfYWxsb2Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IHN0cnVjdCBhbWRncHVfdm0gKnZtLA0KPj4gIAkoKmpvYiktPmdlbmVyYXRpb24gPSBhbWRncHVf
dm1fZ2VuZXJhdGlvbihhZGV2LCB2bSk7DQo+PiAgCSgqam9iKS0+dm1fcGRfYWRkciA9IEFNREdQ
VV9CT19JTlZBTElEX09GRlNFVDsNCj4+ICANCj4+IC0JaWYgKCFlbnRpdHkpDQo+PiArCWlmICgh
ZW50aXR5IHx8DQo+PiArCQkhZHJtX3NjaGVkX2pvYl9pbml0KCYoKmpvYiktPmJhc2UsIGVudGl0
eSwgMSwgb3duZXIsIGRybV9jbGllbnRfaWQpKQ0KPj4gIAkJcmV0dXJuIDA7DQo+IA0KPiBUaGF0
IGlzIG5vdCBldmVuIHJlbW90ZWx5IGNvcnJlY3QuDQo+IA0KPiBZb3UgbmVlZCB0byBhc3NpZ24g
dGhlIHJldHVybiBjb2RlIGFuZCBjaGVjayB0aGF0IGluc3RlYWQsIG90aGVyd2lzZSB5b3UgcmV0
dXJuIHN1Y2Nlc3Mgd2hlbiBhIGZhaWx1cmUgb2NjdXJyZWQgYW5kIGp1c3QgY3Jhc2guDQpZb3Un
cmUgcmlnaHQsIEkndmUgcmVhbGl6ZWQgdGhhdCB0b28uDQpXaWxsIGNoYW5nZSBpbiBuZXh0IHZl
cnNpb24uDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4gDQo+PiAgDQo+PiAtCXJl
dHVybiBkcm1fc2NoZWRfam9iX2luaXQoJigqam9iKS0+YmFzZSwgZW50aXR5LCAxLCBvd25lciwN
Cj4+IC0JCQkJICBkcm1fY2xpZW50X2lkKTsNCj4+ICsJa2ZyZWUoKCpqb2IpLT5od192bV9mZW5j
ZSk7DQo+PiAgDQo+PiAgZXJyX2ZlbmNlOg0KPj4gIAlrZnJlZSgoKmpvYiktPmh3X2ZlbmNlKTsN
Cj4gDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQoNCg==
