Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A753C25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 12:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99DB010E47C;
	Tue,  4 Jun 2024 12:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5IfzY0SA";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8188510E47C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 12:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itc4k/FyswnVI3tcxsyvWA7tD0vPP6Lc1qQQgtWmLQ7Ued/IpPXr1UmcbyV0Mqa8zejnx3EaPGdtu+7iKy48+uUWU88L2lVg2OHaC71Nw2FcXqrG0OPcP5d5gDjJ8+8tCNcrnHj1r/9BqP/FOEKHQNCOVxtbdBUo+eoJaaCMiPEdicqT9VJFP7wx6Dz48Oe+JBz9v+vPHTawH/0t9C+/bgIfuDW1hzmbiiZThN3kuetx1aggFIZ7oqBfEbsfs4H/hEwQwFGflYx/RYJ/qYP3bDphN11A8tIGBR+iXmtlSSxyfMcR9v9UI3gikaA/VEQ++S0LHVNjSz7NwNUdWgM9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnKvUXlxXK+bh9SfyG2oU0abV5ff+Ib4ykMNPyL+4i0=;
 b=Kiupa+XfoU+Ir63GLjeNd+uQHsEOX9m8a//0iOItR068XVqUst27fcEIWWyV0VjwAx6AH6+hzT7jaDUGts1m7E4mi9XojuC214XFKTWJ6CBo49Ck6AhAFWHDlCySAbbVDvh/FdU53xDfjH92VohEV2EAGtRvXMVouZuqAcJM2QHVSekzuZ1Lbn59YrkmBdUIyRa4FgdodFXI9/+kmknd4U6zdshn+LhCnHO/06pjSjU0VLUnqX872FZHCQGHMzhP1vnFMzDD/pANgJQFfEzoKsW0fHBMTX2yQKxqImDIt90eYt4LZvQPNzGjdh1xcpXuKgAQ3G0NKymJIV8Y6GUiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnKvUXlxXK+bh9SfyG2oU0abV5ff+Ib4ykMNPyL+4i0=;
 b=5IfzY0SAiJ3t5sa7Ac4AL/C6rkScvMlZ2i06AlThUQMpI76PjVBVqBvPgylhOVmc/7lUQxu/6VsrszRrHdVi84Pu1TBmMQNVYDiSVLP7Y1V64lNKg4GlRDxuUnQVxit6R0Z3AGDFj3QXRDMg8BlMZ6a7eXX7y13NWEbQxkIbuDI=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.37; Tue, 4 Jun
 2024 12:52:39 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 12:52:39 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH v2 09/10] drm/amdgpu: fix missing reset domain locks
Thread-Topic: [PATCH v2 09/10] drm/amdgpu: fix missing reset domain locks
Thread-Index: AQHasSPnfnkU4y0qpE+6/oMQ8ECeVrGwV7mAgACUEoCAAJWtgIAGFumA
Date: Tue, 4 Jun 2024 12:52:39 +0000
Message-ID: <SA1PR12MB8599D4E6A88DC5729FE9FFC4EDF82@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-10-Yunxiang.Li@amd.com>
 <29490f15-eb5f-4438-bfd7-ffdebff6e678@amd.com>
 <c848dcc1-0816-4c2b-bc87-8d5918046cd7@amd.com>
 <4758e38d-09af-495c-b10b-d54ed908514f@amd.com>
In-Reply-To: <4758e38d-09af-495c-b10b-d54ed908514f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4d04c5a3-56e8-4e16-bf99-2ce8ca75d3a1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-04T12:47:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|IA0PR12MB7776:EE_
x-ms-office365-filtering-correlation-id: f1119dd6-8a5f-412c-d102-08dc84953779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TUlRNzc5UDhVWjZ4elNDMklUYW4xalpLZXliYmZZeXFBV0JwbGRvdUp6SGNS?=
 =?utf-8?B?QmFiWnUyNGlFU3oyVG5sZURyRm90SGY1ZVFzZHh4Rjd3UFhVVDFoUytRb3Bi?=
 =?utf-8?B?bW9lbTBhbnhleUQ3KzMrYmhZSlFheFZ1OTZtb2JUcSt6a2dNTkhKTlRaQzlS?=
 =?utf-8?B?Vmp2ZDZYWlhGVTZVckRlQWt4YzFJUEJaRmJ5ekdhaG1xaW5oZE1QeHhXSGhX?=
 =?utf-8?B?RnJpbGFld0gydngzUVQ5dlVQc2p3ZUxERHpsRUM0bGl1K1V2UlYralVGR1J4?=
 =?utf-8?B?TXBhSkRMNHIxMTFwOVoxbmtqMitIMlJVQklRVGRnbnVvdXd6a0xuYmlBZHlO?=
 =?utf-8?B?SHpkZEpaRDRlbXc0YlFrMmE2cmhRTTY3OUljbmZ2SDVvNmJXNFF0d1Vjd2tj?=
 =?utf-8?B?Q1Izb0E3eEFZN1ZJUzcrMUd4OG16S2U1SUZYbEEvRDA2SG9JTDkweFB0b0wz?=
 =?utf-8?B?QkRLZGtXV1ZVZEFQdlEwdEtVR2tuczNtMVJWQlVSZVB2YjZaN0hhTDUrMFFO?=
 =?utf-8?B?YlhjSTQ2YktJSThjMFZCazh0M3hzVWlrRDlOcGhuaW5rSVZLMlR4V3k1dGho?=
 =?utf-8?B?Z1R0bC9tNktmeWNyRUc5MjBnUDZnR1poNHNORmhwdEMxS3RpTW80bjY4OHAw?=
 =?utf-8?B?cEpQbHdLT0JYbnVvMDVwY2Q0UmU0L0ViNGtRekRoYm1nTVZKZTlmRC9KemxJ?=
 =?utf-8?B?OCt2SjI3clFrYm9jMjR6YlZubGZHaVc2MEJnL3NRVm9PUE1jRysyTzF0MEM2?=
 =?utf-8?B?TkRQZ1hQTVBOaitEUlNPRlkramo5MXM3amdLTVEvQVJwMm1GRDBaVkFCYTZP?=
 =?utf-8?B?TlV1UktMcDR4NDRudGpQNFZzU1lNSGN5MWZYNThuM0FUSHFjWjVSelVtWUdz?=
 =?utf-8?B?bjFqS2RhWGhWQWhHeFJaeGI2eTZ5azdEMjBIc2RZSDRLQWxGK3Z2Y2tLM0k3?=
 =?utf-8?B?TGg4aWFzd202SnNWdFZoNTdPMENsZWZkbnBlbzlXdlltYkw5ZVFMdVhjWkh1?=
 =?utf-8?B?VXlLeGU2VncxWjdCZVRtTVJGaldQQk5yelNoaWgwY21tRXJRd3poZWNIMVVj?=
 =?utf-8?B?eGJxeFdDbHUyTHoxTXI3bnRPbWs0UUhsTjRlZUZvNEpOaDcrSHFPaEhwWm96?=
 =?utf-8?B?OU16S05BNjhqRTZZV3Q0UDhXRzhpaFlIVUZoNHRIeW9HekxLeTlzRitoQkNE?=
 =?utf-8?B?Y3VyMmhOS1JVdjh5NmhEbnI4UXd6NFdrcEhZYlNmdytSb1d1Vm5wNG1Ma3Ix?=
 =?utf-8?B?SmVzMTJORnNPUnhlNTFoSDVlQ01aSWJyOWs1a2NJOEhDSU92Y3llZStrWHRM?=
 =?utf-8?B?SEZMclJHWmYwbjYyV2VjdFVJdGMyWFNVZDZOK2YxUGZoaWNLaVhKZXJLdjIy?=
 =?utf-8?B?RDBibnIzblc1RXVLRUdoYjBpRkl4MjVmSHV5ZG14T1N3c3FqWmEvOHhqb2NC?=
 =?utf-8?B?U0cvZDFoTlRYaGN6MVBCcG52T3phQ2o3WjJFTUMxOUNhcFFFNEU2VHc2T3NZ?=
 =?utf-8?B?MlFJRFpsNkdTOGlYNnpIeUhIU0xaOU91TlNzMVVabXh1Z09TVDBoblNhRjBy?=
 =?utf-8?B?VTViaGlVanhUbnA0SHRKZmdNS0N5UWV2TW9ZUWMzV2luWmRmZWROY3dXdUtj?=
 =?utf-8?B?WUU4b3lZTkpnQ0VabDhTMFJYZUZBM1FxcFZaSG84ck1DRStySDVFSWNTZmZu?=
 =?utf-8?B?TFFhYWdiUENLQXhlRk1TK2NlRFFKbTkwb1g4NWIzSTk4ckxGNTE2dkJLdU5t?=
 =?utf-8?B?M0lMUXlreHF4OThGUDlKSlExdmYyRUVDQ0FMRlVDOG5rNXd2aW9FWDlIQnJ5?=
 =?utf-8?Q?YCg0DlmgqLvegkGBbmBqCU/+WZA1yslQPCvg8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajdzdU50SVBleEJPMTdUeXdhVlRqMlhYQXlZYkFnMk9DTjdVZyttTzlIMjc2?=
 =?utf-8?B?TTNscEpreUlQMGd0eitLYjFaUHBxTXBHODRCejJ1VjlCTG15U0wwVXAvUnMy?=
 =?utf-8?B?NXFycjdEU3RPdldieWJPSzRRZ0U0a01NeDJEejB4eXVveGR2blBhNkJZbXIz?=
 =?utf-8?B?enJERS8zU052ejQyN1llSkhTSkpocjRFU2kwMDBtWXMrZnpUVllURFNEd1hP?=
 =?utf-8?B?Qjk1Uk42YzcxZzd6aFpjZmlBZExzSjVFSFArT3pnd0s2WGpzT3J1bVpYdDho?=
 =?utf-8?B?dkdzekJGVVFJSFBkSUlXN1praUJZMkxJV3ZmVzRWOU1HOE01Z29PVlpKYTc1?=
 =?utf-8?B?azNtSDJzeTFZbXVsRmFkSmpqV3FuVFNXbjZsRjZvMEdQZkZhc0lJQXBYYzAr?=
 =?utf-8?B?WVlaVUFwdnFacDdGR2VVaDBnWHpHTjhHSUhMZHZsZjM3L2pHaEhnOXpxRncy?=
 =?utf-8?B?MS8vUm02aUMrS3l6QVRNbWs5dm40ZjBER2dmdlRVcmpZa1A4Z1gvdmlaTnNE?=
 =?utf-8?B?eUdFYVZCdStYWlMvUk5kTzlCeUYrdld6QjdBWTNReVZJeEFtZVZVRjNvNzlL?=
 =?utf-8?B?TWpMaE5FR0phMnpESk1zbVk0cmo5bWgyeFovSTVKNElWNGd3a1Y5enpwUlRm?=
 =?utf-8?B?L1ZDU0hocEN1Y1JlUWptMDhiOXJTa0JtQ2llempJeXhqckxKMjZFNzhTeW1n?=
 =?utf-8?B?Vk5CNWxKOXVWRmc4WVpHL1dXalpSSG5MTU04Z2hvVzVmMC8xZVQvVFhEd0ZY?=
 =?utf-8?B?TmlVNHJGbGpXOVJUbHhDZGlGU2d6Y0t5MWtCTVR1WkhKUGFiV2dWdjhDVnNT?=
 =?utf-8?B?VWxIMStOSVhzRlJZeG8xZ3dKcU5sbmUzdzhHOXZraFl2c1BodzRTbXIvVjNI?=
 =?utf-8?B?ZUt2bk9DZ242YjJSeUtRY0d3SnpzWkptL2VyaXpKUmwyMlpRd0pKRWtVKzd1?=
 =?utf-8?B?cy8xSW9lVktHcGRkWjBjYzZYZzBTQjdScVVmOFp4Mm52TER3T2xFbERsUzNE?=
 =?utf-8?B?TFVWSUFuZnNZbXp5NWpScnpJVzljUHpWK2p2UjYwdWVtM0g1QnJ5TWE5dzZI?=
 =?utf-8?B?ek9KUndDZm9WdlBEd1RuZ3pUQVZzMC9GMzVtcjdFQzhhaDYvd0tuSFRWYjNC?=
 =?utf-8?B?WERzUXhtSWttbERLLzVKcjl3UGUzSjU1QWVDL0g3Z2t5elNNWTlDL3NxcHJx?=
 =?utf-8?B?SnMzb1RvR1JjdHFSVU55SzRRMXpiU0VQODlpNm9zQjRxTHNnblNuNFJmQ1du?=
 =?utf-8?B?R3piUit6dWEraHZ2U2lzekhVT2lGWlUwUFhQV3NtcERsQ2xGS0s5RTBwR3R2?=
 =?utf-8?B?Q3VDTlVsMXpyNDY4MWI2VUo4S3BqNFFKdEVPcTRBeXlJVjRJUzJyUFNTWWJt?=
 =?utf-8?B?eGp3WFBvNjBiRW9TeGxEMVRBNlRTbjB6MkFNRm16YzY0MU15TUwrOEkzZzJJ?=
 =?utf-8?B?SmttQ0tCV0ZRV3IzOTRaT0RuVEdmMXdwRzNhRElCQlprb1ErU3RONlhBdjc3?=
 =?utf-8?B?Ky91cmZpbWh5TDMrRXM5S1RmTGk2eHliNTVJSXA2MFdGZHJlWjFHaW53N2Nj?=
 =?utf-8?B?OXNXaEFuU2hHcGtVUVFOUVRTcU1kNWF4cVowQWxraERPMld4NVZIWmtzWUxs?=
 =?utf-8?B?RTNiNkQ5Rnp3eXdyNW43RkZlRXQ3TFFqaUZmWXo5N3ZXSm9OUVo1WDJDWEJK?=
 =?utf-8?B?UFJSeFNsOW1NTVpwNlc5ZGhJSWdVSkl6TXhlVFlqWDlPcDJTZFNqR0M4TUVR?=
 =?utf-8?B?bHdQM2JUUnVBdC9XblZXb0VtRXJucEJFQlViOXN4QUhPWlFFYnlVZXJxMEZ0?=
 =?utf-8?B?eHRKeTZrMXEzOUErVWp4THZpVS9PWkNhTURMY1VyclpzcG80TmR6TG9hWGNx?=
 =?utf-8?B?S1d2Mzc2QXZaL3EvdnZ1YmZESmdGRW9tckhMYVMrb0RoWGlEbFptaHFrY2J4?=
 =?utf-8?B?b1F0UDlPWUI1cGlVdmJGVk5KVUd3NDJPS0o4TkViaTZsTVlhZThRTGc0TXho?=
 =?utf-8?B?cS9SbHQ0b3pkaVk2djVmaFFwWWt6NEpBVGd0N0JkaUhETWhvb3JQZVBQaGpp?=
 =?utf-8?B?TEpqMTBpa09mWkQ4UFdUdTQ2WDZVenpweldIeUR6clU2RlNLRjJsSmh1Q283?=
 =?utf-8?Q?Ptg4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1119dd6-8a5f-412c-d102-08dc84953779
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 12:52:39.5206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3HE1AZ6OUy5TSPrCmCDLpUKQ0DcLQkkBF/l6VBT9L3zyBt0/3vEzFWpJZ4I9rrezFlUsskENY4jT4SjX/S6BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
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
Cg0KVGhlIHRyb3VibGUgd2l0aCB0YWtpbmcgdGhlIHJlYWQgc2lkZSBsb2NrIGluIHRoZSBNRVMg
aGVscGVyIGZ1bmN0aW9ucyBpcyB0aGF0IHdlIHVzZSBhIGxvdCBvZiB0aGVtIGR1cmluZyByZXNl
dCB1bmRlciB0aGUgd3JpdGUgbG9jay4gU28gZWl0aGVyIHdlIG5lZWQgdG8gZHVwbGljYXRlIHRo
ZSBoZWxwZXIgZnVuY3Rpb25zIG9yIHdlIHdpbGwgZ2V0IGluY29uc2lzdGVuY2llcyB3aGVyZSBh
IHJhbmRvbSBzdWJzZXQgb2YgdGhlIGhlbHBlciBmdW5jdGlvbnMgdGFrZXMgdGhlIGxvY2sgdGhl
bXNlbHZlcyBidXQgdGhlIG90aGVyIGhlbHBlciBmdW5jdGlvbnMgeW91IG5lZWQgdG8gdGFrZSB0
aGUgbG9jayBvdXRzaWRlLiAiQWx3YXlzIG5lZWQgdG8gdGFrZSB0aGUgbG9jayBiZWZvcmUgYWNj
ZXNzaW5nIE1FUyIgc2VlbXMgdG8gYmUgdGhlIGxlYXN0IGJhZCBvcHRpb24uDQoNClRlZGR5DQo=
