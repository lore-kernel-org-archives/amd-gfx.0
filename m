Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B206CC4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 00:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E8C10F957;
	Sun, 28 Apr 2024 00:31:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S8WvziQN";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E09C10F957
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 00:31:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee4b9Br0wjTqipFTNYRqgzz9qrH9vBh/8E9gXpj0e72lJvBqs5+mmaPdO0horAWxvZ2V4XT8eRdkVvPUAhEfCzmC377nPQtJ7mxGmx0JvwNbxjJTsZIWRlwdImy3gIBDG0tJoOZqoR9QyxNhKfUovMNMaMrCcIhwlawk0wnAqtZpMEOTpTAFowH5mX9iWPlh/wou+F0k41xms1AdByxP9G0fiYWls4CndQh2DlpsqswgaZdjsxSXUAUsAmyHhDtjYxahItWQe8eo6fOdy1h1kpgOlog2FWh6rxVsx9u0jF66AlHmiXKtHmKDgx27N5XLSDG64CWFi2fCOdwoGV/8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6h8uXWwj5OlfNxhpdGr4EvQUL6/VDRw0eWfZ1o0aGY4=;
 b=h4Wxcb43sfxQQZPXbRRTSlp6A4QxS7oP75fkUnvxE9HItHEY7HrCXYVM44JWCq6Rpt2/I/GMpM0MF/pvQEutcrTeTm8DegiCQuQuQkE0daBQiBkVSXWR9yqjTdKDgYKm5MZPRRIeL6HD+08ZSvfNRqIPYWx04QdHJMQGMfTp/8OURoZvksji9xrKph6Z6H8Ze7ltzSYW8HxD64FJ7NudURUvx9x0u2wNVqWzNxlcpHWy1fak0yMzKnlI6OCGo6/f9vkAUu4BjKo43bm/rD0j9kNg/MCtNoiVXEGys3FpClGrsoqcGriJsmXAYkbjusdE1NDXWxojser60WNu0t99Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h8uXWwj5OlfNxhpdGr4EvQUL6/VDRw0eWfZ1o0aGY4=;
 b=S8WvziQN7FT6fH/aCVXbV6KlAZoP62XAagjNcw23fqZT/Oy70qXw8lRr/HR/JWGsq4YjaSF5F4NB+nO6Qi8vb4awfTlxZ7Gf+3lRYsLgnB6mPk8bK+qFnLHdrlv4WQ2NPI15NUUOiER0yY0uEUNBf382nHtAEMWEMkUTiwzYMRM=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 00:31:17 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.030; Sun, 28 Apr 2024
 00:31:17 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix uninitialized variable warning for
 smu8_hwmgr
Thread-Topic: [PATCH] drm/amd/pm: fix uninitialized variable warning for
 smu8_hwmgr
Thread-Index: AQHal7xB0UhsyHUDzkmJYbIF9GtzWbF6bSwAgAJpvcA=
Date: Sun, 28 Apr 2024 00:31:17 +0000
Message-ID: <CH3PR12MB80748FDC7C328FCE4BD6BCDAF6142@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240426092909.1350037-1-Tim.Huang@amd.com>
 <af9531ef-d623-4ef9-a93f-28796dedfa7c@gmail.com>
In-Reply-To: <af9531ef-d623-4ef9-a93f-28796dedfa7c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=45134fc3-5a3a-4132-a4ac-f76453f67478;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T00:29:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|CY8PR12MB7538:EE_
x-ms-office365-filtering-correlation-id: 8d017aca-9042-4953-c407-08dc671a84ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?L3FsbExYVkxxbDZEcnQvRDByV1pFZ2RtdzFSUWxNNk85clFCNml2TVVZZzBW?=
 =?utf-8?B?UFZvN2g1UjJJOWJzUU5nWGRZUFhoMmVDYlZPOXhNRU9KN3I0Qjdpa3NxWEs1?=
 =?utf-8?B?NXA0OWZxT0FnOGZFZlBTVWR6Ny91U0VSTW14M2p2YlRsRFdodUo5N3RtWG9w?=
 =?utf-8?B?RjZaNENkK1BkZ1FtSXRCZVY2dHMrMHJ1TnZiSlkwRWcxTFg5M0NtWDZmSE1Q?=
 =?utf-8?B?dXBMb3FNUzlZZlNsWkFLNUxzMG8rNy9Ga1dKNTloYTIxSVRodWthTXN6QUMr?=
 =?utf-8?B?eXFsZWRpV2lCNFpkRHJzMXliTkM4M3pYMCtic01JL1FvWXd4N1grZ1kyMTUy?=
 =?utf-8?B?dXJ3eE93cUMzSlhaNWxoK3hIOXpnM0ZUU2dQZzdieVdTMkQ1aWhGWWMvcnV0?=
 =?utf-8?B?WUw4UitaK0poUDBwVVpidm4vYWtCS3IxYkZ0RTVFRTN6SThkcGd3UzhPSUdv?=
 =?utf-8?B?eTlXc0d2NVhMQXp4bjhjKzIrNFo3MzBWU21PU3Z1YU5PWDZ5ZHFQcE9lYUpR?=
 =?utf-8?B?Qkl0anptRzVYMVR3SnlxeVNsOUhRL3pBMDJBL25KWFlPZlNJTS90WVZKNWFv?=
 =?utf-8?B?TE1YVzlBN29rTnFCY1FqN3JRR0lnTFg0UUdpWHU0MWEwblFScDV4K01GUkJK?=
 =?utf-8?B?RHZ5aHhjSGRJeVpzZmJoK282ZnVTc2FjMFVrK1lMQ0dhNEs5SzdvUlp1MlJR?=
 =?utf-8?B?THNZOGtZRm1NNDA4bkpsVi85Tit1elgzY2p4U3hjMVJOZGE3S3R5RStOeTVp?=
 =?utf-8?B?WDdDMDNSTHdwbVlZellCam5LR1ZDTkxxenVPYXRQOWpMaUFSZ211YWF1Nkxa?=
 =?utf-8?B?NVBMbUZ6TVRlcEJzaUxaTUxlak5sTm54cEh0dER3cWI5VlB6bjdPeVkwdzVQ?=
 =?utf-8?B?SC9HeEhpZWVWWmEvV1R2Wm9pbDlkUCtHTWIray9RclFyMWZzdVVqejRoNFFC?=
 =?utf-8?B?SUNVZ01SbXpaUUlBU0dtMmhGTk4vQjI2SGV0bzV4Q05KbEF3YnIrUVVCb2w2?=
 =?utf-8?B?Nk96TDhzSlZhWllyZ2hub3Z0UkNwT2NjMjhScTQwdUhORTcvOFg4Mm1Gc1NU?=
 =?utf-8?B?S0cwaW5NZGxEQ01xN21UR3hjUVdtZStDWlVmdWd6NVJsa0JoVFQ5a2hvVklI?=
 =?utf-8?B?WUVrWGNTZ2xrZy8vY0VVZ2xhZmZzUGlxOEd0Vm9SU1UyN01DNXRDekZCZ1Jv?=
 =?utf-8?B?MUhxcDJVcWRYeEdNbGhrWCtxV0dlZGpObWVybUhwZkNuS2VnaVh1SGF6WlVY?=
 =?utf-8?B?NEMwM29aVmcrSHNIdDBGUXdHWWpXOVNrcldiNmxZSEJHSDdMVGVwTmxzK0py?=
 =?utf-8?B?T2o4WUpKam5MaXhvUXBrMkxwVzg1WmwyQkcyVm81M0tRSlBCRjQ2QVNBRlh1?=
 =?utf-8?B?czRpRXZwWXlIbGtGellFYmNwNkZDWURkS3dOOE5nNXdhZ3krMS9RQXZQYjNC?=
 =?utf-8?B?dlhKQ2hHbkRxSlpBbTlUVFFXUW5JOXhXSlZaQ2IrelVVVHgwdlM2NzA1MlUv?=
 =?utf-8?B?bEJGVlVpTnZJeWJPTmdXNjR1U3FSck1DTmtLVURKVTMxR1RIOTUrd0J3b21I?=
 =?utf-8?B?bDNKTEtGaHRyano4bGJSaDBuZFRlVHhzRzZiaEVtTjFkWUl5N0VsWEFiQSsx?=
 =?utf-8?B?SzdHKzJFZ3ZGQWk4NEU5L0YrTENvWXlRUzFIeWdIbTFwRkxveVA3Vk96RWdk?=
 =?utf-8?B?RXhNMXBWWVpvb3R4ZEZNd25zMmk4K2lEdHJCZTA1MlpGSEpDdnM0VzVMdmRJ?=
 =?utf-8?B?bmlmV2VGT0hzTEFUUjZjZDF4WTdUTGVEQjJNS1NBRXFzTVFKVS9CMGR5eFM0?=
 =?utf-8?B?UkdLV0pUZWJVNlUyTXl5Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWdiWC8zTnJsdC9iYzJwaVdtM1VkczAwbDd2Mm4wb0d2aWFkbXJkSnlUTVJt?=
 =?utf-8?B?c2R3QTI1MGwxeG80TXY3aDQ0MUE1KzhHMlZxcEVZd1JNUXVSTThMaHRmWWo0?=
 =?utf-8?B?WTJ0YWNZZWFzaFVvUjBGN0JrNGpGN1N5V0JsOEd1K09HOHZLc1MwR1JOekJ3?=
 =?utf-8?B?bEFLVStKMkpUT0MxZzlFaEYvQldVNVdTTUxZMkQ5ejhLd3pBSmNGRXJ2OVd3?=
 =?utf-8?B?aGs0YnA5VEVNRzQrVDU3UEVHdHJYTENkQ3d1c20rM011VFZWcEpORHNnWnJl?=
 =?utf-8?B?Ry9ONDc4SGpKYy9qQ2RNTC9DdUJ3N1ROelFQSjhkVUhTNzNWdWphVVBrTXkx?=
 =?utf-8?B?UUQwN1FsTUlSRkkrZUVUYndYVSs3NkdPR3dtNm4wSlZVN2NQcGk3MkRySVI0?=
 =?utf-8?B?R2YwVXgrV0RLajV0SFVDeUt1R3IwYU9zN1hJMEJIaVU1dWNNOWRoL3pUcjV1?=
 =?utf-8?B?ZTRsRUlMRmRMYTAzcGJESEJRSzBVZnNheWhOZGQ3K2IrejRuNUNadDZLaEpK?=
 =?utf-8?B?Y2xvV0FCS2xSOUJBK1JnZjdSOFZ0dGpvNHZGYkRyYjc5akxNcWF4b0ZKcGhl?=
 =?utf-8?B?TmpWektLZkZ4V3J0WWNjWGkwajU1MSs3OVB6YjhvY1JlRGVQQXhuQlduR2dz?=
 =?utf-8?B?OGpOYlNhSnBxTTV4WitLUWNCUmpBTTViUENuVnkyeHdZNDBEWnFUTlIyd0E3?=
 =?utf-8?B?ZVBENlFUUGViZFhYcXRYRXlNRWZSbytaNFNKREdLYnFOR3ZRc0xlSFRpRC9E?=
 =?utf-8?B?RGdxZUJFbW4yV001eDZDbXVPd3JsOTJwSjg5RTVjQ0I3Y1hHZGZ0eXRQbzky?=
 =?utf-8?B?a1Q2Q0NObnNqRmJiTEk2N3FDUHI5NTZKa21mOU5hekVteU1JaDVTcml3NFZL?=
 =?utf-8?B?a0xQLzloNkd6VXJQREQ4a0ozQXlRenpEMmwvWXNPck1wdFBSOWFxR3pPMmJ2?=
 =?utf-8?B?SnRHUTR3UmNsYXY1K3ZjM3NhUmVSbzJmelJGeGdVTFlSWmVJVjFuTjNBMjBa?=
 =?utf-8?B?bmNJRkRDS3pOMC9WeGVpNGRCSERJU3c5MS9NbVhOYnhPZ1JhenhkWmhpOWhq?=
 =?utf-8?B?U2pYUkV2bTRUUWZrc0NZNWV2b3hORHRPV3FhRVpMc25OV280SkRPczBBekxj?=
 =?utf-8?B?SThqd2lzaGtnWWh2T2xCZzhlRm1vR25tV1lqNGNmTEY5cWhUclR3MXd2eXAx?=
 =?utf-8?B?Mmp1RkpjR1c1NHpIV21NeGlqRll3SWY4a1NtYlg2RHl5em81ZWg2Y0FSRWN1?=
 =?utf-8?B?eUVtaGlqOUg3V2JhTXRtRmgzU3JHaXdGUnR1cWFjOXMxU1N3SFZBS3ZqVmww?=
 =?utf-8?B?ci9jWmxrMW1qZW9TcVhKazdPZWoxbnpKeDJaYVlWZjIvV3hjYXNvd1RmUHIy?=
 =?utf-8?B?VmJNZ3luRTdjL3RLMFQ2VHgrZTZSY3dGRW81U0VIZTNMTTI2M0laQWtEZElj?=
 =?utf-8?B?QUU3bUgxVDlyYllldmpaYmhXcFpvSVdyeW5DcG1taDZtTGFsOHdVcnFYU3JW?=
 =?utf-8?B?N1RoY1JuMHkxU0Q5NVg3VHNEaGs4elNpak1ML05YcGExc1loT2pEVDlPNTdG?=
 =?utf-8?B?bTFBSng0bVFwS29IU29VVklxL1pleE5hUllwMmRWZmtHSW5YbkhUS2lKVFVN?=
 =?utf-8?B?NVBjWjZqNWhCV1gzY1p0TnhjQmVINTRNUHNKNmlvK2F2ZmhTbGYyOTJmM1Iz?=
 =?utf-8?B?dVlvQVhKdlN0bkhCZFdYSXlBSzFQZGlBSHd3SHRtaEIyOVJ2UTJXR3dwMUwr?=
 =?utf-8?B?V1A0SGJFV1NoblNOQ2dxMDVoU014aVVIVmk3aStXNVhiZk5wWU5PM3VPTlNH?=
 =?utf-8?B?MXR3c0t3d09MUkdQQWhoZGVZNXlSUXZOWkIxS2J6Qjhsek56am9DNk9KMVQ4?=
 =?utf-8?B?eHV3RVFTVDRkcWhKWWRYWVFkeTVqWStDTVZtUzF2OUoxWVh5N2IzdVEyelJD?=
 =?utf-8?B?c1VWREIyT2RMK2VkTVBIUXdhYkRISjVOUkphNGl5dFpXRDBmeXErWjFsMmsx?=
 =?utf-8?B?S0dySG13a3l0RDBjVWFQNmM5REJLWU8rNi83WHplSnNYOGM3czVBQVhIVzZo?=
 =?utf-8?B?UTlMaXM4emxycmR1Y1NTaWkvVDRPSHdVcmRZYnBCMjZhK01mN2JyWG9DanVR?=
 =?utf-8?Q?4shA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d017aca-9042-4953-c407-08dc671a84ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 00:31:17.1936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3x4ptJjAnE0ckngRzFjmmAj5xddTSpe0C1Kdf8j5AIa8HMKeEoWPzQYu5VOhgT28WlEYeIiQvamF3z15+lHooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdt
YWlsLmNvbT4NClNlbnQ6IEZyaWRheSwgQXByaWwgMjYsIDIwMjQgNzozOSBQTQ0KVG86IEh1YW5n
LCBUaW0gPFRpbS5IdWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
CkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZC9wbTogZml4IHVuaW5pdGlhbGl6ZWQgdmFyaWFibGUgd2FybmluZyBmb3Ig
c211OF9od21ncg0KDQpBbSAyNi4wNC4yNCB1bSAxMToyOSBzY2hyaWViIFRpbSBIdWFuZzoNCj4g
Q2xlYXIgd2FybmluZ3MgdGhhdCB1c2luZyB1bmluaXRpYWxpemVkIHZhbHVlIGxldmVsIHdoZW4g
ZmFpbHMgdG8gZ2V0DQo+IHRoZSB2YWx1ZSBmcm9tIFNNVS4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
VGltIEh1YW5nIDxUaW0uSHVhbmdAYW1kLmNvbT4NCg0KPiBNYXliZSBkcm9wIHRoZSBibGFuayBs
aW5lIGJlZm9yZSB0aGUgImlmIChyZXQpIiwgYXBhcnQgZnJvbSB0aGF0DQoNClllcywgd2lsbCBk
cm9wIGl0LiBUaGFua3MuDQoNClRpbQ0KDQo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoNCj4gLS0tDQo+ICAgLi4uL2RybS9hbWQvcG0v
cG93ZXJwbGF5L2h3bWdyL3NtdThfaHdtZ3IuYyAgICB8IDE4ICsrKysrKysrKysrKysrKy0tLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211
OF9od21nci5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211
OF9od21nci5jDQo+IGluZGV4IGIwMTVhNjAxYjM4NS4uNGU0MTQ2Y2U3MWMxIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXU4X2h3bWdyLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211OF9od21n
ci5jDQo+IEBAIC01ODQsNiArNTg0LDcgQEAgc3RhdGljIGludCBzbXU4X2luaXRfdXZkX2xpbWl0
KHN0cnVjdCBwcF9od21nciAqaHdtZ3IpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGh3bWdyLT5keW5fc3RhdGUudXZkX2Nsb2NrX3ZvbHRhZ2VfZGVwZW5kZW5jeV90YWJsZTsNCj4g
ICAgICAgdW5zaWduZWQgbG9uZyBjbG9jayA9IDA7DQo+ICAgICAgIHVpbnQzMl90IGxldmVsOw0K
PiArICAgICBpbnQgcmV0Ow0KPg0KPiAgICAgICBpZiAoTlVMTCA9PSB0YWJsZSB8fCB0YWJsZS0+
Y291bnQgPD0gMCkNCj4gICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gQEAgLTU5MSw3
ICs1OTIsMTAgQEAgc3RhdGljIGludCBzbXU4X2luaXRfdXZkX2xpbWl0KHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IpDQo+ICAgICAgIGRhdGEtPnV2ZF9kcG0uc29mdF9taW5fY2xrID0gMDsNCj4gICAg
ICAgZGF0YS0+dXZkX2RwbS5oYXJkX21pbl9jbGsgPSAwOw0KPg0KPiAtICAgICBzbXVtX3NlbmRf
bXNnX3RvX3NtYyhod21nciwgUFBTTUNfTVNHX0dldE1heFV2ZExldmVsLCAmbGV2ZWwpOw0KPiAr
ICAgICByZXQgPSBzbXVtX3NlbmRfbXNnX3RvX3NtYyhod21nciwgUFBTTUNfTVNHX0dldE1heFV2
ZExldmVsLCAmbGV2ZWwpOw0KPiArDQo+ICsgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4NCj4gICAgICAgaWYgKGxldmVsIDwgdGFibGUtPmNvdW50KQ0KPiAgICAg
ICAgICAgICAgIGNsb2NrID0gdGFibGUtPmVudHJpZXNbbGV2ZWxdLnZjbGs7IEBAIC02MTEsNiAr
NjE1LDcgQEAgc3RhdGljIGludA0KPiBzbXU4X2luaXRfdmNlX2xpbWl0KHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3bWdyLT5keW5fc3Rh
dGUudmNlX2Nsb2NrX3ZvbHRhZ2VfZGVwZW5kZW5jeV90YWJsZTsNCj4gICAgICAgdW5zaWduZWQg
bG9uZyBjbG9jayA9IDA7DQo+ICAgICAgIHVpbnQzMl90IGxldmVsOw0KPiArICAgICBpbnQgcmV0
Ow0KPg0KPiAgICAgICBpZiAoTlVMTCA9PSB0YWJsZSB8fCB0YWJsZS0+Y291bnQgPD0gMCkNCj4g
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gQEAgLTYxOCw3ICs2MjMsMTAgQEAgc3Rh
dGljIGludCBzbXU4X2luaXRfdmNlX2xpbWl0KHN0cnVjdCBwcF9od21nciAqaHdtZ3IpDQo+ICAg
ICAgIGRhdGEtPnZjZV9kcG0uc29mdF9taW5fY2xrID0gMDsNCj4gICAgICAgZGF0YS0+dmNlX2Rw
bS5oYXJkX21pbl9jbGsgPSAwOw0KPg0KPiAtICAgICBzbXVtX3NlbmRfbXNnX3RvX3NtYyhod21n
ciwgUFBTTUNfTVNHX0dldE1heEVjbGtMZXZlbCwgJmxldmVsKTsNCj4gKyAgICAgcmV0ID0gc211
bV9zZW5kX21zZ190b19zbWMoaHdtZ3IsIFBQU01DX01TR19HZXRNYXhFY2xrTGV2ZWwsDQo+ICsm
bGV2ZWwpOw0KPiArDQo+ICsgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgcmV0dXJuIHJl
dDsNCj4NCj4gICAgICAgaWYgKGxldmVsIDwgdGFibGUtPmNvdW50KQ0KPiAgICAgICAgICAgICAg
IGNsb2NrID0gdGFibGUtPmVudHJpZXNbbGV2ZWxdLmVjY2xrOyBAQCAtNjM4LDYgKzY0Niw3IEBA
IHN0YXRpYw0KPiBpbnQgc211OF9pbml0X2FjcF9saW1pdChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdy
KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod21nci0+ZHluX3N0YXRlLmFjcF9j
bG9ja192b2x0YWdlX2RlcGVuZGVuY3lfdGFibGU7DQo+ICAgICAgIHVuc2lnbmVkIGxvbmcgY2xv
Y2sgPSAwOw0KPiAgICAgICB1aW50MzJfdCBsZXZlbDsNCj4gKyAgICAgaW50IHJldDsNCj4NCj4g
ICAgICAgaWYgKE5VTEwgPT0gdGFibGUgfHwgdGFibGUtPmNvdW50IDw9IDApDQo+ICAgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IEBAIC02NDUsNyArNjU0LDEwIEBAIHN0YXRpYyBpbnQg
c211OF9pbml0X2FjcF9saW1pdChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQ0KPiAgICAgICBkYXRh
LT5hY3BfZHBtLnNvZnRfbWluX2NsayA9IDA7DQo+ICAgICAgIGRhdGEtPmFjcF9kcG0uaGFyZF9t
aW5fY2xrID0gMDsNCj4NCj4gLSAgICAgc211bV9zZW5kX21zZ190b19zbWMoaHdtZ3IsIFBQU01D
X01TR19HZXRNYXhBY2xrTGV2ZWwsICZsZXZlbCk7DQo+ICsgICAgIHJldCA9IHNtdW1fc2VuZF9t
c2dfdG9fc21jKGh3bWdyLCBQUFNNQ19NU0dfR2V0TWF4QWNsa0xldmVsLA0KPiArJmxldmVsKTsN
Cj4gKw0KPiArICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+DQo+
ICAgICAgIGlmIChsZXZlbCA8IHRhYmxlLT5jb3VudCkNCj4gICAgICAgICAgICAgICBjbG9jayA9
IHRhYmxlLT5lbnRyaWVzW2xldmVsXS5hY3BjbGs7DQoNCg==
